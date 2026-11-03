# ネットワーク

Waybarのトレイにnm-appletを表示し、有線・Wi-Fi・VPNの接続/切断を操作する。

Archの必要パッケージ: `networkmanager networkmanager-openvpn network-manager-applet nm-connection-editor gnome-keyring`

1. ホストごとにdhcpcd/netctlからNetworkManagerへ移行する(同じNICを二重管理しない)
2. `make network-ui`でユーザーサービスを登録する
3. Hyprlandセッションで`systemctl --user start nm-applet.service`を実行する

以降はwaybar-hyprland.serviceと一緒に起動・停止する。 別の自動起動設定からnm-appletを重複起動しない。

VPNのパスワードはagent-ownedでGNOME Keyringに保存する。 ログイン時のキーリング解除にはPAM連携が必要で、未設定なら解除ダイアログで解除する。 空パスワードのキーリングにはしない。
thinkpadArchでもパッケージ・キーリング・PAM連携を実機確認する。 homeArchから秘密情報はコピーしない。

VPNプロファイル・鍵・パスワードはGitに含めず各端末で管理する。 キーリングが保護するのはパスワードであり、OpenVPNの証明書秘密鍵は別途ファイル権限で保護する。
