import { BrandedUString } from "src/lib/uString";

export type DeckName = BrandedUString<'DeckName'>;
export type DeckInstance = {
    name: DeckName;
}