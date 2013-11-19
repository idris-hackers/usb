module System.Bindings.LibUSB.Data

data Device = MkDevice Ptr
data DeviceHdl = MkDeviceHdl Ptr

data Speed = Unknown | Low | Full | High | Super


