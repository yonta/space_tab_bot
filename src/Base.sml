infix 0 |>

structure Base = struct
  exception Undefine

  fun id x = x
  fun op $ (f, x) = f x
  fun op |> (x, f) = f x
  fun undef () = raise Undefine
  fun puts str = (print str; print "\n")
  fun curry f x y = f (x,y)
  fun uncurry f (x,y) = f x y
  fun flip f x y = f y x

  fun strip str =
    Substring.full str
    |> Substring.dropl Char.isSpace
    |> Substring.dropr Char.isSpace
    |> Substring.string

  fun protectx v f cleanup =
      let
        val res = f v
      in
        (cleanup v; res)
      end handle e => (cleanup v; raise e)
end
