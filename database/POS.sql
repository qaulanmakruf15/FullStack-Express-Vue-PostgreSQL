PGDMP                          x            POS    12.3    12.2 #    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16461    POS    DATABASE     w   CREATE DATABASE "POS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE "POS";
                qaulanmakruf    false            �            1259    16475    category    TABLE     Q   CREATE TABLE public.category (
    id bigint NOT NULL,
    name character(50)
);
    DROP TABLE public.category;
       public         heap    qaulanmakruf    false            �            1259    16497    category_id_seq    SEQUENCE     x   CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          qaulanmakruf    false    202            �           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          qaulanmakruf    false    207            �            1259    16483    history    TABLE     �   CREATE TABLE public.history (
    id bigint NOT NULL,
    invoice bigint NOT NULL,
    subtotal numeric(50,0) NOT NULL,
    date date NOT NULL
);
    DROP TABLE public.history;
       public         heap    qaulanmakruf    false            �            1259    16481    history_id_seq    SEQUENCE     w   CREATE SEQUENCE public.history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.history_id_seq;
       public          qaulanmakruf    false    204            �           0    0    history_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.history_id_seq OWNED BY public.history.id;
          public          qaulanmakruf    false    203            �            1259    16491    order    TABLE     �   CREATE TABLE public."order" (
    id bigint NOT NULL,
    id_product bigint NOT NULL,
    id_history bigint NOT NULL,
    price numeric(50,0) NOT NULL,
    ppn numeric(50,0) NOT NULL,
    qty bigint NOT NULL
);
    DROP TABLE public."order";
       public         heap    qaulanmakruf    false            �            1259    16489    order_id_seq    SEQUENCE     u   CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public          qaulanmakruf    false    206            �           0    0    order_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;
          public          qaulanmakruf    false    205            �            1259    16582    product    TABLE     �   CREATE TABLE public.product (
    id bigint NOT NULL,
    id_category bigint NOT NULL,
    name character varying(50) NOT NULL,
    price bigint NOT NULL,
    image character varying,
    created date,
    updated date,
    status bigint NOT NULL
);
    DROP TABLE public.product;
       public         heap    qaulanmakruf    false            �            1259    16580    product_id_seq    SEQUENCE     w   CREATE SEQUENCE public.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          qaulanmakruf    false    210            �           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          qaulanmakruf    false    209            �            1259    16517    users    TABLE       CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    name character varying(50) NOT NULL,
    role_id bigint,
    status bigint,
    created date,
    updated date,
    image bytea
);
    DROP TABLE public.users;
       public         heap    qaulanmakruf    false                       2604    16499    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          qaulanmakruf    false    207    202                       2604    16486 
   history id    DEFAULT     h   ALTER TABLE ONLY public.history ALTER COLUMN id SET DEFAULT nextval('public.history_id_seq'::regclass);
 9   ALTER TABLE public.history ALTER COLUMN id DROP DEFAULT;
       public          qaulanmakruf    false    203    204    204                       2604    16494    order id    DEFAULT     f   ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);
 9   ALTER TABLE public."order" ALTER COLUMN id DROP DEFAULT;
       public          qaulanmakruf    false    205    206    206                       2604    16585 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          qaulanmakruf    false    209    210    210            �          0    16475    category 
   TABLE DATA           ,   COPY public.category (id, name) FROM stdin;
    public          qaulanmakruf    false    202   �$       �          0    16483    history 
   TABLE DATA           >   COPY public.history (id, invoice, subtotal, date) FROM stdin;
    public          qaulanmakruf    false    204   �$       �          0    16491    order 
   TABLE DATA           N   COPY public."order" (id, id_product, id_history, price, ppn, qty) FROM stdin;
    public          qaulanmakruf    false    206   �%       �          0    16582    product 
   TABLE DATA           `   COPY public.product (id, id_category, name, price, image, created, updated, status) FROM stdin;
    public          qaulanmakruf    false    210   �&       �          0    16517    users 
   TABLE DATA           d   COPY public.users (id, email, password, name, role_id, status, created, updated, image) FROM stdin;
    public          qaulanmakruf    false    208   (       �           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 8, true);
          public          qaulanmakruf    false    207            �           0    0    history_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.history_id_seq', 12, true);
          public          qaulanmakruf    false    203            �           0    0    order_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.order_id_seq', 9, true);
          public          qaulanmakruf    false    205            �           0    0    product_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.product_id_seq', 9, true);
          public          qaulanmakruf    false    209                       2606    16526    category categorys_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.category
    ADD CONSTRAINT categorys_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY public.category DROP CONSTRAINT categorys_pkey;
       public            qaulanmakruf    false    202                       2606    16488    history history_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
       public            qaulanmakruf    false    204                       2606    16496    order order_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public."order" DROP CONSTRAINT order_pkey;
       public            qaulanmakruf    false    206                       2606    16590    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            qaulanmakruf    false    210                       2606    16524    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            qaulanmakruf    false    208            �   )   x�3�t��OQ 	pq�e�e��ɘ�39�4��b���� �I      �   �   x�U��BQ�5��ß^���uINf yvgL8�KDHE咾4�)��"H��ss3��Z-Ç�Pg<FP��
�<�M~�t�ѭ��*qh1����(���B%���{�1�`������20��홽[J���u'����|���(6c�lε��3� �A      �   �   x�]�Kr1C�p����w���$g�ݳpM�������?x�B�]Zx\-%�Z]��_;%Aө�+-H�+]�Aa��,JL4H�#Z�� ^�}{��7ٸ����n�����/�~2�����&XJ�E�}�M�h&���._(�Wy�o�׳��(��L��Rc�
K�Z�GÐ��f���m�d�١a"�->��sژ<�y��v���;�X0;_3�ѯO�ɣ��h>���Q�?Vq]      �   c  x���MO�0���W�LӖv���^4v7��MHʂ|��5��ЍA{��y��y� ��lB�my�}4�`��xH^���%�}�
��1Wz!t6�.3��^�3��&�'"���i�1��wQ*]P��"!��.�\"�6k�"J/�h��@�n*���Z�)�4qA���|uq�AK�mt�	��am�۫���4��;O��݀r������r�ֻ�Ů}CԺ��3W�!����!=Խ䶶��Y��$b��K��I�CxC���r����`oʪ��Ӵ��`����?}0�����LG��r&��t�ǅ����ޚ�	~�"Z���N�/d��b���J/v;2�q>M���      �   ~  x�e�Iw�0���Wt�aw�HQ�
m�	�!2IB��;-j�9oqW�w�U@�x��
��p�H)n�
`:P����68��åi�d���Ľ���iO4'�ř&;snb�[�
L���7@� (C�^���m�l.[�r�ѾX����_���ܬ�6��PV6�E�ǖg��^'���(��������>�7Z��VhW��/�mE,&��v��7~U�N�E��Ҍ�P�]7��
'�Ip���� �FXGQ�п��ڟ����9�{��\M��y�";ߣ|�:9��N�\�RY���p͂�X����}7��~6����t�#�YJ��C,a��#�|v�Sf�Y(M#�o���~�RY���}���.���/l��6� ^��     