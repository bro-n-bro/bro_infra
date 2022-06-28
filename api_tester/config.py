API_PORT = 5002
API_HOST = "0.0.0.0"

NETWORKS = [
    {
        "name": "bostrom",
        "lcd_api": "https://lcd.bostrom.bronbro.io",
        "validator": "bostromvaloper1ydc5fy9fjdygvgw36u49yj39fr67pd9m5qexm8",
        "coingecko_api": "bostrom",
        "prefix": "bostrom",
        "base_denom": "boot",
        "exponent": 1
    },
    {
        "name": "osmosis",
        "lcd_api": "https://lcd.osmosis-1.bronbro.io",
        "validator": "osmovaloper13tk45jkxgf7w0nxquup3suwaz2tx483xe832ge",
        "coingecko_api": "osmosis",
        "prefix": "osmo",
        "base_denom": "uosmo",
        "exponent": 1_000_000
    },
    {
        "name": "juno",
        "lcd_api": "https://lcd.juno-1.bronbro.io",
        "validator": "junovaloper1quqxfrxkycr0uzt4yk0d57tcq3zk7srm7sm6r8",
        "coingecko_api": "juno-network",
        "prefix": "juno",
        "base_denom": "ujuno",
        "exponent": 1_000_000
    },
    {
        "name": "emoney",
        "lcd_api": "https://lcd.emoney-3.bronbro.io",
        "validator": "emoneyvaloper149vyxd36kxpg46rralaw6eejv4d9daqc3nv642",
        "coingecko_api": "e-money",
        "prefix": "emoney",
        "base_denom": "ungm",
        "exponent": 1_000_000
    },
    {
        "name": "microtick",
        "lcd_api": "https://lcd.microtick-1.bronbro.io",
        "validator": "microvaloper13mkjrr578sxd7whex3mqru96vdt3tttw63uwtd",
        "coingecko_api": "microtick",
        "prefix": "micro",
        "base_denom": "utick",
        "exponent": 1_000_000
    },
    {
        "name": "stargaze",
        "lcd_api": "https://lcd.stargaze-1.bronbro.io",
        "validator": "starsvaloper1y58hfnm90r4efhlydx0gavz57lvm7k6uulkg3h",
        "coingecko_api": "stargaze",
        "prefix": "stars",
        "base_denom": "ustars",
        "exponent": 1_000_000
    },
    {
        "name": "gravity",
        "lcd_api": "https://lcd.gravity-bridge-3.bronbro.io",
        "validator": "gravityvaloper1vyd4k5j636erx5y5kdqghdu3rfjtwc48vdc7r6",
        "coingecko_api": "graviton",
        "prefix": "gravity",
        "base_denom": "ugraviton",
        "exponent": 1_000_000
    },
    {
        "name": "evmos",
        "lcd_api": "https://lcd.evmos-9001-2.bronbro.io",
        "validator": "evmosvaloper1ce4vh0e5kanlgc7z0rhcemvd8erjnfzcyfecl7",
        "coingecko_api": "evmos",
        "prefix": "evm",
        "base_denom": "aevmos",
        "exponent": 1_000_000_000_000_000_000
    },
    {
        "name": "crescent",
        "lcd_api": "https://lcd.crescent-1.bronbro.io",
        "validator": "crevaloper1c96vvme4k42zlvkc56fslmdpa2qj6u80xvqwau",
        "coingecko_api": "crescent-network",
        "prefix": "cre",
        "base_denom": "ucre",
        "exponent": 1_000_000
    },
]

