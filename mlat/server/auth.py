# -*- mode: python; indent-tabs-mode: nil -*-

# Copyright (C) 2015  Ycarus (Yannick Chabanois) <ycarus@zugaina.org>
# Part of mlat-server: a Mode S multilateration server
# Copyright (C) 2015  Oliver Jowett <oliver@mutability.co.uk>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
User authentication part of mlat-server
"""

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