'''
This small script serves to choose what books should I read from Horus Heresy, a series of over 50 books
'''

#'OTJH4NwxE8fITsx89D9OA', 'w3mliUQHNxV91MjRIQ8gtIK5aTaW1GPKJBNfSU9b2Po')
import goodreads_api_client as gr
import pandas as pd


client = gr.Client(developer_key='OTJH4NwxE8fITsx89D9OA')

serie = client.Series.show('40983') #id of Horus Heresy Series in GoodReads

columns = ['title','author','publication_year','average_rating','ratings_count']
wh40kdf = pd.DataFrame(columns=columns)


for bookdict in serie['series_works']['series_work']:
    info = bookdict['work']
    info2 = info['best_book']

    try:
        print('entrei')
        wh40kdf= wh40kdf.append({'title': info2['title'],
                        'author': info2['author']['name'],
                        'publication_year':int(info['original_publication_year']),
                        'average_rating': int(info['ratings_sum'])/int(info['ratings_count']),
                        'ratings_count': int(info['ratings_count'])},ignore_index=True)
    except TypeError:
        wh40kdf = wh40kdf.append({'title': info2['title'],
                        'author': info2['author']['name'],
                        'publication_year': None,
                        'average_rating': None,
                        'ratings_count': None},ignore_index=True)

wh40kdf.to_csv('Warhammer_Books.csv')