#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
#

set -e
set -x

url="$(svn info --show-item url)"
branch="${url##*/}"
export MALLOC_OPTIONS=S
(cd .. && gmake BRANCH="$branch" PARALLEL="4" THREADING="no" JAVA="no" \
                EXCLUSIVE_WC_LOCKS=1 \
                                  svn-check-local \
                                  svn-check-svn \
                                  svn-check-neon \
                                  svn-check-serf)
grep -q "^FAIL:" tests.log.svn-check* && exit 1
grep -q "^XPASS:" tests.log.svn-check* && exit 1
exit 0
