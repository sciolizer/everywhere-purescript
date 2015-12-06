-- | This module defines the `Extend` type class and associated helper functions.

module Control.Extend where

import Prelude

infixl 1 =>>
infixr 1 <<=
infixr 1 =>=
infixr 1 =<=

-- | The `Extend` class defines the extension operator `(<<=)`
-- | which extends a local context-dependent computation to
-- | a global computation.
-- |
-- | `Extend` is the dual of `Bind`, and `(<<=)` is the dual of
-- | `(>>=)`.
-- |
-- | Laws:
-- |
-- | - Associativity: `extend f <<< extend g = extend (f <<< extend g)`
class (Functor w) <= Extend w where
  extend :: forall b a. (w a -> b) -> w a -> w b

instance extendFn :: (Semigroup w) => Extend ((->) w) where
  extend f g w = f \w' -> g (w <> w')

-- | An infix version of `extend`
(<<=) :: forall w a b. (Extend w) => (w a -> b) -> w a -> w b
(<<=) = extend

-- | A version of `(<<=)` with its arguments flipped.
(=>>) :: forall b a w. (Extend w) => w a -> (w a -> b) -> w b
(=>>) w f = f <<= w

-- | Forwards co-Kleisli composition.
(=>=) :: forall b a w c. (Extend w) => (w a -> b) -> (w b -> c) -> w a -> c
(=>=) f g w = g (f <<= w)

-- | Backwards co-Kleisli composition.
(=<=) :: forall b a w c. (Extend w) => (w b -> c) -> (w a -> b) -> w a -> c
(=<=) f g w = f (g <<= w)

-- | Duplicate a comonadic context.
-- |
-- | `duplicate` is dual to `Control.Bind.join`.
duplicate :: forall a w. (Extend w) => w a -> w (w a)
duplicate = extend id
