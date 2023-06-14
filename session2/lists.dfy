
/**
 *  Lists.
 *
 *  @note:  Cons arguments can be named if needed (as for Tree)
 */
datatype List<T> = Nil | Cons(T, List<T>)

/**
 *  Length of a list.
 */
ghost function length<T>(xs: List<T>): nat
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
lemma existsListOfArbitraryLength<T(0)>(n: nat) returns (xs: List<T>)
  ensures length(xs) == n
{
  if n == 0 {
    xs := Nil;
  } else {
    var xs1 := existsListOfArbitraryLength(n - 1);
    var t: T := *;
    xs :=  Cons(t, xs1);
    assert length(xs) == length(xs1) + 1;
  }
}

lemma existsListOfArbitraryLength2<T(0)>(n: nat) 
  ensures exists l: List<T> :: length(l) == n  
{
  if n == 0 {
    var xs : List<T> := Nil;
    assert length(xs) == 0;
  } else {
    existsListOfArbitraryLength2<T>(n - 1);
    var xs1 : List<T> :| length(xs1) == n - 1;
    var t: T := *;
    var xs : List<T> :=  Cons(t, xs1);
    assert length(xs) == n ; 
  }
}

/**
 *  Append an element to a list.
 */
function append<T>(xs: List<T>, ys: List<T>): List<T>
{
  xs
}

/**
 *  Reverse of a list.
 */
function reverse<T>(xs: List<T>): List<T>
{
  xs
}

/**
 *  Nil is neutral element for append.
 */
lemma appendNilNeutral<T>(l: List<T>)
  ensures append(l, Nil) == l == append(Nil, l)

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

/**
 *  A useful lemma combining reverse and append.
 *  Distribution.
 */
lemma LemmaReverseAppendDistrib<T>(l1: List<T>, l2: List<T>)
  ensures reverse(append(l1, l2)) == append(reverse(l2), reverse(l1))

