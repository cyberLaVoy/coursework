import unicodecsv

def read_csv(file_name):
    with open(file_name, 'rb') as f:
        obj = unicodecsv.DictReader(f)
        return list(obj)
                            
read_csv("enrollments.csv")
read_csv("daily_engagement.csv")
read_csv("project_submissions.csv")
