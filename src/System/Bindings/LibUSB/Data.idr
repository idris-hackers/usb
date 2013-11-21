module System.Bindings.LibUSB.Data


data Buffer = MkBuffer Nat Ptr

allocate : Nat -> IO Buffer
allocate s = do
  b <- mkForeign (FFun "malloc" [FInt] FPtr) (fromNat s)
  return (MkBuffer s b)

free : Buffer -> IO ()
free (MkBuffer _ b) = mkForeign (FFun "free" [FPtr] FUnit) b

string_from_buffer : Buffer -> IO String
string_from_buffer (MkBuffer s b) =
  mkForeign (FFun "string_from_buffer" [FInt, FPtr] FString) (fromNat s) b

