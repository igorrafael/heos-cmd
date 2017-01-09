# Overview

Issue commands to a HEOS device via command line.

This software might be extended to incorporate any non-stateful function defined in the 
[specification][1].

# Features

The only feature currently implemented is changing the input source. This is done via the parameter `play_input`. For example:

    $ heos-cmd --host=192.168.0.222 --name="Heos 1" --play_input=aux_in_1

# Usage

The project builds with stack and should be simple to run on any supported platform. That said, it has not been tested.

[1]:[http://www2.aerne.com/Public/dok-sw.nsf/1edd1194263fab29c12573ba003a1f32/9193bea412104506c1257dbd00298c78/$FILE/HEOS_CLI_PROTOCOL_Specification_290616.pdf]
