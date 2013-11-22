module System.Bindings.LibUSB.SyncIO

import System.Bindings.LibUSB.Data
import System.Bindings.LibUSB.Devices


-- XXX Hack Hack Hack
nat_to_bits16 : Nat -> Bits16
nat_to_bits16 = fromInteger . toIntegerNat

libusb_control_transfer : DeviceHandle -> Bits8 -> Bits8 -> Bits16 -> Bits16
                        -> Buffer -> Int -> IO Int
libusb_control_transfer (MkDeviceHandle h) reqType request value index (MkBuffer len b) timeout =
  mkForeign (FFun "libusb_control_transfer" [FPtr, FBits8, FBits8, FBits16, FBits16, FPtr, FBits16, FInt] FInt) h reqType request value index b (nat_to_bits16 len) timeout

libusb_bulk_transfer : DeviceHandle -> Bits8 -> Buffer -> Int -> IO (Either Int Int)
libusb_bulk_transfer (MkDeviceHandle h) endpoint (MkBuffer len b) timeout = do
  res <- mkForeign (FFun "idris_libusb_bulk_transfer" [FPtr, FBits8, FPtr, FInt, FInt] FInt) h endpoint b (fromNat len) timeout
  return $ (Right 0) -- if res >= 0 then (Right res) else (Left res) 

libusb_interrupt_transfer : DeviceHandle -> Bits8 -> Buffer -> Int -> IO (Either Int Int)
libusb_interrupt_transfer (MkDeviceHandle h) endpoint (MkBuffer len b) timeout = do
  res <- mkForeign (FFun "idris_libusb_interrupt_transfer" [FPtr, FBits8, FPtr, FInt, FInt] FInt) h endpoint b (fromNat len) timeout
  return $ if res >= 0 then (Right res) else (Left res) 

