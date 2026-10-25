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

