import sqlite3

DATABASE_FILE = "SOAP.db"
db_interaction = True

def execute_sql(query):
    print(f"\n[!] Executing: {query}")

    con = sqlite3.connect(DATABASE_FILE)
    cur = con.cursor()

    cur.execute("PRAGMA foreign_keys = TRUE")

    try:
        res = cur.execute(query)
        res_fetch = res.fetchall()

    except sqlite3.Error as e:
        print("Error: ", e.args[0])
        return
    
    print("[!] Query Executed!\n")
            
    if res.description is not None:
        print("COLUMN NAMES:")
        for col in res.description:
            print(col[0], end = "|")
        
        print("\n\nTABLE ROWS:")
        for row in res_fetch:
            for item in row:
                print(item, end = "|")
            print()
        print()

    con.commit()
    con.close()

while db_interaction == True:
    myStmt = input("Enter SQL Statement (or quit to end): ")

    if myStmt != "quit":
        execute_sql(myStmt)
    else:
        db_interaction = False