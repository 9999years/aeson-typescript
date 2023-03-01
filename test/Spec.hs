
module Main where

import Test.Hspec

import qualified Basic
import qualified Formatting
import qualified Generic
import qualified GetDoc
import qualified HigherKind
import qualified ClosedTypeFamilies

import qualified LegalNameSpec
import qualified NoOmitNothingFields
import qualified ObjectWithSingleFieldNoTagSingleConstructors
import qualified ObjectWithSingleFieldTagSingleConstructors
import qualified OmitNothingFields
import qualified TaggedObjectNoTagSingleConstructors
import qualified TaggedObjectTagSingleConstructors
import qualified TwoElemArrayNoTagSingleConstructors
import qualified TwoElemArrayTagSingleConstructors
import qualified UntaggedNoTagSingleConstructors
import qualified UntaggedTagSingleConstructors
import qualified UnwrapUnaryRecords


main :: IO ()
main = hspec $ parallel $ do
  Basic.tests
  ClosedTypeFamilies.tests
  Formatting.tests
  Generic.tests
  GetDoc.tests
  HigherKind.tests

  LegalNameSpec.tests
  NoOmitNothingFields.allTests
  ObjectWithSingleFieldNoTagSingleConstructors.tests
  ObjectWithSingleFieldTagSingleConstructors.tests
  OmitNothingFields.tests
  TaggedObjectNoTagSingleConstructors.tests
  TaggedObjectTagSingleConstructors.tests
  TwoElemArrayNoTagSingleConstructors.tests
  TwoElemArrayTagSingleConstructors.tests
  UntaggedNoTagSingleConstructors.tests
  UntaggedTagSingleConstructors.tests
  UnwrapUnaryRecords.allTests
