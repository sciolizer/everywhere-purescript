module Context where

import Prelude
import Control.Monad.Eff

foreign import data CONTEXT :: !

foreign import display :: forall e. String -> Eff (context :: CONTEXT | e) Unit

foreign import onInput :: forall e. (String -> Eff (context :: CONTEXT | e) Unit) -> Eff (context :: CONTEXT | e) Unit
