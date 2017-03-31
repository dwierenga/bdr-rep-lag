SELECT 
	'REMOTE_NODE'||node_name||'REMOTE_NODE' AS "Remote Node", 
	localtime(0), 
	pg_xlog_location_diff(pg_current_xlog_insert_location(), flush_location) AS "Bytes Behind This Node", 
	pid, 
        state,
	application_name,
        sent_location,
        write_location,
        flush_location,
        replay_location
FROM 
	pg_stat_replication rep 
	INNER JOIN 
	bdr.bdr_nodes bn 
		ON substring(application_name from 6 for 19) = bn.node_sysid;

