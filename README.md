# Lock not not working as expected due to query caching

When an object is locked more then once in the same request, it is being locked properly
only the first time. The subsequent `SELECT ... FOR UPDATE` queries on (PostgreSQL) are
getting cached and hence the lock is not issued, breaking developers' expectations.

To observe the bug, start the application (configured to run against PostgreSQL server)
and navigate to the app root. Look at the SQL statements in console and you'll notice
that the second query is returned from query cache.

<https://img.skitch.com/20120705-d9bnhqmtyaddku5nimparwys6j.png>

The third query is wrapped inside `#uncached` block to demonstrate a workaround.
