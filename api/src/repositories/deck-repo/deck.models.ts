import { BrandedUString } from "src/lib/uString";

export type DeckID = BrandedUString<'DeckID'>;
export type DeckName = BrandedUString<'DeckName'>;
export type DeckInstance = {
    id: DeckID;
    name: DeckName;
}