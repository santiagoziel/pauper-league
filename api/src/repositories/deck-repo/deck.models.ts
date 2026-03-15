import { BrandedUString } from "src/lib/uString";

export type DeckID = BrandedUString<'DeckId'>;
export type DeckName = BrandedUString<'DeckName'>;
export type DeckInstance = {
    id: DeckID;
    name: DeckName;
}