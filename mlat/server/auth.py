from mlat.server import config
if config.AUTH == "mysql":
    import pymysql.cursors
from mlat.server import config

class auth(object):
    def __call__(self, receiver, auth):
        self.receiver = receiver
        self.auth = auth
        if config.AUTH == "mysql":
            # Connect to the database
            connection = pymysql.connect(host=config.DB_HOST,
                             port=config.DB_PORT,
                             user=config.DB_USER,
                             password=config.DB_PASS,
                             db=config.DB_NAME,
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

            try:
                cursor = connection.cursor()
                sql = "SELECT `user_id` FROM `users` WHERE `user_name` = %s AND `user_key` = %s"
                cursor.execute(sql, (str(self.receiver),self.auth))
                if cursor.rowcount == 0:
                    raise ValueError('Invalid user or key')
            finally:
                connection.close()