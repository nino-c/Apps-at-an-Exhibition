--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO ninopq;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO ninopq;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO ninopq;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO ninopq;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO ninopq;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO ninopq;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: authtools_user; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE authtools_user (
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


ALTER TABLE public.authtools_user OWNER TO ninopq;

--
-- Name: authtools_user_groups; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE authtools_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.authtools_user_groups OWNER TO ninopq;

--
-- Name: authtools_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE authtools_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authtools_user_groups_id_seq OWNER TO ninopq;

--
-- Name: authtools_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE authtools_user_groups_id_seq OWNED BY authtools_user_groups.id;


--
-- Name: authtools_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE authtools_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authtools_user_id_seq OWNER TO ninopq;

--
-- Name: authtools_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE authtools_user_id_seq OWNED BY authtools_user.id;


--
-- Name: authtools_user_user_permissions; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE authtools_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.authtools_user_user_permissions OWNER TO ninopq;

--
-- Name: authtools_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE authtools_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authtools_user_user_permissions_id_seq OWNER TO ninopq;

--
-- Name: authtools_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE authtools_user_user_permissions_id_seq OWNED BY authtools_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO ninopq;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO ninopq;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO ninopq;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO ninopq;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO ninopq;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO ninopq;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO ninopq;

--
-- Name: easy_thumbnails_source; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE easy_thumbnails_source (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL
);


ALTER TABLE public.easy_thumbnails_source OWNER TO ninopq;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE easy_thumbnails_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_source_id_seq OWNER TO ninopq;

--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE easy_thumbnails_source_id_seq OWNED BY easy_thumbnails_source.id;


--
-- Name: easy_thumbnails_thumbnail; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE easy_thumbnails_thumbnail (
    id integer NOT NULL,
    storage_hash character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    modified timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE public.easy_thumbnails_thumbnail OWNER TO ninopq;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE easy_thumbnails_thumbnail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnail_id_seq OWNER TO ninopq;

--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE easy_thumbnails_thumbnail_id_seq OWNED BY easy_thumbnails_thumbnail.id;


--
-- Name: easy_thumbnails_thumbnaildimensions; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE easy_thumbnails_thumbnaildimensions (
    id integer NOT NULL,
    thumbnail_id integer NOT NULL,
    width integer,
    height integer,
    CONSTRAINT easy_thumbnails_thumbnaildimensions_height_check CHECK ((height >= 0)),
    CONSTRAINT easy_thumbnails_thumbnaildimensions_width_check CHECK ((width >= 0))
);


ALTER TABLE public.easy_thumbnails_thumbnaildimensions OWNER TO ninopq;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easy_thumbnails_thumbnaildimensions_id_seq OWNER TO ninopq;

--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE easy_thumbnails_thumbnaildimensions_id_seq OWNED BY easy_thumbnails_thumbnaildimensions.id;


--
-- Name: game_category; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE game_category (
    id integer NOT NULL,
    name character varying(1000) NOT NULL,
    description text,
    image character varying(100),
    parent_id integer
);


ALTER TABLE public.game_category OWNER TO ninopq;

--
-- Name: game_category_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE game_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_category_id_seq OWNER TO ninopq;

--
-- Name: game_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE game_category_id_seq OWNED BY game_category.id;


--
-- Name: game_gameinstance; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE game_gameinstance (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    seed text NOT NULL,
    game_id integer NOT NULL,
    instantiator_id integer NOT NULL,
    updated timestamp with time zone NOT NULL
);


ALTER TABLE public.game_gameinstance OWNER TO ninopq;

--
-- Name: game_gameinstance_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE game_gameinstance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_gameinstance_id_seq OWNER TO ninopq;

--
-- Name: game_gameinstance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE game_gameinstance_id_seq OWNED BY game_gameinstance.id;


--
-- Name: game_gameinstancesnapshot; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE game_gameinstancesnapshot (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    "time" double precision NOT NULL,
    instance_id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL
);


ALTER TABLE public.game_gameinstancesnapshot OWNER TO ninopq;

--
-- Name: game_gameinstancesnapshot_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE game_gameinstancesnapshot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_gameinstancesnapshot_id_seq OWNER TO ninopq;

--
-- Name: game_gameinstancesnapshot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE game_gameinstancesnapshot_id_seq OWNED BY game_gameinstancesnapshot.id;


--
-- Name: game_jslibrary; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE game_jslibrary (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    "scriptPath" character varying(200) NOT NULL
);


ALTER TABLE public.game_jslibrary OWNER TO ninopq;

--
-- Name: game_jslibrary_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE game_jslibrary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_jslibrary_id_seq OWNER TO ninopq;

--
-- Name: game_jslibrary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE game_jslibrary_id_seq OWNED BY game_jslibrary.id;


--
-- Name: game_zeroplayergame; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE game_zeroplayergame (
    id integer NOT NULL,
    title character varying(500) NOT NULL,
    description text NOT NULL,
    created timestamp with time zone NOT NULL,
    category_id integer NOT NULL,
    owner_id integer NOT NULL,
    "scriptType" character varying(100),
    source text NOT NULL,
    "seedStructure" text NOT NULL,
    "mainImage" character varying(255),
    parent_id integer,
    updated timestamp with time zone NOT NULL
);


ALTER TABLE public.game_zeroplayergame OWNER TO ninopq;

--
-- Name: game_plerpingapp_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE game_plerpingapp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_plerpingapp_id_seq OWNER TO ninopq;

--
-- Name: game_plerpingapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE game_plerpingapp_id_seq OWNED BY game_zeroplayergame.id;


--
-- Name: game_zeroplayergame_extraIncludes; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE "game_zeroplayergame_extraIncludes" (
    id integer NOT NULL,
    zeroplayergame_id integer NOT NULL,
    jslibrary_id integer NOT NULL
);


ALTER TABLE public."game_zeroplayergame_extraIncludes" OWNER TO ninopq;

--
-- Name: game_zeroplayergame_extraIncludes_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE "game_zeroplayergame_extraIncludes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."game_zeroplayergame_extraIncludes_id_seq" OWNER TO ninopq;

--
-- Name: game_zeroplayergame_extraIncludes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE "game_zeroplayergame_extraIncludes_id_seq" OWNED BY "game_zeroplayergame_extraIncludes".id;


--
-- Name: portfolio_imagegallery; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE portfolio_imagegallery (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.portfolio_imagegallery OWNER TO ninopq;

--
-- Name: portfolio_imagegallery_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE portfolio_imagegallery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portfolio_imagegallery_id_seq OWNER TO ninopq;

--
-- Name: portfolio_imagegallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE portfolio_imagegallery_id_seq OWNED BY portfolio_imagegallery.id;


--
-- Name: portfolio_imagemodel; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE portfolio_imagemodel (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    gallery_id integer
);


ALTER TABLE public.portfolio_imagemodel OWNER TO ninopq;

--
-- Name: portfolio_imagemodel_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE portfolio_imagemodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portfolio_imagemodel_id_seq OWNER TO ninopq;

--
-- Name: portfolio_imagemodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE portfolio_imagemodel_id_seq OWNED BY portfolio_imagemodel.id;


--
-- Name: portfolio_portfoliocategory; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE portfolio_portfoliocategory (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image character varying(100)
);


ALTER TABLE public.portfolio_portfoliocategory OWNER TO ninopq;

--
-- Name: portfolio_portfoliocategory_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE portfolio_portfoliocategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portfolio_portfoliocategory_id_seq OWNER TO ninopq;

--
-- Name: portfolio_portfoliocategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE portfolio_portfoliocategory_id_seq OWNED BY portfolio_portfoliocategory.id;


--
-- Name: portfolio_portfolioitem; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE portfolio_portfolioitem (
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


ALTER TABLE public.portfolio_portfolioitem OWNER TO ninopq;

--
-- Name: portfolio_portfolioitem_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE portfolio_portfolioitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.portfolio_portfolioitem_id_seq OWNER TO ninopq;

--
-- Name: portfolio_portfolioitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE portfolio_portfolioitem_id_seq OWNED BY portfolio_portfolioitem.id;


--
-- Name: portfolio_proprietaryportfolioitem; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE portfolio_proprietaryportfolioitem (
    portfolioitem_ptr_id integer NOT NULL,
    company character varying(100) NOT NULL,
    gallery_id integer NOT NULL
);


ALTER TABLE public.portfolio_proprietaryportfolioitem OWNER TO ninopq;

--
-- Name: profiles_profile; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE profiles_profile (
    user_id integer NOT NULL,
    slug uuid NOT NULL,
    picture character varying(100),
    bio character varying(200),
    email_verified boolean NOT NULL
);


ALTER TABLE public.profiles_profile OWNER TO ninopq;

--
-- Name: profiles_profile_followers; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE profiles_profile_followers (
    id integer NOT NULL,
    from_profile_id integer NOT NULL,
    to_profile_id integer NOT NULL
);


ALTER TABLE public.profiles_profile_followers OWNER TO ninopq;

--
-- Name: profiles_profile_followers_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE profiles_profile_followers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_profile_followers_id_seq OWNER TO ninopq;

--
-- Name: profiles_profile_followers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE profiles_profile_followers_id_seq OWNED BY profiles_profile_followers.id;


--
-- Name: static_precompiler_dependency; Type: TABLE; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE TABLE static_precompiler_dependency (
    id integer NOT NULL,
    source character varying(255) NOT NULL,
    depends_on character varying(255) NOT NULL
);


ALTER TABLE public.static_precompiler_dependency OWNER TO ninopq;

--
-- Name: static_precompiler_dependency_id_seq; Type: SEQUENCE; Schema: public; Owner: ninopq
--

CREATE SEQUENCE static_precompiler_dependency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.static_precompiler_dependency_id_seq OWNER TO ninopq;

--
-- Name: static_precompiler_dependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ninopq
--

ALTER SEQUENCE static_precompiler_dependency_id_seq OWNED BY static_precompiler_dependency.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user ALTER COLUMN id SET DEFAULT nextval('authtools_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_groups ALTER COLUMN id SET DEFAULT nextval('authtools_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('authtools_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY easy_thumbnails_source ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY easy_thumbnails_thumbnail ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions ALTER COLUMN id SET DEFAULT nextval('easy_thumbnails_thumbnaildimensions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_category ALTER COLUMN id SET DEFAULT nextval('game_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_gameinstance ALTER COLUMN id SET DEFAULT nextval('game_gameinstance_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_gameinstancesnapshot ALTER COLUMN id SET DEFAULT nextval('game_gameinstancesnapshot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_jslibrary ALTER COLUMN id SET DEFAULT nextval('game_jslibrary_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_zeroplayergame ALTER COLUMN id SET DEFAULT nextval('game_plerpingapp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY "game_zeroplayergame_extraIncludes" ALTER COLUMN id SET DEFAULT nextval('"game_zeroplayergame_extraIncludes_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_imagegallery ALTER COLUMN id SET DEFAULT nextval('portfolio_imagegallery_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_imagemodel ALTER COLUMN id SET DEFAULT nextval('portfolio_imagemodel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_portfoliocategory ALTER COLUMN id SET DEFAULT nextval('portfolio_portfoliocategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_portfolioitem ALTER COLUMN id SET DEFAULT nextval('portfolio_portfolioitem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY profiles_profile_followers ALTER COLUMN id SET DEFAULT nextval('profiles_profile_followers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY static_precompiler_dependency ALTER COLUMN id SET DEFAULT nextval('static_precompiler_dependency_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY auth_group (id, name) FROM stdin;
1	Level 1 user
2	Level 2 user
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('auth_group_id_seq', 2, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	52
2	2	46
3	2	49
4	2	50
5	2	52
6	2	53
7	2	55
8	2	57
9	2	67
10	2	68
11	2	69
12	2	47
13	2	48
14	2	51
15	2	54
16	2	56
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 16, true);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add log entry	3	add_logentry
8	Can change log entry	3	change_logentry
9	Can delete log entry	3	delete_logentry
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add user	6	add_user
17	Can change user	6	change_user
18	Can delete user	6	delete_user
19	Can add source	7	add_source
20	Can change source	7	change_source
21	Can delete source	7	delete_source
22	Can add thumbnail	8	add_thumbnail
23	Can change thumbnail	8	change_thumbnail
24	Can delete thumbnail	8	delete_thumbnail
25	Can add thumbnail dimensions	9	add_thumbnaildimensions
26	Can change thumbnail dimensions	9	change_thumbnaildimensions
27	Can delete thumbnail dimensions	9	delete_thumbnaildimensions
28	Can add profile	10	add_profile
29	Can change profile	10	change_profile
30	Can delete profile	10	delete_profile
31	Can add portfolio category	11	add_portfoliocategory
32	Can change portfolio category	11	change_portfoliocategory
33	Can delete portfolio category	11	delete_portfoliocategory
34	Can add portfolio item	12	add_portfolioitem
35	Can change portfolio item	12	change_portfolioitem
36	Can delete portfolio item	12	delete_portfolioitem
37	Can add image gallery	13	add_imagegallery
38	Can change image gallery	13	change_imagegallery
39	Can delete image gallery	13	delete_imagegallery
40	Can add image model	14	add_imagemodel
41	Can change image model	14	change_imagemodel
42	Can delete image model	14	delete_imagemodel
43	Can add proprietary portfolio item	15	add_proprietaryportfolioitem
44	Can change proprietary portfolio item	15	change_proprietaryportfolioitem
45	Can delete proprietary portfolio item	15	delete_proprietaryportfolioitem
46	Can add category	16	add_category
47	Can change category	16	change_category
48	Can delete category	16	delete_category
49	Can add zero player game	17	add_zeroplayergame
50	Can change zero player game	17	change_zeroplayergame
51	Can delete zero player game	17	delete_zeroplayergame
52	Can add game instance	18	add_gameinstance
53	Can change game instance	18	change_gameinstance
54	Can delete game instance	18	delete_gameinstance
55	Can add game instance snapshot	19	add_gameinstancesnapshot
56	Can change game instance snapshot	19	change_gameinstancesnapshot
57	Can delete game instance snapshot	19	delete_gameinstancesnapshot
64	Can add dependency	22	add_dependency
65	Can change dependency	22	change_dependency
66	Can delete dependency	22	delete_dependency
67	Can add js library	23	add_jslibrary
68	Can change js library	23	change_jslibrary
69	Can delete js library	23	delete_jslibrary
70	Can add category	24	add_category
71	Can change category	24	change_category
72	Can delete category	24	delete_category
73	Can add js library	25	add_jslibrary
74	Can change js library	25	change_jslibrary
75	Can delete js library	25	delete_jslibrary
76	Can add app	26	add_app
77	Can change app	26	change_app
78	Can delete app	26	delete_app
79	Can add app instance	27	add_appinstance
80	Can change app instance	27	change_appinstance
81	Can delete app instance	27	delete_appinstance
82	Can add snapshot	28	add_snapshot
83	Can change snapshot	28	change_snapshot
84	Can delete snapshot	28	delete_snapshot
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('auth_permission_id_seq', 87, true);


--
-- Data for Name: authtools_user; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY authtools_user (id, password, last_login, is_superuser, email, is_staff, is_active, date_joined, name) FROM stdin;
1	pbkdf2_sha256$24000$FjBYgpxyCPgp$QyiNe1HT60XGPtKcAaTDnHiLajVkkHo99/2Tit3PFhc=	2016-03-05 03:18:49.677951-08	t	nino.cocchiarella@gmail.com	t	t	2016-01-27 17:45:34.23439-08	Nino P. Cocchiarella
\.


--
-- Data for Name: authtools_user_groups; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY authtools_user_groups (id, user_id, group_id) FROM stdin;
1	1	2
\.


--
-- Name: authtools_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('authtools_user_groups_id_seq', 1, true);


--
-- Name: authtools_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('authtools_user_id_seq', 1, true);


--
-- Data for Name: authtools_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY authtools_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: authtools_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('authtools_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2016-01-27 17:47:27.700943-08	1	Mazes	1	Added.	16	1
2	2016-01-27 17:48:40.369918-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	1	Added.	17	1
3	2016-01-27 17:58:16.621353-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	1	Added.	17	1
4	2016-01-28 19:00:46.80575-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seedStruct and source.	17	1
5	2016-01-28 20:05:20.435543-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seedStruct. Added game param "GameParam object".	17	1
6	2016-01-29 12:07:55.189922-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seedStructure.	17	1
7	2016-01-29 12:14:32.594538-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
8	2016-01-29 13:07:03.238402-08	2	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	3		18	1
9	2016-01-29 15:18:25.040593-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
10	2016-01-29 15:47:14.663537-08	2	Mathematics	1	Added.	16	1
11	2016-01-29 15:48:06.502087-08	3	"Test", by Nino P. Cocchiarella	1	Added.	17	1
12	2016-01-29 15:57:16.277988-08	3	"Test", by Nino P. Cocchiarella	2	Changed source.	17	1
13	2016-01-29 15:58:04.816405-08	4	Nino P. Cocchiarella's instance of "Test", by Nino P. Cocchiarella	3		18	1
14	2016-01-29 15:58:04.835702-08	3	Nino P. Cocchiarella's instance of "Test", by Nino P. Cocchiarella	3		18	1
15	2016-01-29 16:28:59.530265-08	5	Nino P. Cocchiarella's instance of "Test", by Nino P. Cocchiarella	2	Changed source.	18	1
16	2016-01-29 16:31:04.16745-08	1	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	18	1
17	2016-01-29 16:33:33.901737-08	6	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed and source.	18	1
18	2016-01-29 16:36:03.062344-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
19	2016-01-29 16:36:20.307774-08	6	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	3		18	1
20	2016-01-29 16:36:20.395975-08	1	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	3		18	1
21	2016-01-29 18:19:37.751364-08	9	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed.	18	1
22	2016-01-29 18:19:48.186781-08	8	Nino P. Cocchiarella's instance of "2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed.	18	1
23	2016-01-29 18:50:16.867484-08	1	"2-dimensional interactive Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed description.	17	1
24	2016-01-29 18:51:07.990815-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	2	Changed description.	17	1
25	2016-01-29 20:29:37.152309-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed title.	17	1
26	2016-01-29 22:36:56.549286-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
27	2016-01-30 13:21:45.864177-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
28	2016-01-30 13:22:40.981475-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
37	2016-01-30 18:27:33.221388-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
38	2016-01-30 18:28:27.249254-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
39	2016-01-30 18:29:57.247359-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
40	2016-01-30 18:32:24.06655-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
41	2016-01-30 18:33:58.285461-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
42	2016-01-30 19:43:04.323785-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source.	17	1
43	2016-01-30 19:43:53.968305-08	9	Nino P. Cocchiarella's instance of "2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed.	18	1
44	2016-01-30 19:44:14.159965-08	8	Nino P. Cocchiarella's instance of "2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed.	18	1
45	2016-01-30 19:44:38.722613-08	7	Nino P. Cocchiarella's instance of "2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seed.	18	1
46	2016-01-30 19:52:53.443235-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed seedStructure.	17	1
47	2016-02-01 11:35:18.265689-08	1	Level 1 user	1	Added.	2	1
48	2016-02-01 11:36:25.121257-08	2	Level 2 user	1	Added.	2	1
49	2016-02-01 11:36:33.75104-08	1	Nino P. Cocchiarella <nino.cocchiarella@gmail.com>	2	Changed groups.	6	1
50	2016-02-01 16:00:48.075102-08	4	"Multivariate Polynomial Landscape", by Nino P. Cocchiarella	1	Added.	17	1
51	2016-02-01 16:03:48.883288-08	4	"Multivariate Polynomial Landscape", by Nino P. Cocchiarella	2	No fields changed.	17	1
52	2016-02-01 16:04:39.421893-08	4	"Multivariate Polynomial Landscape", by Nino P. Cocchiarella	2	Changed seedStructure.	17	1
53	2016-02-01 16:05:29.865624-08	4	"Multivariate Polynomial Landscape", by Nino P. Cocchiarella	2	Changed seedStructure.	17	1
54	2016-02-01 16:36:32.529452-08	4	"Multivariate Polynomial Landscape", by Nino P. Cocchiarella	2	Changed source.	17	1
55	2016-02-01 17:48:13.770165-08	5	"Function in 1 variable with time parameter", by Nino P. Cocchiarella	1	Added.	17	1
56	2016-02-02 01:01:18.52974-08	13	Nino P. Cocchiarella's instance of "Function in 1 variable with time parameter", by Nino P. Cocchiarella	3		18	1
57	2016-02-02 01:01:18.577913-08	5	Nino P. Cocchiarella's instance of "Test", by Nino P. Cocchiarella	3		18	1
58	2016-02-02 01:04:01.14474-08	5	"Function in 1 variable with time parameter", by Nino P. Cocchiarella	2	Changed source and seedStructure.	17	1
59	2016-02-02 01:04:46.661892-08	5	"Function in 1 variable with time parameter", by Nino P. Cocchiarella	2	Changed seedStructure.	17	1
60	2016-02-03 23:10:40.868447-08	3	"Test", by Nino P. Cocchiarella	3		17	1
61	2016-02-03 23:11:58.972916-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	2	Changed source and seedStructure.	17	1
62	2016-02-03 23:29:18.436802-08	1	JSLibrary object	1	Added.	23	1
63	2016-02-03 23:30:35.554499-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	2	Changed source and extraIncludes.	17	1
64	2016-02-03 23:44:49.520596-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	2	Changed source.	17	1
65	2016-02-04 00:18:50.923287-08	41	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 08:16:33.344232+00:00	3		19	1
66	2016-02-04 00:18:50.934047-08	40	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 08:12:21.762028+00:00	3		19	1
67	2016-02-04 00:18:50.944281-08	39	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 08:11:40.674877+00:00	3		19	1
68	2016-02-04 00:18:50.955265-08	38	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:45:07.952702+00:00	3		19	1
69	2016-02-04 00:18:50.966227-08	37	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:21:36.492645+00:00	3		19	1
70	2016-02-04 00:18:50.977288-08	35	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:18:07.345077+00:00	3		19	1
71	2016-02-04 00:18:50.988413-08	34	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:18:02.663271+00:00	3		19	1
72	2016-02-04 00:18:50.999312-08	33	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:17:57.341122+00:00	3		19	1
73	2016-02-04 00:18:51.010311-08	32	3-dimensional "Wolfenstein" Maze Generator, 2016-02-04 07:17:53.179290+00:00	3		19	1
29	2016-01-30 13:35:43.560644-08	8	ImageTest object	3		\N	1
30	2016-01-30 13:35:43.61517-08	7	ImageTest object	3		\N	1
31	2016-01-30 13:35:43.648126-08	6	ImageTest object	3		\N	1
32	2016-01-30 13:35:43.659143-08	5	ImageTest object	3		\N	1
33	2016-01-30 13:35:43.670146-08	4	ImageTest object	3		\N	1
34	2016-01-30 13:35:43.681172-08	3	ImageTest object	3		\N	1
35	2016-01-30 13:35:43.692139-08	2	ImageTest object	3		\N	1
36	2016-01-30 13:35:43.703166-08	1	ImageTest object	3		\N	1
74	2016-02-22 02:31:25.003504-08	1	"2-dimensional Maze Generator and Solver", by Nino P. Cocchiarella	2	Changed source and seedStructure.	17	1
75	2016-02-29 18:57:30.376716-08	2	"3-dimensional "Wolfenstein" Maze Generator", by Nino P. Cocchiarella	2	Changed source.	17	1
76	2016-03-05 03:18:14.239689-08	2	Level 2 user	2	Changed permissions.	2	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 76, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	auth	permission
2	auth	group
3	admin	logentry
4	contenttypes	contenttype
5	sessions	session
6	authtools	user
7	easy_thumbnails	source
8	easy_thumbnails	thumbnail
9	easy_thumbnails	thumbnaildimensions
10	profiles	profile
11	portfolio	portfoliocategory
12	portfolio	portfolioitem
13	portfolio	imagegallery
14	portfolio	imagemodel
15	portfolio	proprietaryportfolioitem
16	game	category
17	game	zeroplayergame
18	game	gameinstance
19	game	gameinstancesnapshot
22	static_precompiler	dependency
23	game	jslibrary
24	exhibitions	category
25	exhibitions	jslibrary
26	exhibitions	app
27	exhibitions	appinstance
28	exhibitions	snapshot
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('django_content_type_id_seq', 29, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-01-27 16:29:09.657917-08
2	auth	0001_initial	2016-01-27 16:29:10.36432-08
3	authtools	0001_initial	2016-01-27 16:29:11.003785-08
4	admin	0001_initial	2016-01-27 16:29:11.246166-08
5	admin	0002_logentry_remove_auto_add	2016-01-27 16:29:11.345112-08
6	contenttypes	0002_remove_content_type_name	2016-01-27 16:29:11.433158-08
7	auth	0002_alter_permission_name_max_length	2016-01-27 16:29:11.48828-08
8	auth	0003_alter_user_email_max_length	2016-01-27 16:29:11.529092-08
9	auth	0004_alter_user_username_opts	2016-01-27 16:29:11.567364-08
10	auth	0005_alter_user_last_login_null	2016-01-27 16:29:11.615745-08
11	auth	0006_require_contenttypes_0002	2016-01-27 16:29:11.636105-08
12	auth	0007_alter_validators_add_error_messages	2016-01-27 16:29:11.685856-08
13	authtools	0002_django18	2016-01-27 16:29:11.730451-08
14	authtools	0003_auto_20160119_0110	2016-01-27 16:29:12.083018-08
15	easy_thumbnails	0001_initial	2016-01-27 16:29:12.821142-08
16	easy_thumbnails	0002_thumbnaildimensions	2016-01-27 16:29:13.010288-08
17	game	0001_initial	2016-01-27 16:29:13.341116-08
18	game	0002_auto_20160126_1004	2016-01-27 16:29:13.382257-08
19	game	0003_auto_20160126_2325	2016-01-27 16:29:13.46204-08
20	game	0004_auto_20160127_0729	2016-01-27 16:29:14.046475-08
21	game	0005_auto_20160127_0938	2016-01-27 16:29:14.498796-08
22	game	0006_auto_20160128_0029	2016-01-27 16:29:14.828707-08
23	portfolio	0001_initial	2016-01-27 16:29:15.413418-08
24	portfolio	0002_portfolioitem_url	2016-01-27 16:29:15.457852-08
25	portfolio	0003_auto_20160119_0804	2016-01-27 16:29:15.493712-08
26	profiles	0001_initial	2016-01-27 16:29:15.611238-08
27	sessions	0001_initial	2016-01-27 16:29:15.864685-08
28	game	0007_zeroplayergame_seedstruct	2016-01-28 18:56:51.119154-08
29	game	0008_gameparam	2016-01-28 19:55:40.48746-08
30	game	0009_auto_20160129_0358	2016-01-28 19:58:09.648095-08
31	game	0010_remove_zeroplayergame_seedstruct	2016-01-28 20:08:37.100551-08
32	game	0011_auto_20160129_2004	2016-01-29 12:05:16.332071-08
33	game	0012_auto_20160129_2037	2016-01-29 12:37:26.816915-08
34	game	0013_auto_20160129_2108	2016-01-29 13:08:13.190762-08
35	game	0014_remove_gameinstance_source	2016-01-29 22:23:41.475212-08
36	game	0015_imagetest	2016-01-30 00:07:50.293203-08
37	game	0016_auto_20160130_2158	2016-01-30 13:58:17.789642-08
38	game	0017_zeroplayergame_updated	2016-01-31 14:52:10.84083-08
39	game	0018_remove_zeroplayergame_updated	2016-02-01 12:45:08.377417-08
40	static_precompiler	0001_initial	2016-02-02 16:36:38.784478-08
41	game	0019_auto_20160204_0727	2016-02-03 23:27:26.839165-08
42	profiles	0002_profile_followers	2016-02-05 17:00:14.407172-08
43	exhibitions	0001_initial	2016-02-18 04:26:06.187906-08
44	game	0020_auto_20160218_1434	2016-02-18 06:34:47.7967-08
45	game	0002_auto_20160220_0240	2016-02-19 18:40:40.003093-08
46	game	0003_auto_20160220_1718	2016-02-20 09:18:11.897276-08
47	game	0004_auto_20160220_1719	2016-02-20 09:19:19.113146-08
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('django_migrations_id_seq', 47, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
o5euotw6b22qh8jfg9lspow6daibgg46	YTZkMGI4MDIyN2IzMWRhNmYyZGQ5OGViOWNmNDMyZTExNmQyNTBkNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwMmJmYzMxNDJiODMzNThkZDgyM2JmZTc4ZGMzZTkzM2QxNGUwMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-02-12 18:49:10.471831-08
6dx7q6va4bq8gbfkr5fznk0d3zj2s2xn	YTZkMGI4MDIyN2IzMWRhNmYyZGQ5OGViOWNmNDMyZTExNmQyNTBkNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwMmJmYzMxNDJiODMzNThkZDgyM2JmZTc4ZGMzZTkzM2QxNGUwMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-02-16 14:41:29.393568-08
iqmsse0hhdq50kgzszfar8fi3sgzq7y0	YTZkMGI4MDIyN2IzMWRhNmYyZGQ5OGViOWNmNDMyZTExNmQyNTBkNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwMmJmYzMxNDJiODMzNThkZDgyM2JmZTc4ZGMzZTkzM2QxNGUwMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-02-19 16:56:20.951166-08
nknuc7mud0exywtdr1zgkszsnybup3nx	YTZkMGI4MDIyN2IzMWRhNmYyZGQ5OGViOWNmNDMyZTExNmQyNTBkNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwMmJmYzMxNDJiODMzNThkZDgyM2JmZTc4ZGMzZTkzM2QxNGUwMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-03-03 05:55:13.99241-08
eqiuzs007bc4pyzu5yrrfm7cuidvkdc4	YTZkMGI4MDIyN2IzMWRhNmYyZGQ5OGViOWNmNDMyZTExNmQyNTBkNzp7Il9hdXRoX3VzZXJfaGFzaCI6ImMwMmJmYzMxNDJiODMzNThkZDgyM2JmZTc4ZGMzZTkzM2QxNGUwMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-03-19 04:18:49.698756-07
\.


--
-- Data for Name: easy_thumbnails_source; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY easy_thumbnails_source (id, storage_hash, name, modified) FROM stdin;
1	f9bde26a1556cd667f742bd34ec7c55e	profile_pics/2016-02-02/97.jpg	2016-02-02 14:42:54.578053-08
\.


--
-- Name: easy_thumbnails_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('easy_thumbnails_source_id_seq', 1, true);


--
-- Data for Name: easy_thumbnails_thumbnail; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY easy_thumbnails_thumbnail (id, storage_hash, name, modified, source_id) FROM stdin;
1	d26becbf46ac48eda79c7a39a13a02dd	profile_pics/2016-02-02/97.jpg.30x30_q85_crop.png	2016-02-02 14:42:54.401698-08	1
2	d26becbf46ac48eda79c7a39a13a02dd	profile_pics/2016-02-02/97.jpg.140x140_q85_crop.png	2016-02-02 14:42:54.621918-08	1
\.


--
-- Name: easy_thumbnails_thumbnail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('easy_thumbnails_thumbnail_id_seq', 2, true);


--
-- Data for Name: easy_thumbnails_thumbnaildimensions; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY easy_thumbnails_thumbnaildimensions (id, thumbnail_id, width, height) FROM stdin;
\.


--
-- Name: easy_thumbnails_thumbnaildimensions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('easy_thumbnails_thumbnaildimensions_id_seq', 1, false);


--
-- Data for Name: game_category; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY game_category (id, name, description, image, parent_id) FROM stdin;
1	Mazes	sdfg		\N
2	Mathematics	sdfg		\N
\.


--
-- Name: game_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('game_category_id_seq', 2, true);


--
-- Data for Name: game_gameinstance; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY game_gameinstance (id, created, seed, game_id, instantiator_id, updated) FROM stdin;
12	2016-02-01 16:05:36.312578-08	{"x1": 5}	4	1	2016-02-18 06:34:17.339458-08
14	2016-02-02 01:04:54.948786-08	{"xMin": -5, "breathDelta": 17, "xMax": 5, "funct": "x*Math.cos(x)"}	5	1	2016-02-18 06:34:17.339458-08
15	2016-02-02 14:39:31.169028-08	{"xMin": -5, "breathDelta": 17, "xMax": 5, "funct": "x*Math.cos(x)"}	5	1	2016-02-18 06:34:17.339458-08
17	2016-02-03 23:15:16.00152-08	{}	2	1	2016-02-18 06:34:17.339458-08
18	2016-02-05 01:07:54.920742-08	{"xMin": -5, "breathDelta": 17, "xMax": 5, "funct": "x*Math.cos(x)"}	5	1	2016-02-18 06:34:17.339458-08
19	2016-02-18 07:06:59.028687-08	{"xMin": -5, "breathDelta": 17, "xMax": 5, "funct": "x*Math.cos(x)"}	5	1	2016-02-18 07:06:59.028738-08
26	2016-03-11 21:36:25.044913-08	{"solutionPathColor": "rgba(0,0,200,0.8)", "cellSize": 30}	24	1	2016-03-11 21:36:25.044964-08
27	2016-03-11 21:41:15.526222-08	{"solutionPathColor": "rgba(0,0,200,0.8)", "cellSize": 30}	24	1	2016-03-11 21:41:15.526272-08
28	2016-03-12 04:54:34.693646-08	{"x1": 5}	4	1	2016-03-12 04:54:34.693696-08
29	2016-03-12 05:10:02.404567-08	{"param1": ""}	25	1	2016-03-12 05:10:02.404617-08
\.


--
-- Name: game_gameinstance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('game_gameinstance_id_seq', 29, true);


--
-- Data for Name: game_gameinstancesnapshot; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY game_gameinstancesnapshot (id, image, "time", instance_id, created, updated) FROM stdin;
17	./fbd09b58694a58022e0938fa5ed7b19b18462f79f8a17922750b8940.png	8.27299999999999969	12	2016-02-01 17:53:27.823736-08	2016-02-18 06:34:28.447981-08
18	./1c25cae8be78cda9a5af09232f30867d66707c2b07408682668a4a88.png	7.87199999999999989	12	2016-02-01 17:53:39.524886-08	2016-02-18 06:34:28.447981-08
19	./5c4878aa13fc26ef0960a8d62de0a1c083d592eb83c647b682aecdd0.png	8.36500000000000021	12	2016-02-01 17:53:51.943088-08	2016-02-18 06:34:28.447981-08
20	./ca4ca066f299db769661abb572ea9fbf40e837041b800b0397b95ae3.png	7.77200000000000024	12	2016-02-01 17:54:20.659956-08	2016-02-18 06:34:28.447981-08
21	./c35d043fe308cd604a1fe48638129102855689e57ec8bad3bdf59353.png	9.23000000000000043	12	2016-02-01 17:54:45.088959-08	2016-02-18 06:34:28.447981-08
22	./12fb10b8bf0b17abc8fb954d518de38fe2c1fcafe355526787f6ca5c.png	14.4969999999999999	14	2016-02-02 01:05:18.070731-08	2016-02-18 06:34:28.447981-08
23	./32c43cfd4bea343bcc1b2c24be02079dba2656a71ad5ebc7261a3308.png	15.9730000000000008	14	2016-02-02 01:05:19.394882-08	2016-02-18 06:34:28.447981-08
24	./4c6a426c869b38e169ad00f14343abb653062388679cb84d8fec4f85.png	52.0579999999999998	14	2016-02-02 14:35:48.287837-08	2016-02-18 06:34:28.447981-08
25	./37f6e3349916cd2d33b66bd2b313dca6a169fece8ed4beace161e36e.png	70.7309999999999945	14	2016-02-02 14:36:07.050122-08	2016-02-18 06:34:28.447981-08
26	./c27d6a7897ef1635cb6fa95a546301ac9ae823e1bea8f2661c54caae.png	90.9920000000000044	14	2016-02-02 14:36:27.301439-08	2016-02-18 06:34:28.447981-08
27	./d5edddf598c581d35983543ba9fa6e040ba38325f5232c7531b08c3b.png	56.6370000000000005	14	2016-02-02 19:11:36.790294-08	2016-02-18 06:34:28.447981-08
28	./23dd09625b5c13acfae0d5ef74b6cb60c30cbfc46fbc2316b210b867.png	82.8769999999999953	15	2016-02-02 19:13:05.542025-08	2016-02-18 06:34:28.447981-08
29	./cf507f1df011fe9b2563dad9de87bfe298672ae407e2e3fc4ec59928.png	129.369	15	2016-02-02 19:13:52.277157-08	2016-02-18 06:34:28.447981-08
30	./5fd3ee31789830bdf075a7c2fe86fd6ce8ab8e5a3135b0198e2989e9.png	132.407000000000011	15	2016-02-02 19:13:55.123357-08	2016-02-18 06:34:28.447981-08
31	./d13a0e43e3514bb08092dd982500b6ad88c116aea23ed57b234966db.png	10.1669999999999998	12	2016-02-02 19:43:46.877535-08	2016-02-18 06:34:28.447981-08
46	./a53d2c1a96a63bca715d9a6c76784ce5b0bf1132d00d597767544ade.png	38.7890000000000015	17	2016-02-04 00:19:41.305824-08	2016-02-18 06:34:28.447981-08
47	./adba4107e6649f0071bc628d9ba16aa9ce27647637559b766a71d52b.png	46.588000000000001	17	2016-02-04 00:19:48.91899-08	2016-02-18 06:34:28.447981-08
36	./56ecd84445998f041ed56456589f98ce3385e64d17c9a1fdc5daeee9.png	46.9470000000000027	15	2016-02-03 23:20:37.874775-08	2016-02-18 06:34:28.447981-08
48	./38baa787b89c5e212f4086bcf49b7fda946d028f53875080209aa2be.png	54.8689999999999998	17	2016-02-04 00:19:57.170569-08	2016-02-18 06:34:28.447981-08
49	./a382994e2b7d3fbd75ac28307dace144370cfecb9de6069ff0a3787d.png	64.3190000000000026	17	2016-02-04 00:20:06.344033-08	2016-02-18 06:34:28.447981-08
42	./72e16451f6c5fa040e33b3eca0b7af2dec0a6fd3727910c906282a2f.png	17.3640000000000008	17	2016-02-04 00:19:19.547904-08	2016-02-18 06:34:28.447981-08
43	./800e5190edf2567b777b0519e3b889c26df434bb346d7f2ec003896f.png	21.6260000000000012	17	2016-02-04 00:19:23.73775-08	2016-02-18 06:34:28.447981-08
44	./e2e1504d9d21725c49d35d3abbcb67f9e999d45a197460cc18b5adef.png	26.3859999999999992	17	2016-02-04 00:19:28.424514-08	2016-02-18 06:34:28.447981-08
45	./a622ff97f68234b2c0fa453312a32aea7e39b2ea92e40e00c801edf6.png	30.5249999999999986	17	2016-02-04 00:19:32.645332-08	2016-02-18 06:34:28.447981-08
65	./d4a9d053f647aa694aa175899485c85cd056bb69607dc885f6a8fc1c.png	11.0009999999999994	26	2016-03-11 21:37:28.199992-08	2016-03-11 21:37:28.456733-08
66	./ed32f55845fb8fa0d8dbb450fb631d158717b5404f628f420b4bd8d8.png	4	26	2016-03-11 21:40:50.654836-08	2016-03-11 21:40:50.793041-08
54	./760d1b71007d6af4d933ac93687a772bffd0d54e5e3bfcbe0c9b7adb.png	0	14	2016-03-06 17:00:14.463819-08	2016-03-06 17:00:14.779789-08
55	./392a353732a8f32724027f1ae36739ec4dfb1f435eee5eb03a01fb79.png	4.01400000000000023	14	2016-03-06 19:24:29.6019-08	2016-03-06 19:24:29.836049-08
56	./a11bc7f6b7a3a65948ffd2d59d29fb5e036933fe5d31854c5e27f259.png	12.0020000000000007	12	2016-03-06 19:29:21.366168-08	2016-03-06 19:29:21.580142-08
57	./6eebbbcb172fe83d9c279a002ec60a08a93a22cee8a4c111a6caa9fd.png	11.0009999999999994	12	2016-03-06 19:30:00.850774-08	2016-03-06 19:30:01.023757-08
67	./b8ad3bf37155e524a59f8c92bff274112c476ea50ae30a1f54461162.png	2	27	2016-03-12 02:39:34.751393-08	2016-03-12 02:39:35.489276-08
68	./fbda4f83dd3e816ed3a537fa7099a42e49ec44826b5aee146baac182.png	29.0010000000000012	28	2016-03-12 04:55:05.64803-08	2016-03-12 04:55:05.92639-08
69	./50c84f6a867921efa961a0c4e3cf77f680f5de03ac395bf564b11fbf.png	7.00100000000000033	29	2016-03-12 05:10:11.182432-08	2016-03-12 05:10:11.347712-08
64	./733113529144eb60117e5bfc58a69ec8021d281ce30eb4b7fbcd2655.png	9.00099999999999945	12	2016-03-08 02:11:57.185799-08	2016-03-08 02:11:57.400074-08
\.


--
-- Name: game_gameinstancesnapshot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('game_gameinstancesnapshot_id_seq', 69, true);


--
-- Data for Name: game_jslibrary; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY game_jslibrary (id, name, "scriptPath") FROM stdin;
1	three.js	/static/site/js/lib/three.js
\.


--
-- Name: game_jslibrary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('game_jslibrary_id_seq', 1, true);


--
-- Name: game_plerpingapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('game_plerpingapp_id_seq', 25, true);


--
-- Data for Name: game_zeroplayergame; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY game_zeroplayergame (id, title, description, created, category_id, owner_id, "scriptType", source, "seedStructure", "mainImage", parent_id, updated) FROM stdin;
5	Function in 1 variable with time parameter	Sets of graphs of a function in 1 variable with time as a parameter.  (Technically a function in 2 variables)	2016-02-02 19:11:30.899129-08	2	1	text/paperscript	/*\n    *\n    *   @author: nino p cocchiarella\n    *   (c) 2016\n    *\n*/\n\nview.viewSize = new Size(Canvas.width, Canvas.height);\n\n// define formal mathematical function in 1 var\nMFunction = function(func, extrema) {\n   \n    this.func = func;\n    if (!extrema) { extrema = [-5,5]; }\n\n    this.domain = {\n        elements: [],\n        min: (extrema[0] || -5),\n        max: (extrema[1] || 5)\n    };\n\n    this.codomain = {\n        elements: [],\n        min: null,\n        max: null\n    };\n\n    this.mapping = null;\n    this.compute();\n}\n\nMFunction.prototype = {\n    \n    compute: function(delta) {\n        if (!delta) { delta = 100; }\n\n        eval("_func = function(x) { return "+this.func+"; };");\n\n        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);\n        this.codomain.elements = _.map(this.domain.elements, _func);\n        this.codomain.min = _.min(this.codomain.elements);\n        this.codomain.max = _.max(this.codomain.elements);\n        this.mapping = _.zip(this.domain.elements, this.codomain.elements);\n    },\n\n    draw: function(path, matrix_premult) {\n        if (this.mapping == null) { this.compute(); }\n        \n        _w = Math.abs(this.domain.max - this.domain.min);\n        _h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );\n    \n\n        points = this.mapping;\n\n        if (matrix_premult) {\n            points = _.map(points, function(p) {\n                return numeric.dot(matrix_premult, p);\n            })\n        }\n\n        _.each(points, function(p) {\n            path.add(new Point(p));\n        });\n        \n        T = new Matrix(\n            (view.size.width / _w), 0,\n            0, (view.size.height / (-1*_h)), \n            view.center.x, view.center.y);\n\n        project.activeLayer.transform(T); \n    }\n}\n\n\nfunc = new MFunction(funct, [xMin,xMax]);\n\n// draw Cartesian axes\ndrawAxes = function(xmax, ymax) {\n\n    if (xmax == undefined) xmax = 10;\n    if (ymax == undefined) ymax = 10;\n\n    DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);\n    LIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);\n\n    x_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });\n    x_axis.add(new Point(-view.size.width/2, 0));\n    x_axis.add(new Point(view.size.width/2, 0));\n\n    y_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });\n    y_axis.add(new Point(0, -view.size.height/2));\n    y_axis.add(new Point(0, view.size.height/2));\n\n    _.each(_.range(-1*xmax,xmax), function(n) {\n        var line = new Path({strokeColor: LIGHT_GREY });\n        line.add( new Point(n, view.size.height/2) );\n        line.add( new Point(n, -view.size.height/2) );\n        line.closed = true;\n    });\n\n\n    _.each(_.range(-1*ymax,ymax), function(n) {\n        var line = new Path({strokeColor: LIGHT_GREY });\n        line.add( new Point(view.size.width/2, n) );\n        line.add( new Point(-view.size.width/2, n) );\n        line.closed = true;\n    });\n\n\n    project.activeLayer.transform( new Matrix((view.size.width / xmax),0,0,(view.size.height / (-1*ymax)), view.center.x, view.center.y) );\n\n}\n//executeRemotePaperscript("/static/site/js/app/graph-util.js");\ndrawAxes();\n\n////////////////////////\n\nINITCOLOR = _.map(_.range(3), Math.random)\nN = 15;\n\n\ngraphs = [];\n\n_.map(_.range(N), function(n) {\n\n    layer = new Layer({\n        backgroundColor: new Color(1,1,1,0)\n    });\n\n    thickness = (n == 0 ? 3 : 1)\n    alpha = 0.5 - (n/(N*2))\n\n    var graph = new Path({\n        strokeColor: new Color(  INITCOLOR.concat([alpha]) ),\n        strokeWidth: thickness\n    });\n\n    matrix = [[1,0],[0,(1-(n/N))]]\n    func.draw(graph, matrix);\n    graph.smooth();\n    graphs.push(graph);\n\n });\n\n\n\n\n////////////\n\n\nfunction onResize(event) {\n\n}\n\nview.onFrame = function(event) {\n    scale = 1 + (Math.sin(event.time)/ breathDelta)\n    _.each(graphs, function(g) {\n        g.scale(1, scale);\n    });\n}\n\nwindow.onDestroy = function() {\n\tproject.layers.forEach(function(lay) {\n\t\tlay.remove();\n\t}); \n}	{\n    "breathDelta": {"default":17, "min":1.1, "max":1000},\n    "funct": {"default": "x*Math.cos(x)"},\n    "xMin": {"default": -5},\n    "xMax": {"default": 5}\n}		\N	2016-03-11 20:03:55.707658-08
24	2-dimensional Maze Generator and Solver	Uses DFS algorithm to create a unique maze each instance of running. Arrow keys let user navigate through and try to solve the maze. Automatic solving -- solution button presents the one and only one correct path.	2016-03-11 21:34:40.222228-08	1	1	text/javascript	/*\n\nMaze Generator pseudo-code\n\n1. Make the initial cell the current cell and mark it as visited\n2. While there are unvisited cells\n    1. If the current cell has any neighbors which have not been visited\n        1. Choose randomly one of the unvisited neighbors\n        2. Push the chosen cell to the stack\n        3. Remove the wall between the current cell and the chosen cell\n        4. Make the chosen cell the current cell and mark it as visited\n    2. Otherwise\n        1. Pop a cell from the stack\n        2. Make it the current cell\n*/\n\n// class Maze {\n\nfunction Maze(dimension, x, y, cellSize) {\n    this.x = x;\n    this.y = y;\n    this.map = [];\n    this.visited = [];\n    this.stack = [];\n    this.cellSize = cellSize;\n    this.begin = [];\n    this.turnArounds = [];\n    this.currentPosition = [0, 0];\n    this.ballRadius = this.cellSize * 0.4;\n    this.linesDrawn = [];\n\n    for (var i=0; i<y; i++) {\n        this.map.push( [] );\n        this.visited.push( [] );\n        for (var j=0; j<x; j++) {\n            this.map[i].push( [1,1,1,1] );\n            this.visited[i].push( false );\n        }\n    }\n\n    this.generateMap();\n}\n\nMaze.prototype.unvisitedCellsExist = function() {\n    for (var i=0; i<this.y; i++) {\n        for (var j=0; j<this.x; j++) {\n            if (this.visited[i][j]) return true;\n        }\n    }\n    return false;\n};\n\nMaze.prototype.chooseNeighbor = function(cx,cy) {\n    var neighbors = [];\n    var directions = [];\n    if (cx > 0 && !this.visited[cy][cx-1]) \n        { neighbors.push( [cx-1, cy] ); directions.push('W'); }\n    if (cx < this.x-1 && !this.visited[cy][cx+1]) \n        { neighbors.push( [cx+1, cy] ); directions.push('E'); }\n    if (cy < this.y-1 && !this.visited[cy+1][cx]) \n        { neighbors.push( [cx, cy+1] ); directions.push('S'); }\n    if (cy > 0 && !this.visited[cy-1][cx]) \n        { neighbors.push( [cx, cy-1] ); directions.push('N'); }\n    if (neighbors.length) {\n        r = Math.floor(Math.random()*neighbors.length);\n        return [ neighbors[r], directions[r] ];\n    } else return false;\n};\n\nMaze.prototype.removeWall = function(x1, y1, direction) { \n    switch (direction) {\n        case 'N':\n            this.map[y1][x1][0] = 0;\n            this.map[y1-1][x1][2] = 0;\n        break;\n        case 'E':\n            this.map[y1][x1][1] = 0;\n            this.map[y1][x1+1][3] = 0;\n        break;\n        case 'S':\n            this.map[y1][x1][2] = 0;\n            this.map[y1+1][x1][0] = 0;\n        break;\n        case 'W':\n            this.map[y1][x1][3] = 0;\n            this.map[y1][x1-1][1] = 0;\n        break;\n    }\n};\n\nMaze.prototype.generateMap = function() {\n    \n    // choose initial cell\n    var rx = Math.floor(Math.random()*this.x);\n    var ry = Math.floor(Math.random()*this.y);\n\n    this.begin = [rx, ry];\n\n    var cx = rx;\n    var cy = ry;\n    var nx;\n    var ny;\n\n    this.visited[cy][cx] = true;\n\n    var next;\n    var nextDirection;\n\n    // while there are still unvisited cells\n    while (this.unvisitedCellsExist()) {\n        if (this.chooseNeighbor(cx,cy)) {\n            \n            next = this.chooseNeighbor(cx,cy);\n            \n            nx = next[0][0];\n            ny = next[0][1];\n            \n            nextDirection = next[1];\n            this.stack.push( [nx, ny] );\n            this.removeWall(cx, cy, nextDirection);\n            this.visited[ny][nx] = true;\n\n            cx = nx;\n            cy = ny;\n        \n        } else if (this.stack.length) {\n\n            next = this.stack.pop();\n            cx = next[0];\n            cy = next[1];\n            this.turnArounds.push([cx, cy]);\n          \n        } else break;\n    }\n\n    this.end = [cx, cy];\n    this.map[0][0][3] = 0;\n    this.map[this.y-1][this.x-1][1] = 0;\n\n};\n\nMaze.prototype.getClearRect = function(cx, cy) {\n    var fx = cx * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;\n    var fy = cy * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;\n    return [fx,fy];\n};\n\nMaze.prototype.getBallCoords = function(nx, ny) {\n    var bx = nx * this.cellSize + (this.cellSize/2);\n    var by = ny * this.cellSize + (this.cellSize/2);\n    return [bx,by];\n};\n\nMaze.prototype.clearBall = function() {\n    var cl = this.getClearRect(this.currentPosition[0], this.currentPosition[1]);\n    ctx.clearRect(cl[0], cl[1], this.ballRadius*2+2, this.ballRadius*2+2);\n};\n\nMaze.prototype.drawBall = function() {\n    var ballCoords = this.getBallCoords(this.currentPosition[0], this.currentPosition[1]);\n    ctx.beginPath();\n    ctx.arc(ballCoords[0], ballCoords[1], this.ballRadius, 0, 2*Math.PI, false);\n    ctx.fillStyle = 'green';\n    ctx.fill();\n    ctx.lineWidth = 1;\n    ctx.strokeStyle = '#003300';\n    ctx.stroke();\n};\n\nMaze.prototype.move = function(d) {\n    var dx = d[0];\n    var dy = d[1];\n    this.clearBall();\n    this.currentPosition = [this.currentPosition[0]+dx, this.currentPosition[1]+dy];\n    this.drawBall();\n};\n\nMaze.prototype.lineIsDrawn = function(mt, lt) {\n    for (var i=0; i<this.linesDrawn.length; i++) {\n        if (this.linesDrawn[i][0][0] == mt[0] &&\n            this.linesDrawn[i][0][1] == mt[1] &&\n            this.linesDrawn[i][1][0] == lt[0] &&\n            this.linesDrawn[i][1][1] == lt[1]) {\n\n            return true;\n        }\n    }\n    return false;\n};\n\nMaze.prototype.render = function(ctx) {\n    \n    var cell;\n    var cx;\n    var cy;\n\n    ctx.moveTo(0,0);\n    ctx.lineWidth = 1;\n    ctx.strokeStyle = '#666666';\n    \n    for (var i=0; i<this.y; i++) {\n        for (var j=0; j<this.x; j++) {\n            \n            ctx.beginPath();\n            cell = this.map[i][j];\n            cx = this.cellSize * j;\n            cy = this.cellSize * i;\n            var mt;\n            var lt;\n\n            if (cell[0]) {\n                mt = [cx, cy];\n                lt = [cx+this.cellSize, cy];\n                if (!this.lineIsDrawn(mt, lt)) {\n                    this.linesDrawn.push([mt, lt]);\n                    ctx.moveTo(mt[0], mt[1]);\n                    ctx.lineTo(lt[0], lt[1]);\n                    ctx.stroke();\n                }\n            } \n            if (cell[1]) {\n                mt = [cx+this.cellSize, cy];\n                lt = [cx+this.cellSize, cy+this.cellSize];\n                if (!this.lineIsDrawn(mt, lt)) {\n                    this.linesDrawn.push([mt, lt]);\n                    ctx.moveTo(mt[0], mt[1]);\n                    ctx.lineTo(lt[0], lt[1]);\n                    ctx.stroke();\n                }\n            } \n            if (cell[2]) {\n                mt = [cx+this.cellSize, cy+this.cellSize];\n                lt = [cx, cy+this.cellSize];\n                if (!this.lineIsDrawn(mt, lt)) {\n                    this.linesDrawn.push([mt, lt]);\n                    ctx.moveTo(mt[0], mt[1]);\n                    ctx.lineTo(lt[0], lt[1]);\n                    ctx.stroke();\n                }\n            }\n            if (cell[3]) {\n                mt = [cx, cy+this.cellSize];\n                lt = [cx, cy];\n                if (!this.lineIsDrawn(mt, lt)) {\n                    this.linesDrawn.push([mt, lt]);\n                    ctx.moveTo(mt[0], mt[1]);\n                    ctx.lineTo(lt[0], lt[1]);\n                    ctx.stroke();\n                }\n            }\n\n        }\n    }\n\n    this.move([0,0]);\n\n};\n\n// } end class Maze\n\n/*\n    MazeSolver pseudo-code\n\n    1. start at the entrance\n    2. while not at the exit\n        1. push the current cell to visited\n        2. if exists one or more directions that have not been visited\n            1. push the current cell to pathStack\n            2. choose any direction from those not visited\n            3. move in that direction\n            4. draw path from previous cell to chosen cell\n            5. make the chosen cell the current cell\n        3. otherwise backtrack\n            1. pop the pathStack\n            2. remove line from currentCell to popped cell\n            3. do not remove popped cell from visited\n*/\n\n// class MazeSolver {\n\nfunction MazeSolver(maze) {\n    this.Maze = maze;\n    this.position = [0, 0];\n    this.pathStack = [];\n    this.visited = [];\n    this.Maze.clearBall();\n\n    var self = this;\n    this.solveStep = function() {\n        self.moveForward();\n    };\n}\n\nMazeSolver.prototype.getValidDirections = function(x,y) {\n    \n    var directions = [];\n    \n    if (!this.Maze.map[y][x][0]) \n        directions.push([0,-1]);\n    if (!this.Maze.map[y][x][1] && (x!=this.Maze.x-1 || y!=this.Maze.y-1)) \n        directions.push([1,0]);\n    if (!this.Maze.map[y][x][2]) \n        directions.push([0,1]);\n    if (!this.Maze.map[y][x][3] && (x||y)) \n        directions.push([-1,0]);\n\n    var validDirections = [];\n    for (var i=0; i<directions.length; i++) {\n        var tx = x+directions[i][0];\n        var ty = y+directions[i][1];\n        if (!this.isVisited(tx,ty)) {\n            validDirections.push(directions[i]);\n        }\n    }\n\n    return validDirections;\n};\n\nMazeSolver.prototype.isVisited = function(x,y) {\n    for (var i=0; i<this.visited.length; i++) {\n        if (this.visited[i][0] == x && this.visited[i][1] == y) \n            return true;\n    }\n    return false;\n};\n\nMazeSolver.prototype.isDeadEnd = function(x,y) {\n    if (!this.getValidDirections(x,y).length)\n        return true;\n    return false;\n};\n\nMazeSolver.prototype.movePath = function(cx,cy,nx,ny) {\n    ctx.lineWidth = 4;\n    ctx.strokeStyle = solutionPathColor;\n    ctx.beginPath();\n\n    ctx.moveTo(cx*this.Maze.cellSize+this.Maze.cellSize/2, \n        cy*this.Maze.cellSize+this.Maze.cellSize/2);\n    ctx.lineTo(nx*this.Maze.cellSize+this.Maze.cellSize/2, \n        ny*this.Maze.cellSize+this.Maze.cellSize/2);\n    ctx.stroke();\n};\n\nMazeSolver.prototype.clearPath = function(x,y) {\n    ctx.clearRect(x*this.Maze.cellSize+2, y*this.Maze.cellSize+2, \n        this.Maze.cellSize-4, this.Maze.cellSize-4);\n};\n\nMazeSolver.prototype.isFinished = function() {\n    if (this.position[0] == this.Maze.x-1 && this.position[1] == this.Maze.y-1)\n        return true;\n    return false;\n};\n\nMazeSolver.prototype.moveForward = function() {\n    \n    var cx = this.position[0];\n    var cy = this.position[1];\n    \n    this.visited.push([cx,cy]);\n    \n    if (this.isFinished()) {\n        console.log("FINISH");\n        clearInterval(this.interval);\n        return;\n    }\n\n    if (!this.isDeadEnd(cx,cy)) {\n        this.pathStack.push([cx,cy]);\n        var directions = this.getValidDirections(cx,cy);\n        var randomDirection = Math.floor(Math.random()*directions.length);\n        \n        var nx = cx + directions[randomDirection][0];\n        var ny = cy + directions[randomDirection][1];\n\n        this.movePath(cx,cy,nx,ny);\n        this.position = [nx,ny];\n\n    } else { \n        this.backtrack();\n    }\n};\n\nMazeSolver.prototype.backtrack = function() {\n    var lastCell = this.pathStack.pop();\n    this.clearPath(this.position[0], this.position[1]);\n    this.position = [lastCell[0], lastCell[1]];\n};\n\n// } end class MazeSolver\n\n\n\n\nfunction solveMaze() {\n    solver = new MazeSolver(Maze);\n    solver.interval = setInterval(solver.solveStep, 5);\n}\n\nvar Maze;\nvar ctx = Canvas.getContext("2d");\nvar solver;\n\nctx.fillStyle = '#ffffff'\nctx.fillRect(0,0,Canvas.width, Canvas.height)\n\n\n\nvar mx = Math.floor((Canvas.width) / cellSize);\nvar my = Math.floor((Canvas.height) / cellSize);\n\nconsole.log([Canvas.height, $(window).height(), mx, my]);\n\nMaze = new Maze(2, mx, my, cellSize);\nMaze.render(ctx);\n\n$(window).keydown(function(e) {\n            \n    var tx = Maze.currentPosition[0];\n    var ty = Maze.currentPosition[1];\n\n    switch (e.keyCode) {\n\n        case 37: // left\n            if (!Maze.map[ty][tx][3]) Maze.move([-1,0]);\n        break;\n        case 38: // up\n            if (!Maze.map[ty][tx][0]) Maze.move([0,-1]);\n        break;\n        case 39: // right\n            if (!Maze.map[ty][tx][1]) Maze.move([1,0]);\n        break;\n        case 40: // down\n            if (!Maze.map[ty][tx][2]) Maze.move([0,1]);\n        break;\n        case 83: // 's' key\n            solver = new MazeSolver(Maze);\n            solver.interval = setInterval(solver.solveStep, 5);\n        break;\n\n    }\n});	{\n    "cellSize": {"min": 5, "max": 150, "default": 30},\n    "solutionPathColor": {"default": "rgba(0,0,200,0.8)"}\n}	\N	\N	2016-03-12 03:22:11.854548-08
25	Neenbox	just some stooopid boxes	2016-03-12 05:09:56.958477-08	2	1	text/javascript	var ctx = Canvas.getContext('2d')\nctx.fillStyle = '#cccc00';\nctx.fillRect(10, 20, 400, 400);	{"param1":{"default":""}}	\N	\N	2016-03-12 05:09:56.958528-08
4	Multivariate Polynomial Landscape	Choose coefficients of high-degree a polynomial function in 2 variables, as well as the 3x3 matrix used to project the graph of the surface onto a 2-dimensional canvas.  Many intricate and beautiful scenes emerge with certain affine transformations.  Defaults to a "standard" parallel projection of the z-axis (the axis "coming out of the screen")	2016-02-02 21:50:13.820034-08	2	1	text/paperscript	DARK_GREY = new Color(0.3, 0.3, 0.3, 0.8);\nLIGHT_GREY = new Color(0.9, 0.9, 0.9, 0.2);\nconsole.log(paper.Matrix)\nview.viewSize = new Size(Canvas.width, Canvas.height);\n\nx_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });\nx_axis.add(new Point(-view.size.width/2, 0));\nx_axis.add(new Point(view.size.width/2, 0));\nx_axis.closed = true;\n//project.activeLayer.insertChild(0,x_axis)\n\ny_axis = new Path({ strokeColor: DARK_GREY, strokeWidth: 0.3, strokeScaling: false });\ny_axis.add(new Point(0, -view.size.height/2));\ny_axis.add(new Point(0, view.size.height/2));\n\nx_lines = [];\n_.each(_.range(-10,10), function(n) {\n    line = new Path({strokeColor: LIGHT_GREY });\n    line.add( new Point(n, view.size.height/2) );\n    line.add( new Point(n, -view.size.height/2) );\n    line.closed = true;\n    //project.activeLayer.insertChild(0, line);\n    x_lines.push( line );\n});\n\ny_lines = [];\n_.each(_.range(-10,10), function(n) {\n    line = new Path({strokeColor: LIGHT_GREY });\n    line.add( new Point(view.size.width/2, n) );\n    line.add( new Point(-view.size.width/2, n) );\n    line.closed = true;\n    //project.activeLayer.insertChild(0, line);\n    y_lines.push( line );\n});\n\nfunction transformToCartesian(lay) {\n    lay.transform( new Matrix((view.size.width / 10),0,0,(view.size.height / -10), view.center.x, view.center.y) );\n}\n\ntransformToCartesian(project.activeLayer);\n\n\n// define formal mathematical function\nFunction = function(func, extrema) {\n    //console.log(func.length);\n    this.func = func;\n    if (!extrema) { extrema = [-5,5]; }\n\n    this.domain = {\n        elements: [],\n        min: (extrema[0] || -5),\n        max: (extrema[1] || 5)\n    };\n\n    this.codomain = {\n        elements: [],\n        min: null,\n        max: null\n    };\n\n    this.mapping = null;\n}\n\nFunction.prototype = {\n    \n    compute: function(delta) {\n        if (!delta) { delta = 50; }\n        this.domain.elements = numeric.linspace(this.domain.min, this.domain.max, delta);\n        this.codomain.elements = _.map(this.domain.elements, this.func);\n        this.codomain.min = _.min(this.codomain.elements);\n        this.codomain.max = _.max(this.codomain.elements);\n        this.mapping = _.zip(this.domain.elements, this.codomain.elements);\n\n        this._w = Math.abs(this.domain.max - this.domain.min);\n        this._h = _.max(  [Math.abs(this.codomain.max),  Math.abs(this.codomain.min)]  );\n\n        this.transformation_matrix = new Matrix(\n            (view.size.width / this._w), 0,\n            0, (view.size.height / (-1*this._h)), \n            view.center.x, view.center.y);\n\n        this.computed = true;\n        console.log("computed")\n    },\n\n    // "flattens" mapping\n    // i.e. [[1,2],3] -> [1,2,3]\n    getPoints: function() {\n        if (!this.computed) { this.compute(); }\n        this.points = _.map(this.mapping, function(pair) {\n            return _.flatten(pair);\n        });\n        return this.points;\n    },\n\n\n    draw: function(path, matrix_premult, map3d, tmatrix) {\n\n        if (!this.computed) { this.compute(); }\n\n        if (map3d) {\n            this.points = this.points3d;\n        } else {\n            this.points = this.getPoints();\n        }\n\n        if (matrix_premult) {\n            this.points = _.map(this.points, function(p) {\n                return numeric.dot(matrix_premult, p);\n            })\n        }\n\n        _.each(this.points, function(p) {\n            path.add(new Point(p));\n        })\n\n        path.add(new Point(this.domain.max*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));\n        path.add(new Point(this.domain.min*2, Math.abs(this.codomain.min)*-5 + Math.abs(this.codomain.max)*-5));\n        path.closed = true;\n\n        //path.transform(this.transformation_matrix);\n\n        //path.smooth();\n        \n        if (tmatrix) {\n            path.transform(tmatrix);\n        } else {\n            path.transform(this.transformation_matrix);\n        } \n    }\n}\n\n\nfunction CartesianProduct(A,B) {\n    prod = [];\n    _.each(A, function(a) {\n        _.each(B, function(b) {\n            prod.push([a,b]);\n        });\n    });\n    return prod;\n}\n\nBivariatePolynomialFunction = function(degree, vars, coeffs, roots) {\n\n\n    if (roots) {\n        // each set of roots must be <= degree in order\n        factorsSym = [];\n        _.each(roots[0], function(root) {\n            factorsSym.push("("+vars[0]+"-"+root.toString()+")")\n        });\n        _.each(roots[1], function(root) {\n            factorsSym.push("("+vars[1]+"-"+root.toString()+")")\n        });\n        latex = _.reduce(factorsSym, function(j,k) { return j.toString() + k.toString(); });\n\n        f = function(x,z) {\n            factors = [];\n            _.each(roots[0], function(root) {\n                factors.push( (x-root) );\n            });\n            _.each(roots[1], function(root) {\n                factors.push( (z-root) );\n            });\n            return _.reduce(factors, function(j,k) { return j*k; });\n        }\n        f.latex = "f("+vars[0]+", "+vars[1]+")=" +latex.split('--').join('+');\n        return f;\n\n    } else {\n\n        // num coeffs should be 1 less than degree-th triangular number\n        term_exps = _.filter(CartesianProduct(_.range(degree+1), _.range(degree+1)),\n            function(x) {\n                return (x[0] + x[1]) <= degree && (x[0] + x[1]) != 0;\n            });\n        \n        if (!coeffs) {\n            coeffs = _.map(_.range(term_exps.length), function(i) {\n                rand = (Math.random() * degree) - (degree/2);\n                if (Math.random() > .4) return 0;\n                return Math.round(rand*3);\n            });\n        }  \n        \n        terms_sym = _.map(term_exps, function(term, i) {\n            if (coeffs[i] == 0) return "";\n            if (coeffs[i] == 1) {\n                coeff = "";\n            } else if (coeffs[i] == -1) {\n                coeff = "-"\n            } else coeff = coeffs[i].toString();\n            return coeff + " "\n                + vars[0]+"^"+term[0].toString() + " "\n                + vars[1]+"^"+term[1].toString();\n        });\n        terms_sym = _.filter(terms_sym, function(x) { return x != ""; })\n        //console.log(terms_sym.join(" + "));\n\n        f = function(x,z) {\n            terms = _.map(term_exps, function(term, i) {\n                return coeffs[i] * Math.pow(x, term[0]) * Math.pow(z, term[1]);\n                });\n            return _.reduce(terms, function(j,k) { return j+k; });\n        }\n        f.latex = terms_sym.join("+").split("+-").join("-").split("+").join(" + ");\n        f.latex = f.latex.split("^1").join("");\n        f.latex = "f("+vars[0]+", "+vars[1]+")=" + f.latex.split(/[a-z]\\^0/).join("");\n        return f;\n    }\n\n}\n\n\n\n// choose a polynomial\n//Polynomial = new BivariatePolynomialFunction(3, ['x','y'], [1,-1,0,0,0,0,-2,3,1]);\nPolynomial = new BivariatePolynomialFunction(5, ['x','y']);//, null, [[2,3,0,-7,0],[1,-2, -4, -13]]);\n\n\nslices = [];\nzrange = [-15,0];\nxrange = [-9, 9];\nzspace = numeric.linspace(zrange[0], zrange[1], 50);\n\nF0 = function(x) { return Polynomial(x,0); }\nslice0 = new Function(F0, [xrange[0],xrange[1]]);\nslice0.compute();\nglobal_matrix = slice0.transformation_matrix;\n\nCartesianMatrix = new Matrix(1,0,0,-1, view.center.x, view.center.y);\n\n// begin drawing process\nGraphLayer = new Layer({\n     blendMode: "multiply",\n});\n//GraphLayer.globalMatrix = CartesianMatrix;\n//GraphLayer.transform(CartesianMatrix);\n\nconsole.log("global matrix"); console.log(global_matrix);\n\nfunction_shown = false;\nzindex=0\n\nview.onFrame = function(event) {\n    \n    if (zindex < zspace.length) {\n        \n        //prevLayer = project.activeLayer;\n        l = new Layer({\n            //blendMode: "multiply"\n        });\n\n        z = zspace[zindex];\n        //console.log(z)\n    \n\n        F = function(x) { return Polynomial(x,z); }\n        slice = new Function(F, [xrange[0],xrange[1]]);\n\n        points3d = slice.getPoints();\n        _.each(_.range(points3d.length), function(i) { points3d[i].push(z); });\n\n        slice.points3d = points3d\n\n        transformation = [\n            [1, 0, 0], //5*Math.cos(Math.PI/-4)],\n            [0, 1, 0] //5*Math.sin(Math.PI/-4)],\n        ];\n\n        path1 = new Path({\n            strokeColor: new Color(0.3, 0.3, 0.3, 0.5),\n            strokeWidth: 1,\n            closed: true,\n            fillColor: new Color(Math.random(),1,Math.random(),0.2),\n        });\n\n        slice.draw(path1, transformation, true, global_matrix);\n        //path.transform(CartesianMatrix)\n\n        // transformation2 = new Matrix(\n        //     1-(z/50), 0, 0, 1-(z/50), 0, 0 //5*Math.sin(Math.PI/-4)],\n        // );\n\n        transformation2 = new Matrix(\n            1, 0, 0, 1, 0, 0 //5*Math.sin(Math.PI/-4)],\n        );\n\n        //path1.transform(transformation2);\n        path1.scale(1-(z/50), 1-(z/50), view.center)\n        path1.translate(new Point(-10*z, 30*z))\n        \n        project.activeLayer.insertChild(0,path1);\n\n        slices.push({layer: project.activeLayer,\n            func: slice,\n            transformation: transformation,\n            path: path1});\n\n        //console.log(path.position)\n        \n        if (zindex == zspace.length-1) { \n            //console.log(slices);\n            //view.pause();\n        }\n        zindex++;\n\n        if (!function_shown) {\n            if (display = document.getElementById("function-katex")) {\n                //katex.render(Polynomial.latex, display);\n                tokens = Polynomial.latex.split(" ");\n                line_length = Math.ceil(tokens.length/2);\n                line2 = tokens.splice(-1*line_length).join(" ");\n                line1 = tokens.join(" ");\n                $("#function-katex").text(\n                    "$$" + line1 + "$$\\n$$\\\\space \\\\space \\\\space \\\\space " + line2 + "$$ \\n"\n                     + "$$\\\\left(\\\\begin{array}{rrr}\\n1 & 0 & \\\\frac{1}{2} \\\\, \\\\sqrt{2} \\\\\\\\\\n0 & 1 & \\\\frac{1}{2} \\\\, \\\\sqrt{2}\\\\\\\\\\n \\\\end{array}\\\\right)$$");\n                function_shown = true;\n            }\n        }\n    }\n    \n}\n\n\n\n////////////\n\n\nfunction onResize(event) {\n\n}	{\n  "x1": {"default": 5}\n}		\N	2016-03-06 14:23:06.253224-08
2	3-dimensional "Wolfenstein" Maze Generator	Generates a unique random 3-dimensional maze each instance. Allows user to navigate through maze with old-fashioned "Wolfenstein"-style interface. Collision detection built in.	2016-02-04 00:16:14.056506-08	1	1	text/javascript	/*\r\n\r\n        Maze Generator pseudo-code\r\n\r\n        1. Make the initial cell the current cell and mark it as visited\r\n        2. While there are unvisited cells\r\n            1. If the current cell has any neighbors which have not been visited\r\n                1. Choose randomly one of the unvisited neighbors\r\n                2. Push the chosen cell to the stack\r\n                3. Remove the wall between the current cell and the chosen cell\r\n                4. Make the chosen cell the current cell and mark it as visited\r\n            2. Otherwise\r\n                1. Pop a cell from the stack\r\n                2. Make it the current cell\r\n        */\r\n\r\n        // class Maze {\r\n\r\n        function Maze(dimension, x, y, cellSize) {\r\n            this.x = x;\r\n            this.y = y;\r\n            this.map = [];\r\n            this.visited = [];\r\n            this.stack = [];\r\n            this.cellSize = cellSize;\r\n            this.begin = [];\r\n            this.turnArounds = [];\r\n            this.currentPosition = [0, 0];\r\n            this.ballRadius = this.cellSize * 0.4;\r\n            this.wallsRendered = [];\r\n            this.grass;\r\n            this.sky;\r\n            this.collisionPadding = 20;\r\n            this.playerCurrentCell = [0, 0];\r\n            this.atWall = false;\r\n            this.directionUnlocked = 0;\r\n            this.approachQuadrant = 0;\r\n\r\n            for (var i=0; i<y; i++) {\r\n                this.map.push( [] );\r\n                this.visited.push( [] );\r\n                for (var j=0; j<x; j++) {\r\n                    this.map[i].push( [1,1,1,1] );\r\n                    this.visited[i].push( false );\r\n                }\r\n            }\r\n\r\n            this.generateMap();\r\n        }\r\n\r\n        Maze.prototype.unvisitedCellsExist = function() {\r\n            for (var i=0; i<this.y; i++) {\r\n                for (var j=0; j<this.x; j++) {\r\n                    if (this.visited[i][j]) return true;\r\n                }\r\n            }\r\n            return false;\r\n        };\r\n\r\n        Maze.prototype.chooseNeighbor = function(cx,cy) {\r\n            var neighbors = [];\r\n            var directions = [];\r\n            if (cx > 0 && !this.visited[cy][cx-1]) \r\n                { neighbors.push( [cx-1, cy] ); directions.push('W'); }\r\n            if (cx < this.x-1 && !this.visited[cy][cx+1]) \r\n                { neighbors.push( [cx+1, cy] ); directions.push('E'); }\r\n            if (cy < this.y-1 && !this.visited[cy+1][cx]) \r\n                { neighbors.push( [cx, cy+1] ); directions.push('S'); }\r\n            if (cy > 0 && !this.visited[cy-1][cx]) \r\n                { neighbors.push( [cx, cy-1] ); directions.push('N'); }\r\n            if (neighbors.length) {\r\n                r = Math.floor(Math.random()*neighbors.length);\r\n                return [ neighbors[r], directions[r] ];\r\n            } else return false;\r\n        };\r\n\r\n        Maze.prototype.removeWall = function(x1, y1, direction) { \r\n            switch (direction) {\r\n                case 'N':\r\n                    this.map[y1][x1][0] = 0;\r\n                    this.map[y1-1][x1][2] = 0;\r\n                break;\r\n                case 'E':\r\n                    this.map[y1][x1][1] = 0;\r\n                    this.map[y1][x1+1][3] = 0;\r\n                break;\r\n                case 'S':\r\n                    this.map[y1][x1][2] = 0;\r\n                    this.map[y1+1][x1][0] = 0;\r\n                break;\r\n                case 'W':\r\n                    this.map[y1][x1][3] = 0;\r\n                    this.map[y1][x1-1][1] = 0;\r\n                break;\r\n            }\r\n        };\r\n\r\n        Maze.prototype.generateMap = function() {\r\n            \r\n            // choose initial cell\r\n            var rx = Math.floor(Math.random()*this.x);\r\n            var ry = Math.floor(Math.random()*this.y);\r\n\r\n            this.begin = [rx, ry];\r\n\r\n            var cx = rx;\r\n            var cy = ry;\r\n            var nx;\r\n            var ny;\r\n\r\n            this.visited[cy][cx] = true;\r\n\r\n            var next;\r\n            var nextDirection;\r\n\r\n            // while there are still unvisited cells\r\n            while (this.unvisitedCellsExist()) {\r\n                if (this.chooseNeighbor(cx,cy)) {\r\n                    \r\n                    next = this.chooseNeighbor(cx,cy);\r\n                    \r\n                    nx = next[0][0];\r\n                    ny = next[0][1];\r\n                    \r\n                    nextDirection = next[1];\r\n                    this.stack.push( [nx, ny] );\r\n                    this.removeWall(cx, cy, nextDirection);\r\n                    this.visited[ny][nx] = true;\r\n\r\n                    cx = nx;\r\n                    cy = ny;\r\n                \r\n                } else if (this.stack.length) {\r\n\r\n                    next = this.stack.pop();\r\n                    cx = next[0];\r\n                    cy = next[1];\r\n                    this.turnArounds.push([cx, cy]);\r\n                  \r\n                } else break;\r\n            }\r\n\r\n            this.end = [cx, cy];\r\n            this.map[0][0][3] = 0;\r\n            this.map[this.y-1][this.x-1][1] = 0;\r\n\r\n        };\r\n\r\n        Maze.prototype.getClearRect = function(cx, cy) {\r\n            var fx = cx * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;\r\n            var fy = cy * this.cellSize + (this.cellSize/2) - (this.ballRadius) - 1;\r\n            return [fx,fy];\r\n        };\r\n\r\n        Maze.prototype.getBallCoords = function(nx, ny) {\r\n            var bx = nx * this.cellSize + (this.cellSize/2);\r\n            var by = ny * this.cellSize + (this.cellSize/2);\r\n            return [bx,by];\r\n        };\r\n\r\n        Maze.prototype.clearBall = function() {\r\n            var cl = this.getClearRect(this.currentPosition[0], this.currentPosition[1]);\r\n            ctx.clearRect(cl[0], cl[1], this.ballRadius*2+2, this.ballRadius*2+2);\r\n        };\r\n\r\n        Maze.prototype.drawBall = function() {\r\n            var ballCoords = this.getBallCoords(this.currentPosition[0], this.currentPosition[1]);\r\n            ctx.beginPath();\r\n            ctx.arc(ballCoords[0], ballCoords[1], this.ballRadius, 0, 2*Math.PI, false);\r\n            ctx.fillStyle = 'green';\r\n            ctx.fill();\r\n            ctx.lineWidth = 1;\r\n            ctx.strokeStyle = '#003300';\r\n            ctx.stroke();\r\n        };\r\n\r\n        Maze.prototype.move = function(d) {\r\n            var dx = d[0];\r\n            var dy = d[1];\r\n            this.clearBall();\r\n            this.currentPosition = [this.currentPosition[0]+dx, this.currentPosition[1]+dy];\r\n            this.drawBall();\r\n        };\r\n\r\n        Maze.prototype.wallIsRendered = function(mt, lt) {\r\n            for (var i=0; i<this.wallsRendered.length; i++) {\r\n                if (this.wallsRendered[i][0][0] == mt[0] &&\r\n                    this.wallsRendered[i][0][1] == mt[1] &&\r\n                    this.wallsRendered[i][1][0] == lt[0] &&\r\n                    this.wallsRendered[i][1][1] == lt[1]) {\r\n\r\n                    return true;\r\n                }\r\n            }\r\n            return false;\r\n        };\r\n\r\n        Maze.prototype.getQuadrant = function(theta) {\r\n            if (theta <= (Math.PI/2)) return 1;\r\n            if (theta <= Math.PI) return 2;\r\n            if (theta <= (Math.PI*3)/2) return 3;\r\n            if (theta <= (Math.PI*2)) return 4;\r\n        }\r\n\r\n        Maze.prototype.getOppositeQuad = function(quad) {\r\n            if (quad == 1) return 3;\r\n            if (quad == 2) return 4;\r\n            if (quad == 3) return 1;\r\n            if (quad == 4) return 2;\r\n        }\r\n\r\n        Maze.prototype.isDirectionValid = function(direction) {\r\n            \r\n            var currentAngle = (((Math.PI*3)/2) - camera.rotation.y) % (2*Math.PI);\r\n            if (currentAngle < 0) currentAngle += (2*Math.PI);\r\n            var currentQuad = this.getQuadrant(currentAngle);\r\n\r\n            // if at a wall, handle wall vs. direction, then return false\r\n            if (this.atWall) {\r\n\r\n                switch (this.atWall) {\r\n                    case 'N':\r\n                        if ((currentQuad == 3 || currentQuad == 4) && direction == 1)\r\n                            return true;\r\n                        if ((currentQuad == 1 || currentQuad == 2) && direction == -1)\r\n                            return true;\r\n                        if (currentQuad == 1)\r\n                            camera.position.x += 10;\r\n                        if (currentQuad == 2)\r\n                            camera.position.x -= 10;\r\n                        return false;\r\n                    break;\r\n                    case 'E':\r\n                        if ((currentQuad == 2 || currentQuad == 3) && direction == 1)\r\n                            return true;\r\n                        if ((currentQuad == 1 || currentQuad == 4) && direction == -1)\r\n                            return true;\r\n                        if (currentQuad == 1)\r\n                            camera.position.z -= 10;\r\n                        if (currentQuad == 4)\r\n                            camera.position.z += 10;\r\n                        return false;\r\n                    break;\r\n                    case 'S':\r\n                        if ((currentQuad == 1 || currentQuad == 2) && direction == 1)\r\n                            return true;\r\n                        if ((currentQuad == 3 || currentQuad == 4) && direction == -1)\r\n                            return true;\r\n                        if (currentQuad == 3)\r\n                            camera.position.x -= 10;\r\n                        if (currentQuad == 4)\r\n                            camera.position.x += 10;\r\n                        return false;\r\n                    break;\r\n                    case 'W':\r\n                        if ((currentQuad == 1 || currentQuad == 4) && direction == 1)\r\n                            return true;\r\n                        if ((currentQuad == 2 || currentQuad == 3) && direction == -1)\r\n                            return true;\r\n                        if (currentQuad == 2)\r\n                            camera.position.z -= 10;\r\n                        if (currentQuad == 3)\r\n                            camera.position.z += 10;\r\n                        return false;\r\n                    break;\r\n                }\r\n\r\n                return false;\r\n\r\n            }\r\n\r\n            return true;\r\n\r\n        };\r\n\r\n        Maze.prototype.checkWallCollision = function() {\r\n            \r\n            // figure out which cell player is in\r\n            var playerX = Math.floor(camera.position.x / this.cellSize) + (this.x/2);\r\n            var playerZ = Math.floor(camera.position.z / this.cellSize) + (this.y/2);\r\n\r\n            // mark cell as current cell if not already\r\n            if (playerX != this.playerCurrentCell[0] || playerZ != this.playerCurrentCell[1]) {\r\n                this.playerCurrentCell = [playerX, playerZ];\r\n                console.log('entered cell ' + playerX + ', ' + playerZ);\r\n            }\r\n\r\n            // get walls in current cell\r\n            var walls = this.map[this.playerCurrentCell[1]][this.playerCurrentCell[0]];\r\n\r\n            // get global boundary coords\r\n            var bounds = [];\r\n            bounds.push((this.playerCurrentCell[1] * this.cellSize - \r\n                ((this.y*this.cellSize)/2)) + this.collisionPadding);\r\n            bounds.push((this.playerCurrentCell[0] * this.cellSize - \r\n                ((this.x*this.cellSize)/2)) + this.cellSize - this.collisionPadding);\r\n            bounds.push((this.playerCurrentCell[1] * this.cellSize - \r\n                ((this.y*this.cellSize)/2)) + this.cellSize - this.collisionPadding);\r\n            bounds.push((this.playerCurrentCell[0] * this.cellSize - \r\n                ((this.x*this.cellSize)/2)) + this.collisionPadding);\r\n\r\n            \r\n            // test each wall for collision\r\n            var whichWall = false;\r\n\r\n            if (walls[0] && camera.position.z <= bounds[0]) {\r\n                console.log('hit north wall');\r\n                whichWall = 'N';\r\n            }\r\n            if (walls[1] && camera.position.x >= bounds[1]) {\r\n                console.log('hit east wall');\r\n                whichWall = 'E';\r\n            }\r\n            if (walls[2] && camera.position.z >= bounds[2]) {\r\n                console.log('hit south wall');\r\n                whichWall = 'S';\r\n            }\r\n            if (walls[3] && camera.position.x <= bounds[3]) {\r\n                console.log('hit west wall');\r\n                whichWall = 'W';\r\n            }\r\n\r\n            this.atWall = whichWall;\r\n        };\r\n\r\n        Maze.prototype.render = function(ctx) {\r\n            \r\n            var cell;\r\n            var cx;\r\n            var cy;\r\n\r\n            var geometry, texture, mesh;\r\n\r\n            // draw grass\r\n            geometry = new THREE.BoxGeometry(this.x*this.cellSize, 10, this.y*this.cellSize);\r\n            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/grass.jpg');\r\n            texture.anisotropy = renderer.getMaxAnisotropy();\r\n            material = new THREE.MeshBasicMaterial( { map: texture } );\r\n            this.grass = new THREE.Mesh( geometry, material );\r\n            this.grass.position.set(0, -100, 0); \r\n            scene.add( this.grass );\r\n\r\n            // draw sky\r\n            var skyRadius;\r\n            if (this.y > this.x) {\r\n                skyRadius = (this.y*this.cellSize);\r\n            } else skyRadius = (this.x*this.cellSize); \r\n            \r\n            geometry = new THREE.SphereGeometry(skyRadius, 16, 16, Math.PI/2,  Math.PI*2, 0, Math.PI);\r\n            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/sky.jpg');\r\n            texture.anisotropy = renderer.getMaxAnisotropy();\r\n            material = new THREE.MeshBasicMaterial( {map: texture} );\r\n            material.side = THREE.BackSide\r\n            this.sky = new THREE.Mesh(geometry, material);\r\n            this.sky.position.set(0,0,0);\r\n            scene.add(this.sky);\r\n\r\n            for (var i=0; i<this.y; i++) {\r\n                for (var j=0; j<this.x; j++) {\r\n                    \r\n                    cell = this.map[i][j];\r\n                    cx = this.cellSize * j - ((this.x*this.cellSize)/2);\r\n                    cy = this.cellSize * i - ((this.y*this.cellSize)/2);\r\n                    var mt;\r\n                    var lt;\r\n\r\n                    if (cell[0]) {\r\n                        mt = [cx, cy];\r\n                        lt = [cx+this.cellSize, cy];\r\n                        if (!this.wallIsRendered(mt, lt)) {\r\n                            geometry = new THREE.BoxGeometry(  200, 200, 10  );\r\n                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/wood.jpg');\r\n                            texture.anisotropy = renderer.getMaxAnisotropy();\r\n                            material = new THREE.MeshBasicMaterial( { map: texture } );\r\n                            mesh = new THREE.Mesh( geometry, material );\r\n                            mesh.position.set(mt[0]+this.cellSize/2, 0, mt[1]); \r\n                            scene.add( mesh );\r\n                        }\r\n                    } \r\n                    if (cell[1]) {\r\n                        mt = [cx+this.cellSize, cy];\r\n                        lt = [cx+this.cellSize, cy+this.cellSize];\r\n                        if (!this.wallIsRendered(mt, lt)) {\r\n                            geometry = new THREE.BoxGeometry(  10, 200, 200  );\r\n                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/wood.jpg');\r\n                            texture.anisotropy = renderer.getMaxAnisotropy();\r\n                            material = new THREE.MeshBasicMaterial( { map: texture } );\r\n                            mesh = new THREE.Mesh( geometry, material );\r\n                            mesh.position.set(mt[0], 0, mt[1]+this.cellSize/2); \r\n                            scene.add( mesh );\r\n                        }\r\n                    } \r\n                    if (cell[2]) {\r\n                        mt = [cx+this.cellSize, cy+this.cellSize];\r\n                        lt = [cx, cy+this.cellSize];\r\n                        if (!this.wallIsRendered(mt, lt)) {\r\n                            geometry = new THREE.BoxGeometry(  200, 200, 10  );\r\n                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/crate.gif');\r\n                            texture.anisotropy = renderer.getMaxAnisotropy();\r\n                            material = new THREE.MeshBasicMaterial( { map: texture } );\r\n                            mesh = new THREE.Mesh( geometry, material );\r\n                            mesh.position.set(mt[0]-this.cellSize/2, 0, mt[1]); \r\n                            scene.add( mesh );\r\n                        }\r\n                    }\r\n                    if (cell[3]) {\r\n                        mt = [cx, cy+this.cellSize];\r\n                        lt = [cx, cy];\r\n                        if (!this.wallIsRendered(mt, lt)) {\r\n                            geometry = new THREE.BoxGeometry(  10, 200, 200  );\r\n                            texture = THREE.ImageUtils.loadTexture('/static/site/img/textures/crate.gif');\r\n                            texture.anisotropy = renderer.getMaxAnisotropy();\r\n                            material = new THREE.MeshBasicMaterial( { map: texture } );\r\n                            mesh = new THREE.Mesh( geometry, material );\r\n                            mesh.position.set(mt[0], 0, mt[1]-this.cellSize/2); \r\n                            scene.add( mesh );\r\n                        }\r\n                    }\r\n\r\n                }\r\n            }\r\n        };\r\n\r\n        Maze.prototype.walkForward = function() {\r\n            this.checkWallCollision();\r\n            if (this.isDirectionValid(1)) {\r\n                camera.position.x -= 10 * Math.sin(camera.rotation.y);\r\n                camera.position.z += 10 * Math.cos(camera.rotation.y);\r\n                console.log('F');\r\n            }\r\n        };\r\n\r\n        Maze.prototype.walkBackwards = function() {\r\n            this.checkWallCollision();\r\n            if (this.isDirectionValid(-1)) {\r\n                camera.position.x += 10 * Math.sin(camera.rotation.y);\r\n                camera.position.z -= 10 * Math.cos(camera.rotation.y);\r\n                console.log('B');\r\n            }\r\n        };\r\n\r\n        Maze.prototype.turnLeft = function() {\r\n            camera.rotation.y -= Math.PI / 10;\r\n        };\r\n\r\n        Maze.prototype.turnRight = function() {\r\n            camera.rotation.y += Math.PI / 10;\r\n        };\r\n\r\n        Maze.prototype.flyUp = function() {\r\n            camera.position.y += 10;\r\n        };\r\n\r\n        Maze.prototype.flyDown = function() {\r\n            camera.position.y -= 10;\r\n        };\r\n\r\n        // } end class Maze\r\n\r\n        /*\r\n            MazeSolver pseudo-code\r\n\r\n            1. start at the entrance\r\n            2. while not at the exit\r\n                1. push the current cell to visited\r\n                2. if exists one or more directions that have not been visited\r\n                    1. push the current cell to pathStack\r\n                    2. choose any direction from those not visited\r\n                    3. move in that direction\r\n                    4. draw path from previous cell to chosen cell\r\n                    5. make the chosen cell the current cell\r\n                3. otherwise backtrack\r\n                    1. pop the pathStack\r\n                    2. remove line from currentCell to popped cell\r\n                    3. do not remove popped cell from visited\r\n        */\r\n\r\n        // class MazeSolver {\r\n\r\n        function MazeSolver(maze) {\r\n            this.Maze = maze;\r\n            this.position = [0, 0];\r\n            this.pathStack = [];\r\n            this.visited = [];\r\n            this.Maze.clearBall();\r\n\r\n            var self = this;\r\n            this.solveStep = function() {\r\n                self.moveForward();\r\n            };\r\n        }\r\n\r\n        MazeSolver.prototype.getValidDirections = function(x,y) {\r\n            \r\n            var directions = [];\r\n            \r\n            if (!this.Maze.map[y][x][0]) \r\n                directions.push([0,-1]);\r\n            if (!this.Maze.map[y][x][1] && (x!=this.Maze.x-1 || y!=this.Maze.y-1)) \r\n                directions.push([1,0]);\r\n            if (!this.Maze.map[y][x][2]) \r\n                directions.push([0,1]);\r\n            if (!this.Maze.map[y][x][3] && (x||y)) \r\n                directions.push([-1,0]);\r\n\r\n            var validDirections = [];\r\n            for (var i=0; i<directions.length; i++) {\r\n                var tx = x+directions[i][0];\r\n                var ty = y+directions[i][1];\r\n                if (!this.isVisited(tx,ty)) {\r\n                    validDirections.push(directions[i]);\r\n                }\r\n            }\r\n\r\n            return validDirections;\r\n        };\r\n\r\n        MazeSolver.prototype.isVisited = function(x,y) {\r\n            for (var i=0; i<this.visited.length; i++) {\r\n                if (this.visited[i][0] == x && this.visited[i][1] == y) \r\n                    return true;\r\n            }\r\n            return false;\r\n        };\r\n\r\n        MazeSolver.prototype.isDeadEnd = function(x,y) {\r\n            if (!this.getValidDirections(x,y).length)\r\n                return true;\r\n            return false;\r\n        };\r\n\r\n        MazeSolver.prototype.movePath = function(cx,cy,nx,ny) {\r\n            ctx.lineWidth = 4;\r\n            ctx.strokeStyle = '#5555ff';\r\n            ctx.beginPath();\r\n\r\n            ctx.moveTo(cx*this.Maze.cellSize+this.Maze.cellSize/2, \r\n                cy*this.Maze.cellSize+this.Maze.cellSize/2);\r\n            ctx.lineTo(nx*this.Maze.cellSize+this.Maze.cellSize/2, \r\n                ny*this.Maze.cellSize+this.Maze.cellSize/2);\r\n            ctx.stroke();\r\n        };\r\n\r\n        MazeSolver.prototype.clearPath = function(x,y) {\r\n            ctx.clearRect(x*this.Maze.cellSize+2, y*this.Maze.cellSize+2, \r\n                this.Maze.cellSize-4, this.Maze.cellSize-4);\r\n        };\r\n\r\n        MazeSolver.prototype.isFinished = function() {\r\n            if (this.position[0] == this.Maze.x-1 && this.position[1] == this.Maze.y-1)\r\n                return true;\r\n            return false;\r\n        };\r\n\r\n        MazeSolver.prototype.moveForward = function() {\r\n            \r\n            var cx = this.position[0];\r\n            var cy = this.position[1];\r\n            \r\n            this.visited.push([cx,cy]);\r\n            \r\n            if (this.isFinished()) {\r\n                console.log("FINISH");\r\n                clearInterval(this.interval);\r\n                return;\r\n            }\r\n\r\n            if (!this.isDeadEnd(cx,cy)) {\r\n                this.pathStack.push([cx,cy]);\r\n                var directions = this.getValidDirections(cx,cy);\r\n                var randomDirection = Math.floor(Math.random()*directions.length);\r\n                \r\n                var nx = cx + directions[randomDirection][0];\r\n                var ny = cy + directions[randomDirection][1];\r\n\r\n                this.movePath(cx,cy,nx,ny);\r\n                this.position = [nx,ny];\r\n\r\n            } else { \r\n                this.backtrack();\r\n            }\r\n        };\r\n\r\n        MazeSolver.prototype.backtrack = function() {\r\n            var lastCell = this.pathStack.pop();\r\n            this.clearPath(this.position[0], this.position[1]);\r\n            this.position = [lastCell[0], lastCell[1]];\r\n        };\r\n\r\n        // } end class MazeSolver\r\n\r\n\r\n        $(document).keydown(function(e) {\r\n            \r\n            var tx = Maze.currentPosition[0];\r\n            var ty = Maze.currentPosition[1];\r\n\r\n            switch (e.keyCode) {\r\n\r\n                case 37: // left\r\n                    Maze.turnLeft();\r\n                break;\r\n                case 38: // up (forward)\r\n                    Maze.walkForward();\r\n                break;\r\n                case 39: // right\r\n                    Maze.turnRight();\r\n                break;\r\n                case 40: // down (backwards)\r\n                    Maze.walkBackwards();\r\n                break;\r\n                case 65: // 'a' key\r\n                    Maze.flyUp();\r\n                break;\r\n                case 90: // 'z' key\r\n                    Maze.flyDown();\r\n                break;\r\n\r\n            }\r\n        });\r\n\r\n        function solveMaze() {\r\n            solver = new MazeSolver(Maze);\r\n            solver.interval = setInterval(solver.solveStep, 5);\r\n        }\r\n\r\n        var Maze;\r\n        \r\n\r\n        var ctx;\r\n        var solver;\r\n\r\n        var camera, scene, renderer;\r\n        var mesh;\r\n\r\nfunction onWindowResize() {\r\n  camera.aspect = window.innerWidth / window.innerHeight;\r\n  camera.updateProjectionMatrix();\r\n  renderer.setSize( window.innerWidth, window.innerHeight );\r\n}\r\n\r\nfunction animate() {\r\n  requestAnimationFrame(animate);\r\n  renderer.render(scene, camera);\r\n}\r\n\r\n    \r\n    var cellSize = 200;\r\n\r\nrenderer = new THREE.WebGLRenderer({\r\n    preserveDrawingBuffer: true\r\n});\r\nrenderer.setSize( Canvas.width, Canvas.height );\r\nconsole.log(renderer.domElement); console.log('-----');\r\ndocument.body.appendChild( renderer.domElement );\r\n\r\nwindow._renderer = renderer;\r\n\r\ncamera = new THREE.PerspectiveCamera( 90, window.innerWidth / window.innerHeight, 1, 10000 );\r\nscene = new THREE.Scene();\r\n\r\nMaze = new Maze(2, 16, 10, cellSize);\r\nMaze.render();\r\n\r\ncamera.position.x = Maze.cellSize * Maze.x * -0.5;\r\ncamera.position.y = 15;\r\ncamera.position.z = Maze.cellSize * Maze.y * -0.5 + Maze.cellSize/2;\r\n\r\ncamera.lookAt(scene.position);\r\nwindow.addEventListener( 'resize', onWindowResize, false );\r\nanimate();	{}		\N	2016-02-29 18:57:30.047799-08
\.


--
-- Data for Name: game_zeroplayergame_extraIncludes; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY "game_zeroplayergame_extraIncludes" (id, zeroplayergame_id, jslibrary_id) FROM stdin;
1	2	1
\.


--
-- Name: game_zeroplayergame_extraIncludes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('"game_zeroplayergame_extraIncludes_id_seq"', 1, true);


--
-- Data for Name: portfolio_imagegallery; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY portfolio_imagegallery (id, name) FROM stdin;
\.


--
-- Name: portfolio_imagegallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('portfolio_imagegallery_id_seq', 1, false);


--
-- Data for Name: portfolio_imagemodel; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY portfolio_imagemodel (id, image, "timestamp", gallery_id) FROM stdin;
\.


--
-- Name: portfolio_imagemodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('portfolio_imagemodel_id_seq', 1, false);


--
-- Data for Name: portfolio_portfoliocategory; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY portfolio_portfoliocategory (id, name, description, image) FROM stdin;
\.


--
-- Name: portfolio_portfoliocategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('portfolio_portfoliocategory_id_seq', 1, false);


--
-- Data for Name: portfolio_portfolioitem; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY portfolio_portfolioitem (id, title, subtitle, description, sourcecode, image, creationdate, category_id, url) FROM stdin;
\.


--
-- Name: portfolio_portfolioitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('portfolio_portfolioitem_id_seq', 1, false);


--
-- Data for Name: portfolio_proprietaryportfolioitem; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY portfolio_proprietaryportfolioitem (portfolioitem_ptr_id, company, gallery_id) FROM stdin;
\.


--
-- Data for Name: profiles_profile; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY profiles_profile (user_id, slug, picture, bio, email_verified) FROM stdin;
1	5f4a81e2-0c14-435e-a4a4-b84f793fbc75	profile_pics/2016-02-02/97.jpg		f
\.


--
-- Data for Name: profiles_profile_followers; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY profiles_profile_followers (id, from_profile_id, to_profile_id) FROM stdin;
\.


--
-- Name: profiles_profile_followers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('profiles_profile_followers_id_seq', 1, false);


--
-- Data for Name: static_precompiler_dependency; Type: TABLE DATA; Schema: public; Owner: ninopq
--

COPY static_precompiler_dependency (id, source, depends_on) FROM stdin;
\.


--
-- Name: static_precompiler_dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ninopq
--

SELECT pg_catalog.setval('static_precompiler_dependency_id_seq', 1, false);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtools_user_email_key; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user
    ADD CONSTRAINT authtools_user_email_key UNIQUE (email);


--
-- Name: authtools_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_pkey PRIMARY KEY (id);


--
-- Name: authtools_user_groups_user_id_a8658824_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_user_id_a8658824_uniq UNIQUE (user_id, group_id);


--
-- Name: authtools_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user
    ADD CONSTRAINT authtools_user_pkey PRIMARY KEY (id);


--
-- Name: authtools_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: authtools_user_user_permissions_user_id_3e9e8ba9_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permissions_user_id_3e9e8ba9_uniq UNIQUE (user_id, permission_id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: easy_thumbnails_source_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_source_storage_hash_481ce32d_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_source
    ADD CONSTRAINT easy_thumbnails_source_storage_hash_481ce32d_uniq UNIQUE (storage_hash, name);


--
-- Name: easy_thumbnails_thumbnail_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_fb375270_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_thumbnail_storage_hash_fb375270_uniq UNIQUE (storage_hash, name, source_id);


--
-- Name: easy_thumbnails_thumbnaildimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_pkey PRIMARY KEY (id);


--
-- Name: easy_thumbnails_thumbnaildimensions_thumbnail_id_key; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thumbnails_thumbnaildimensions_thumbnail_id_key UNIQUE (thumbnail_id);


--
-- Name: game_category_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY game_category
    ADD CONSTRAINT game_category_pkey PRIMARY KEY (id);


--
-- Name: game_gameinstance_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_pkey PRIMARY KEY (id);


--
-- Name: game_gameinstancesnapshot_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY game_gameinstancesnapshot
    ADD CONSTRAINT game_gameinstancesnapshot_pkey PRIMARY KEY (id);


--
-- Name: game_jslibrary_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY game_jslibrary
    ADD CONSTRAINT game_jslibrary_pkey PRIMARY KEY (id);


--
-- Name: game_plerpingapp_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_pkey PRIMARY KEY (id);


--
-- Name: game_zeroplayergame_extraInclud_zeroplayergame_id_2d035b3a_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT "game_zeroplayergame_extraInclud_zeroplayergame_id_2d035b3a_uniq" UNIQUE (zeroplayergame_id, jslibrary_id);


--
-- Name: game_zeroplayergame_extraIncludes_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT "game_zeroplayergame_extraIncludes_pkey" PRIMARY KEY (id);


--
-- Name: portfolio_imagegallery_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY portfolio_imagegallery
    ADD CONSTRAINT portfolio_imagegallery_pkey PRIMARY KEY (id);


--
-- Name: portfolio_imagemodel_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY portfolio_imagemodel
    ADD CONSTRAINT portfolio_imagemodel_pkey PRIMARY KEY (id);


--
-- Name: portfolio_portfoliocategory_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY portfolio_portfoliocategory
    ADD CONSTRAINT portfolio_portfoliocategory_pkey PRIMARY KEY (id);


--
-- Name: portfolio_portfolioitem_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY portfolio_portfolioitem
    ADD CONSTRAINT portfolio_portfolioitem_pkey PRIMARY KEY (id);


--
-- Name: portfolio_proprietaryportfolioitem_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT portfolio_proprietaryportfolioitem_pkey PRIMARY KEY (portfolioitem_ptr_id);


--
-- Name: profiles_profile_followers_from_profile_id_8a9bcb07_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_profile_followers_from_profile_id_8a9bcb07_uniq UNIQUE (from_profile_id, to_profile_id);


--
-- Name: profiles_profile_followers_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_profile_followers_pkey PRIMARY KEY (id);


--
-- Name: profiles_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY profiles_profile
    ADD CONSTRAINT profiles_profile_pkey PRIMARY KEY (user_id);


--
-- Name: static_precompiler_dependency_pkey; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY static_precompiler_dependency
    ADD CONSTRAINT static_precompiler_dependency_pkey PRIMARY KEY (id);


--
-- Name: static_precompiler_dependency_source_d8e91940_uniq; Type: CONSTRAINT; Schema: public; Owner: ninopq; Tablespace: 
--

ALTER TABLE ONLY static_precompiler_dependency
    ADD CONSTRAINT static_precompiler_dependency_source_d8e91940_uniq UNIQUE (source, depends_on);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: authtools_user_email_f133274f_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX authtools_user_email_f133274f_like ON authtools_user USING btree (email varchar_pattern_ops);


--
-- Name: authtools_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX authtools_user_groups_0e939a4f ON authtools_user_groups USING btree (group_id);


--
-- Name: authtools_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX authtools_user_groups_e8701ad4 ON authtools_user_groups USING btree (user_id);


--
-- Name: authtools_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX authtools_user_user_permissions_8373b171 ON authtools_user_user_permissions USING btree (permission_id);


--
-- Name: authtools_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX authtools_user_user_permissions_e8701ad4 ON authtools_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_b068931c; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_b068931c ON easy_thumbnails_source USING btree (name);


--
-- Name: easy_thumbnails_source_b454e115; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_b454e115 ON easy_thumbnails_source USING btree (storage_hash);


--
-- Name: easy_thumbnails_source_name_5fe0edc6_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_name_5fe0edc6_like ON easy_thumbnails_source USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_source_storage_hash_946cbcc9_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_source_storage_hash_946cbcc9_like ON easy_thumbnails_source USING btree (storage_hash varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_0afd9202; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_0afd9202 ON easy_thumbnails_thumbnail USING btree (source_id);


--
-- Name: easy_thumbnails_thumbnail_b068931c; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_b068931c ON easy_thumbnails_thumbnail USING btree (name);


--
-- Name: easy_thumbnails_thumbnail_b454e115; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_b454e115 ON easy_thumbnails_thumbnail USING btree (storage_hash);


--
-- Name: easy_thumbnails_thumbnail_name_b5882c31_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_name_b5882c31_like ON easy_thumbnails_thumbnail USING btree (name varchar_pattern_ops);


--
-- Name: easy_thumbnails_thumbnail_storage_hash_f1435f49_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX easy_thumbnails_thumbnail_storage_hash_f1435f49_like ON easy_thumbnails_thumbnail USING btree (storage_hash varchar_pattern_ops);


--
-- Name: game_category_6be37982; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_category_6be37982 ON game_category USING btree (parent_id);


--
-- Name: game_gameinstance_6072f8b3; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_gameinstance_6072f8b3 ON game_gameinstance USING btree (game_id);


--
-- Name: game_gameinstance_6ccdb143; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_gameinstance_6ccdb143 ON game_gameinstance USING btree (instantiator_id);


--
-- Name: game_gameinstancesnapshot_51afcc4f; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_gameinstancesnapshot_51afcc4f ON game_gameinstancesnapshot USING btree (instance_id);


--
-- Name: game_plerpingapp_5e7b1936; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_plerpingapp_5e7b1936 ON game_zeroplayergame USING btree (owner_id);


--
-- Name: game_plerpingapp_b583a629; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_plerpingapp_b583a629 ON game_zeroplayergame USING btree (category_id);


--
-- Name: game_zeroplayergame_6be37982; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX game_zeroplayergame_6be37982 ON game_zeroplayergame USING btree (parent_id);


--
-- Name: game_zeroplayergame_extraIncludes_030a3785; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX "game_zeroplayergame_extraIncludes_030a3785" ON "game_zeroplayergame_extraIncludes" USING btree (zeroplayergame_id);


--
-- Name: game_zeroplayergame_extraIncludes_32432e4e; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX "game_zeroplayergame_extraIncludes_32432e4e" ON "game_zeroplayergame_extraIncludes" USING btree (jslibrary_id);


--
-- Name: portfolio_imagemodel_6d994cdb; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX portfolio_imagemodel_6d994cdb ON portfolio_imagemodel USING btree (gallery_id);


--
-- Name: portfolio_portfolioitem_b583a629; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX portfolio_portfolioitem_b583a629 ON portfolio_portfolioitem USING btree (category_id);


--
-- Name: portfolio_proprietaryportfolioitem_6d994cdb; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX portfolio_proprietaryportfolioitem_6d994cdb ON portfolio_proprietaryportfolioitem USING btree (gallery_id);


--
-- Name: profiles_profile_followers_658493f6; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX profiles_profile_followers_658493f6 ON profiles_profile_followers USING btree (to_profile_id);


--
-- Name: profiles_profile_followers_9c2b64df; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX profiles_profile_followers_9c2b64df ON profiles_profile_followers USING btree (from_profile_id);


--
-- Name: static_precompiler_dependency_1f903a40; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX static_precompiler_dependency_1f903a40 ON static_precompiler_dependency USING btree (depends_on);


--
-- Name: static_precompiler_dependency_36cd38f4; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX static_precompiler_dependency_36cd38f4 ON static_precompiler_dependency USING btree (source);


--
-- Name: static_precompiler_dependency_depends_on_a14c2c8b_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX static_precompiler_dependency_depends_on_a14c2c8b_like ON static_precompiler_dependency USING btree (depends_on varchar_pattern_ops);


--
-- Name: static_precompiler_dependency_source_6c770ab0_like; Type: INDEX; Schema: public; Owner: ninopq; Tablespace: 
--

CREATE INDEX static_precompiler_dependency_source_6c770ab0_like ON static_precompiler_dependency USING btree (source varchar_pattern_ops);


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtools_user_groups_group_id_fdf65e59_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_group_id_fdf65e59_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtools_user_groups_user_id_c1c2c51f_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_groups
    ADD CONSTRAINT authtools_user_groups_user_id_c1c2c51f_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtools_user_use_permission_id_039bf6fe_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_use_permission_id_039bf6fe_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtools_user_user_permi_user_id_d172ce6b_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY authtools_user_user_permissions
    ADD CONSTRAINT authtools_user_user_permi_user_id_d172ce6b_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thum_thumbnail_id_c3a0c549_fk_easy_thumbnails_thumbnail_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY easy_thumbnails_thumbnaildimensions
    ADD CONSTRAINT easy_thum_thumbnail_id_c3a0c549_fk_easy_thumbnails_thumbnail_id FOREIGN KEY (thumbnail_id) REFERENCES easy_thumbnails_thumbnail(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: easy_thumbnails_source_id_5b57bc77_fk_easy_thumbnails_source_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY easy_thumbnails_thumbnail
    ADD CONSTRAINT easy_thumbnails_source_id_5b57bc77_fk_easy_thumbnails_source_id FOREIGN KEY (source_id) REFERENCES easy_thumbnails_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_category_parent_id_4a4e38a7_fk_game_category_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_category
    ADD CONSTRAINT game_category_parent_id_4a4e38a7_fk_game_category_id FOREIGN KEY (parent_id) REFERENCES game_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_gameinstance_game_id_a878f786_fk_game_zeroplayergame_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_game_id_a878f786_fk_game_zeroplayergame_id FOREIGN KEY (game_id) REFERENCES game_zeroplayergame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_gameinstance_instantiator_id_3f0b0fcb_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_gameinstance
    ADD CONSTRAINT game_gameinstance_instantiator_id_3f0b0fcb_fk_authtools_user_id FOREIGN KEY (instantiator_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_gameinstances_instance_id_d6d83406_fk_game_gameinstance_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_gameinstancesnapshot
    ADD CONSTRAINT game_gameinstances_instance_id_d6d83406_fk_game_gameinstance_id FOREIGN KEY (instance_id) REFERENCES game_gameinstance(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_plerpingapp_category_id_d18c203b_fk_game_category_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_category_id_d18c203b_fk_game_category_id FOREIGN KEY (category_id) REFERENCES game_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_plerpingapp_owner_id_db15314c_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_plerpingapp_owner_id_db15314c_fk_authtools_user_id FOREIGN KEY (owner_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_zerop_zeroplayergame_id_a5dd43ed_fk_game_zeroplayergame_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT game_zerop_zeroplayergame_id_a5dd43ed_fk_game_zeroplayergame_id FOREIGN KEY (zeroplayergame_id) REFERENCES game_zeroplayergame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_zeroplayergam_parent_id_00669d04_fk_game_zeroplayergame_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY game_zeroplayergame
    ADD CONSTRAINT game_zeroplayergam_parent_id_00669d04_fk_game_zeroplayergame_id FOREIGN KEY (parent_id) REFERENCES game_zeroplayergame(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: game_zeroplayergame__jslibrary_id_30752fb8_fk_game_jslibrary_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY "game_zeroplayergame_extraIncludes"
    ADD CONSTRAINT game_zeroplayergame__jslibrary_id_30752fb8_fk_game_jslibrary_id FOREIGN KEY (jslibrary_id) REFERENCES game_jslibrary(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: por_portfolioitem_ptr_id_da61254d_fk_portfolio_portfolioitem_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT por_portfolioitem_ptr_id_da61254d_fk_portfolio_portfolioitem_id FOREIGN KEY (portfolioitem_ptr_id) REFERENCES portfolio_portfolioitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: portfoli_category_id_db01a81d_fk_portfolio_portfoliocategory_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_portfolioitem
    ADD CONSTRAINT portfoli_category_id_db01a81d_fk_portfolio_portfoliocategory_id FOREIGN KEY (category_id) REFERENCES portfolio_portfoliocategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: portfolio_imag_gallery_id_ae9b842e_fk_portfolio_imagegallery_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_imagemodel
    ADD CONSTRAINT portfolio_imag_gallery_id_ae9b842e_fk_portfolio_imagegallery_id FOREIGN KEY (gallery_id) REFERENCES portfolio_imagegallery(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: portfolio_prop_gallery_id_e7ba0f54_fk_portfolio_imagegallery_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY portfolio_proprietaryportfolioitem
    ADD CONSTRAINT portfolio_prop_gallery_id_e7ba0f54_fk_portfolio_imagegallery_id FOREIGN KEY (gallery_id) REFERENCES portfolio_imagegallery(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_p_from_profile_id_e7888571_fk_profiles_profile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_p_from_profile_id_e7888571_fk_profiles_profile_user_id FOREIGN KEY (from_profile_id) REFERENCES profiles_profile(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_pro_to_profile_id_562358dd_fk_profiles_profile_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY profiles_profile_followers
    ADD CONSTRAINT profiles_pro_to_profile_id_562358dd_fk_profiles_profile_user_id FOREIGN KEY (to_profile_id) REFERENCES profiles_profile(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_profile_user_id_a3e81f91_fk_authtools_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ninopq
--

ALTER TABLE ONLY profiles_profile
    ADD CONSTRAINT profiles_profile_user_id_a3e81f91_fk_authtools_user_id FOREIGN KEY (user_id) REFERENCES authtools_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

