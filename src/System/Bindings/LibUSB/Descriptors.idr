module System.Bindings.LibUSB.Decriptors

import System.Bindings.LibUSB.Data
import System.Bindings.LibUSB.Devices

data UsbClass = PerInterface
              | Audio 
              | Comm
              | HID
              | Physical 
              | Printer
              | PTP 
              | Image
              | MassStorage
              | Data
              | SmartCard
              | ContentSecurity
              | Video
              | PersonalHealthCare
              | DiagnosticDevice
              | Wireless
              | Application
              | VendorSpec


-- int  libusb_get_device_descriptor (libusb_device *dev, struct libusb_device_descriptor *desc)
-- int   libusb_get_active_config_descriptor (libusb_device *dev, struct libusb_config_descriptor **config)
-- int   libusb_get_config_descriptor (libusb_device *dev, uint8_t config_index, struct libusb_config_descriptor **config)
-- int   libusb_get_config_descriptor_by_value (libusb_device *dev, uint8_t bConfigurationValue, struct libusb_config_descriptor **config)
-- void  libusb_free_config_descriptor (struct libusb_config_descriptor *config)

-- int   libusb_get_string_descriptor_ascii (libusb_device_handle *dev, uint8_t desc_index, unsigned char *data, int length)
libusb_get_string_descriptor_ascii : DeviceHandle -> Bits8 -> Buffer -> IO Int
libusb_get_string_descriptor_ascii (MkDeviceHandle h) i (MkBuffer s b) = 
  mkForeign (FFun "libusb_get_string_descriptor_ascii" [FPtr, FBits8, FPtr, FInt] FInt) h i b (fromNat s)

libusb_get_string_descriptor' : DeviceHandle -> Bits8 -> IO String
libusb_get_string_descriptor' h i = do
  b <- allocate 256
  r <- libusb_get_string_descriptor_ascii h i b
  s <- string_from_buffer b
  free b
  return s


-- static int  libusb_get_descriptor (libusb_device_handle *dev, uint8_t desc_type, uint8_t desc_index, unsigned char *data, int length)
--static int  libusb_get_string_descriptor (libusb_device_handle *dev, uint8_t desc_index, uint16_t langid, unsigned char *data, int length)

