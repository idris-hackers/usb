module System.Bindings.LibUSB.Devices

data Device = MkDevice Ptr

data DeviceHdl = MkDeviceHdl Ptr

data Speed = Unknown | Low | Full | High | Super


