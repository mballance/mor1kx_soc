/****************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License. 
 ****************************************************************************/

class sw_txn extends uvm_sequence_item;
	`uvm_object_utils(sw_txn)
	
	rand bit[31:0]					A;
	rand bit[31:0]					B;
	
	constraint c {
		A inside {[1:10]};
		B inside {[1:10]};
	}

	/**
	 * Function: do_pack
	 *
	 * Override from class uvm_object
	 */
	virtual function void do_pack(input uvm_packer packer);
		packer.pack_field_int(A, 32);
		packer.pack_field_int(B, 32);
	endfunction

	/**
	 * Function: do_unpack
	 *
	 * Override from class uvm_object
	 */
	virtual function void do_unpack(input uvm_packer packer);
		A = packer.unpack_field_int(32);
		B = packer.unpack_field_int(32);
	endfunction
	
endclass

