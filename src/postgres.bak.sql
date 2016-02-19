PGDMP     1    	                t            plsys_with_backbone    9.3.10    9.3.10    8	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            9	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            :	           1262    16558    plsys_with_backbone    DATABASE     w   CREATE DATABASE plsys_with_backbone WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE plsys_with_backbone;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            ;	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5            <	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    5            �            3079    11787    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            =	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    223            �            1259    16590 
   auth_group    TABLE     ^   CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);
    DROP TABLE public.auth_group;
       public         ninopq    false    5            �            1259    16588    auth_group_id_seq    SEQUENCE     s   CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public       ninopq    false    177    5            >	           0    0    auth_group_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;
            public       ninopq    false    176            �            1259    16600    auth_group_permissions    TABLE     �   CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         ninopq    false    5            �            1259    16598    auth_group_permissions_id_seq    SEQUENCE        CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public       ninopq    false    179    5            ?	           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;
            public       ninopq    false    178            �            1259    16582    auth_permission    TABLE     �   CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         ninopq    false    5            �            1259    16580    auth_permission_id_seq    SEQUENCE     x   CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public       ninopq    false    175    5            @	           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;
            public       ninopq    false    174            �            1259    16631    authtools_user    TABLE     z  CREATE TABLE authtools_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(255) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL
);
 "   DROP TABLE public.authtools_user;
       public         ninopq    false    5            �            1259    16644    authtools_user_groups    TABLE     }   CREATE TABLE authtools_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 )   DROP TABLE public.authtools_user_groups;
       public         ninopq    false    5            �            1259    16642    authtools_user_groups_id_seq    SEQUENCE     ~   CREATE SEQUENCE authtools_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.authtools_user_groups_id_seq;
       public       ninopq    false    5    183            A	           0    0    authtools_user_groups_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE authtools_user_groups_id_seq OWNED BY authtools_user_groups.id;
            public       ninopq    false    182            �            1259    16629    authtools_user_id_seq    SEQUENCE     w   CREATE SEQUENCE authtools_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.authtools_user_id_seq;
       public       ninopq    false    181    5            B	           0    0    authtools_user_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE authtools_user_id_seq OWNED BY authtools_user.id;
            public       ninopq    false    180            �            1259    16652    authtools_user_user_permissions    TABLE     �   CREATE TABLE authtools_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 3   DROP TABLE public.authtools_user_user_permissions;
       public         ninopq    false    5            �            1259    16650 &   authtools_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE authtools_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.authtools_user_user_permissions_id_seq;
       public       ninopq    false    5    185            C	           0    0 &   authtools_user_user_permissions_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE authtools_user_user_permissions_id_seq OWNED BY authtools_user_user_permissions.id;
            public       ninopq    false    184            �            1259    16689    django_admin_log    TABLE     �  CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         ninopq    false    5            �            1259    16687    django_admin_log_id_seq    SEQUENCE     y   CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public       ninopq    false    5    187            D	           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;
            public       ninopq    false    186            �            1259    16572    django_content_type    TABLE     �   CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         ninopq    false    5            �            1259    16570    django_content_type_id_seq    SEQUENCE     |   CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public       ninopq    false    5    173            E	           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;
            public       ninopq    false    172            �            1259    16561    django_migrations    TABLE     �   CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         ninopq    false    5            �            1259    16559    django_migrations_id_seq    SEQUENCE     z   CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public       ninopq    false    171    5            F	           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;
            public       ninopq    false    170            �            1259    16943    django_session    TABLE     �   CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         ninopq    false    5            �            1259    16724    easy_thumbnails_source    TABLE     �   CREATE TABLE easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);
 *   DROP TABLE public.easy_thumbnails_source;
       public         ninopq    false    5            �            1259    16722    easy_thumbnails_source_id_seq    SEQUENCE        CREATE SEQUENCE easy_thumbnails_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.easy_thumbnails_source_id_seq;
       public       ninopq    false    5    189            G	           0    0    easy_thumbnails_source_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE easy_thumbnails_source_id_seq OWNED BY easy_thumbnails_source.id;
            public       ninopq    false    188            �            1259    16732    easy_thumbnails_thumbnail    TABLE     �   CREATE TABLE easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);
 -   DROP TABLE public.easy_thumbnails_thumbnail;
       public         ninopq    false    5            �            1259    16730     easy_thumbnails_thumbnail_id_seq    SEQUENCE     �   CREATE SEQUENCE easy_thumbnails_thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.easy_thumbnails_thumbnail_id_seq;
       public       ninopq    false    5    191            H	           0    0     easy_thumbnails_thumbnail_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE easy_thumbnails_thumbnail_id_seq OWNED BY easy_thumbnails_thumbnail.id;
            public       ninopq    false    190            �            1259    16758 #   easy_thumbnails_thumbnaildimensions    TABLE     D  CREATE TABLE easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);
 7   DROP TABLE public.easy_thumbnails_thumbnaildimensions;
       public         ninopq    false    5            �            1259    16756 *   easy_thumbnails_thumbnaildimensions_id_seq    SEQUENCE     �   CREATE SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.easy_thumbnails_thumbnaildimensions_id_seq;
       public       ninopq    false    193    5            I	           0    0 *   easy_thumbnails_thumbnaildimensions_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq OWNED BY easy_thumbnails_thumbnaildimensions.id;
            public       ninopq    false    192            �            1259    16775    game_category    TABLE     �   CREATE TABLE game_category (
    id integer NOT NULL,
    name character varying(1000) NOT NULL,
    description text,
    image character varying(100)
);
 !   DROP TABLE public.game_category;
       public         ninopq    false    5            �            1259    16773    game_category_id_seq    SEQUENCE     v   CREATE SEQUENCE game_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.game_category_id_seq;
       public       ninopq    false    195    5            J	           0    0    game_category_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE game_category_id_seq OWNED BY game_category.id;
            public       ninopq    false    194            �            1259    16809    game_gameinstance    TABLE     �   CREATE TABLE game_gameinstance (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    seed text NOT NULL,
    game_id integer NOT NULL,
    instantiator_id integer NOT NULL,
    pagecache text
);
 %   DROP TABLE public.game_gameinstance;
       public         ninopq    false    5            �            1259    16807    game_gameinstance_id_seq    SEQUENCE     z   CREATE SEQUENCE game_gameinstance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.game_gameinstance_id_seq;
       public       ninopq    false    199    5            K	           0    0    game_gameinstance_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE game_gameinstance_id_seq OWNED BY game_gameinstance.id;
            public       ninopq    false    198            �            1259    16820    game_gameinstancesnapshot    TABLE     �   CREATE TABLE game_gameinstancesnapshot (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    "time" double precision NOT NULL,
    instance_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);
 -   DROP TABLE public.game_gameinstancesnapshot;
       public         ninopq    false    5            �            1259    16818     game_gameinstancesnapshot_id_seq    SEQUENCE     �   CREATE SEQUENCE game_gameinstancesnapshot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.game_gameinstancesnapshot_id_seq;
       public       ninopq    false    201    5            L	           0    0     game_gameinstancesnapshot_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE game_gameinstancesnapshot_id_seq OWNED BY game_gameinstancesnapshot.id;
            public       ninopq    false    200            �            1259    17415    game_imagetest    TABLE     d   CREATE TABLE game_imagetest (
    id integer NOT NULL,
    image character varying(100) NOT NULL
);
 "   DROP TABLE public.game_imagetest;
       public         ninopq    false    5            �            1259    17413    game_imagetest_id_seq    SEQUENCE     w   CREATE SEQUENCE game_imagetest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.game_imagetest_id_seq;
       public       ninopq    false    214    5            M	           0    0    game_imagetest_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE game_imagetest_id_seq OWNED BY game_imagetest.id;
            public       ninopq    false    213            �            1259    25683    game_jslibrary    TABLE     �   CREATE TABLE game_jslibrary (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    "scriptPath" character varying(200) NOT NULL
);
 "   DROP TABLE public.game_jslibrary;
       public         ninopq    false    5            �            1259    25681    game_jslibrary_id_seq    SEQUENCE     w   CREATE SEQUENCE game_jslibrary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.game_jslibrary_id_seq;
       public       ninopq    false    218    5            N	           0    0    game_jslibrary_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE game_jslibrary_id_seq OWNED BY game_jslibrary.id;
            public       ninopq    false    217            �            1259    16786    game_zeroplayergame    TABLE     �  CREATE TABLE game_zeroplayergame (
    id integer NOT NULL,
    title character varying(500) NOT NULL,
    description text NOT NULL,
    created timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    owner_id integer NOT NULL,
    "scriptName" character varying(500),
    "scriptType" character varying(100),
    source text NOT NULL,
    "seedStructure" text NOT NULL
);
 '   DROP TABLE public.game_zeroplayergame;
       public         ninopq    false    5            �            1259    16784    game_plerpingapp_id_seq    SEQUENCE     y   CREATE SEQUENCE game_plerpingapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.game_plerpingapp_id_seq;
       public       ninopq    false    5    197            O	           0    0    game_plerpingapp_id_seq    SEQUENCE OWNED BY     H   ALTER SEQUENCE game_plerpingapp_id_seq OWNED BY game_zeroplayergame.id;
            public       ninopq    false    196            �            1259    25691 !   game_zeroplayergame_extraIncludes    TABLE     �   CREATE TABLE "game_zeroplayergame_extraIncludes" (
    id integer NOT NULL,
    zeroplayergame_id integer NOT NULL,
    jslibrary_id integer NOT NULL
);
 7   DROP TABLE public."game_zeroplayergame_extraIncludes";
       public         ninopq    false    5            �            1259    25689 (   game_zeroplayergame_extraIncludes_id_seq    SEQUENCE     �   CREATE SEQUENCE "game_zeroplayergame_extraIncludes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public."game_zeroplayergame_extraIncludes_id_seq";
       public       ninopq    false    220    5            P	           0    0 (   game_zeroplayergame_extraIncludes_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE "game_zeroplayergame_extraIncludes_id_seq" OWNED BY "game_zeroplayergame_extraIncludes".id;
            public       ninopq    false    219            �            1259    16869    portfolio_imagegallery    TABLE     k   CREATE TABLE portfolio_imagegallery (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);
 *   DROP TABLE public.portfolio_imagegallery;
       public         ninopq    false    5            �            1259    16867    portfolio_imagegallery_id_seq    SEQUENCE        CREATE SEQUENCE portfolio_imagegallery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.portfolio_imagegallery_id_seq;
       public       ninopq    false    5    203            Q	           0    0    portfolio_imagegallery_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE portfolio_imagegallery_id_seq OWNED BY portfolio_imagegallery.id;
            public       ninopq    false    202            �            1259    16877    portfolio_imagemodel    TABLE     �   CREATE TABLE portfolio_imagemodel (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    gallery_id integer
);
 (   DROP TABLE public.portfolio_imagemodel;
       public         ninopq    false    5            �            1259    16875    portfolio_imagemodel_id_seq    SEQUENCE     }   CREATE SEQUENCE portfolio_imagemodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.portfolio_imagemodel_id_seq;
       public       ninopq    false    5    205            R	           0    0    portfolio_imagemodel_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE portfolio_imagemodel_id_seq OWNED BY portfolio_imagemodel.id;
            public       ninopq    false    204            �            1259    16885    portfolio_portfoliocategory    TABLE     �   CREATE TABLE portfolio_portfoliocategory (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image character varying(100)
);
 /   DROP TABLE public.portfolio_portfoliocategory;
       public         ninopq    false    5            �            1259    16883 "   portfolio_portfoliocategory_id_seq    SEQUENCE     �   CREATE SEQUENCE portfolio_portfoliocategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.portfolio_portfoliocategory_id_seq;
       public       ninopq    false    5    207            S	           0    0 "   portfolio_portfoliocategory_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE portfolio_portfoliocategory_id_seq OWNED BY portfolio_portfoliocategory.id;
            public       ninopq    false    206            �            1259    16896    portfolio_portfolioitem    TABLE     e  CREATE TABLE portfolio_portfolioitem (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    subtitle character varying(500) NOT NULL,
    description text NOT NULL,
    sourcecode character varying(200),
    image character varying(100),
    creationdate date NOT NULL,
    category_id integer NOT NULL,
    url character varying(150)
);
 +   DROP TABLE public.portfolio_portfolioitem;
       public         ninopq    false    5            �            1259    16894    portfolio_portfolioitem_id_seq    SEQUENCE     �   CREATE SEQUENCE portfolio_portfolioitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.portfolio_portfolioitem_id_seq;
       public       ninopq    false    209    5            T	           0    0    portfolio_portfolioitem_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE portfolio_portfolioitem_id_seq OWNED BY portfolio_portfolioitem.id;
            public       ninopq    false    208            �            1259    16905 "   portfolio_proprietaryportfolioitem    TABLE     �   CREATE TABLE portfolio_proprietaryportfolioitem (
    portfolioitem_ptr_id integer NOT NULL,
    company character varying(100) NOT NULL,
    gallery_id integer NOT NULL
);
 6   DROP TABLE public.portfolio_proprietaryportfolioitem;
       public         ninopq    false    5            �            1259    16933    profiles_profile    TABLE     �   CREATE TABLE profiles_profile (
    user_id integer NOT NULL,
    slug uuid NOT NULL,
    picture character varying(100),
    bio character varying(200),
    email_verified boolean NOT NULL
);
 $   DROP TABLE public.profiles_profile;
       public         ninopq    false    5            �            1259    25730    profiles_profile_followers    TABLE     �   CREATE TABLE profiles_profile_followers (
    id integer NOT NULL,
    from_profile_id integer NOT NULL,
    to_profile_id integer NOT NULL
);
 .   DROP TABLE public.profiles_profile_followers;
       public         ninopq    false    5            �            1259    25728 !   profiles_profile_followers_id_seq    SEQUENCE     �   CREATE SEQUENCE profiles_profile_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.profiles_profile_followers_id_seq;
       public       ninopq    false    222    5            U	           0    0 !   profiles_profile_followers_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE profiles_profile_followers_id_seq OWNED BY profiles_profile_followers.id;
            public       ninopq    false    221            �            1259    17504    static_precompiler_dependency    TABLE     �   CREATE TABLE static_precompiler_dependency (
    id integer NOT NULL,
    source character varying(255) NOT NULL,
    depends_on character varying(255) NOT NULL
);
 1   DROP TABLE public.static_precompiler_dependency;
       public         ninopq    false    5            �            1259    17502 $   static_precompiler_dependency_id_seq    SEQUENCE     �   CREATE SEQUENCE static_precompiler_dependency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.static_precompiler_dependency_id_seq;
       public       ninopq    false    5    216            V	           0    0 $   static_precompiler_dependency_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE static_precompiler_dependency_id_seq OWNED BY static_precompiler_dependency.id;
            public       ninopq    false    215            �           2604    16593    id    DEFAULT     `   ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    177    176    177            �           2604    16603    id    DEFAULT     x   ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    178    179    179            �           2604    16585    id    DEFAULT     j   ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    174    175    175            �           2604    16634    id    DEFAULT     h   ALTER TABLE ONLY authtools_user ALTER COLUMN id SET DEFAULT nextval('authtools_user_id_seq'::regclass);
 @   ALTER TABLE public.authtools_user ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    181    180    181            �           2604    16647    id    DEFAULT     v   ALTER TABLE ONLY authtools_user_groups ALTER COLUMN id SET DEFAULT nextval('authtools_user_groups_id_seq'::regclass);
 G   ALTER TABLE public.authtools_user_groups ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    182    183    183            �           2604    16655    id    DEFAULT     �   ALTER TABLE ONLY authtools_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('authtools_user_user_permissions_id_seq'::regclass);
 Q   ALTER TABLE public.authtools_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    185    184    185            �           2604    16692    id    DEFAULT     l   ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    186    187    187            �           2604    16575    id    DEFAULT     r   ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    172    173    173            �           2604    16564    id    DEFAULT     n   ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    170    171    171            �           2604    16727    id    DEFAULT     x   ALTER TABLE ONLY easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_source_id_seq'::regclass);
 H   ALTER TABLE public.easy_thumbnails_source ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    189    188    189            �           2604    16735    id    DEFAULT     ~   ALTER TABLE ONLY easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnail_id_seq'::regclass);
 K   ALTER TABLE public.easy_thumbnails_thumbnail ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    190    191    191            �           2604    16761    id    DEFAULT     �   ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnaildimensions_id_seq'::regclass);
 U   ALTER TABLE public.easy_thumbnails_thumbnaildimensions ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    192    193    193            �           2604    16778    id    DEFAULT     f   ALTER TABLE ONLY game_category ALTER COLUMN id SET DEFAULT nextval('game_category_id_seq'::regclass);
 ?   ALTER TABLE public.game_category ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    194    195    195            �           2604    16812    id    DEFAULT     n   ALTER TABLE ONLY game_gameinstance ALTER COLUMN id SET DEFAULT nextval('game_gameinstance_id_seq'::regclass);
 C   ALTER TABLE public.game_gameinstance ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    198    199    199            �           2604    16823    id    DEFAULT     ~   ALTER TABLE ONLY game_gameinstancesnapshot ALTER COLUMN id SET DEFAULT nextval('game_gameinstancesnapshot_id_seq'::regclass);
 K   ALTER TABLE public.game_gameinstancesnapshot ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    201    200    201                        2604    17418    id    DEFAULT     h   ALTER TABLE ONLY game_imagetest ALTER COLUMN id SET DEFAULT nextval('game_imagetest_id_seq'::regclass);
 @   ALTER TABLE public.game_imagetest ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    214    213    214                       2604    25686    id    DEFAULT     h   ALTER TABLE ONLY game_jslibrary ALTER COLUMN id SET DEFAULT nextval('game_jslibrary_id_seq'::regclass);
 @   ALTER TABLE public.game_jslibrary ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    218    217    218            �           2604    16789    id    DEFAULT     o   ALTER TABLE ONLY game_zeroplayergame ALTER COLUMN id SET DEFAULT nextval('game_plerpingapp_id_seq'::regclass);
 E   ALTER TABLE public.game_zeroplayergame ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    197    196    197                       2604    25694    id    DEFAULT     �   ALTER TABLE ONLY "game_zeroplayergame_extraIncludes" ALTER COLUMN id SET DEFAULT nextval('"game_zeroplayergame_extraIncludes_id_seq"'::regclass);
 U   ALTER TABLE public."game_zeroplayergame_extraIncludes" ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    219    220    220            �           2604    16872    id    DEFAULT     x   ALTER TABLE ONLY portfolio_imagegallery ALTER COLUMN id SET DEFAULT nextval('portfolio_imagegallery_id_seq'::regclass);
 H   ALTER TABLE public.portfolio_imagegallery ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    203    202    203            �           2604    16880    id    DEFAULT     t   ALTER TABLE ONLY portfolio_imagemodel ALTER COLUMN id SET DEFAULT nextval('portfolio_imagemodel_id_seq'::regclass);
 F   ALTER TABLE public.portfolio_imagemodel ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    205    204    205            �           2604    16888    id    DEFAULT     �   ALTER TABLE ONLY portfolio_portfoliocategory ALTER COLUMN id SET DEFAULT nextval('portfolio_portfoliocategory_id_seq'::regclass);
 M   ALTER TABLE public.portfolio_portfoliocategory ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    207    206    207            �           2604    16899    id    DEFAULT     z   ALTER TABLE ONLY portfolio_portfolioitem ALTER COLUMN id SET DEFAULT nextval('portfolio_portfolioitem_id_seq'::regclass);
 I   ALTER TABLE public.portfolio_portfolioitem ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    209    208    209                       2604    25733    id    DEFAULT     �   ALTER TABLE ONLY profiles_profile_followers ALTER COLUMN id SET DEFAULT nextval('profiles_profile_followers_id_seq'::regclass);
 L   ALTER TABLE public.profiles_profile_followers ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    221    222    222                       2604    17507    id    DEFAULT     �   ALTER TABLE ONLY static_precompiler_dependency ALTER COLUMN id SET DEFAULT nextval('static_precompiler_dependency_id_seq'::regclass);
 O   ALTER TABLE public.static_precompiler_dependency ALTER COLUMN id DROP DEFAULT;
       public       ninopq    false    215    216    216            	          0    16590 
   auth_group 
   TABLE DATA               '   COPY auth_group (id, name) FROM stdin;
    public       ninopq    false    177   `Y      W	           0    0    auth_group_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('auth_group_id_seq', 2, true);
            public       ninopq    false    176            
	          0    16600    auth_group_permissions 
   TABLE DATA               F   COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public       ninopq    false    179   �Y      X	           0    0    auth_group_permissions_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('auth_group_permissions_id_seq', 8, true);
            public       ninopq    false    178            	          0    16582    auth_permission 
   TABLE DATA               G   COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
    public       ninopq    false    175   �Y      Y	           0    0    auth_permission_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('auth_permission_id_seq', 69, true);
            public       ninopq    false    174            	          0    16631    authtools_user 
   TABLE DATA               x   COPY authtools_user (id, password, last_login, is_superuser, email, is_staff, is_active, date_joined, name) FROM stdin;
    public       ninopq    false    181   �\      	          0    16644    authtools_user_groups 
   TABLE DATA               ?   COPY authtools_user_groups (id, user_id, group_id) FROM stdin;
    public       ninopq    false    183   �]      Z	           0    0    authtools_user_groups_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('authtools_user_groups_id_seq', 1, true);
            public       ninopq    false    182            [	           0    0    authtools_user_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('authtools_user_id_seq', 1, true);
            public       ninopq    false    180            	          0    16652    authtools_user_user_permissions 
   TABLE DATA               N   COPY authtools_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public       ninopq    false    185   �]      \	           0    0 &   authtools_user_user_permissions_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('authtools_user_user_permissions_id_seq', 1, false);
            public       ninopq    false    184            	          0    16689    django_admin_log 
   TABLE DATA               �   COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public       ninopq    false    187   �]      ]	           0    0    django_admin_log_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('django_admin_log_id_seq', 73, true);
            public       ninopq    false    186            	          0    16572    django_content_type 
   TABLE DATA               <   COPY django_content_type (id, app_label, model) FROM stdin;
    public       ninopq    false    173   �c      ^	           0    0    django_content_type_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('django_content_type_id_seq', 23, true);
            public       ninopq    false    172            	          0    16561    django_migrations 
   TABLE DATA               <   COPY django_migrations (id, app, name, applied) FROM stdin;
    public       ninopq    false    171   e      _	           0    0    django_migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('django_migrations_id_seq', 42, true);
            public       ninopq    false    170            +	          0    16943    django_session 
   TABLE DATA               I   COPY django_session (session_key, session_data, expire_date) FROM stdin;
    public       ninopq    false    212   �h      	          0    16724    easy_thumbnails_source 
   TABLE DATA               K   COPY easy_thumbnails_source (id, storage_hash, name, modified) FROM stdin;
    public       ninopq    false    189   ,j      `	           0    0    easy_thumbnails_source_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('easy_thumbnails_source_id_seq', 1, true);
            public       ninopq    false    188            	          0    16732    easy_thumbnails_thumbnail 
   TABLE DATA               Y   COPY easy_thumbnails_thumbnail (id, storage_hash, name, modified, source_id) FROM stdin;
    public       ninopq    false    191   �j      a	           0    0     easy_thumbnails_thumbnail_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('easy_thumbnails_thumbnail_id_seq', 2, true);
            public       ninopq    false    190            	          0    16758 #   easy_thumbnails_thumbnaildimensions 
   TABLE DATA               W   COPY easy_thumbnails_thumbnaildimensions (id, thumbnail_id, width, height) FROM stdin;
    public       ninopq    false    193   .k      b	           0    0 *   easy_thumbnails_thumbnaildimensions_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('easy_thumbnails_thumbnaildimensions_id_seq', 1, false);
            public       ninopq    false    192            	          0    16775    game_category 
   TABLE DATA               >   COPY game_category (id, name, description, image) FROM stdin;
    public       ninopq    false    195   Kk      c	           0    0    game_category_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('game_category_id_seq', 2, true);
            public       ninopq    false    194            	          0    16809    game_gameinstance 
   TABLE DATA               `   COPY game_gameinstance (id, "timestamp", seed, game_id, instantiator_id, pagecache) FROM stdin;
    public       ninopq    false    199   �k      d	           0    0    game_gameinstance_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('game_gameinstance_id_seq', 18, true);
            public       ninopq    false    198             	          0    16820    game_gameinstancesnapshot 
   TABLE DATA               Y   COPY game_gameinstancesnapshot (id, image, "time", instance_id, "timestamp") FROM stdin;
    public       ninopq    false    201   �l      e	           0    0     game_gameinstancesnapshot_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('game_gameinstancesnapshot_id_seq', 49, true);
            public       ninopq    false    200            -	          0    17415    game_imagetest 
   TABLE DATA               ,   COPY game_imagetest (id, image) FROM stdin;
    public       ninopq    false    214   8u      f	           0    0    game_imagetest_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('game_imagetest_id_seq', 8, true);
            public       ninopq    false    213            1	          0    25683    game_jslibrary 
   TABLE DATA               9   COPY game_jslibrary (id, name, "scriptPath") FROM stdin;
    public       ninopq    false    218   Uu      g	           0    0    game_jslibrary_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('game_jslibrary_id_seq', 1, true);
            public       ninopq    false    217            h	           0    0    game_plerpingapp_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('game_plerpingapp_id_seq', 5, true);
            public       ninopq    false    196            	          0    16786    game_zeroplayergame 
   TABLE DATA               �   COPY game_zeroplayergame (id, title, description, created, category_id, owner_id, "scriptName", "scriptType", source, "seedStructure") FROM stdin;
    public       ninopq    false    197   �u      3	          0    25691 !   game_zeroplayergame_extraIncludes 
   TABLE DATA               [   COPY "game_zeroplayergame_extraIncludes" (id, zeroplayergame_id, jslibrary_id) FROM stdin;
    public       ninopq    false    220   �      i	           0    0 (   game_zeroplayergame_extraIncludes_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('"game_zeroplayergame_extraIncludes_id_seq"', 1, true);
            public       ninopq    false    219            "	          0    16869    portfolio_imagegallery 
   TABLE DATA               3   COPY portfolio_imagegallery (id, name) FROM stdin;
    public       ninopq    false    203   2�      j	           0    0    portfolio_imagegallery_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('portfolio_imagegallery_id_seq', 1, false);
            public       ninopq    false    202            $	          0    16877    portfolio_imagemodel 
   TABLE DATA               K   COPY portfolio_imagemodel (id, image, "timestamp", gallery_id) FROM stdin;
    public       ninopq    false    205   O�      k	           0    0    portfolio_imagemodel_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('portfolio_imagemodel_id_seq', 1, false);
            public       ninopq    false    204            &	          0    16885    portfolio_portfoliocategory 
   TABLE DATA               L   COPY portfolio_portfoliocategory (id, name, description, image) FROM stdin;
    public       ninopq    false    207   l�      l	           0    0 "   portfolio_portfoliocategory_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('portfolio_portfoliocategory_id_seq', 1, false);
            public       ninopq    false    206            (	          0    16896    portfolio_portfolioitem 
   TABLE DATA                  COPY portfolio_portfolioitem (id, title, subtitle, description, sourcecode, image, creationdate, category_id, url) FROM stdin;
    public       ninopq    false    209   ��      m	           0    0    portfolio_portfolioitem_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('portfolio_portfolioitem_id_seq', 1, false);
            public       ninopq    false    208            )	          0    16905 "   portfolio_proprietaryportfolioitem 
   TABLE DATA               `   COPY portfolio_proprietaryportfolioitem (portfolioitem_ptr_id, company, gallery_id) FROM stdin;
    public       ninopq    false    210   ��      *	          0    16933    profiles_profile 
   TABLE DATA               P   COPY profiles_profile (user_id, slug, picture, bio, email_verified) FROM stdin;
    public       ninopq    false    211   Ý      5	          0    25730    profiles_profile_followers 
   TABLE DATA               Q   COPY profiles_profile_followers (id, from_profile_id, to_profile_id) FROM stdin;
    public       ninopq    false    222   $�      n	           0    0 !   profiles_profile_followers_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('profiles_profile_followers_id_seq', 1, false);
            public       ninopq    false    221            /	          0    17504    static_precompiler_dependency 
   TABLE DATA               H   COPY static_precompiler_dependency (id, source, depends_on) FROM stdin;
    public       ninopq    false    216   A�      o	           0    0 $   static_precompiler_dependency_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('static_precompiler_dependency_id_seq', 1, false);
            public       ninopq    false    215                       2606    16597    auth_group_name_key 
   CONSTRAINT     R   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public         ninopq    false    177    177                       2606    16626 -   auth_group_permissions_group_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 n   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq;
       public         ninopq    false    179    179    179                       2606    16605    auth_group_permissions_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public         ninopq    false    179    179                       2606    16595    auth_group_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public         ninopq    false    177    177                       2606    16612 -   auth_permission_content_type_id_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);
 g   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_01ab375a_uniq;
       public         ninopq    false    175    175    175                       2606    16587    auth_permission_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public         ninopq    false    175    175                       2606    16641    authtools_user_email_key 
   CONSTRAINT     \   ALTER TABLE ONLY authtools_user
    ADD CONSTRAINT authtools_user_email_key UNIQUE (email);
 Q   ALTER TABLE ONLY public.authtools_user DROP CONSTRAINT authtools_user_email_key;
       public         ninopq    false    181    181            #           2606    16649    authtools_user_groups_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.authtools_user_groups DROP CONSTRAINT authtools_user_groups_pkey;
       public         ninopq    false    183    183            %           2606    16670 +   authtools_user_groups_user_id_a8658824_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_user_id_a8658824_uniq UNIQUE (user_id, group_id);
 k   ALTER TABLE ONLY public.authtools_user_groups DROP CONSTRAINT authtools_user_groups_user_id_a8658824_uniq;
       public         ninopq    false    183    183    183                       2606    16639    authtools_user_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY authtools_user
    ADD CONSTRAINT authtools_user_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.authtools_user DROP CONSTRAINT authtools_user_pkey;
       public         ninopq    false    181    181            )           2606    16657 $   authtools_user_user_permissions_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permissions_pkey PRIMARY KEY (id);
 n   ALTER TABLE ONLY public.authtools_user_user_permissions DROP CONSTRAINT authtools_user_user_permissions_pkey;
       public         ninopq    false    185    185            +           2606    16684 5   authtools_user_user_permissions_user_id_3e9e8ba9_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permissions_user_id_3e9e8ba9_uniq UNIQUE (user_id, permission_id);
    ALTER TABLE ONLY public.authtools_user_user_permissions DROP CONSTRAINT authtools_user_user_permissions_user_id_3e9e8ba9_uniq;
       public         ninopq    false    185    185    185            /           2606    16698    django_admin_log_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public         ninopq    false    187    187                       2606    16579 +   django_content_type_app_label_76bd3d3b_uniq 
   CONSTRAINT        ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);
 i   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_76bd3d3b_uniq;
       public         ninopq    false    173    173    173            
           2606    16577    django_content_type_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public         ninopq    false    173    173                       2606    16569    django_migrations_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public         ninopq    false    171    171            c           2606    16950    django_session_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public         ninopq    false    212    212            4           2606    16729    easy_thumbnails_source_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.easy_thumbnails_source DROP CONSTRAINT easy_thumbnails_source_pkey;
       public         ninopq    false    189    189            6           2606    16741 1   easy_thumbnails_source_storage_hash_481ce32d_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_481ce32d_uniq UNIQUE (storage_hash, name);
 r   ALTER TABLE ONLY public.easy_thumbnails_source DROP CONSTRAINT easy_thumbnails_source_storage_hash_481ce32d_uniq;
       public         ninopq    false    189    189    189            =           2606    16737    easy_thumbnails_thumbnail_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.easy_thumbnails_thumbnail DROP CONSTRAINT easy_thumbnails_thumbnail_pkey;
       public         ninopq    false    191    191            @           2606    16739 4   easy_thumbnails_thumbnail_storage_hash_fb375270_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_storage_hash_fb375270_uniq UNIQUE (storage_hash, name, source_id);
 x   ALTER TABLE ONLY public.easy_thumbnails_thumbnail DROP CONSTRAINT easy_thumbnails_thumbnail_storage_hash_fb375270_uniq;
       public         ninopq    false    191    191    191    191            B           2606    16765 (   easy_thumbnails_thumbnaildimensions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);
 v   ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions DROP CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey;
       public         ninopq    false    193    193            D           2606    16767 4   easy_thumbnails_thumbnaildimensions_thumbnail_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);
 �   ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions DROP CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key;
       public         ninopq    false    193    193            F           2606    16783    game_category_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY game_category
    ADD CONSTRAINT game_category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.game_category DROP CONSTRAINT game_category_pkey;
       public         ninopq    false    195    195            N           2606    16817    game_gameinstance_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.game_gameinstance DROP CONSTRAINT game_gameinstance_pkey;
       public         ninopq    false    199    199            Q           2606    16825    game_gameinstancesnapshot_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY game_gameinstancesnapshot
    ADD CONSTRAINT game_gameinstancesnapshot_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.game_gameinstancesnapshot DROP CONSTRAINT game_gameinstancesnapshot_pkey;
       public         ninopq    false    201    201            f           2606    17420    game_imagetest_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY game_imagetest
    ADD CONSTRAINT game_imagetest_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.game_imagetest DROP CONSTRAINT game_imagetest_pkey;
       public         ninopq    false    214    214            p           2606    25688    game_jslibrary_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY game_jslibrary
    ADD CONSTRAINT game_jslibrary_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.game_jslibrary DROP CONSTRAINT game_jslibrary_pkey;
       public         ninopq    false    218    218            J           2606    16794    game_plerpingapp_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_pkey PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.game_zeroplayergame DROP CONSTRAINT game_plerpingapp_pkey;
       public         ninopq    false    197    197            r           2606    25708 ?   game_zeroplayergame_extraInclud_zeroplayergame_id_2d035b3a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT "game_zeroplayergame_extraInclud_zeroplayergame_id_2d035b3a_uniq" UNIQUE (zeroplayergame_id, jslibrary_id);
 �   ALTER TABLE ONLY public."game_zeroplayergame_extraIncludes" DROP CONSTRAINT "game_zeroplayergame_extraInclud_zeroplayergame_id_2d035b3a_uniq";
       public         ninopq    false    220    220    220            v           2606    25696 &   game_zeroplayergame_extraIncludes_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT "game_zeroplayergame_extraIncludes_pkey" PRIMARY KEY (id);
 v   ALTER TABLE ONLY public."game_zeroplayergame_extraIncludes" DROP CONSTRAINT "game_zeroplayergame_extraIncludes_pkey";
       public         ninopq    false    220    220            S           2606    16874    portfolio_imagegallery_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY portfolio_imagegallery
    ADD CONSTRAINT portfolio_imagegallery_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.portfolio_imagegallery DROP CONSTRAINT portfolio_imagegallery_pkey;
       public         ninopq    false    203    203            V           2606    16882    portfolio_imagemodel_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY portfolio_imagemodel
    ADD CONSTRAINT portfolio_imagemodel_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.portfolio_imagemodel DROP CONSTRAINT portfolio_imagemodel_pkey;
       public         ninopq    false    205    205            X           2606    16893     portfolio_portfoliocategory_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY portfolio_portfoliocategory
    ADD CONSTRAINT portfolio_portfoliocategory_pkey PRIMARY KEY (id);
 f   ALTER TABLE ONLY public.portfolio_portfoliocategory DROP CONSTRAINT portfolio_portfoliocategory_pkey;
       public         ninopq    false    207    207            [           2606    16904    portfolio_portfolioitem_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY portfolio_portfolioitem
    ADD CONSTRAINT portfolio_portfolioitem_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.portfolio_portfolioitem DROP CONSTRAINT portfolio_portfolioitem_pkey;
       public         ninopq    false    209    209            ^           2606    16909 '   portfolio_proprietaryportfolioitem_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT portfolio_proprietaryportfolioitem_pkey PRIMARY KEY (portfolioitem_ptr_id);
 t   ALTER TABLE ONLY public.portfolio_proprietaryportfolioitem DROP CONSTRAINT portfolio_proprietaryportfolioitem_pkey;
       public         ninopq    false    210    210            z           2606    25747 8   profiles_profile_followers_from_profile_id_8a9bcb07_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_profile_followers_from_profile_id_8a9bcb07_uniq UNIQUE (from_profile_id, to_profile_id);
 }   ALTER TABLE ONLY public.profiles_profile_followers DROP CONSTRAINT profiles_profile_followers_from_profile_id_8a9bcb07_uniq;
       public         ninopq    false    222    222    222            |           2606    25735    profiles_profile_followers_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_profile_followers_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.profiles_profile_followers DROP CONSTRAINT profiles_profile_followers_pkey;
       public         ninopq    false    222    222            `           2606    16937    profiles_profile_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY profiles_profile
    ADD CONSTRAINT profiles_profile_pkey PRIMARY KEY (user_id);
 P   ALTER TABLE ONLY public.profiles_profile DROP CONSTRAINT profiles_profile_pkey;
       public         ninopq    false    211    211            k           2606    17512 "   static_precompiler_dependency_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY static_precompiler_dependency
    ADD CONSTRAINT static_precompiler_dependency_pkey PRIMARY KEY (id);
 j   ALTER TABLE ONLY public.static_precompiler_dependency DROP CONSTRAINT static_precompiler_dependency_pkey;
       public         ninopq    false    216    216            n           2606    17514 2   static_precompiler_dependency_source_d8e91940_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY static_precompiler_dependency
    ADD CONSTRAINT static_precompiler_dependency_source_d8e91940_uniq UNIQUE (source, depends_on);
 z   ALTER TABLE ONLY public.static_precompiler_dependency DROP CONSTRAINT static_precompiler_dependency_source_d8e91940_uniq;
       public         ninopq    false    216    216    216                       1259    16614    auth_group_name_a6ea08ec_like    INDEX     a   CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public         ninopq    false    177                       1259    16627    auth_group_permissions_0e939a4f    INDEX     _   CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);
 3   DROP INDEX public.auth_group_permissions_0e939a4f;
       public         ninopq    false    179                       1259    16628    auth_group_permissions_8373b171    INDEX     d   CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);
 3   DROP INDEX public.auth_group_permissions_8373b171;
       public         ninopq    false    179                       1259    16613    auth_permission_417f1b1c    INDEX     X   CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);
 ,   DROP INDEX public.auth_permission_417f1b1c;
       public         ninopq    false    175                       1259    16658 "   authtools_user_email_f133274f_like    INDEX     k   CREATE INDEX authtools_user_email_f133274f_like ON authtools_user USING btree (email varchar_pattern_ops);
 6   DROP INDEX public.authtools_user_email_f133274f_like;
       public         ninopq    false    181                        1259    16672    authtools_user_groups_0e939a4f    INDEX     ]   CREATE INDEX authtools_user_groups_0e939a4f ON authtools_user_groups USING btree (group_id);
 2   DROP INDEX public.authtools_user_groups_0e939a4f;
       public         ninopq    false    183            !           1259    16671    authtools_user_groups_e8701ad4    INDEX     \   CREATE INDEX authtools_user_groups_e8701ad4 ON authtools_user_groups USING btree (user_id);
 2   DROP INDEX public.authtools_user_groups_e8701ad4;
       public         ninopq    false    183            &           1259    16686 (   authtools_user_user_permissions_8373b171    INDEX     v   CREATE INDEX authtools_user_user_permissions_8373b171 ON authtools_user_user_permissions USING btree (permission_id);
 <   DROP INDEX public.authtools_user_user_permissions_8373b171;
       public         ninopq    false    185            '           1259    16685 (   authtools_user_user_permissions_e8701ad4    INDEX     p   CREATE INDEX authtools_user_user_permissions_e8701ad4 ON authtools_user_user_permissions USING btree (user_id);
 <   DROP INDEX public.authtools_user_user_permissions_e8701ad4;
       public         ninopq    false    185            ,           1259    16709    django_admin_log_417f1b1c    INDEX     Z   CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);
 -   DROP INDEX public.django_admin_log_417f1b1c;
       public         ninopq    false    187            -           1259    16710    django_admin_log_e8701ad4    INDEX     R   CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);
 -   DROP INDEX public.django_admin_log_e8701ad4;
       public         ninopq    false    187            a           1259    16951    django_session_de54fa62    INDEX     R   CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);
 +   DROP INDEX public.django_session_de54fa62;
       public         ninopq    false    212            d           1259    16952 (   django_session_session_key_c0390e0f_like    INDEX     w   CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public         ninopq    false    212            0           1259    16743    easy_thumbnails_source_b068931c    INDEX     [   CREATE INDEX easy_thumbnails_source_b068931c ON easy_thumbnails_source USING btree (name);
 3   DROP INDEX public.easy_thumbnails_source_b068931c;
       public         ninopq    false    189            1           1259    16742    easy_thumbnails_source_b454e115    INDEX     c   CREATE INDEX easy_thumbnails_source_b454e115 ON easy_thumbnails_source USING btree (storage_hash);
 3   DROP INDEX public.easy_thumbnails_source_b454e115;
       public         ninopq    false    189            2           1259    16745 )   easy_thumbnails_source_name_5fe0edc6_like    INDEX     y   CREATE INDEX easy_thumbnails_source_name_5fe0edc6_like ON easy_thumbnails_source USING btree (name varchar_pattern_ops);
 =   DROP INDEX public.easy_thumbnails_source_name_5fe0edc6_like;
       public         ninopq    false    189            7           1259    16744 1   easy_thumbnails_source_storage_hash_946cbcc9_like    INDEX     �   CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9_like ON easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);
 E   DROP INDEX public.easy_thumbnails_source_storage_hash_946cbcc9_like;
       public         ninopq    false    189            8           1259    16753 "   easy_thumbnails_thumbnail_0afd9202    INDEX     f   CREATE INDEX easy_thumbnails_thumbnail_0afd9202 ON easy_thumbnails_thumbnail USING btree (source_id);
 6   DROP INDEX public.easy_thumbnails_thumbnail_0afd9202;
       public         ninopq    false    191            9           1259    16752 "   easy_thumbnails_thumbnail_b068931c    INDEX     a   CREATE INDEX easy_thumbnails_thumbnail_b068931c ON easy_thumbnails_thumbnail USING btree (name);
 6   DROP INDEX public.easy_thumbnails_thumbnail_b068931c;
       public         ninopq    false    191            :           1259    16751 "   easy_thumbnails_thumbnail_b454e115    INDEX     i   CREATE INDEX easy_thumbnails_thumbnail_b454e115 ON easy_thumbnails_thumbnail USING btree (storage_hash);
 6   DROP INDEX public.easy_thumbnails_thumbnail_b454e115;
       public         ninopq    false    191            ;           1259    16755 ,   easy_thumbnails_thumbnail_name_b5882c31_like    INDEX        CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31_like ON easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);
 @   DROP INDEX public.easy_thumbnails_thumbnail_name_b5882c31_like;
       public         ninopq    false    191            >           1259    16754 4   easy_thumbnails_thumbnail_storage_hash_f1435f49_like    INDEX     �   CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49_like ON easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);
 H   DROP INDEX public.easy_thumbnails_thumbnail_storage_hash_f1435f49_like;
       public         ninopq    false    191            K           1259    16838    game_gameinstance_6072f8b3    INDEX     T   CREATE INDEX game_gameinstance_6072f8b3 ON game_gameinstance USING btree (game_id);
 .   DROP INDEX public.game_gameinstance_6072f8b3;
       public         ninopq    false    199            L           1259    16844    game_gameinstance_6ccdb143    INDEX     \   CREATE INDEX game_gameinstance_6ccdb143 ON game_gameinstance USING btree (instantiator_id);
 .   DROP INDEX public.game_gameinstance_6ccdb143;
       public         ninopq    false    199            O           1259    16837 "   game_gameinstancesnapshot_51afcc4f    INDEX     h   CREATE INDEX game_gameinstancesnapshot_51afcc4f ON game_gameinstancesnapshot USING btree (instance_id);
 6   DROP INDEX public.game_gameinstancesnapshot_51afcc4f;
       public         ninopq    false    201            G           1259    16806    game_plerpingapp_5e7b1936    INDEX     V   CREATE INDEX game_plerpingapp_5e7b1936 ON game_zeroplayergame USING btree (owner_id);
 -   DROP INDEX public.game_plerpingapp_5e7b1936;
       public         ninopq    false    197            H           1259    16805    game_plerpingapp_b583a629    INDEX     Y   CREATE INDEX game_plerpingapp_b583a629 ON game_zeroplayergame USING btree (category_id);
 -   DROP INDEX public.game_plerpingapp_b583a629;
       public         ninopq    false    197            s           1259    25709 *   game_zeroplayergame_extraIncludes_030a3785    INDEX     �   CREATE INDEX "game_zeroplayergame_extraIncludes_030a3785" ON "game_zeroplayergame_extraIncludes" USING btree (zeroplayergame_id);
 @   DROP INDEX public."game_zeroplayergame_extraIncludes_030a3785";
       public         ninopq    false    220            t           1259    25710 *   game_zeroplayergame_extraIncludes_32432e4e    INDEX     }   CREATE INDEX "game_zeroplayergame_extraIncludes_32432e4e" ON "game_zeroplayergame_extraIncludes" USING btree (jslibrary_id);
 @   DROP INDEX public."game_zeroplayergame_extraIncludes_32432e4e";
       public         ninopq    false    220            T           1259    16915    portfolio_imagemodel_6d994cdb    INDEX     ]   CREATE INDEX portfolio_imagemodel_6d994cdb ON portfolio_imagemodel USING btree (gallery_id);
 1   DROP INDEX public.portfolio_imagemodel_6d994cdb;
       public         ninopq    false    205            Y           1259    16927     portfolio_portfolioitem_b583a629    INDEX     d   CREATE INDEX portfolio_portfolioitem_b583a629 ON portfolio_portfolioitem USING btree (category_id);
 4   DROP INDEX public.portfolio_portfolioitem_b583a629;
       public         ninopq    false    209            \           1259    16926 +   portfolio_proprietaryportfolioitem_6d994cdb    INDEX     y   CREATE INDEX portfolio_proprietaryportfolioitem_6d994cdb ON portfolio_proprietaryportfolioitem USING btree (gallery_id);
 ?   DROP INDEX public.portfolio_proprietaryportfolioitem_6d994cdb;
       public         ninopq    false    210            w           1259    25749 #   profiles_profile_followers_658493f6    INDEX     l   CREATE INDEX profiles_profile_followers_658493f6 ON profiles_profile_followers USING btree (to_profile_id);
 7   DROP INDEX public.profiles_profile_followers_658493f6;
       public         ninopq    false    222            x           1259    25748 #   profiles_profile_followers_9c2b64df    INDEX     n   CREATE INDEX profiles_profile_followers_9c2b64df ON profiles_profile_followers USING btree (from_profile_id);
 7   DROP INDEX public.profiles_profile_followers_9c2b64df;
       public         ninopq    false    222            g           1259    17516 &   static_precompiler_dependency_1f903a40    INDEX     o   CREATE INDEX static_precompiler_dependency_1f903a40 ON static_precompiler_dependency USING btree (depends_on);
 :   DROP INDEX public.static_precompiler_dependency_1f903a40;
       public         ninopq    false    216            h           1259    17515 &   static_precompiler_dependency_36cd38f4    INDEX     k   CREATE INDEX static_precompiler_dependency_36cd38f4 ON static_precompiler_dependency USING btree (source);
 :   DROP INDEX public.static_precompiler_dependency_36cd38f4;
       public         ninopq    false    216            i           1259    17518 6   static_precompiler_dependency_depends_on_a14c2c8b_like    INDEX     �   CREATE INDEX static_precompiler_dependency_depends_on_a14c2c8b_like ON static_precompiler_dependency USING btree (depends_on varchar_pattern_ops);
 J   DROP INDEX public.static_precompiler_dependency_depends_on_a14c2c8b_like;
       public         ninopq    false    216            l           1259    17517 2   static_precompiler_dependency_source_6c770ab0_like    INDEX     �   CREATE INDEX static_precompiler_dependency_source_6c770ab0_like ON static_precompiler_dependency USING btree (source varchar_pattern_ops);
 F   DROP INDEX public.static_precompiler_dependency_source_6c770ab0_like;
       public         ninopq    false    216                       2606    16620 ?   auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id;
       public       ninopq    false    179    2063    175            ~           2606    16615 9   auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public       ninopq    false    177    2068    179            }           2606    16606 ?   auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id;
       public       ninopq    false    173    2058    175            �           2606    16712 8   authtools_user_groups_group_id_fdf65e59_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_group_id_fdf65e59_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.authtools_user_groups DROP CONSTRAINT authtools_user_groups_group_id_fdf65e59_fk_auth_group_id;
       public       ninopq    false    2068    177    183            �           2606    16717 ;   authtools_user_groups_user_id_c1c2c51f_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_user_id_c1c2c51f_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.authtools_user_groups DROP CONSTRAINT authtools_user_groups_user_id_c1c2c51f_fk_authtools_user_id;
       public       ninopq    false    2079    181    183            �           2606    16678 ?   authtools_user_use_permission_id_039bf6fe_fk_auth_permission_id    FK CONSTRAINT     �   ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_use_permission_id_039bf6fe_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.authtools_user_user_permissions DROP CONSTRAINT authtools_user_use_permission_id_039bf6fe_fk_auth_permission_id;
       public       ninopq    false    2063    175    185            �           2606    16673 ?   authtools_user_user_permi_user_id_d172ce6b_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permi_user_id_d172ce6b_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.authtools_user_user_permissions DROP CONSTRAINT authtools_user_user_permi_user_id_d172ce6b_fk_authtools_user_id;
       public       ninopq    false    185    181    2079            �           2606    16699 ?   django_admin_content_type_id_c4bce8eb_fk_django_content_type_id    FK CONSTRAINT     �   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id;
       public       ninopq    false    187    173    2058            �           2606    16704 6   django_admin_log_user_id_c564eba6_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_authtools_user_id;
       public       ninopq    false    181    2079    187            �           2606    16768 ?   easy_thum_thumbnail_id_c3a0c549_fk_easy_thumbnails_thumbnail_id    FK CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thum_thumbnail_id_c3a0c549_fk_easy_thumbnails_thumbnail_id FOREIGN KEY (thumbnail_id) REFERENCES easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.easy_thumbnails_thumbnaildimensions DROP CONSTRAINT easy_thum_thumbnail_id_c3a0c549_fk_easy_thumbnails_thumbnail_id;
       public       ninopq    false    2109    193    191            �           2606    16746 ?   easy_thumbnails_source_id_5b57bc77_fk_easy_thumbnails_source_id    FK CONSTRAINT     �   ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_source_id_5b57bc77_fk_easy_thumbnails_source_id FOREIGN KEY (source_id) REFERENCES easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.easy_thumbnails_thumbnail DROP CONSTRAINT easy_thumbnails_source_id_5b57bc77_fk_easy_thumbnails_source_id;
       public       ninopq    false    191    2100    189            �           2606    17394 <   game_gameinstance_game_id_a878f786_fk_game_zeroplayergame_id    FK CONSTRAINT     �   ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_game_id_a878f786_fk_game_zeroplayergame_id FOREIGN KEY (game_id) REFERENCES game_zeroplayergame(id) DEFERRABLE INITIALLY DEFERRED;
 x   ALTER TABLE ONLY public.game_gameinstance DROP CONSTRAINT game_gameinstance_game_id_a878f786_fk_game_zeroplayergame_id;
       public       ninopq    false    197    199    2122            �           2606    16845 ?   game_gameinstance_instantiator_id_3f0b0fcb_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_instantiator_id_3f0b0fcb_fk_authtools_user_id FOREIGN KEY (instantiator_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 {   ALTER TABLE ONLY public.game_gameinstance DROP CONSTRAINT game_gameinstance_instantiator_id_3f0b0fcb_fk_authtools_user_id;
       public       ninopq    false    199    2079    181            �           2606    17423 ?   game_gameinstances_instance_id_d6d83406_fk_game_gameinstance_id    FK CONSTRAINT     �   ALTER TABLE ONLY game_gameinstancesnapshot
    ADD CONSTRAINT game_gameinstances_instance_id_d6d83406_fk_game_gameinstance_id FOREIGN KEY (instance_id) REFERENCES game_gameinstance(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.game_gameinstancesnapshot DROP CONSTRAINT game_gameinstances_instance_id_d6d83406_fk_game_gameinstance_id;
       public       ninopq    false    199    201    2126            �           2606    16795 9   game_plerpingapp_category_id_d18c203b_fk_game_category_id    FK CONSTRAINT     �   ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_category_id_d18c203b_fk_game_category_id FOREIGN KEY (category_id) REFERENCES game_category(id) DEFERRABLE INITIALLY DEFERRED;
 w   ALTER TABLE ONLY public.game_zeroplayergame DROP CONSTRAINT game_plerpingapp_category_id_d18c203b_fk_game_category_id;
       public       ninopq    false    2118    197    195            �           2606    16800 7   game_plerpingapp_owner_id_db15314c_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_owner_id_db15314c_fk_authtools_user_id FOREIGN KEY (owner_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 u   ALTER TABLE ONLY public.game_zeroplayergame DROP CONSTRAINT game_plerpingapp_owner_id_db15314c_fk_authtools_user_id;
       public       ninopq    false    2079    181    197            �           2606    25697 ?   game_zerop_zeroplayergame_id_a5dd43ed_fk_game_zeroplayergame_id    FK CONSTRAINT     �   ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT game_zerop_zeroplayergame_id_a5dd43ed_fk_game_zeroplayergame_id FOREIGN KEY (zeroplayergame_id) REFERENCES game_zeroplayergame(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public."game_zeroplayergame_extraIncludes" DROP CONSTRAINT game_zerop_zeroplayergame_id_a5dd43ed_fk_game_zeroplayergame_id;
       public       ninopq    false    220    2122    197            �           2606    25702 ?   game_zeroplayergame__jslibrary_id_30752fb8_fk_game_jslibrary_id    FK CONSTRAINT     �   ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT game_zeroplayergame__jslibrary_id_30752fb8_fk_game_jslibrary_id FOREIGN KEY (jslibrary_id) REFERENCES game_jslibrary(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public."game_zeroplayergame_extraIncludes" DROP CONSTRAINT game_zeroplayergame__jslibrary_id_30752fb8_fk_game_jslibrary_id;
       public       ninopq    false    220    2160    218            �           2606    16916 ?   por_portfolioitem_ptr_id_da61254d_fk_portfolio_portfolioitem_id    FK CONSTRAINT     �   ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT por_portfolioitem_ptr_id_da61254d_fk_portfolio_portfolioitem_id FOREIGN KEY (portfolioitem_ptr_id) REFERENCES portfolio_portfolioitem(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.portfolio_proprietaryportfolioitem DROP CONSTRAINT por_portfolioitem_ptr_id_da61254d_fk_portfolio_portfolioitem_id;
       public       ninopq    false    210    209    2139            �           2606    16928 ?   portfoli_category_id_db01a81d_fk_portfolio_portfoliocategory_id    FK CONSTRAINT     �   ALTER TABLE ONLY portfolio_portfolioitem
    ADD CONSTRAINT portfoli_category_id_db01a81d_fk_portfolio_portfoliocategory_id FOREIGN KEY (category_id) REFERENCES portfolio_portfoliocategory(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.portfolio_portfolioitem DROP CONSTRAINT portfoli_category_id_db01a81d_fk_portfolio_portfoliocategory_id;
       public       ninopq    false    207    2136    209            �           2606    16910 ?   portfolio_imag_gallery_id_ae9b842e_fk_portfolio_imagegallery_id    FK CONSTRAINT     �   ALTER TABLE ONLY portfolio_imagemodel
    ADD CONSTRAINT portfolio_imag_gallery_id_ae9b842e_fk_portfolio_imagegallery_id FOREIGN KEY (gallery_id) REFERENCES portfolio_imagegallery(id) DEFERRABLE INITIALLY DEFERRED;
 ~   ALTER TABLE ONLY public.portfolio_imagemodel DROP CONSTRAINT portfolio_imag_gallery_id_ae9b842e_fk_portfolio_imagegallery_id;
       public       ninopq    false    2131    203    205            �           2606    16921 ?   portfolio_prop_gallery_id_e7ba0f54_fk_portfolio_imagegallery_id    FK CONSTRAINT     �   ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT portfolio_prop_gallery_id_e7ba0f54_fk_portfolio_imagegallery_id FOREIGN KEY (gallery_id) REFERENCES portfolio_imagegallery(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.portfolio_proprietaryportfolioitem DROP CONSTRAINT portfolio_prop_gallery_id_e7ba0f54_fk_portfolio_imagegallery_id;
       public       ninopq    false    2131    203    210            �           2606    25736 ?   profiles_p_from_profile_id_e7888571_fk_profiles_profile_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_p_from_profile_id_e7888571_fk_profiles_profile_user_id FOREIGN KEY (from_profile_id) REFERENCES profiles_profile(user_id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.profiles_profile_followers DROP CONSTRAINT profiles_p_from_profile_id_e7888571_fk_profiles_profile_user_id;
       public       ninopq    false    222    2144    211            �           2606    25741 ?   profiles_pro_to_profile_id_562358dd_fk_profiles_profile_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_pro_to_profile_id_562358dd_fk_profiles_profile_user_id FOREIGN KEY (to_profile_id) REFERENCES profiles_profile(user_id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.profiles_profile_followers DROP CONSTRAINT profiles_pro_to_profile_id_562358dd_fk_profiles_profile_user_id;
       public       ninopq    false    2144    222    211            �           2606    16938 6   profiles_profile_user_id_a3e81f91_fk_authtools_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY profiles_profile
    ADD CONSTRAINT profiles_profile_user_id_a3e81f91_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.profiles_profile DROP CONSTRAINT profiles_profile_user_id_a3e81f91_fk_authtools_user_id;
       public       ninopq    false    2079    211    181            	   !   x�3��I-K�Q0T(-N-�2�r� �=... ��	�      
	   2   x��� D�s~1�����v.���AX�\u����
��J�*n�      	   �  x�}�M�� ��p
�`*��$���TM�:�.۸0YdN?6���]�?����`������jQf�u�3l+�M.u��燢��a�v�]��f��a������N�}�-��A�V
�x����R�5/V;�m����e0R�b5�b�)���l�be_�b���^�B`�}�K�!�����dU�Wh�	Xq�`�툵X7a �.�=WeX����\��<\� ����,�in���Q܂�9I �A �
� HF!���>�~��i�5�5��("���]���tu&5���ʮ�Ez�ew��6��p���$�����K��?�Q�m\��%�W�!
	\}"�����IQ���AW�ު�ަR@��'��i�vGe3Ͷ��`�lnVMLHjv/��=6:r���;6�rs�)��0�{��������tE����e��+�B��hO��9e�&�aL4ɐ��F�v"�� .K+�F ��[��A�޼���/z ���4ٛ��Fi���f���^i`����:��>��Kې��X��"I��b�dJ���j��2�+1ms�C}���^�-	��&p����?�oy_��u5̫�����؋��[r|��BZȕP���0��=�T�s��_�2q-��g���z$�M{�ߚ&{��{t"�k�VˤHc�x'˩$j��L���S�բ滚o/&} �
�H�R`��.���S�~��8|�m4��a��B�w$i)	L2��� �~q���B �      	   �   x�M�M�0���~
^]��m�T�	�H���|�<��oA���Ïí�?��*0n��Q�>�{
�b��Jrg��鸓+�m�X�Eu�����djtӨ�0�3���� 0�s`T׹1��z${)K%�yӈe�
����;�<q���P��K]����Y��7/�4���7�      	      x�3�4�4������ �Y      	      x������ � �      	     x�͙�o�Fǟ��B������~ð���mQ����V��r���O��,�^m%$��|���H
F��^k�F��ˍ��)�u0t��Fo�ʕ��y:-�jvW�Z��hE6�����ռ\��墘eբ)�b�T��,.��*��Y�Y��f��Oe=~��|��U�e�^e/���]U��lV����)����*�@܊�ј���ߗ���_SV�q"�d�y��B�un����g��+��4[���CS�'Mk�Z��I�QŻ�P��s����>�,����n�y��u1�Ư�����˛?�I3���C�ky�����d����.�&'T�0��#g�=�=ݢI!y�����վ[��US,&e���]X*�F �
{�8�#+m4��cl�G�!���(k�ܻ�Io�殜M5Is@j�smkԾ5����r՜� ���4���O[��>)]Y���������`�
|�v��ӈ]ztQ��l�>砘4�vo|	Z�c[�M�q�`�����?dǤ�T*ɏ
\��y�J*ݿ�Z�>mc�ɘ'��P�\���s湼�=����������4)�U�I*B���³��&��/��u�R��QJ�R�����},��jRW����9hR5��
A{�K�Ϗ�ػ�n�6̀�t�u�ynh�f�M�w ���R	������L���I�B!7,�`����>�cl܂s���$<$p��[m����^ϋ�2^훞!f%IH���^[���#��oj<�������o������~[��خ�;nk�m=�۔d�m��6H{��}����:M`7'���~`K��b�������c�|
�|�r��?�^Rx�^@��x�\�7:��h���<��6��I��������gS�~��<!9?����R�[O]��-U���cRu&���!t=ַTF�SǇ��+�h��d���l��1�Yc$�	����٦R����4r�,[�I(o�O�,�l�*뇹Fc��8��͐�3�>�ph,I\�m�w&�y�&;�~���L����m�\߯�(�cX��l;O�JGv����z&%pQWESfϋ����'�&�}y���!�Q�yO��Ng�p�n�}���t�M��nɘ�%܃2����M~,��R:��$�&[4��MB�ᄊ1��;>�������	�(��k;c��^Lb?"IE�Q˿���_Us'��v�]6����,fZ�*��Vv����A�E�m�yv���@�}���f������{�޻IT_ �CA�*k���@�zd؝\GR:�]�z��i����v)H��Xs��0��W|l1Q$寄�!����ί�T7uQ�6��(Y��\y�٘�S�wS���zZ��{2�"�QL���9��-'��Ln�vh��u���ާ�_d��ŏ��R'cd��eq���
l��dt��o������ѧ`���4O��3��[��9��}?�y�ABz�o����l���W�~���]Rpg�1�nJ�_k8;�vnS���d�dX��A?�{�]Fd�c��R0��C ��)t��v� ���Q�M�E5�	&.`�	�uuu�/�>w�      	     x�uP�n�0;K3�I��2�p5�`[��ү��lk�n�"M��?��$�������-�>���&3n��l�\H܂��? wK�1G�IIp�u>�8�s���ʓt���������&�w(k�o��Aa���w�y���g\�����A
�4��f�<+�{�趏a�E���)w�O����R�D?��Ft���!��\�䎯�f_td�ƭ�R�H+�@�c�;��S�+��P�)w36�j���R���"~���      	   �  x����n�6�+O�����U�R�PmnV�.^J�6}����.����<sf(��Ӹ�qYޯa��໱[���P�~����A�Wke�Wa_�jo��'���$L e`����s j!�X�0Y����#(5h��!��鍷�}��;x^�����P��ȫ�_��O��/|�Ə��$(��Lq
}�/!�k�C7��4f��?����P�Z�J�(ч�m�Kڮ&��	��把�WI��������p5�����5�v^��o���I�22���h6�׭���l�O�����lA4K���ݥ]�8�B�����}�;�VY��1E���&���!��ɠ܃�&-A�y��	��%�������~�y���Ok� 2������Bw���u�zK�~�p�v��6[��8j��c�"�<K��h$T���(rQX�`��Aw �ZH-M�B��#���貖����Xh��-G��gs/��P��S\~L}7=3[���\�{}���0�[�FA�L�YaOw
_�jk���: QW�8�����c��*�k7��5�O1��^O��e��!N׾}1}��.�o�e�'��ҍ���jM�3���6��r�R�<r���-]nWa6��}�m>$�./�J�@|�k�(a25w�Z��<�w-�N��P���Yi*4~��<�dԵ��eZ�ivGSZ97(8a�z��B�O��8/�xf�[<�{���|��k�H廁g���4'���F���2TF��/��|L�¹|`jc�^G*�����ݮ|Ą�5���Q��y�䡞J��~S��?R�bk2F�o[RT��ҝ�5��4\���Q� �"���)M�;�%�>�<CӔ4M'6���������y��w�'H?���	���K�%��d'��_^^���      +	   g  x���An�0�us�\ ��F�fŎ�(k6P
8��PJ>}�H]�
�?���]����q#%@׺Ǻ���z����e���)O�bAh3?�8���-��$�������>�D�w�:�x�Gqs]�'�V���Y�YT��됄�ݘ�tn���H�|fx�*�7�H���3"Q�A<����̋ܮ�:�RTl(~�t� js�8�:�;�Bo����5��c��s{�U�Si�ͱ�t�����p������ a�@��0ǮgS���®�ȝ�j\u䳰��m�Z�;�9+TY�=��_���c۳�tiQ�!��Nv���P�V��TczS�n-��1�jB�v;:��s�hI�	���_�f�/��8�      	   ^   x�E�K
�  ����h�z��,A��(����f5^հ��x"N�Y� �y��$����g�۞��g����G��?�ǈ	-��h0nԓ�Z�y��      	   �   x���M
�0�ur�^�83��Y
!&Q,��v����ಋ�{�ǃE&3�4�lbbWr�>٨}D�ru���YB]ӧ'@���ުG]��CCx�!�}���q�n�#�8���yׁ(�o��߬!�x�w%����?      	      x������ � �      	   '   x�3��M�J-�,NIK��2�J2RsK2�ab1z\\\ �a      	   E  x���Mk�@���+�SZt���ٯk{M)���	�H�Ā���w4B"���� �:�</��%`I!C�#[��ht	>��7uӼm��<f�,?�ͱ۶�ת�|j�v/?��ǺZ@�|��O	�J�-�h�L�>���3���m�>jV�]��|�_�}�G�$	�(�6x������h8V/)�L!�#�b4���4SX�Gm�Fb�ϊ��O��:̥�2�&�Q�x��P�r���r�z_K��������˪��}?�6��\J�ڴ�E?��'_��D�F�Vމ���]d:#=<I�
 �F�)���_*y��g@��;�J�i��C��       	   Q  x�}X�r$��q_��a=��ףG��".�)�����g�̞nXj��dWWVf������UE��/?��˷�ۿg���o�g�\{���L�����������_��Yo.7�	%㯔�^&���(K/��޺⏒g���B9Y�֭M7e��w�f|$'-eC( �T��
�֢�u��c%5)��y���i��6gJ���"&!�65��Rm�c�:KaQV��lM/ ��K/m���soߋ(O�&~#?��~������e�,�Rg��N�j�(��k�Ճ(��Xc����k9�0�x�?!��<s�~v&��F��h���]�e�?���S�iFs��S���|�@�����"7�Gd� ťؐ����R[-�&�����G#˨o�&�<-�)�{�2ˡ �G ��m�Q��8ys��&6�I�)N��`aP���[�e$�kh�F#�r�d,����|� ��J`�- -hᠾA{�_�v)���KU���Zx��_R�*���>��O�jґ1<��	�Z3+�UW#Z+�'�4Q�4�ƙ�ԞV��
.Z�}Ġ����>ʞ�����p:K���p�$K��)kcO��ޓ0��h-G/������f�/T=p��)�	��Ft0�z�n5)�hh���*�OS0����%����*({i���pD��s��L	�>Q��('�Ĕ��b�~Y H���rW��i	�+�&w�����GT{��t��+'�y��,_Ѐ�#�M�$CCRZP#�*I�J��V�&�%j���_��z8�v�5�Rd�@�2z�/Y*����<�
�p���`FӨ�os��Wp􂅚�;���f��DqMo]Xm`F=�b�3�L*�W�	Jsi�tCCse��S���>���Z���V�8�s�.o�`�ff���Q��������)��0�;��s5t����0JO~�v��/�-����ʊ�L��j�����1��l�k� \g�{�{�ᗰ�G1��O+�J���� \�h������ ��+k���{�z�6B�`��݄��h�Y�l����:�����YP����d����1{nuhˋ�[�'U4}	k~���g*��,�1X�50�AQ�g��5����r�^FF`��/SeLmy���~��;�|xY9aO��n��@��j���M:�}"�Q�ܨ��c�nK�ط�>��K�r@�s>����j�:&�)D(A�� T8z�\)��������V���I���a��;	�{I�l�P\�T�s�
�-��WVh~�8�f���t��7�E)h����������<&;�t�l��%��8;�|Up�-��k/�i�ɀ�S��A�z�:Jy���KX�^fzQj�:6�f'�7�P|�(�U�$�"kV�吐�����2xOGzrZ�Tm�1Q��YF�J�b�Ko�Y+�~��b���x0����պ���lާ��B S�Lv��՝H݄��U�/���c!Q�Y�x���S a2�)Jf�c���dE����$����ne�5tNet4+A (�˺���	��pV�`�7��7:����!��KX?XT��[�9ឦ� ��^A��(��Z�#�� Rg��G=����$�C#`M-���y���[]ħ�TZ���D��D�m1�� �c/��b��H]�h?`����皤��(N���
�1F�R�����Z��(�fJ�n@R�{�"5\�jQ���|ʯQ�p��f�V��>����ނ�L���}c��>��"|atu�{g�,��9��Y}�:a��.��u���I��c�S���[_����Ҁ�`��J���Z�]W�uf���/����jm��ފ���Pd��#�R�-}f��9D��	s-��S^I1١��YH�'XTK	��!z����`��Ke�/,��km�x+5D7��Ns��0�^`��.C��}����s;/]��V:Lǉ�XІh�Lm�b$����¦����4�t�
�xI�����׮po�v:�;֨2��͐U}l�;w:�ҍy�m�X��sG��a�yx�u� n�*v;��,�iEI�U�P+v8HDL�D"H	q":��+]CK;>�Ek%K����������_��.      -	      x������ � �      1	   /   x�3�,�(JM��*��/.I,�L�/�,I��*���L҇Ir��qqq _Zx      	      x��}m{۶����W�:ݚ���qOc7�MҤ'�6=٤�f��>~h��ӤJR����}g�B╢d��so�֕H`f0�����e:)�,%qJ�!���"��M\�I_Gd��uTF���QY�lF.�p1��B2�T=,�Tc@��K4���$L��`\(�ƣ���h����Q��>z��G�>?������/E3x_<(�U9\��(/&y�(�OS�?����r��G$�ӌ,�$�L�q�GI֥�I� %U���iz�~����y��c�F7�z���CXn�i9�	�5���y�=ƚ�!�F�8��,˯Ä\��<�?����髪�W�=��heU��%��X��b��y�c�8��˺���N�����1�E�*��:�'�M?Q]GiY��3�~|�G�� OFg���H��+�WR���8�����
�I�-�t�$:.|f.qz�]E��׋ey�M���<+�r��j��_^����i��U�����1�_ L0I�M�&^�\�9
p����\�)�����u��q�{,��:n 8F[z��d��i�'�'��JE�����k�E���ϑ���Ohc�P�i/���=;�����#_��[w���c좹ح/�=����!�w�y�:_��/���&�ؽ���\�j������������S����+^r�9��	q��g����-�����<E.���Q�0yb?}��F��q!|���,dF�.�ֿ�x>��ɼ���t����塐��V�Q����(��
ԣsJ��=��zd���F�\�M-P�����.TP�Ӣ�a�|a`�?ת� -�>�����!�)\C�2�'*��K>�~<M���Mz!OM����+�,�W�꬞�`�����Q�)	WQq���'�MQzT	�Q$�������1Y�l�v	{
U���f��T���ɛ�}������7�Y�d�7 ϥ?ߊ��������V����k����U\���Aj�O�(��*�u�j|��v��͞�� ��0)�Z�lM���@Q��������MX������=w7�qTa���>�8_F8T����Ϋ�.UF:X_$ACMn��tI"���(��&1��HZT�qì7I�"��Η���\<�!��GXD-���L۪m�@���5�E3Y�?.�K9���5.aݢ>�V�f�7�uVF��Պ�%.�E\F�����!]u��e��
�~BszB��?����/y�ϟ����a� �t·�0����3��C�7�փU�}�V�ٔ���˅�2ړ��"�\]�(g.C�2|�g�Uz��m1�J�I�R��#�?�9"/&�9Z֣�!XC^:�~�  �$��(�\�uM!��J'a��PLgЕ�^����X��:Av�@3�������힝�2����G�V��w�pP\g4@yX�b�jq����RO�ti��o"�h/� ��;��Z�f�\��St]�64<�H�xT������;$y��E#1�%A�TT����`X��о}�Kv$��#��`�(��O:`�·A�_�|�F���:�Z�tV�����%X�*�V�V�(�E���C4��x�����{��@�%�4��a��;h�"z�l���5e4�œ��������O��<�ГR�txN|t��DI��/�9X�[��,3�	�k6( �(��V� P*$��:/-  �0o��5`�l��\D!���2�N�@�	���K��Dy�K�pF���|�cWA(�h�t��u%I����2R?��a��w��+(\Xe˲j���vg�88:�oǣ��C�L����_s���������!��ww1}.�sK�s;k���'���6k�i"�l'S��XU��?���������:G��hcm�#����y��y��i�4���)�]�[(s���L�?c��f]�y��E{�[72��@*��KV��=0�jF����2r�e'�iWl����a%��a��s�������h2���A���\p�//�V^v����O?)n�?�'���2�p��Ӭ����5���y^-¶���Vn���M��WV�Ц:dQ?u�����6���,	�����^��р.E�g���O�;|��ʨ�V!Hs,*n�Π�4_�,���=�s������&V��y��%��6N����8��p�K��ѱ��i�P����`*7t5ئ��V]�)\�rw��m�>M[�-6k�]������~�
����� h0(��߄1N?F���_���j�ϭD����o
?������*	����}e���ȭAٶ��]XY���l�����iE,/S�֐���$����<�
\�M��L?	��3�J�����u�m�T�.jג��e~$�E0j��	��C\��vl���_�M!ED=,� �^%���w�	�R�!���(�+��Z�����Z���

�Z�G��`S�1��uz�����;=�4(��������u������`w��֘aꊘ��G ^�WÖ�x�_IG?�K�a�_I?�e3%U�J�?�ڢ���!A��Lo�g%M}ބjsXP}l��2T����u�B�l��@t`g&��O$��>��-7(I\z{��^w�Ի��۳X)��k%�=�=��%�<[&�t%IpS���)~}<y� �\&a��.��&��y�Z��|'��3���0�� X�QW���#KN�[�ڵGV����4��Z{��c2j�W��b�10s���^Ĳ^��N>z����W#q����-'�u8֥OШV��vW��Jc�p��ú���~+3F��⼠���o�R���O��#���'��{��t�7����Ep����`���;V8�}KV�V%�j�H�tLt=R�wz�/�����z�T/p��t��o|�V}ủ�p�t��`WV t�X�e���w��>(��Ig3��}&�����Ӯ��#�ن�FmO�u��^+]�3T<���^��5{�/=�Rۀ�o�ʿ����¦G�8<	��NO�=ZKSoxeSw��mI�ێ�\ھdN���;����j��[�����������?�Y�n�P��=}��$''���n�������ٙ�I<��>��zh�C��{Q��G>yDKQ�ͅ��S[�E[�pİ������1�l�P�����UhVm���^�L��0��\��uED����W��-��N+����t��w�(z�G�e��y*�����l�݉]$���w*�ú��5�"T#]/]/
���^�=c ���s�)\T7L������*�!D���i�z<jw`⴬Y�&��0戬8��u}\���ȋ����pm�~`��F��l�3�G>���^��������1������2!����E(j9l�
*Zt���\s1t~�U��*#���-��Л��d8<���/�_��g��}���Y]O�8j�뮮�q���~$�8�p�����@{��NG���� �$1�)V���o<.�;���
=KE�k]�3*�1�k��|K���h*��k�J�'�{���.�u_�ݪG��_Ў��»B��/��o*~����\US�o҄��kQ�h��GO��>����+U��n�-��-2�]��9�# ������ި9�%��d�&�ꜦZv�l�"���FK������B�P�N��Z�[��!��E�,"}A|e�z=�Z�$W�K��r���AJ��d�������}Ƨ��S�SE�]�a�ۢb8�o��br��^�9��ȶ~(AW�h굄Y�Z�⃧)�_���$�����;�*�L^�L��l	f�xp"jME��:�y8��l�Y?�����ß��)�9=e6p�7Qw��Բ���4�f@|���)��p}�)��[���A5}MQ��p�)��4��?}��׼O�'��A�:R���c�_9=R찱հ��Y���V�H�*k�C���kgX��(g6;��d��(N; �#�c�FyXf��-��e����X�
��Q�?h�2LA��'I��x�4�S�i�!��à�<ϖ�sV���̒is�MU��E�Np� T>�;���Ĉ�L����X�I	��1·d4:
�9
F�����c��s0�#�~�%@ۋ3��    ��
\����(��4�O�0�K(x�3�q
�O��[|0Y��vJ� ���a~E���~�����4�w0�PP9����e�KQ�6G�˙�f�a���v������c��y�!"i�2Qjb����Ƭ��5[$N��U�MА�0E2�� *�����2�\���>0VބP�"*o�X++5�&��R�(dl�1�M��~����ʴ���
�7�a�4�t�	�K���0&��ᒄE��Rq�W:_y���	���*��o��:yuly������:\�6��;!���η�Rt����b̋��K�'�%n��b��_sS	�ѥ����p/�c����yh���[���F3.s�O+�������:�N�񬱾7�>P��k�3Ȧ�廐��4Ι��W�d�+�$+�p�0L�gº
$��ӬaP�F�ďG�$�nz=��&���靜�yU).y�%+�����V�ǁZF_��qN���׉�����V�a�$��ů��������R�( ��U\������պ�)w���dڤ��U�{͠��g�~��J��H�)�Ԛ��7������̖�ʟ�����lj�X�%�t�jE�Gs�k�����d���Ʀ��O5f!�X���PB�^���S]f�����."z[�k ⹋�� bm' ���@z����n"���{߁�g��ş+>�X6ΒL�s���'5�'��/Q	?�.�|_t�!�S�M�$�[DdHhMC� 0N=��ٜItK�6h�5t�
��Y�(K�>/?v����+�sF���-	��8v#�mk��-�J�6q���w�	r��R���QA�-�X�igK�&vC��9E䫦a�t�>�i���z����g�������gF)�?A�r}@� �\7G�|h+���T��̙�`i��6����"���7�ʹ(c�E��gV�Y$sɳ�+#F�"����}�O�Yպ��1���쪄�zbX�U��T*p�r�[u� ��Q��Ĕ�����s=�xl��U��lo�؜�&>T�Y��RV��og�t8Ij�4�o� Ϊla�?R�e}�H��~���p1c��MC��֢"zJN�q����g���� �N�A+��U}�,�����K �X̐����#�'4���}��������f�a�k�U��?S��!OC�d����q�Z+G.��iC���lx�P[��b�_�o����f�Z�5I� �JL<����0��M�#�B�$�.�/ �~���ևݶ�ŭ�V���{]4��{i5�C�A��0�x5�����)=����>[�� 㱁�t#�1��#�鞣��0ܭ�g��>��=�
 �m4:8�l(XI�u�QG��a��)���9�wt�ԜX���`4��!uHAo�r
BojW�B2�s=�/e�jŗ��'��4�;K��������fr���Fl9��\�<L���a��UD�`�ʁ����9�����w�$��?ԍ�2�O
�#-���x��I�q�r#��T���W��M����.N���A�*A�A�����=�!;dV�
������'����V��R���Zy�Ծ��L���Xi���c����y�^R��yZ?��$��e� 0Ӄ4�9���/t�G��2��0�Ay�{�P_"�w��E�X+�ͥ:�[�HX���{�d���o�~(�um�*��&�վ�c���^R/���7��S8 R�)&�g 3_]7�	�,~�uQ����I@��(�	� �K�8�5X��.��xk$�H\��|~a�gT4�h����hq����G\>n�I��[#�$��".N��hƎ����KK��������=��fv/���U��qp>qi��>��l;O��]���Ϫ]'�������^�y4�zG����V[I��r�G4U%;�Gϔ�C=$.Hl�5ao���MdΡ�h�V����A���g3؏n����j���v��T9�B�G�:u�6M[��/E����~&(w��+`]@�'�8j_��y�'YZdI4H�Ko�F+��'�L��Ȟ/=�O#j��2XL�� ���Ġ�5V���.�q���jtf�r"xD������N:�W�y�B�t���^��e��_��H�=��9��m�mEͪ�����Qw�����#�,�lХeT��t:]J�W��b8�n�Ӑ�
�Ëy�,�w�9Wh��E�(*b�����ѷg�z���U��*��V�V���>�4��¢lI���������$����-�޶������{Z�w�f�;y�yub������B�������bqnE
����Ȉ1jh~�(���|��V`UE>����m��W�����+��-���7ϟ�f��s�������ӷ&] �A~y^F�*㤀�����ޞrC|}9��!�y�~qit5/2Ӹ��<[�s5�7����U�zR�3�d�C�$����W���aO^����������,���(O��
��~=(����FxƼ�
H|h�w��X�n5i�WkSz�!����ޱo���p�uTV��_�F����>A��m!�oxJ���
��7��jWCd4�����@�]v��?Tre�5�V���n��pr�6�F���n
�U���t���^��kQɔ���P��O�-R��{牡�%��=�5q�d.Hk���d�=��	��A@�eR���`���k��.�Ǒ�O�������V��Uݼ;֍��g�tG�U.����P���]I�d�Ԫ%�v�����?0��m&�AR�=��̐)q��o��G�8)�M��_�:PT#ı�����ǋ���=�<�����g=�h��џb�8��U��a$���=���3����e<�k�X!Y�O���|6���j�N������+�/��fH��>V~�b�p��tB��E�߄�r�Ξ��ܢ4���������>8�D�VLf˳m�����y����}a�m��~dl��9�o���=��w�>ݙ����S4k�K`�4s/�P��������l����Y��Ws��k�0�&?�L�[��u�(�Ct|�S)׌�z_����dJ��H�	�'/�|+�����m�k7�xL���K��Ҕ>�����g�̝��ø�0��`��rr��$$�m(瀷e��M�`.����?��?9]KG�x� |�44�?$���
������#e&���eQݘM	?���MF%�6���I��g�s��ق��F,��/���H�6�#�ł��p�q�QnsPR�腆�L|8|r&hb<LDf�Ah���4G��9-�rcN��m��C�25Qe�	Yve�d��V?:6�m5�A�  ��-cμ�U��K�@
:�� �d��֛��fۚӹ�3��5�h�����u@���S��`
m#j�	���{�/�o1��o����lM͉�������m��E�x�~�mݎ�� ���F�����H�7ńa���L�I�TbG�=-M�i����5{��?���ʕ_6$�˸���%�?��o�K�!X5a�ȳn��l^�C���R,>n���b�ok��I�nN�)��fa�Q8}�ndK-�2�Df�)�f�N7�f��%z�,?]���p=vV7����g6��Ϊ���{���ڗ�.���fYԬ��v
	��HH�DB�c�g��w�M"��uk;�Q�Xk���8lO�lQ\��Ӹ�G͎�Jw��kuRZ�*h���#��k����sb��/���Rnm�3f*�-Yg�$q�@D_9��Ȯ�΋�?�|�k�e*�/��5L[6��N�fjy���vS���nd~+ӥ�hn(�J���Le�96�v,)�|�S2ȩ�����8i��g�+��	H�u,،5-i���S�D5�"[�
��,���� Y1g��݆"��al 3J৵���;���[��_����<���;�����&���oZ����M�9�H?a�b��U�"`":BҞe��0M���~��Ɣ�v�bnM��Ic���o)���x3���T�����#�������4���ŀ�M��A�Ԡ�վ=�o)½p�@_6࡮���?b���>zf1�u�j�V�#�L������q�K�c¯ƩE���������M��r���Йo��+�I����X}����g{j~��U�΋K� ��a��w!p�p�w a  X,Xj�ZڜF9[��g���{��!��\L�r9v� �W�0^T���94P=�o�O7o��4�LAw�����	}�k�<^H��/3�cdWX_ṰӪ�G,A� �쭾�.~�����[�N�E ��ʶ�����A��߿f2�Y�~����5�Y@������otw����C7��{_.����C-v;� �g�9�ϥ6J�t�2^)-�TV��3�փ�zER0�%���z����+w�������]ܕ��� �W�e�����:8/�]���B^Y��D��y��d�X�?t\uE8�>�[J~����zd/�v��F�/eJ�G�-d��������r�va^��T��QA~x����e������w�2.����.z��2MA��I�g7��0Jv��q�	��"_#x���6���2Ñ=�o0���_�T\,�2Ë�aȥeA��F�R~�$��\f��kW�<|tt�����G?W��[^y�|��ݯ8i{���^ir��L����ޮ.��+K�W������j��e��d�+HXX���1<��#"pA�߻6��f��ݥ�!W��U�~�}��B�l�:��[]Bߠ߰���"��lqK�`����3��hy�B����������Jb�~�ŭPL;�j�6�f����n�P/�Ҽ~�ǖ�����y�{�r��'�t�Į�M�閉]o��ӭ[�&q�[$6����[�a�%�*�[�
�|�#]��o�J9o}����\fB�]Z)��v�F6,�������;B#����9wí2�[��l�u��m�ea����UA����[���[��,��H]�ݎ��a����a���_��v��n�ݠ�V��ͷ�f���h�mo-P�|�m�[
��	$�c����B�p�@í�M�tۀ� M}H��z�@��,�T��=���Z�p����� ƭ ����`����e�7���������!��}e󷶦1{����o���Y����Y�]��7g����X��ζo˲oˮ_o�*��]NG��̦OK(Y���B~������ֵr��p«斺l����M�-56����h�}_���K�.�S*)���J��6)�6�������G4{��Ώ�I�YIlf�^(�
Ys�8r�l��)g�v�B�F�P���PfO�Z�ۛA⑏<�]��iLX�dSq��C��O[��5���.�]�O��!�2�%��v��v��?1����o�����s��//�Rm�'� pM�`�� �����A�[C�g���w	zl�x� ����5nf�K�����[9Xqc�bu�]N4Αۡ�`�ƽ\g��=��y�6:�qW��w&���]8��e�`s���6�l�:�oS�߆`��������"�o� >}br�ի����v
ʻ�`<s�i��}���u&Y��i<�
�3W���B}�%Y.����9Hn���;�m�t�m�v_�n��� �F�nj�,�lw���`5���N��f�֨+�GΠ�M�f-�̔��JQ�&SM&g���c�4�B�!Hl���j=�fئZ0�%��`��_������>���C�2��hhS0�s�*o)KK�I����bM�x�bKx	T���u��x��댧t|j�%����f��W��j�z7D+t��X;\���d�ߧ��
�V��E�(�|��ǎ�w���%����O�޻�	p;�֭����k��:
oS�]s�ը�j���DI�]��yk�zv�	�*��������b����#	T$�Z!�ܵA1��Ѣ�� ����š�At�4�؎����Թ�S���O:��
��#�>�f�2)�����������v�ˋ����9|�� �/N_|���#��F      3	      x�3�4�4������ �Y      "	      x������ � �      $	      x������ � �      &	      x������ � �      (	      x������ � �      )	      x������ � �      *	   Q   x��Q
�  ���.K�3�.A��0�����CP)��#�XH|�T��$���b���:����^�,�d��L��9 �mA�.~      5	      x������ � �      /	      x������ � �     