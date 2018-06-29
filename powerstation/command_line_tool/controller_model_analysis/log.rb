dir = ../applications/pw-blog/
Finish reading files
single_attr is def_i 
single_attr is def_user 
single_attr is def_blog 
single_attr is def_bid 
single_attr is def_category 
single_attr is def_id 
single_attr is def_blog 
QUERY [[["controllers/blogs_controller.rb", 8]], 1.2, "Blog", "Load", 0]
QUERY [[["controllers/blogs_controller.rb", 8]], 1.0, "Blog", "Load", 0]
QUERY [[["controllers/blogs_controller.rb", 8]], 1.1, "Blog", "Load", 0]
QUERY [[["controllers/blogs_controller.rb", 8]], 188.5, "Blog", "Load", 0]
n is [BlogsController.before_filter] (1.0) 
n is [BlogsController.show] (1.0) 
n is [BlogsController.show] (2.0) 
n is [BlogsController.show] (2.1) 
n is COPY [BlogsController.show] (2.2) 
n is COPY [BlogsController.show] (2.3) 
n is [BlogsController.show] (2.4) 
n is [BlogsController.show] (2.5) 
n is COPY [BlogsController.show] (2.6) 
n is [BlogsController.show] (2.7) 
n is ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
n is [BlogsController.show] (2.9) 
n is [BlogsController.show] (2.10) 
n is [BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
2 10
2 0
2 8
TDD: [BlogsController.show] (2.10) 
n is [BlogsController.show] (1.0) 
n is [BlogsController.show] (2.0) 
n is [BlogsController.show] (2.1) 
n is RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
TDD: [BlogsController.show] (2.10) 
n is COPY [BlogsController.show] (2.3) 
n is COPY [BlogsController.show] (2.4) 
n is [BlogsController.show] (2.5) 
n is (User)
n is [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
2 6
-1 -1
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
n is ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
2 7
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
n is [BlogsController.show] (2.9) 
n is (User)
n is [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
2 10
-1 -1
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
n is ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
2 11
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
n is [BlogsController.show] (2.13) 
n is COPY <test>[BlogsController.show] (2.14) 
n is COPY <blogs/show>[BlogsController.show] (2.15) 
n is [BlogsController.show] (2.16) %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %cl_1_7[2.14] %cl_1_8[2.15]  %self -> link_to
-1 -1
-1 -1
2 0
2 8
2 12
2 14
2 15
TDD: COPY <test>[BlogsController.show] (2.14) 
TDD: COPY <blogs/show>[BlogsController.show] (2.15) 
n is RETURN [BlogsController.show] (2.17) %cl_1_9[2.16] %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %self[2.16] 
2 16
-1 -1
-1 -1
2 0
2 8
2 12
2 16
TDD: [BlogsController.show] (2.16) %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %cl_1_7[2.14] %cl_1_8[2.15]  %self -> link_to
TDD: COPY <test>[BlogsController.show] (2.14) 
TDD: COPY <blogs/show>[BlogsController.show] (2.15) 
n is [BlogsController.show] (4.0) 
n is [BlogsController.show] (2.12) 
n is COPY [BlogsController.show] (2.13) 
n is [BlogsController.show] (2.14) 
n is COPY [BlogsController.show] (2.15) 
n is [BlogsController.show] (2.16) 
n is [BlogsController.show] (2.17) 
n is BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
2 17
TDD: [BlogsController.show] (2.17) 
n is [BlogsController.show] (3.0) 
n is (Blog)
n is [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
2 0
2 8
n is [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
3 2
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
3 3
2 13
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
3 1
3 4
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
3 5
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (3.7) 
n is [BlogsController.show] (4.0) 
n is [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
2 13
2 15
TDD: COPY [BlogsController.show] (2.13) 
TDD: COPY [BlogsController.show] (2.15) 
n is BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
4 1
TDD: [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
TDD: COPY [BlogsController.show] (2.13) 
TDD: COPY [BlogsController.show] (2.15) 
n is [BlogsController.show] (5.0) 
n is (Blog)
n is [BlogsController.show] (5.2) %v_12[5.1]  %v_12 -> first
5 1
TDD: (Blog)
n is [BlogsController.show] (5.3) 
n is [BlogsController.show] (6.0) 
n is (Blog)
n is [BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
6 1
TDD: (Blog)
n is COPY [BlogsController.show] (6.3) %v_15[6.2] 
6 2
TDD: [BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
TDD: (Blog)
n is COPY [BlogsController.show] (7.0) %v_13[6.3] %v_13[5.2] 
6 3
5 2
TDD: COPY [BlogsController.show] (6.3) %v_15[6.2] 
TDD: [BlogsController.show] (5.2) %v_12[5.1]  %v_12 -> first
TDD: (Blog)
TDD: [BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
TDD: (Blog)
n is [BlogsController.show] (8.0) 
n is (Blog)
n is [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
8 1
TDD: (Blog)
n is COPY [BlogsController.show] (8.3) %v_17[8.2] 
8 2
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (8.4) 
n is [BlogsController.show] (8.5) %v_17[8.2]  %v_17 -> id
8 2
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (8.6) 
n is (Blog)
n is [BlogsController.show] (8.8) b[8.3]  b -> id
8 3
TDD: COPY [BlogsController.show] (8.3) %v_17[8.2] 
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (8.9) %v_19[8.7] %v_20[8.8]  %v_19 -> find
8 7
8 8
TDD: (Blog)
TDD: [BlogsController.show] (8.8) b[8.3]  b -> id
TDD: COPY [BlogsController.show] (8.3) %v_17[8.2] 
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (8.10) 
n is [BlogsController.show] (8.11) b[8.3] b[8.8]  b -> reload
8 3
8 8
TDD: COPY [BlogsController.show] (8.3) %v_17[8.2] 
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (8.12) 
n is COPY <show>[BlogsController.show] (8.13) 
n is [BlogsController.show] (8.14) %self[3.6] %self[2.0] %self[2.8] %v_23[8.13]  %self -> render
3 6
2 0
2 8
8 13
TDD: COPY <show>[BlogsController.show] (8.13) 
n is [BlogsController.show] (8.15) 
n is (Blog)
n is COPY <admin>[BlogsController.show] (8.17) 
n is HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
8 17
TDD: COPY <admin>[BlogsController.show] (8.17) 
n is [BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
8 16
8 18
TDD: (Blog)
TDD: HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
TDD: COPY <admin>[BlogsController.show] (8.17) 
n is [BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
8 19
TDD: [BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
TDD: (Blog)
TDD: HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
TDD: COPY <admin>[BlogsController.show] (8.17) 
n is [BlogsController.show] (8.21) %self[8.14] %self[3.6] %self[2.0] %self[2.8] %v_29[8.20]  %self -> link_to
8 14
3 6
2 0
2 8
8 20
TDD: [BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
TDD: [BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
TDD: (Blog)
TDD: HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
TDD: COPY <admin>[BlogsController.show] (8.17) 
n is [BlogsController.show] (8.22) 
n is (User)
n is [BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
8 23
TDD: (User)
n is [BlogsController.show] (8.25) %self[8.14] %self[8.21] %self[3.6] %self[2.0] %self[2.8] %v_32[8.24]  %self -> link_to
8 14
8 21
3 6
2 0
2 8
8 24
TDD: [BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
TDD: (User)
n is [BlogsController.show] (8.26) 
n is COPY <user>[BlogsController.show] (8.27) 
n is HashField [partial ] [BlogsController.show] (8.28) %v_34[8.27] 
8 27
TDD: COPY <user>[BlogsController.show] (8.27) 
n is [BlogsController.show] (8.29) %self[8.14] %self[8.21] %self[8.25] %self[3.6] %self[2.0] %self[2.8] %v_35[8.28]  %self -> render
8 14
8 21
8 25
3 6
2 0
2 8
8 28
TDD: HashField [partial ] [BlogsController.show] (8.28) %v_34[8.27] 
TDD: COPY <user>[BlogsController.show] (8.27) 
n is [BlogsController.show] (8.30) 
n is GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
8 14
8 21
8 25
8 29
2 0
2 8
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
8 31
8 14
8 21
8 25
8 29
3 6
2 0
2 8
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (1.0) 
n is [BlogsController.show] (2.0) 
n is [BlogsController.show] (2.1) 
n is RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is COPY [BlogsController.show] (2.3) 
n is COPY [BlogsController.show] (2.4) 
n is [BlogsController.show] (3.0) 
n is [BlogsController.show] (3.1) user[2.2]  user -> name
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (3.2) 
n is [BlogsController.show] (3.3) user[3.1] user[2.2]  user -> nickname
3 1
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (3.4) 
n is [BlogsController.show] (3.5) user[3.1] user[3.3] user[2.2]  user -> address
3 1
3 3
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (3.6) 
n is [BlogsController.show] (3.7) user[3.1] user[3.3] user[3.5] user[2.2]  user -> created_at
3 1
3 3
3 5
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is RETURN [BlogsController.show] (3.8) %cl_2_6[3.7] %self[2.0] 
3 7
2 0
TDD: [BlogsController.show] (3.7) user[3.1] user[3.3] user[3.5] user[2.2]  user -> created_at
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
TDD: GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
TDD: ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
TDD: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
TDD: (User)
TDD: COPY [BlogsController.show] (2.6) 
TDD: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
TDD: (User)
n is [BlogsController.show] (4.0) 
n is [BlogsController.show] (4.1) %cl_2_7[4.0] 
4 0
TDD: [BlogsController.show] (4.0) 
n is RETURN [BlogsController.show] (4.2) %cl_2_8[4.1] %self[2.0] 
4 1
2 0
TDD: [BlogsController.show] (4.1) %cl_2_7[4.0] 
TDD: [BlogsController.show] (4.0) 
n is [BlogsController.show] (6.0) 
n is [BlogsController.show] (8.33) 
n is COPY <blogs/blog>[BlogsController.show] (8.34) 
n is HashField [partial ] [BlogsController.show] (8.35) %v_39[8.34] 
8 34
TDD: COPY <blogs/blog>[BlogsController.show] (8.34) 
n is [BlogsController.show] (8.36) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8] %v_40[8.35]  %self -> render
8 14
8 21
8 25
8 29
3 6
2 0
2 8
8 35
TDD: HashField [partial ] [BlogsController.show] (8.35) %v_39[8.34] 
TDD: COPY <blogs/blog>[BlogsController.show] (8.34) 
n is [BlogsController.show] (8.37) 
n is GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
8 14
8 21
8 25
8 29
8 36
3 6
2 0
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
8 38
8 14
8 21
8 25
8 29
8 36
3 6
2 0
2 8
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (1.0) 
n is [BlogsController.show] (2.0) 
n is [BlogsController.show] (2.1) 
n is RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is COPY [BlogsController.show] (2.3) 
n is COPY [BlogsController.show] (2.4) 
n is [BlogsController.show] (3.0) 
n is [BlogsController.show] (3.1) blog[2.2]  blog -> title
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (3.2) 
n is [BlogsController.show] (3.3) blog[3.1] blog[2.2]  blog -> created_at
3 1
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (3.4) 
n is [BlogsController.show] (3.5) blog[3.1] blog[3.3] blog[2.2]  blog -> text
3 1
3 3
2 2
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is RETURN [BlogsController.show] (3.6) %cl_3_5[3.5] %self[2.0] 
3 5
2 0
TDD: [BlogsController.show] (3.5) blog[3.1] blog[3.3] blog[2.2]  blog -> text
TDD: RECEIVEARG [BlogsController.show] (2.2) 
TDD: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
TDD: GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (4.0) 
n is [BlogsController.show] (4.1) %cl_3_6[4.0] 
4 0
TDD: [BlogsController.show] (4.0) 
n is RETURN [BlogsController.show] (4.2) %cl_3_7[4.1] %self[2.0] 
4 1
2 0
TDD: [BlogsController.show] (4.1) %cl_3_6[4.0] 
TDD: [BlogsController.show] (4.0) 
n is [BlogsController.show] (6.0) 
n is [BlogsController.show] (8.40) 
n is GETFIELD [BlogsController.show] (8.41) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
8 14
8 21
8 25
8 29
8 36
3 6
2 0
TDD: ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
TDD: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
TDD: (Blog)
TDD: HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
TDD: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
TDD: COPY [BlogsController.show] (2.13) 
TDD: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
n is [BlogsController.show] (8.42) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8] %v_44[8.41]  %self -> will_paginate
8 14
8 21
8 25
8 29
8 36
3 6
2 0
2 8
8 41
n is [BlogsController.show] (8.43) 
n is COPY <blogs/date>[BlogsController.show] (8.44) 
n is HashField [partial ] [BlogsController.show] (8.45) %v_46[8.44] 
8 44
TDD: COPY <blogs/date>[BlogsController.show] (8.44) 
n is [BlogsController.show] (8.46) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[3.6] %self[2.0] %self[2.8] %v_47[8.45]  %self -> render
8 14
8 21
8 25
8 29
8 36
8 42
3 6
2 0
2 8
8 45
TDD: HashField [partial ] [BlogsController.show] (8.45) %v_46[8.44] 
TDD: COPY <blogs/date>[BlogsController.show] (8.44) 
n is [BlogsController.show] (8.47) 
n is (Time)
n is [BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
8 48
TDD: (Time)
n is [BlogsController.show] (8.50) %v_50[8.49]  %v_50 -> now
8 49
TDD: [BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
TDD: (Time)
n is [BlogsController.show] (8.51) 
n is COPY <test>[BlogsController.show] (8.52) 
n is [BlogsController.show] (8.53) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[8.46] %self[3.6] %self[2.0] %self[2.8] %v_52[8.52]  %self -> link_to
8 14
8 21
8 25
8 29
8 36
8 42
8 46
3 6
2 0
2 8
8 52
TDD: COPY <test>[BlogsController.show] (8.52) 
n is [BlogsController.show] (8.54) 
n is [BlogsController.show] (8.55) b[8.3] b[8.8] b[8.11]  b -> user
8 3
8 8
8 11
TDD: COPY [BlogsController.show] (8.3) %v_17[8.2] 
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is RETURN [BlogsController.show] (8.56) %v_54[8.55] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[8.46] %self[8.53] %self[3.6] %self[2.0] %self[2.8] 
8 55
8 14
8 21
8 25
8 29
8 36
8 42
8 46
8 53
3 6
2 0
2 8
TDD: [BlogsController.show] (8.55) b[8.3] b[8.8] b[8.11]  b -> user
TDD: COPY [BlogsController.show] (8.3) %v_17[8.2] 
TDD: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
TDD: (Blog)
n is [BlogsController.show] (9.0) 
-------------------
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
******************************
Instr is: [BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================

%v_3 = %v_4.each do |i|
----------------------
%v_4.each do |i|
end
--------Finished--------
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
******************************
Instr is: [BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum

%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
----------------------
size = Fixnum
%v_4.each do |i|
User.limit(size)
end
--------Finished--------
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
******************************
Instr is: [BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum

%v_3 = %v_4.each do |i|
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
----------------------
size = Fixnum
%v_4.each do |i|
User.limit(size)
end
--------Finished--------
[BlogsController.show] (2.16) %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %cl_1_7[2.14] %cl_1_8[2.15]  %self -> link_to
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY <blogs/show>[BlogsController.show] (2.15) 
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY <test>[BlogsController.show] (2.14) 
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
******************************
Instr is: [BlogsController.show] (2.16) %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %cl_1_7[2.14] %cl_1_8[2.15]  %self -> link_to
[BlogsController.show] (2.16) %self[-1.-1] %self[-1.-1] %self[2.0] %self[2.8] %self[2.12] %cl_1_7[2.14] %cl_1_8[2.15]  %self -> link_to
COPY <test>[BlogsController.show] (2.14) 
COPY <blogs/show>[BlogsController.show] (2.15) 
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================

%v_3 = %v_4.each do |i|
%cl_1_7 = 'test'
%cl_1_8 = 'blogs/show'
%cl_1_9 = %self.link_to(%cl_1_7, %cl_1_8)
----------------------
%v_4.each do |i|
link_to('test', 'blogs/show')
end
--------Finished--------
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_7 = %self.params
----------------------
if
params
end
--------Finished--------
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_7 = %self.params
%v_8 = %v_7[:page]
----------------------
if
params[:page]
end
--------Finished--------
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
(Blog)
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_6 = Blog
%v_7 = %self.params
%v_8 = %v_7[:page]
%v_9 = :page => %v_8, :per_page => a
%v_10 = %v_6.paginate(%v_9)
----------------------
a = Fixnum
if
Blog.paginate(:page => params[:page], :per_page => a)
end
--------Finished--------
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
******************************
Instr is: [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
COPY [BlogsController.show] (2.13) 
COPY [BlogsController.show] (2.15) 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum
b = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
instr is : [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
%v_11 = a.==(b)
----------------------
a = Fixnum
b = Fixnum
if
else
a.==(b)
end
--------Finished--------
[BlogsController.show] (5.2) %v_12[5.1]  %v_12 -> first
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
(Blog)
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
******************************
Instr is: [BlogsController.show] (5.2) %v_12[5.1]  %v_12 -> first
[BlogsController.show] (5.2) %v_12[5.1]  %v_12 -> first
(Blog)
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
COPY [BlogsController.show] (2.13) 
COPY [BlogsController.show] (2.15) 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum
b = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
instr is : [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
%v_11 = a.==(b)
merge_instr.toString is COPY [BlogsController.show] (7.0) %v_13[6.3] %v_13[5.2] 
outgoings [5, 6]
if
%v_12 = Blog
%v_13 = %v_12.first
----------------------
a = Fixnum
b = Fixnum
if
else
a.==(b)
if
Blog.first
end
end
--------Finished--------
[BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
(Blog)
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.15) 
COPY [BlogsController.show] (2.13) 
******************************
Instr is: [BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
[BlogsController.show] (6.2) %v_14[6.1]  %v_14 -> first
(Blog)
BRANCH [BlogsController.show] (4.2) %v_11[4.1] 
[BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
COPY [BlogsController.show] (2.13) 
COPY [BlogsController.show] (2.15) 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum
b = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
instr is : [BlogsController.show] (4.1) a[2.13] b[2.15]  a -> ==
%v_11 = a.==(b)
merge_instr.toString is COPY [BlogsController.show] (7.0) %v_13[6.3] %v_13[5.2] 
outgoings [5, 6]
if
%v_14 = Blog
%v_15 = %v_14.first
----------------------
a = Fixnum
b = Fixnum
if
else
a.==(b)
if
Blog.first
end
end
--------Finished--------
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
******************************
Instr is: [BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
----------------------
Blog.first
--------Finished--------
[BlogsController.show] (8.5) %v_17[8.2]  %v_17 -> id
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
******************************
Instr is: [BlogsController.show] (8.5) %v_17[8.2]  %v_17 -> id
[BlogsController.show] (8.5) %v_17[8.2]  %v_17 -> id
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
%v_18 = %v_17.id
----------------------
Blog.first.id
--------Finished--------
[BlogsController.show] (8.8) b[8.3]  b -> id
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
COPY [BlogsController.show] (8.3) %v_17[8.2] 
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
******************************
Instr is: [BlogsController.show] (8.8) b[8.3]  b -> id
[BlogsController.show] (8.8) b[8.3]  b -> id
COPY [BlogsController.show] (8.3) %v_17[8.2] 
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
b = %v_17
%v_20 = b.id
----------------------
b = Blog.first
b.id
--------Finished--------
[BlogsController.show] (8.9) %v_19[8.7] %v_20[8.8]  %v_19 -> find
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
COPY [BlogsController.show] (8.3) %v_17[8.2] 
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
[BlogsController.show] (8.8) b[8.3]  b -> id
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
COPY [BlogsController.show] (8.3) %v_17[8.2] 
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
(Blog)
******************************
Instr is: [BlogsController.show] (8.9) %v_19[8.7] %v_20[8.8]  %v_19 -> find
[BlogsController.show] (8.9) %v_19[8.7] %v_20[8.8]  %v_19 -> find
(Blog)
[BlogsController.show] (8.8) b[8.3]  b -> id
COPY [BlogsController.show] (8.3) %v_17[8.2] 
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
b = %v_17
%v_19 = Blog
%v_20 = b.id
%v_21 = %v_19.find(%v_20)
----------------------
b = Blog.first
Blog.find(b.id)
--------Finished--------
[BlogsController.show] (8.11) b[8.3] b[8.8]  b -> reload
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
COPY [BlogsController.show] (8.3) %v_17[8.2] 
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
******************************
Instr is: [BlogsController.show] (8.11) b[8.3] b[8.8]  b -> reload
[BlogsController.show] (8.11) b[8.3] b[8.8]  b -> reload
COPY [BlogsController.show] (8.3) %v_17[8.2] 
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
b = %v_17
%v_22 = b.reload
----------------------
b = Blog.first
b.reload
--------Finished--------
[BlogsController.show] (8.14) %self[3.6] %self[2.0] %self[2.8] %v_23[8.13]  %self -> render
COPY <show>[BlogsController.show] (8.13) 
******************************
Instr is: [BlogsController.show] (8.14) %self[3.6] %self[2.0] %self[2.8] %v_23[8.13]  %self -> render
[BlogsController.show] (8.14) %self[3.6] %self[2.0] %self[2.8] %v_23[8.13]  %self -> render
COPY <show>[BlogsController.show] (8.13) 
=====================
%v_23 = 'show'
%v_24 = %self.render(%v_23)
----------------------
render('show')
--------Finished--------
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
******************************
Instr is: [BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
(Blog)
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
=====================
%v_25 = Blog
%v_26 = 'admin'
%v_27 = :category => %v_26
%v_28 = %v_25.where(%v_27)
----------------------
Blog.where(:category => 'admin')
--------Finished--------
[BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
******************************
Instr is: [BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
[BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
(Blog)
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
=====================
%v_25 = Blog
%v_26 = 'admin'
%v_27 = :category => %v_26
%v_28 = %v_25.where(%v_27)
%v_29 = %v_28.count
----------------------
Blog.where(:category => 'admin').count
--------Finished--------
[BlogsController.show] (8.21) %self[8.14] %self[3.6] %self[2.0] %self[2.8] %v_29[8.20]  %self -> link_to
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
[BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
COPY <admin>[BlogsController.show] (8.17) 
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
(Blog)
******************************
Instr is: [BlogsController.show] (8.21) %self[8.14] %self[3.6] %self[2.0] %self[2.8] %v_29[8.20]  %self -> link_to
[BlogsController.show] (8.21) %self[8.14] %self[3.6] %self[2.0] %self[2.8] %v_29[8.20]  %self -> link_to
[BlogsController.show] (8.20) %v_28[8.19]  %v_28 -> count
[BlogsController.show] (8.19) %v_25[8.16] %v_27[8.18]  %v_25 -> where
(Blog)
HashField [category ] [BlogsController.show] (8.18) %v_26[8.17] 
COPY <admin>[BlogsController.show] (8.17) 
=====================
%v_25 = Blog
%v_26 = 'admin'
%v_27 = :category => %v_26
%v_28 = %v_25.where(%v_27)
%v_29 = %v_28.count
%v_30 = %self.link_to(%v_29)
----------------------
link_to(Blog.where(:category => 'admin').count)
--------Finished--------
[BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
(User)
******************************
Instr is: [BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
[BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
(User)
=====================
%v_31 = User
%v_32 = %v_31.count
----------------------
User.count
--------Finished--------
[BlogsController.show] (8.25) %self[8.14] %self[8.21] %self[3.6] %self[2.0] %self[2.8] %v_32[8.24]  %self -> link_to
(User)
[BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
(User)
******************************
Instr is: [BlogsController.show] (8.25) %self[8.14] %self[8.21] %self[3.6] %self[2.0] %self[2.8] %v_32[8.24]  %self -> link_to
[BlogsController.show] (8.25) %self[8.14] %self[8.21] %self[3.6] %self[2.0] %self[2.8] %v_32[8.24]  %self -> link_to
[BlogsController.show] (8.24) %v_31[8.23]  %v_31 -> count
(User)
=====================
%v_31 = User
%v_32 = %v_31.count
%v_33 = %self.link_to(%v_32)
----------------------
link_to(User.count)
--------Finished--------
[BlogsController.show] (8.29) %self[8.14] %self[8.21] %self[8.25] %self[3.6] %self[2.0] %self[2.8] %v_35[8.28]  %self -> render
COPY <user>[BlogsController.show] (8.27) 
HashField [partial ] [BlogsController.show] (8.28) %v_34[8.27] 
COPY <user>[BlogsController.show] (8.27) 
******************************
Instr is: [BlogsController.show] (8.29) %self[8.14] %self[8.21] %self[8.25] %self[3.6] %self[2.0] %self[2.8] %v_35[8.28]  %self -> render
[BlogsController.show] (8.29) %self[8.14] %self[8.21] %self[8.25] %self[3.6] %self[2.0] %self[2.8] %v_35[8.28]  %self -> render
HashField [partial ] [BlogsController.show] (8.28) %v_34[8.27] 
COPY <user>[BlogsController.show] (8.27) 
=====================
%v_34 = 'user'
%v_35 = :partial => %v_34
%v_36 = %self.render(%v_35)
----------------------
render(:partial => 'user')
--------Finished--------
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
******************************
Instr is: [BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum


%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
users = %cl_1_4
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
users = %cl_1_6
put to the end
%v_37 = %self.users
%v_38 = %v_37.each do |user|
----------------------
size = Fixnum
users = User.limit(size)
users = User.limit(size)
end
users
%v_4.each do |i|7.each do |user|
end
--------Finished--------
[BlogsController.show] (3.1) user[2.2]  user -> name
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
RECEIVEARG [BlogsController.show] (2.2) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
******************************
Instr is: [BlogsController.show] (3.1) user[2.2]  user -> name
[BlogsController.show] (3.1) user[2.2]  user -> name
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum


%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
users = %cl_1_4
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
users = %cl_1_6
put to the end
%v_37 = %self.users
%v_38 = %v_37.each do |user|

%cl_2_3 = user.name
----------------------
size = Fixnum
users = User.limit(size)
users = User.limit(size)
end
users
%v_4.each do |i|7.each do |user|
user.name
end
--------Finished--------
[BlogsController.show] (3.3) user[3.1] user[2.2]  user -> nickname
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
RECEIVEARG [BlogsController.show] (2.2) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
******************************
Instr is: [BlogsController.show] (3.3) user[3.1] user[2.2]  user -> nickname
[BlogsController.show] (3.3) user[3.1] user[2.2]  user -> nickname
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum


%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
users = %cl_1_4
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
users = %cl_1_6
put to the end
%v_37 = %self.users
%v_38 = %v_37.each do |user|

%cl_2_4 = user.nickname
----------------------
size = Fixnum
users = User.limit(size)
users = User.limit(size)
end
users
%v_4.each do |i|7.each do |user|
user.nickname
end
--------Finished--------
[BlogsController.show] (3.5) user[3.1] user[3.3] user[2.2]  user -> address
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
RECEIVEARG [BlogsController.show] (2.2) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
******************************
Instr is: [BlogsController.show] (3.5) user[3.1] user[3.3] user[2.2]  user -> address
[BlogsController.show] (3.5) user[3.1] user[3.3] user[2.2]  user -> address
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum


%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
users = %cl_1_4
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
users = %cl_1_6
put to the end
%v_37 = %self.users
%v_38 = %v_37.each do |user|

%cl_2_5 = user.address
----------------------
size = Fixnum
users = User.limit(size)
users = User.limit(size)
end
users
%v_4.each do |i|7.each do |user|
user.address
end
--------Finished--------
[BlogsController.show] (3.7) user[3.1] user[3.3] user[3.5] user[2.2]  user -> created_at
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
RECEIVEARG [BlogsController.show] (2.2) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
COPY [BlogsController.show] (2.6) 
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
******************************
Instr is: [BlogsController.show] (3.7) user[3.1] user[3.3] user[3.5] user[2.2]  user -> created_at
[BlogsController.show] (3.7) user[3.1] user[3.3] user[3.5] user[2.2]  user -> created_at
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.32) %v_37[8.31] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8]  %v_37 -> each
GETFIELD [BlogsController.show] (8.31) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[2.0] %self[2.8]  %self -> users
ATTRASSIGN [BlogsController.show] (2.8)  %self -> users
ATTRASSIGN [BlogsController.show] (2.8) %cl_1_4[2.7]  %self -> users
ATTRASSIGN [BlogsController.show] (2.12) %cl_1_6[2.11]  %self -> users
[BlogsController.show] (2.11) %cl_1_5[2.10] size[-1.-1]  %cl_1_5 -> limit
(User)
COPY [BlogsController.show] (2.6) 
[BlogsController.show] (2.7) %cl_1_3[2.6] size[-1.-1]  %cl_1_3 -> limit
(User)
[BlogsController.show] (2.11) %v_4[2.10] %self[2.0] %self[2.8]  %v_4 -> each
[BlogsController.show] (2.10) 
=====================
size = Fixnum


%v_3 = %v_4.each do |i|
%cl_1_3 = User
%cl_1_4 = %cl_1_3.limit(size)
users = %cl_1_4
%cl_1_5 = User
%cl_1_6 = %cl_1_5.limit(size)
users = %cl_1_6
put to the end
%v_37 = %self.users
%v_38 = %v_37.each do |user|

%cl_2_6 = user.created_at
----------------------
size = Fixnum
users = User.limit(size)
users = User.limit(size)
end
users
%v_4.each do |i|7.each do |user|
user.created_at
end
--------Finished--------
[BlogsController.show] (8.36) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8] %v_40[8.35]  %self -> render
COPY <blogs/blog>[BlogsController.show] (8.34) 
HashField [partial ] [BlogsController.show] (8.35) %v_39[8.34] 
COPY <blogs/blog>[BlogsController.show] (8.34) 
******************************
Instr is: [BlogsController.show] (8.36) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8] %v_40[8.35]  %self -> render
[BlogsController.show] (8.36) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[3.6] %self[2.0] %self[2.8] %v_40[8.35]  %self -> render
HashField [partial ] [BlogsController.show] (8.35) %v_39[8.34] 
COPY <blogs/blog>[BlogsController.show] (8.34) 
=====================
%v_39 = 'blogs/blog'
%v_40 = :partial => %v_39
%v_41 = %self.render(%v_40)
----------------------
render(:partial => 'blogs/blog')
--------Finished--------
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
(Blog)
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_6 = Blog
%v_7 = %self.params
%v_8 = %v_7[:page]
%v_9 = :page => %v_8, :per_page => a
%v_10 = %v_6.paginate(%v_9)
blogs = %v_10
branch put end
%v_42 = %self.blogs
%v_43 = %v_42.each do |blog|
----------------------
a = Fixnum
if
blogs = Blog.paginate(:page => params[:page], :per_page => a)
end
blogs.each do |blog|
end
--------Finished--------
[BlogsController.show] (3.1) blog[2.2]  blog -> title
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.1) blog[2.2]  blog -> title
[BlogsController.show] (3.1) blog[2.2]  blog -> title
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
(Blog)
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_6 = Blog
%v_7 = %self.params
%v_8 = %v_7[:page]
%v_9 = :page => %v_8, :per_page => a
%v_10 = %v_6.paginate(%v_9)
blogs = %v_10
branch put end
%v_42 = %self.blogs
%v_43 = %v_42.each do |blog|

%cl_3_3 = blog.title
----------------------
a = Fixnum
if
blogs = Blog.paginate(:page => params[:page], :per_page => a)
end
blogs.each do |blog|
blog.title
end
--------Finished--------
[BlogsController.show] (3.3) blog[3.1] blog[2.2]  blog -> created_at
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.3) blog[3.1] blog[2.2]  blog -> created_at
[BlogsController.show] (3.3) blog[3.1] blog[2.2]  blog -> created_at
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
(Blog)
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_6 = Blog
%v_7 = %self.params
%v_8 = %v_7[:page]
%v_9 = :page => %v_8, :per_page => a
%v_10 = %v_6.paginate(%v_9)
blogs = %v_10
branch put end
%v_42 = %self.blogs
%v_43 = %v_42.each do |blog|

%cl_3_4 = blog.created_at
----------------------
a = Fixnum
if
blogs = Blog.paginate(:page => params[:page], :per_page => a)
end
blogs.each do |blog|
blog.created_at
end
--------Finished--------
[BlogsController.show] (3.5) blog[3.1] blog[3.3] blog[2.2]  blog -> text
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
(Blog)
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
******************************
Instr is: [BlogsController.show] (3.5) blog[3.1] blog[3.3] blog[2.2]  blog -> text
[BlogsController.show] (3.5) blog[3.1] blog[3.3] blog[2.2]  blog -> text
RECEIVEARG [BlogsController.show] (2.2) 
[BlogsController.show] (8.39) %v_42[8.38] %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8]  %v_42 -> each
GETFIELD [BlogsController.show] (8.38) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0]  %self -> blogs
ATTRASSIGN [BlogsController.show] (3.6) %v_10[3.5]  %self -> blogs
[BlogsController.show] (3.5) %v_6[3.1] %v_9[3.4]  %v_6 -> paginate
(Blog)
HashField [page per_page ] [BlogsController.show] (3.4) %v_8[3.3] a[2.13] 
[BlogsController.show] (3.3) %v_7[3.2]  %v_7 -> []
COPY [BlogsController.show] (2.13) 
[BlogsController.show] (3.2) %self[2.0] %self[2.8]  %self -> params
BRANCH [BlogsController.show] (2.18) %v_5[2.17] 
[BlogsController.show] (2.17) 
=====================
a = Fixnum

merge_instr.toString is [BlogsController.show] (8.0) 
outgoings [3, 4]
if
%v_6 = Blog
%v_7 = %self.params
%v_8 = %v_7[:page]
%v_9 = :page => %v_8, :per_page => a
%v_10 = %v_6.paginate(%v_9)
blogs = %v_10
branch put end
%v_42 = %self.blogs
%v_43 = %v_42.each do |blog|

%cl_3_5 = blog.text
----------------------
a = Fixnum
if
blogs = Blog.paginate(:page => params[:page], :per_page => a)
end
blogs.each do |blog|
blog.text
end
--------Finished--------
[BlogsController.show] (8.42) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8] %v_44[8.41]  %self -> will_paginate
******************************
Instr is: [BlogsController.show] (8.42) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8] %v_44[8.41]  %self -> will_paginate
[BlogsController.show] (8.42) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[3.6] %self[2.0] %self[2.8] %v_44[8.41]  %self -> will_paginate
=====================
%v_45 = %self.will_paginate(%v_44)
----------------------
will_paginate(%v_44)
--------Finished--------
[BlogsController.show] (8.46) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[3.6] %self[2.0] %self[2.8] %v_47[8.45]  %self -> render
COPY <blogs/date>[BlogsController.show] (8.44) 
HashField [partial ] [BlogsController.show] (8.45) %v_46[8.44] 
COPY <blogs/date>[BlogsController.show] (8.44) 
******************************
Instr is: [BlogsController.show] (8.46) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[3.6] %self[2.0] %self[2.8] %v_47[8.45]  %self -> render
[BlogsController.show] (8.46) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[3.6] %self[2.0] %self[2.8] %v_47[8.45]  %self -> render
HashField [partial ] [BlogsController.show] (8.45) %v_46[8.44] 
COPY <blogs/date>[BlogsController.show] (8.44) 
=====================
%v_46 = 'blogs/date'
%v_47 = :partial => %v_46
%v_48 = %self.render(%v_47)
----------------------
render(:partial => 'blogs/date')
--------Finished--------
[BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
(Time)
******************************
Instr is: [BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
[BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
(Time)
=====================
%v_49 = Time
%v_50 = %v_49.zone
----------------------
Time.zone
--------Finished--------
[BlogsController.show] (8.50) %v_50[8.49]  %v_50 -> now
(Time)
[BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
(Time)
******************************
Instr is: [BlogsController.show] (8.50) %v_50[8.49]  %v_50 -> now
[BlogsController.show] (8.50) %v_50[8.49]  %v_50 -> now
[BlogsController.show] (8.49) %v_49[8.48]  %v_49 -> zone
(Time)
=====================
%v_49 = Time
%v_50 = %v_49.zone
%v_51 = %v_50.now
----------------------
Time.zone.now
--------Finished--------
[BlogsController.show] (8.53) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[8.46] %self[3.6] %self[2.0] %self[2.8] %v_52[8.52]  %self -> link_to
COPY <test>[BlogsController.show] (8.52) 
******************************
Instr is: [BlogsController.show] (8.53) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[8.46] %self[3.6] %self[2.0] %self[2.8] %v_52[8.52]  %self -> link_to
[BlogsController.show] (8.53) %self[8.14] %self[8.21] %self[8.25] %self[8.29] %self[8.36] %self[8.42] %self[8.46] %self[3.6] %self[2.0] %self[2.8] %v_52[8.52]  %self -> link_to
COPY <test>[BlogsController.show] (8.52) 
=====================
%v_52 = 'test'
%v_53 = %self.link_to(%v_52)
----------------------
link_to('test')
--------Finished--------
[BlogsController.show] (8.55) b[8.3] b[8.8] b[8.11]  b -> user
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
COPY [BlogsController.show] (8.3) %v_17[8.2] 
(Blog)
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
******************************
Instr is: [BlogsController.show] (8.55) b[8.3] b[8.8] b[8.11]  b -> user
[BlogsController.show] (8.55) b[8.3] b[8.8] b[8.11]  b -> user
COPY [BlogsController.show] (8.3) %v_17[8.2] 
[BlogsController.show] (8.2) %v_16[8.1]  %v_16 -> first
(Blog)
=====================
%v_16 = Blog
%v_17 = %v_16.first
b = %v_17
%v_54 = b.user
----------------------
b = Blog.first
b.user
--------Finished--------
