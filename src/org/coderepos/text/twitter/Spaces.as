package org.coderepos.text.twitter
{
    public class Spaces
    {
        private static const UNICODE_SPACE_RANGES:Array = [
            "\u0009-\u000d",
            "\u0020",
            "\u0085",
            "\u00a0",
            "\u1680",
            "\u180E",
            "\u2000-\u200a",
            "\u2028",
            "\u2029",
            "\u202F",
            "\u205F",
            "\u3000"
        ];

        public static function getCharacterClass():String
        {
            return UNICODE_SPACE_RANGES.join("");
        }
    }
}

