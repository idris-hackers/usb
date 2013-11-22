module System.Bindings.LibUSB.Data


data Buffer = MkBuffer Nat Ptr

-- XXX this is ugly, make it more like the Raw memory effect
-- XXX with type guarantees for space. length, etc

allocate : Nat -> IO Buffer
allocate s = do
  b <- mkForeign (FFun "malloc" [FInt] FPtr) (fromNat s)
  return (MkBuffer s b)

free : Buffer -> IO ()
free (MkBuffer _ b) = mkForeign (FFun "free" [FPtr] FUnit) b

string_from_buffer : Buffer -> IO String
string_from_buffer (MkBuffer s b) =
  mkForeign (FFun "string_from_buffer" [FInt, FPtr] FString) (fromNat s) b

peek : Buffer -> Nat -> IO Bits8
peek (MkBuffer l b) i = mkForeign (FFun "idris_libusb_peek" [FPtr, FInt] FBits8) b (fromNat i)

poke : Buffer -> Nat -> Bits8 -> IO ()
poke (MkBuffer l b) i d = mkForeign (FFun "idris_libusb_poke" [FPtr, FInt, FBits8] FUnit) b (fromNat i) d

-- 
fill_buffer : Buffer -> List Bits8 -> IO ()
fill_buffer _ [] = do return () 
fill_buffer b (x::xs) = fill_buffer' b 0 (x::xs)
  where fill_buffer' : Buffer -> Nat -> List Bits8 -> IO ()
        fill_buffer' _ _ []      = do return ()
        fill_buffer' b i (x::xs) = do
          poke b i x 
          fill_buffer' b (i+1) xs 

read_buffer : Buffer -> Nat -> IO (List Bits8)
read_buffer b Z = return []
read_buffer b (S n) = traverse (peek b) [0..n]

bits_to_int : Bits8 -> IO Int
bits_to_int b = mkForeign (FFun "idris_bits_to_int" [FBits8] FInt) b

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


