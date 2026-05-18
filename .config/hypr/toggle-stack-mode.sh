#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="$(realpath "${HOME}/.config/hypr/custom.lua")"
BEGIN_MARKER="-- hyprstack-mode:begin float-all-windows"
END_MARKER="-- hyprstack-mode:end float-all-windows"

tmp_file="$(mktemp)"
cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT

current_mode="$(
  python3 - "$CONFIG_FILE" "$BEGIN_MARKER" "$END_MARKER" <<'PY'
from pathlib import Path
import sys

config = Path(sys.argv[1]).read_text().splitlines()
begin = sys.argv[2]
end = sys.argv[3]
for i, line in enumerate(config):
    if line == begin:
        for candidate in config[i + 1:]:
            stripped = candidate.lstrip()
            if not stripped:
                continue
            if candidate == end:
                break
            if stripped.startswith("hl.window_rule({") or stripped.startswith("name = ") or stripped.startswith("match = ") or stripped.startswith("float = ") or stripped.startswith("center = "):
                print("stack")
                raise SystemExit
            if stripped.startswith("#"):
                print("tile")
            elif stripped.startswith("--"):
                print("tile")
            else:
                print("stack")
            raise SystemExit
raise SystemExit("float-all-windows block markers not found")
PY
)"

python3 - "$CONFIG_FILE" "$BEGIN_MARKER" "$END_MARKER" "$current_mode" >"$tmp_file" <<'PY'
from pathlib import Path
import sys

config_path = Path(sys.argv[1])
begin = sys.argv[2]
end = sys.argv[3]
current_mode = sys.argv[4]
lines = config_path.read_text().splitlines()

enabled_block = [
    "-- hyprstack-mode:begin float-all-windows",
    "hl.window_rule({",
    '    name = "float-all-windows",',
    '    match = { class = ".*" },',
    "",
    "    float = true,",
    "    center = true,",
    "})",
    "-- hyprstack-mode:end float-all-windows",
]

disabled_block = [
    "-- hyprstack-mode:begin float-all-windows",
    "-- hl.window_rule({",
    '--     name = "float-all-windows",',
    '--     match = { class = ".*" },',
    "--",
    "--     float = true,",
    "--     center = true,",
    "-- })",
    "-- hyprstack-mode:end float-all-windows",
]

inside = False
result = []
for line in lines:
    if line == begin:
        inside = True
        result.extend(disabled_block if current_mode == "stack" else enabled_block)
        continue
    if line == end:
        inside = False
        continue

    if inside:
        continue

    result.append(line)

sys.stdout.write("\n".join(result) + "\n")
PY

mv "$tmp_file" "$CONFIG_FILE"
trap - EXIT

layout="monocle"
dispatch="setfloating"
post_dispatch="centerwindow"

if [[ "$current_mode" == "stack" ]]; then
  layout="dwindle"
  dispatch="settiled"
  post_dispatch=""
fi

hyprctl reload >/dev/null
hyprctl keyword general:layout "$layout" >/dev/null

current_workspace="$(
  python3 - <<'PY'
import json
import subprocess

workspace = json.loads(subprocess.check_output(["hyprctl", "activeworkspace", "-j"], text=True))
print(workspace["id"])
PY
)"

active_address="$(
  python3 - <<'PY'
import json
import subprocess

window = json.loads(subprocess.check_output(["hyprctl", "activewindow", "-j"], text=True))
print(window["address"])
PY
)"

python3 - "$current_workspace" <<'PY' | while IFS= read -r address; do
import json
import subprocess
import sys

workspace_id = int(sys.argv[1])
clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"], text=True))

for client in clients:
    if client["workspace"]["id"] == workspace_id:
        print(client["address"])
PY
  [[ -n "$address" ]] || continue
  hyprctl dispatch focuswindow "address:${address}" >/dev/null
  hyprctl dispatch "$dispatch" >/dev/null
  if [[ -n "$post_dispatch" ]]; then
    hyprctl dispatch "$post_dispatch" >/dev/null
  fi
done

hyprctl dispatch workspace "$current_workspace" >/dev/null
hyprctl dispatch focuswindow "address:${active_address}" >/dev/null
