{-# LANGUAGE QuasiQuotes, OverloadedStrings, TemplateHaskell, RecordWildCards, ScopedTypeVariables, ExistentialQuantification, PolyKinds, StandaloneDeriving #-}

module Data.Aeson.TypeScript.Types where

import qualified Data.Aeson as A
import Data.Proxy
import Data.String
import Data.Typeable
import Language.Haskell.TH

-- | The typeclass that defines how a type is turned into TypeScript.
--
-- The 'getTypeScriptDeclarations' method describes the top-level declarations that are needed for a type,
-- while 'getTypeScriptType' describes how references to the type should be translated. The 'getTypeScriptOptional'
-- method exists purely so that 'Maybe' types can be encoded with a question mark.
--
--  Instances for common types are built-in and are usually very simple; for example,
--
-- @
-- instance TypeScript Bool where
--   getTypeScriptType _ = "boolean"
-- @
--
-- Most of the time you should not need to write instances by hand; in fact, the 'TSDeclaration'
-- constructors are deliberately opaque. However, you may occasionally need to specify the type of something.
-- For example, since 'UTCTime' is encoded to a JSON string and is not built-in to this library:
--
-- @
-- import Data.Time.Clock (UTCTime)
--
-- instance TypeScript UTCTime where
--   getTypeScriptType _ = "string"
-- @
--
-- If you need to write a definition for a higher-order type, it may depend on a type parameter. For example,
-- a 'Set' is encoded to a JSON list of the underlying type:
--
-- @
-- instance (TypeScript a) => TypeScript (Set a) where
--   getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a) <> "[]";
-- @
class (Typeable a) => TypeScript a where
  getTypeScriptDeclarations :: Proxy a -> [TSDeclaration]
  -- ^ Get the declaration(s) needed for this type.
  getTypeScriptDeclarations _ = []

  getTypeScriptType :: Proxy a -> String
  -- ^ Get the type as a string.

  getTypeScriptOptional :: Proxy a -> Bool
  -- ^ Get a flag representing whether this type is optional.
  getTypeScriptOptional _ = False

  getParentTypes :: Proxy a -> [TSType]
  getParentTypes _ = []
  -- ^ Get the types that this type depends on. This is useful for generating transitive closures of necessary types.

-- | An existential wrapper for any TypeScript instance.
data TSType = forall a. (Typeable a, TypeScript a) => TSType { unTSType :: Proxy a }

instance Eq TSType where
  (TSType p1) == (TSType p2) = typeRep p1 == typeRep p2

instance Ord TSType where
  (TSType p1) `compare` (TSType p2) = typeRep p1 `compare` typeRep p2

instance Show TSType where
  show (TSType proxy) = show $ typeRep proxy

data TSDeclaration = TSInterfaceDeclaration { interfaceName :: String
                                            , interfaceGenericVariables :: [String]
                                            , interfaceMembers :: [TSField] }
                   | TSTypeAlternatives { typeName :: String
                                        , typeGenericVariables :: [String]
                                        , alternativeTypes :: [String]}
                   | TSRawDeclaration { text :: String }
  deriving (Show, Eq, Ord)

data TSField = TSField { fieldOptional :: Bool
                       , fieldName :: String
                       , fieldType :: String } deriving (Show, Eq, Ord)

newtype TSString a = TSString { unpackTSString :: String } deriving Show

instance IsString (TSString a) where
  fromString = TSString

-- * Formatting options

data FormattingOptions = FormattingOptions
  { numIndentSpaces       :: Int
  -- ^ How many spaces to indent TypeScript blocks
  , interfaceNameModifier :: String -> String
  -- ^ Function applied to generated interface names
  , typeNameModifier :: String -> String
  -- ^ Function applied to generated type names
  }

defaultFormattingOptions :: FormattingOptions
defaultFormattingOptions = FormattingOptions
  { numIndentSpaces = 2
  , interfaceNameModifier = id
  , typeNameModifier = id
  }

-- | Convenience typeclass class you can use to "attach" a set of Aeson encoding options to a type.
class HasJSONOptions a where
  getJSONOptions :: (Proxy a) -> A.Options

data T = T
data T1 = T1
data T2 = T2
data T3 = T3
data T4 = T4
data T5 = T5
data T6 = T6
data T7 = T7
data T8 = T8
data T9 = T9
data T10 = T10

instance TypeScript T where getTypeScriptType _ = "T"
instance TypeScript T1 where getTypeScriptType _ = "T1"
instance TypeScript T2 where getTypeScriptType _ = "T2"
instance TypeScript T3 where getTypeScriptType _ = "T3"
instance TypeScript T4 where getTypeScriptType _ = "T4"
instance TypeScript T5 where getTypeScriptType _ = "T5"
instance TypeScript T6 where getTypeScriptType _ = "T6"
instance TypeScript T7 where getTypeScriptType _ = "T7"
instance TypeScript T8 where getTypeScriptType _ = "T8"
instance TypeScript T9 where getTypeScriptType _ = "T9"
instance TypeScript T10 where getTypeScriptType _ = "T10"

allStarConstructors = [ConT ''T1, ConT ''T2, ConT ''T3, ConT ''T4, ConT ''T5, ConT ''T6, ConT ''T7, ConT ''T8, ConT ''T9, ConT ''T10]                 

data F (a :: k) = F
data F1 a = F1
data F2 a = F2
data F3 a = F3
data F4 a = F4
data F5 a = F5
data F6 a = F6
data F7 a = F7
data F8 a = F8
data F9 a = F9
data F10 a = F10

instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F1 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F2 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F3 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F4 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F5 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F6 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F7 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F8 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F9 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)
instance (Typeable a, Typeable k, TypeScript a) => TypeScript (F10 (a :: k)) where getTypeScriptType _ = getTypeScriptType (Proxy :: Proxy a)

allPolyStarConstructors = [ConT ''F1, ConT ''F2, ConT ''F3, ConT ''F4, ConT ''F5, ConT ''F6, ConT ''F7, ConT ''F8, ConT ''F9, ConT ''F10]                 
