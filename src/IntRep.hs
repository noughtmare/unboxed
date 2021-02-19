{-# Language NoImplicitPrelude #-}
{-# Language RebindableSyntax #-}
{-# Language MagicHash #-}
{-# Language KindSignatures #-}
{-# Language DataKinds #-}
{-# Language TypeSynonymInstances #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module IntRep 
  ( module Classes.IntRep
  ) where

import GHC.Prim
import GHC.Integer
import GHC.Types 
import Prelude (otherwise)

import Classes.IntRep

instance Eq Int# where
  x == y = isTrue# (x ==# y)
  x /= y = isTrue# (x /=# y)

instance Ord Int# where
  x <= y = isTrue# (x <=# y)
  x >= y = isTrue# (x >=# y)
  x < y = isTrue# (x <# y)
  x > y = isTrue# (x ># y)

instance Num Int# where
  (+) = (+#)
  (-) = (-#)
  (*) = (*#)
  negate = negateInt#
  abs n
    | isTrue# (n >=# 0) = n
    | otherwise = negate n
  signum n
    | isTrue# (n <# 0) = negate 1
    | isTrue# (n ==# 0) = 0
    | otherwise = 1
  fromInteger = integerToInt
  {-# INLINE fromInteger #-}