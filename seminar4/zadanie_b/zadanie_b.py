# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: hydrogen
#       format_version: '1.3'
#       jupytext_version: 1.19.6
#   kernelspec:
#     display_name: Python 3 (nvim)
#     language: python
#     name: python3-nvim
# ---
# %%
#uloha 1
import pandas as pd
from pandas.errors import EmptyDataError, ParserError

try:
    df = pd.read_csv("sales_data_dirty.csv")

    print(f"Počet riadkov: {df.shape[0]}")
    print(f"Počet stĺpcov: {df.shape[1]}")
    print(df.head())

except FileNotFoundError:
    print("Chyba: Súbor sales_data_dirty.csv neexistuje.")

except EmptyDataError:
    print("Chyba: Súbor je prázdny.")

except ParserError:
    print("Chyba: Súbor má poškodenú alebo nesprávnu CSV štruktúru.")

except Exception as e:
    print(f"Nastala neočakávaná chyba: {e}")


#%%
import pandas as pd
from pandas.errors import EmptyDataError, ParserError

try:
    df = pd.read_csv("sales_data_dirty.csv")

    print(f"Počet riadkov: {df.shape[0]}")
    print(f"Počet stĺpcov: {df.shape[1]}")
    print(df.head())

except FileNotFoundError:
    print("Chyba: Súbor sales_data_dirty.csv neexistuje.")

except EmptyDataError:
    print("Chyba: Súbor je prázdny.")

except ParserError:
    print("Chyba: Súbor má poškodenú alebo nesprávnu CSV štruktúru.")

except Exception as e:
    print(f"Nastala neočakávaná chyba: {e}")

#%% 

#uloha 3

import pandas as pd

df = pd.read_csv("sales_data_dirty.csv")

required_columns = [
    "OrderID",
    "Region",
    "Product",
    "Quantity"
]

missing_columns = [
    col for col in required_columns
    if col not in df.columns
]

if missing_columns:
    raise ValueError(
        f"Chýbajú povinné stĺpce: {', '.join(missing_columns)}"
    )

print("Všetky povinné stĺpce sú prítomné.")

#%%
#uloha 4

import pandas as pd

df = pd.read_csv("sales_data_dirty.csv")

invalid_order_ids = df[
    ~df["OrderID"].astype(str).str.match(r"^ORD\d{4}$", na=False)
]

duplicate_order_ids = df[
    df.duplicated("OrderID", keep=False)
]

print("OrderID s nesprávnym formátom:")
print(invalid_order_ids)

print("\nDuplicitné OrderID:")
print(duplicate_order_ids)
