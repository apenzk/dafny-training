
/**
 *  Lists.
 *
 *  @note:  Cons arguments can be named if needed (as for Tree)
 */
datatype List<T> = Nil | Cons(T, List<T>)

/**
 *  Length of a list.
 */
function length<T>(xs: List<T>): nat
{
    match xs
        case Nil => 0

        case Cons(x, xrest) => 1 + length(xrest)
}

/**
 *  Existence of lists of length 1.
 */
lemma existsListOfLengthOneNat()
  ensures exists l: List<nat> :: length(l) == 1
{
  var l: List<nat>;
  l := Cons(496, Nil);
  assert length(l) == 1;
}

/**
 *  Same as above.
 */
lemma witnessLengthOneNat() returns (r: List<nat>)
  ensures length(r) == 1
{
  r := Cons(496, Nil);
}

lemma witnessLengthTwoNat() 
  ensures exists l: List<nat> :: length(l) == 2
{
  existsListOfLengthOneNat();
  var k : List<nat> :| length(k) == 1; 
  var r := Cons(0, k);
  assert(length(r) == 2);
}

/**
 *  Example of a lemma without a proof ...
 *  dangerous! This one states that false is ... true.
 */
lemma foo1()
  ensures false

function foo2() : bool 
  ensures false 
{
  foo1();
  false
}

/**
 *  Existence of lists of arbitrary length.
 *  Demonstrate how to prove existential properties.
 */
lemma existsListOfArbitraryLength<T(0)>(n: nat)
  ensures exists l: List<T> :: length(l) == n
{
  if n == 0 {
    var x: List<T> := Nil;
    assert length(x) == 0;
  } else {
    existsListOfArbitraryLength<T>(n - 1);
    var xs: List<T> :| length(xs) == n - 1;
    //  T(0) is for generic types that can be auto-initialised (and are inhabited)
    var t: T := *;
    assert length(Cons(t, xs)) == n; 
  }
}

/**
 *  Append an element to a list.
 */
function append<T>(xs: List<T>, ys: List<T>): List<T>
{
  match xs
    case Nil => ys

    case Cons(x, xrest) => Cons(x, append(xrest, ys))
}

/**
 *  Reverse of a list.
 */
function reverse<T>(xs: List<T>): List<T>
{
  match xs
    case Nil => Nil

    case Cons(x, xrest) => append(reverse(xrest), Cons(x, Nil))
}

/**
 *  Nil is neutral element for append.
 */
lemma appendNilNeutral<T>(l: List<T>)
  ensures append(l, Nil) == l == append(Nil, l)
{
}

/**
 *  Append is associative
 */
lemma appendIsAssoc<T>(l1: List<T>, l2: List<T>, l3: List<T>)
  ensures append(append(l1, l2), l3) == append(l1, append(l2, l3))
{
}

/**
 *  Reverse is involutive.
 */
lemma reverseInvolutive<T>(l: List<T>)
  ensures reverse(reverse(l)) == l
{
  match l
  case Nil =>

  case Cons(hd, tl) =>
    calc == {
      reverse(reverse(l));
      reverse(append(reverse(tl), Cons(hd, Nil)));
      {
        LemmaReverseAppendDistrib(reverse(tl), Cons(hd, Nil));
      }
      append(reverse(Cons(hd, Nil)), reverse(reverse(tl)));
      {
        reverseInvolutive(tl);
      }
      append(reverse(Cons(hd, Nil)), tl);
      append(Cons(hd, Nil), tl);
      l;
    }
}

/**
 *  A useful lemma combining reverse and append.
 *  Distribution.
 */
lemma LemmaReverseAppendDistrib<T>(l1: List<T>, l2: List<T>)
  ensures reverse(append(l1, l2)) == append(reverse(l2), reverse(l1))
{
  match l1
  case Nil =>
    calc == {
      reverse(append(l1, l2)); // line<0>
    // S<0>
      reverse(append(Nil, l2)); // line<1>
      reverse(l2);
      {
        appendNilNeutral(reverse(l2));
      }
      append(reverse(l2), Nil);
    }
  case Cons(h1, t1) =>
    calc == {
      reverse(append(l1, l2));
      reverse(append(Cons(h1, t1), l2));
      reverse(Cons(h1, append(t1, l2)));
      append(reverse(append(t1, l2)), Cons(h1, Nil));
      append(append(reverse(l2), reverse(t1)), Cons(h1, Nil));
      {
        appendIsAssoc(reverse(l2), reverse(t1), Cons(h1, Nil));
      }
      append(reverse(l2), append(reverse(t1), Cons(h1, Nil)));
      append(reverse(l2), reverse(Cons(h1, t1))) ;
    }
}
