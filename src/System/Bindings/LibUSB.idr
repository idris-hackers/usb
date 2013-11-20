module System.Bindings.LibUSB

%lib C "usb-1.0"
%include C "libusb-1.0/libusb.h"

%include C "idris_usb.h"
%link C "idris_usb.o"

data Context = MkContext Ptr

libusb_init : IO (Maybe Context)
libusb_init = do
    res <- mkForeign (FFun "idris_libusb_init" [] FPtr)
    is_null <- nullPtr res
    return $ if is_null then Nothing else Just (MkContext res)

libusb_exit : Context -> IO ()
libusb_exit (MkContext p) = mkForeign (FFun "libusb_exit" [FPtr] FUnit) p

data Device = MkDevice Ptr
data DeviceHandle = MkDeviceHandle Ptr
data DeviceList = MkDeviceList Ptr

libusb_get_device_list : Context -> IO DeviceList
libusb_get_device_list (MkContext p) = do
  r <- mkForeign (FFun "idris_libusb_get_device_list" [FPtr] FPtr) p
  return $ MkDeviceList r

-- This should exist 
-- libusb_get_device_list' : Context -> List Device
-- libusb_get_device_list' ctx = 

libusb_free_device_list : DeviceList -> Int -> IO ()
libusb_free_device_list (MkDeviceList l) u = mkForeign (FFun "libusb_free_device_list" [FPtr, FInt] FUnit) l u

libusb_get_bus_number : Device -> IO Bits8
libusb_get_bus_number (MkDevice d) = mkForeign (FFun "libusb_get_bus_number" [FPtr] FBits8) d

libusb_get_device_address : Device -> IO Bits8
libusb_get_device_address (MkDevice d) = mkForeign (FFun "libusb_get_device_address" [FPtr] FBits8) d

libusb_get_device_speed : Device -> IO Int
libusb_get_device_speed (MkDevice d) = mkForeign (FFun "libusb_get_device_speed" [FPtr] FInt) d

libusb_get_max_packet_size : Device -> IO Int
libusb_get_max_packet_size (MkDevice d) = mkForeign (FFun "libusb_get_max_packet_size" [FPtr] FInt) d

libusb_get_max_iso_packet_size : Device -> IO Int
libusb_get_max_iso_packet_size (MkDevice d) = mkForeign (FFun "libusb_get_max_iso_packet_size" [FPtr] FInt) d

libusb_ref_device : Device -> IO Device
libusb_ref_device (MkDevice d) = do
  r <- mkForeign (FFun "libusb_ref_device" [FPtr] FPtr) d
  return (MkDevice r)

libusb_unref_device : Device -> IO ()
libusb_unref_device (MkDevice d) = mkForeign (FFun "libusb_unref_device" [FPtr] FUnit) d

libusb_open : Device -> IO (Maybe DeviceHandle)
libusb_open (MkDevice d) = do
  r <- mkForeign (FFun "idris_libusb_open" [FPtr] FPtr) d
  is_null <- nullPtr r
  return $ if is_null then Nothing else Just (MkDeviceHandle r)

libusb_open_device_with_vid_pid : Context -> Bits16 -> Bits16 -> IO (Maybe Device)
libusb_open_device_with_vid_pid (MkContext ctx) vid pid = do
  r <- mkForeign (FFun "libusb_open_device_with_vid_pid" [FPtr, FBits16, FBits16] FPtr) ctx vid pid
  is_null <- nullPtr r
  return $ if is_null then Nothing else Just (MkDevice r)

libusb_close : Device -> IO ()
libusb_close (MkDevice d) =
  mkForeign (FFun "libusb_close" [FPtr] FUnit) d

libusb_get_device : DeviceHandle -> IO (Maybe Device)
libusb_get_device (MkDeviceHandle h) = do
  r <- mkForeign (FFun "libusb_get_device" [FPtr] FPtr) h
  is_null <- nullPtr r
  return $ if is_null then Nothing else Just (MkDevice r)

libusb_get_configuration : DeviceHandle -> IO Int
libusb_get_configuration (MkDeviceHandle h) =
  mkForeign (FFun "idris_libusb_get_configuration" [FPtr] FInt) h

libusb_set_configuration : DeviceHandle -> Int -> IO Int
libusb_set_configuration (MkDeviceHandle h) c =
  mkForeign (FFun "libusb_set_configuration" [FPtr, FInt] FInt) h c

libusb_claim_interface : DeviceHandle -> Int -> IO Int
libusb_claim_interface (MkDeviceHandle h) i =
  mkForeign (FFun "libusb_claim_interface" [FPtr, FInt] FInt) h i

libusb_release_interface : DeviceHandle -> Int -> IO Int
libusb_release_interface (MkDeviceHandle h) i =
  mkForeign (FFun "libusb_release_interface" [FPtr, FInt] FInt) h i

libusb_set_interface_alt_setting : DeviceHandle -> Int -> Int -> IO Int
libusb_set_interface_alt_setting (MkDeviceHandle h) i s =
  mkForeign (FFun "libusb_set_interface_alt_setting" [FPtr, FInt, FInt] FInt) h i s

libusb_clear_halt : DeviceHandle -> Bits8 -> IO Int
libusb_clear_halt (MkDeviceHandle h) ep =
  mkForeign (FFun "libusb_clear_halt" [FPtr, FBits8] FInt) h ep

libusb_reset_device : DeviceHandle -> IO Int
libusb_reset_device (MkDeviceHandle h) =
  mkForeign (FFun "libusb_reset_device" [FPtr] FInt) h

libusb_kernel_driver_active : DeviceHandle -> Int -> IO Int
libusb_kernel_driver_active (MkDeviceHandle h) i =
  mkForeign (FFun "libusb_kernel_driver_active" [FPtr, FInt] FInt) h i

libusb_detach_kernel_driver : DeviceHandle -> Int -> IO Int
libusb_detach_kernel_driver (MkDeviceHandle h) i =
  mkForeign (FFun "libusb_detach_kernel_driver" [FPtr, FInt] FInt) h i

libusb_attach_kernel_driver : DeviceHandle -> Int -> IO Int
libusb_attach_kernel_driver (MkDeviceHandle h) i =
  mkForeign (FFun "libusb_attach_kernel_driver" [FPtr, FInt] FInt) h i

