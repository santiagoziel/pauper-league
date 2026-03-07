import { BrandedUString } from "src/lib/uString";

export type ImageUrl = BrandedUString<'ImageUrl'>;
export type CardName = BrandedUString<'CardName'>;
export type CardRecord = {
    name: CardName;
    legal: boolean;
    imageUrl: ImageUrl;
}