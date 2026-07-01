Server.program = "pw-jack scsynth";

(
  s.options.numBuffers = 1024 * 256;
  s.options.memSize = 8192 * 32;
  s.options.numWireBufs = 2048;
  s.options.maxNodes = 1024 * 32;

  s.reboot {
    s.waitForBoot {
      ~dirt.stop;
      ~dirt = SuperDirt(2, s);
      ~dirt.loadSoundFiles;
      ~dirt.start(57120, 0 ! 12);
    };
  };
)
