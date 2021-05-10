from typing import List


class CursorColumnDescription():

    def __init__(self, name) -> None:
        self.name = name

class MockedCursor():

    def set_result(self, table: dict = {}, affected_rows: int=0) -> None:
        self.executed_query = ''
        self.rowcount = affected_rows
        self.description = [CursorColumnDescription(x) for x in table] if len(table) > 0 else None
        self.rows = []
        if not self.description or len(self.description) == 0:
            return
        rows_count = len(table[self.description[0].name])
        for i in range(rows_count):
            row = []
            for col in self.description:
                row.append(table[col.name][i])
            self.rows.append(row)

    def fetchall(self) -> List[List[object]]:
        return self.rows