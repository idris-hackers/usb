module System.Bindings.LibUSB.Devices

data Device = MkDevice Ptr

data DeviceHandle = MkDeviceHandle Ptr

data Speed = Unknown | Low | Full | High | Super


