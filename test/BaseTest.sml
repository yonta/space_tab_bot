structure BaseTest = struct
  structure Test = SMLUnit.Test
  structure Assert = SMLUnit.Assert
  open Base

  fun id_test () =
    (Assert.assertEqualInt 42 (id 42);
     Assert.assertEqualString  "Thanks for All the Fish" (Base.id "Thanks for All the Fish"))

  fun curry_uncurry_test () =
    let
      fun plus x y = x + y
    in
      (Assert.assertEqualInt (curry (op +) 1 2) (1 + 2);
       Assert.assertEqualInt (uncurry plus (1,2)) (plus 1 2);
       Assert.assertEqualInt ((uncurry (curry (op +))) (1,2)) (1 + 2))
    end

  fun strip_test () =
    (Assert.assertEqualString "foo" (strip "foo");
     Assert.assertEqualString "foo" (strip "foo ");
     Assert.assertEqualString "foo" (strip "foo\r\n");
     Assert.assertEqualString "foo" (strip " foo");
     Assert.assertEqualString "foo" (strip " foo ");
     Assert.assertEqualString "lazy dog" (strip "lazy dog"))

  fun takeWhile_test () =
    (Assert.assertEqualIntList [] $ takeWhile (fn x => x < 4) [];
     Assert.assertEqualIntList [] $ takeWhile (fn x => x < 4) [100];
     Assert.assertEqualIntList [1,2,3] $ takeWhile (fn x => x < 4) [1,2,3,4,5])

  fun dropWhile_test () =
    (Assert.assertEqualIntList [] $ dropWhile (fn x => x < 4) [];
     Assert.assertEqualIntList [100] $ dropWhile (fn x => x < 4) [100];
     Assert.assertEqualIntList [4,5] $ dropWhile (fn x => x < 4) [1,2,3,4,5])

  fun span_test () =
    (Assert.assertTrue $ ([],[]) = span (fn x => x < 4) [];
     Assert.assertTrue $ ([1,2,3],[4,5]) = span (fn x => x < 4) [1,2,3,4,5])

  fun suite _ = Test.labelTests [
    ("id test", id_test),
    ("curry_uncurry_test", curry_uncurry_test),
    ("strip test", strip_test),
    ("takeWhile test", takeWhile_test),
    ("dropWhile test", dropWhile_test),
    ("span test", span_test)
  ]
end
