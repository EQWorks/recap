def flatten_gb(gb_df, **kwargs):
    df = gb_df.copy()
    df.columns = ['_'.join(col) for col in df.columns]
    return df.reset_index(**kwargs)
