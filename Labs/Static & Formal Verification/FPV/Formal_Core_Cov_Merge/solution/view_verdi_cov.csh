#!/bin/csh -f
 verdi -cov -covdir simv.vdb &
 verdi -cov -covdir formal_core_cov.vdb&
 verdi -cov -covdir Merge_db.vdb&
