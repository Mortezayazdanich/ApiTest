import datetime
import jdatetime

date1 = ["2022-01-24T23:06:15.259Z"]


def g2p(date):
    txt = date[0].split("T")
    txt_date = txt[0].split("-")
    x = datetime.date(int(txt_date[0]), int(txt_date[1]), int(txt_date[2]))
    print(x)
    persian_date = dateToPersian(x)
    return persian_date


def spliter(date):
    txt = date[0].split("T")
    return txt[1]


def dateToPersian(date):
    y = []
    y = jdatetime.date.fromgregorian(date=date)
    return y
