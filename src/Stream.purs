module Stream
  ( readString
  ) where

import Effect.Aff (Aff)
import Effect.Aff as Aff
import Effect.Ref as Ref
import Node.Encoding as Encoding
import Node.Stream (Readable)
import Node.Stream as Stream
import Prelude (append, bind, discard, mempty, pure)

readString :: Readable () -> Aff String
readString r = Aff.makeAff \callback -> do
  ref <- Ref.new mempty
  Stream.onDataString r Encoding.UTF8 \s -> do
    buffer <- Ref.read ref
    Ref.write (append buffer s) ref
  Stream.onEnd r do
    buffer <- Ref.read ref
    callback (pure buffer)
  pure mempty -- canceler
