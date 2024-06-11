--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: root
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO root;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: root
--

COMMENT ON SCHEMA public IS '';


--
-- Name: FactiiiRequirement; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."FactiiiRequirement" AS ENUM (
    'MEDIA_REQUIRED',
    'CONTENT_REQUIRED',
    'HUMAN_SOURCE',
    'GOVERNMENT_SOURCE',
    'ENTERPRISE_SOURCE',
    'ANONYMOUS_SOURCE',
    'WIKI',
    'DATA_REQUIRED',
    'LOCATION_REQUIRED',
    'TIME_REQUIRED',
    'NONE',
    'NO_POST_DUPLICATES',
    'BUDGET'
);


ALTER TYPE public."FactiiiRequirement" OWNER TO root;

--
-- Name: FactiiiStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."FactiiiStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED',
    'RETIRED'
);


ALTER TYPE public."FactiiiStatus" OWNER TO root;

--
-- Name: FactiiiType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."FactiiiType" AS ENUM (
    'PRIVATE',
    'PREMIUM',
    'PAID',
    'INVITE'
);


ALTER TYPE public."FactiiiType" OWNER TO root;

--
-- Name: FeedbackType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."FeedbackType" AS ENUM (
    'SUGGESTION',
    'BUG_REPORT'
);


ALTER TYPE public."FeedbackType" OWNER TO root;

--
-- Name: ModelType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."ModelType" AS ENUM (
    'OPENAI_LANGUAGE',
    'OPENAI_IMAGE',
    'OPENAI_EMBEDDING',
    'OPENAI_FINE_TUNED',
    'WIKIPEDIA_SCRAPER'
);


ALTER TYPE public."ModelType" OWNER TO root;

--
-- Name: NotificationType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."NotificationType" AS ENUM (
    'UPVOTED',
    'FOLLOWED',
    'REPLIED',
    'TAGGED_POST',
    'SPACE_INVITES'
);


ALTER TYPE public."NotificationType" OWNER TO root;

--
-- Name: PaymentType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PaymentType" AS ENUM (
    'STRIPE',
    'GOOGLE',
    'APPLE'
);


ALTER TYPE public."PaymentType" OWNER TO root;

--
-- Name: PostFactiiiStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PostFactiiiStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED',
    'RETIRED'
);


ALTER TYPE public."PostFactiiiStatus" OWNER TO root;

--
-- Name: PostStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."PostStatus" AS ENUM (
    'PUBLISHED',
    'DELETED',
    'DELISTED',
    'DRAFT',
    'WITHDRAWN'
);


ALTER TYPE public."PostStatus" OWNER TO root;

--
-- Name: ProductType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."ProductType" AS ENUM (
    'COIN',
    'MONTHLY_SUBSCRIPTION',
    'LIFETIME_PREMIUM',
    'DONATION'
);


ALTER TYPE public."ProductType" OWNER TO root;

--
-- Name: ReportStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."ReportStatus" AS ENUM (
    'PENDING',
    'DISCARDED',
    'CONTENT_REMOVED'
);


ALTER TYPE public."ReportStatus" OWNER TO root;

--
-- Name: ReportType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."ReportType" AS ENUM (
    'AVATAR',
    'BANNER',
    'BIO',
    'POST',
    'FACTIII'
);


ALTER TYPE public."ReportType" OWNER TO root;

--
-- Name: SpaceMemberRoles; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."SpaceMemberRoles" AS ENUM (
    'OWNER',
    'MODERATOR',
    'MEMBER'
);


ALTER TYPE public."SpaceMemberRoles" OWNER TO root;

--
-- Name: SpaceStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."SpaceStatus" AS ENUM (
    'ACTIVE',
    'DELISTED',
    'BANNED'
);


ALTER TYPE public."SpaceStatus" OWNER TO root;

--
-- Name: SpaceType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."SpaceType" AS ENUM (
    'PRIVATE',
    'PREMIUM',
    'PAID',
    'INVITE'
);


ALTER TYPE public."SpaceType" OWNER TO root;

--
-- Name: UploadStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UploadStatus" AS ENUM (
    'PUBLISHED',
    'DELETED',
    'DELISTED',
    'S3_MISSING',
    'DB_MISSING'
);


ALTER TYPE public."UploadStatus" OWNER TO root;

--
-- Name: UploadType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UploadType" AS ENUM (
    'IMAGE',
    'VIDEO',
    'DOCUMENT'
);


ALTER TYPE public."UploadType" OWNER TO root;

--
-- Name: UserStatus; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UserStatus" AS ENUM (
    'ACTIVE',
    'DEACTIVATED',
    'BANNED',
    'MUTED'
);


ALTER TYPE public."UserStatus" OWNER TO root;

--
-- Name: UserTag; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UserTag" AS ENUM (
    'HUMAN',
    'BOT',
    'GOVERNMENT',
    'ACADEMIA',
    'BUSINESS',
    'NEW',
    'WAITLIST'
);


ALTER TYPE public."UserTag" OWNER TO root;

--
-- Name: UserType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."UserType" AS ENUM (
    'PRIVATE',
    'PREMIUM',
    'PAID',
    'INVITE'
);


ALTER TYPE public."UserType" OWNER TO root;

--
-- Name: VoteType; Type: TYPE; Schema: public; Owner: root
--

CREATE TYPE public."VoteType" AS ENUM (
    'UPVOTE',
    'DOWNVOTE'
);


ALTER TYPE public."VoteType" OWNER TO root;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Ban; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Ban" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "conversationId" text,
    public boolean DEFAULT false NOT NULL,
    "userId" integer NOT NULL,
    "spaceId" integer
);


ALTER TABLE public."Ban" OWNER TO root;

--
-- Name: BanReason; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."BanReason" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "ruleId" integer NOT NULL,
    "banId" integer NOT NULL
);


ALTER TABLE public."BanReason" OWNER TO root;

--
-- Name: BanReason_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."BanReason_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."BanReason_id_seq" OWNER TO root;

--
-- Name: BanReason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."BanReason_id_seq" OWNED BY public."BanReason".id;


--
-- Name: Ban_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Ban_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Ban_id_seq" OWNER TO root;

--
-- Name: Ban_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Ban_id_seq" OWNED BY public."Ban".id;


--
-- Name: BotSetting; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."BotSetting" (
    api text,
    types public."ModelType"[],
    "userId" integer NOT NULL
);


ALTER TABLE public."BotSetting" OWNER TO root;

--
-- Name: Coin; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Coin" (
    "productId" text NOT NULL,
    "premiumDays" integer DEFAULT 0 NOT NULL,
    "awardTitle" text NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public."Coin" OWNER TO root;

--
-- Name: CoinRewardItem; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."CoinRewardItem" (
    id text NOT NULL,
    title text NOT NULL,
    quantity integer NOT NULL,
    description text NOT NULL,
    "expiresAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."CoinRewardItem" OWNER TO root;

--
-- Name: Conversation; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Conversation" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastMessageId" integer
);


ALTER TABLE public."Conversation" OWNER TO root;

--
-- Name: ConversationParticipants; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."ConversationParticipants" (
    "userId" integer NOT NULL,
    "conversationId" text NOT NULL,
    "joinedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ConversationParticipants" OWNER TO root;

--
-- Name: Error; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Error" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip text NOT NULL,
    description text,
    "userId" integer
);


ALTER TABLE public."Error" OWNER TO root;

--
-- Name: Error_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Error_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Error_id_seq" OWNER TO root;

--
-- Name: Error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Error_id_seq" OWNED BY public."Error".id;


--
-- Name: ExpoPushToken; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."ExpoPushToken" (
    id integer NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ExpoPushToken" OWNER TO root;

--
-- Name: ExpoPushToken_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."ExpoPushToken_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ExpoPushToken_id_seq" OWNER TO root;

--
-- Name: ExpoPushToken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."ExpoPushToken_id_seq" OWNED BY public."ExpoPushToken".id;


--
-- Name: Factiii; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Factiii" (
    "userId" integer NOT NULL,
    "spaceId" integer,
    "avatarId" text,
    "bannerId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description text,
    id integer NOT NULL,
    requirements public."FactiiiRequirement"[] DEFAULT ARRAY['NONE'::public."FactiiiRequirement"],
    slug text NOT NULL,
    name text NOT NULL,
    status public."FactiiiStatus" DEFAULT 'APPROVED'::public."FactiiiStatus" NOT NULL,
    types public."FactiiiType"[] DEFAULT ARRAY[]::public."FactiiiType"[],
    data text
);


ALTER TABLE public."Factiii" OWNER TO root;

--
-- Name: FactiiiPreferences; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."FactiiiPreferences" (
    "factiiiId" integer NOT NULL,
    "userId" integer NOT NULL,
    "userPreferenceUserId" integer
);


ALTER TABLE public."FactiiiPreferences" OWNER TO root;

--
-- Name: Factiii_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Factiii_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Factiii_id_seq" OWNER TO root;

--
-- Name: Factiii_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Factiii_id_seq" OWNED BY public."Factiii".id;


--
-- Name: Feedback; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Feedback" (
    id text NOT NULL,
    message text,
    "userId" integer NOT NULL,
    "mediaId" text,
    type public."FeedbackType" DEFAULT 'SUGGESTION'::public."FeedbackType" NOT NULL,
    "includeDiagnosticsData" boolean DEFAULT true NOT NULL,
    discarded boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Feedback" OWNER TO root;

--
-- Name: Follows; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Follows" (
    "followerId" integer NOT NULL,
    "followingId" integer NOT NULL
);


ALTER TABLE public."Follows" OWNER TO root;

--
-- Name: History; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."History" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer,
    "spaceId" integer,
    "column" text NOT NULL,
    value text NOT NULL
);


ALTER TABLE public."History" OWNER TO root;

--
-- Name: Item; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Item" (
    id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    "productId" text NOT NULL,
    "orderId" integer NOT NULL,
    price integer NOT NULL
);


ALTER TABLE public."Item" OWNER TO root;

--
-- Name: Item_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Item_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Item_id_seq" OWNER TO root;

--
-- Name: Item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Item_id_seq" OWNED BY public."Item".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    content text NOT NULL,
    "senderId" integer NOT NULL,
    "conversationId" text NOT NULL
);


ALTER TABLE public."Message" OWNER TO root;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Message_id_seq" OWNER TO root;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: Model; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Model" (
    id integer NOT NULL,
    cost bigint NOT NULL,
    query text,
    "maxTokens" integer,
    description text NOT NULL,
    "perTokens" integer NOT NULL,
    active boolean NOT NULL,
    type public."ModelType" NOT NULL
);


ALTER TABLE public."Model" OWNER TO root;

--
-- Name: Model_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Model_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Model_id_seq" OWNER TO root;

--
-- Name: Model_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Model_id_seq" OWNED BY public."Model".id;


--
-- Name: Notification; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Notification" (
    id integer NOT NULL,
    type public."NotificationType" NOT NULL,
    "targetUserId" integer NOT NULL,
    "referenceUserId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    read boolean DEFAULT false NOT NULL,
    "referenceSpaceId" integer,
    "referencePostId" integer
);


ALTER TABLE public."Notification" OWNER TO root;

--
-- Name: Notification_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Notification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Notification_id_seq" OWNER TO root;

--
-- Name: Notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Notification_id_seq" OWNED BY public."Notification".id;


--
-- Name: OTPBasedLogin; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."OTPBasedLogin" (
    id integer NOT NULL,
    code integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    disabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public."OTPBasedLogin" OWNER TO root;

--
-- Name: OTPBasedLogin_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."OTPBasedLogin_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OTPBasedLogin_id_seq" OWNER TO root;

--
-- Name: OTPBasedLogin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."OTPBasedLogin_id_seq" OWNED BY public."OTPBasedLogin".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public."Order" OWNER TO root;

--
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_id_seq" OWNER TO root;

--
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- Name: PasswordReset; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PasswordReset" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    "invalidatedAt" timestamp(3) without time zone
);


ALTER TABLE public."PasswordReset" OWNER TO root;

--
-- Name: Payment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Payment" (
    id text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "paymentIntent" text,
    completed timestamp(3) without time zone,
    refunded timestamp(3) without time zone,
    "orderId" integer NOT NULL,
    "userId" integer NOT NULL,
    type public."PaymentType" NOT NULL,
    "subscriptionId" text
);


ALTER TABLE public."Payment" OWNER TO root;

--
-- Name: Post; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Post" (
    "userId" integer NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."PostStatus" DEFAULT 'PUBLISHED'::public."PostStatus" NOT NULL,
    "trendingRank" double precision DEFAULT 0.0 NOT NULL,
    "voteCount" integer DEFAULT 0 NOT NULL,
    "spaceId" integer,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    id integer NOT NULL,
    "parentPostId" integer,
    "referencePostId" integer
);


ALTER TABLE public."Post" OWNER TO root;

--
-- Name: PostAward; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PostAward" (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    "coinId" text NOT NULL,
    private boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."PostAward" OWNER TO root;

--
-- Name: PostAward_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."PostAward_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostAward_id_seq" OWNER TO root;

--
-- Name: PostAward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."PostAward_id_seq" OWNED BY public."PostAward".id;


--
-- Name: PostEditHistory; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PostEditHistory" (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."PostEditHistory" OWNER TO root;

--
-- Name: PostEditHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."PostEditHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostEditHistory_id_seq" OWNER TO root;

--
-- Name: PostEditHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."PostEditHistory_id_seq" OWNED BY public."PostEditHistory".id;


--
-- Name: PostFactiii; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PostFactiii" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    anonymous boolean DEFAULT false NOT NULL,
    status public."PostFactiiiStatus" DEFAULT 'APPROVED'::public."PostFactiiiStatus" NOT NULL,
    data text,
    "factiiiId" integer NOT NULL,
    "userId" integer NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."PostFactiii" OWNER TO root;

--
-- Name: PostFactiii_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."PostFactiii_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostFactiii_id_seq" OWNER TO root;

--
-- Name: PostFactiii_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."PostFactiii_id_seq" OWNED BY public."PostFactiii".id;


--
-- Name: PostOpenAILanguageSetting; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PostOpenAILanguageSetting" (
    id integer NOT NULL,
    "chosenMaxTokens" integer NOT NULL,
    temperature integer NOT NULL,
    n integer DEFAULT 1 NOT NULL,
    "modelId" integer NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."PostOpenAILanguageSetting" OWNER TO root;

--
-- Name: PostOpenAILanguageSetting_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."PostOpenAILanguageSetting_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostOpenAILanguageSetting_id_seq" OWNER TO root;

--
-- Name: PostOpenAILanguageSetting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."PostOpenAILanguageSetting_id_seq" OWNED BY public."PostOpenAILanguageSetting".id;


--
-- Name: PostUpload; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."PostUpload" (
    id integer NOT NULL,
    "uploadId" text NOT NULL,
    "sharedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."PostUpload" OWNER TO root;

--
-- Name: PostUpload_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."PostUpload_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostUpload_id_seq" OWNER TO root;

--
-- Name: PostUpload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."PostUpload_id_seq" OWNED BY public."PostUpload".id;


--
-- Name: Post_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Post_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Post_id_seq" OWNER TO root;

--
-- Name: Post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Post_id_seq" OWNED BY public."Post".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Product" (
    id text NOT NULL,
    active boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "saleTitle" text NOT NULL,
    price integer NOT NULL,
    type public."ProductType" NOT NULL,
    "appStoreProductId" text,
    "playStoreProductId" text,
    "spaceId" integer,
    "originalDisplayPrice" integer
);


ALTER TABLE public."Product" OWNER TO root;

--
-- Name: ReadMessage; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."ReadMessage" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "messageId" integer NOT NULL,
    "conversationId" text NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public."ReadMessage" OWNER TO root;

--
-- Name: ReadMessage_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."ReadMessage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ReadMessage_id_seq" OWNER TO root;

--
-- Name: ReadMessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."ReadMessage_id_seq" OWNED BY public."ReadMessage".id;


--
-- Name: Report; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Report" (
    id text NOT NULL,
    type public."ReportType" NOT NULL,
    "ruleId" integer NOT NULL,
    comment text,
    status public."ReportStatus" DEFAULT 'PENDING'::public."ReportStatus" NOT NULL,
    "reportedUploadId" text,
    "reportedBio" text,
    "conversationId" text,
    public boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    "actionTakenById" integer,
    "reportedPostId" integer
);


ALTER TABLE public."Report" OWNER TO root;

--
-- Name: Rule; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Rule" (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "spaceId" integer,
    edited boolean DEFAULT false NOT NULL,
    "factiiiId" integer
);


ALTER TABLE public."Rule" OWNER TO root;

--
-- Name: Rule_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Rule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rule_id_seq" OWNER TO root;

--
-- Name: Rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Rule_id_seq" OWNED BY public."Rule".id;


--
-- Name: SavedPost; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SavedPost" (
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."SavedPost" OWNER TO root;

--
-- Name: Session; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Session" (
    id integer NOT NULL,
    "refreshToken" text NOT NULL,
    "issuedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "browserName" text DEFAULT 'Unknown'::text NOT NULL,
    "lastUsed" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    "revokedAt" timestamp(3) without time zone
);


ALTER TABLE public."Session" OWNER TO root;

--
-- Name: Session_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Session_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Session_id_seq" OWNER TO root;

--
-- Name: Session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Session_id_seq" OWNED BY public."Session".id;


--
-- Name: SiteSettings; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SiteSettings" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "coinTronRatio" integer NOT NULL,
    "coinTransferRatio" integer NOT NULL,
    "requestRateLimit" integer NOT NULL,
    "postsPerMinute" integer NOT NULL,
    "maxSpacesPerUser" integer NOT NULL,
    "openAiLimitPerHourPerUser" integer NOT NULL,
    "openAiLimitPremiumUser" integer NOT NULL
);


ALTER TABLE public."SiteSettings" OWNER TO root;

--
-- Name: SiteSettings_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."SiteSettings_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."SiteSettings_id_seq" OWNER TO root;

--
-- Name: SiteSettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."SiteSettings_id_seq" OWNED BY public."SiteSettings".id;


--
-- Name: Space; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Space" (
    id integer NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    description text,
    "avatarId" text,
    "bannerId" text,
    robohash text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status public."SpaceStatus" DEFAULT 'ACTIVE'::public."SpaceStatus" NOT NULL,
    "paidSpaceMonthlyPrice" integer DEFAULT 99 NOT NULL,
    "pinnedPostId" integer,
    types public."SpaceType"[] DEFAULT ARRAY[]::public."SpaceType"[]
);


ALTER TABLE public."Space" OWNER TO root;

--
-- Name: SpaceFilter; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SpaceFilter" (
    "spaceId" integer NOT NULL,
    "userId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."SpaceFilter" OWNER TO root;

--
-- Name: SpaceInvite; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SpaceInvite" (
    "spaceId" integer NOT NULL,
    "userId" integer NOT NULL,
    "inviterId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    joined boolean DEFAULT false NOT NULL
);


ALTER TABLE public."SpaceInvite" OWNER TO root;

--
-- Name: SpaceMember; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SpaceMember" (
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires timestamp(3) without time zone,
    "userId" integer NOT NULL,
    "spaceId" integer NOT NULL,
    "productId" text,
    "subscriptionId" text,
    roles public."SpaceMemberRoles"[] DEFAULT ARRAY['MEMBER'::public."SpaceMemberRoles"]
);


ALTER TABLE public."SpaceMember" OWNER TO root;

--
-- Name: SpaceRuleEditHistory; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SpaceRuleEditHistory" (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    "ruleId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."SpaceRuleEditHistory" OWNER TO root;

--
-- Name: SpaceRuleEditHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."SpaceRuleEditHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."SpaceRuleEditHistory_id_seq" OWNER TO root;

--
-- Name: SpaceRuleEditHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."SpaceRuleEditHistory_id_seq" OWNED BY public."SpaceRuleEditHistory".id;


--
-- Name: SpaceTime; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."SpaceTime" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "timestamp" timestamp(3) without time zone,
    latitude double precision,
    longitude double precision,
    display text,
    altitude integer,
    "postFactiiiId" integer NOT NULL
);


ALTER TABLE public."SpaceTime" OWNER TO root;

--
-- Name: SpaceTime_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."SpaceTime_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."SpaceTime_id_seq" OWNER TO root;

--
-- Name: SpaceTime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."SpaceTime_id_seq" OWNED BY public."SpaceTime".id;


--
-- Name: Space_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."Space_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Space_id_seq" OWNER TO root;

--
-- Name: Space_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."Space_id_seq" OWNED BY public."Space".id;


--
-- Name: Subscription; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Subscription" (
    id text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    "payDayAnchor" integer NOT NULL,
    "nextPayment" timestamp(3) without time zone,
    "productId" text NOT NULL,
    "userId" integer NOT NULL,
    identifier text NOT NULL
);


ALTER TABLE public."Subscription" OWNER TO root;

--
-- Name: Upload; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Upload" (
    id text NOT NULL,
    status public."UploadStatus" DEFAULT 'PUBLISHED'::public."UploadStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    key text NOT NULL,
    type public."UploadType" NOT NULL,
    "productId" text,
    name text,
    size integer
);


ALTER TABLE public."Upload" OWNER TO root;

--
-- Name: User; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    status public."UserStatus" DEFAULT 'ACTIVE'::public."UserStatus" NOT NULL,
    "tronsBalance" bigint DEFAULT 0 NOT NULL,
    "coinsBalance" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    username text NOT NULL,
    name text DEFAULT 'Factiii User'::text NOT NULL,
    bio text,
    "avatarId" text,
    "bannerId" text,
    "twoFaSecret" text,
    "referredById" integer,
    robohash text,
    tag public."UserTag" DEFAULT 'NEW'::public."UserTag" NOT NULL,
    "pinnedPostId" integer,
    types public."UserType"[] DEFAULT ARRAY[]::public."UserType"[]
);


ALTER TABLE public."User" OWNER TO root;

--
-- Name: UserCoinReward; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."UserCoinReward" (
    id text NOT NULL,
    "userId" integer NOT NULL,
    "rewardId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."UserCoinReward" OWNER TO root;

--
-- Name: UserCost; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."UserCost" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" integer NOT NULL,
    usd bigint NOT NULL,
    tokens integer NOT NULL,
    "modelId" integer NOT NULL
);


ALTER TABLE public."UserCost" OWNER TO root;

--
-- Name: UserCost_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."UserCost_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserCost_id_seq" OWNER TO root;

--
-- Name: UserCost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."UserCost_id_seq" OWNED BY public."UserCost".id;


--
-- Name: UserMute; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."UserMute" (
    "muterId" integer NOT NULL,
    "mutedUserId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."UserMute" OWNER TO root;

--
-- Name: UserPreference; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."UserPreference" (
    "userId" integer NOT NULL,
    "awardsVisibilityPrivate" boolean DEFAULT false NOT NULL,
    "allowProfanity" boolean DEFAULT false NOT NULL,
    "betaAccess" boolean DEFAULT false NOT NULL,
    "allowPoliticalContent" boolean DEFAULT false NOT NULL,
    "hidePostsOnProfile" boolean DEFAULT false NOT NULL,
    "hideProfileHistory" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."UserPreference" OWNER TO root;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO root;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: Vote; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."Vote" (
    "userId" integer NOT NULL,
    type public."VoteType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."Vote" OWNER TO root;

--
-- Name: _BanReasonToPost; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."_BanReasonToPost" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_BanReasonToPost" OWNER TO root;

--
-- Name: _ExpoPushTokenToUser; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."_ExpoPushTokenToUser" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ExpoPushTokenToUser" OWNER TO root;

--
-- Name: _ReferencesPostFactiii; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."_ReferencesPostFactiii" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ReferencesPostFactiii" OWNER TO root;

--
-- Name: _blockedUsers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."_blockedUsers" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_blockedUsers" OWNER TO root;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO root;

--
-- Name: Ban id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ban" ALTER COLUMN id SET DEFAULT nextval('public."Ban_id_seq"'::regclass);


--
-- Name: BanReason id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BanReason" ALTER COLUMN id SET DEFAULT nextval('public."BanReason_id_seq"'::regclass);


--
-- Name: Error id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Error" ALTER COLUMN id SET DEFAULT nextval('public."Error_id_seq"'::regclass);


--
-- Name: ExpoPushToken id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ExpoPushToken" ALTER COLUMN id SET DEFAULT nextval('public."ExpoPushToken_id_seq"'::regclass);


--
-- Name: Factiii id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii" ALTER COLUMN id SET DEFAULT nextval('public."Factiii_id_seq"'::regclass);


--
-- Name: Item id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Item" ALTER COLUMN id SET DEFAULT nextval('public."Item_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: Model id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Model" ALTER COLUMN id SET DEFAULT nextval('public."Model_id_seq"'::regclass);


--
-- Name: Notification id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification" ALTER COLUMN id SET DEFAULT nextval('public."Notification_id_seq"'::regclass);


--
-- Name: OTPBasedLogin id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."OTPBasedLogin" ALTER COLUMN id SET DEFAULT nextval('public."OTPBasedLogin_id_seq"'::regclass);


--
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- Name: Post id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post" ALTER COLUMN id SET DEFAULT nextval('public."Post_id_seq"'::regclass);


--
-- Name: PostAward id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostAward" ALTER COLUMN id SET DEFAULT nextval('public."PostAward_id_seq"'::regclass);


--
-- Name: PostEditHistory id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostEditHistory" ALTER COLUMN id SET DEFAULT nextval('public."PostEditHistory_id_seq"'::regclass);


--
-- Name: PostFactiii id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostFactiii" ALTER COLUMN id SET DEFAULT nextval('public."PostFactiii_id_seq"'::regclass);


--
-- Name: PostOpenAILanguageSetting id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostOpenAILanguageSetting" ALTER COLUMN id SET DEFAULT nextval('public."PostOpenAILanguageSetting_id_seq"'::regclass);


--
-- Name: PostUpload id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostUpload" ALTER COLUMN id SET DEFAULT nextval('public."PostUpload_id_seq"'::regclass);


--
-- Name: ReadMessage id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ReadMessage" ALTER COLUMN id SET DEFAULT nextval('public."ReadMessage_id_seq"'::regclass);


--
-- Name: Rule id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Rule" ALTER COLUMN id SET DEFAULT nextval('public."Rule_id_seq"'::regclass);


--
-- Name: Session id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Session" ALTER COLUMN id SET DEFAULT nextval('public."Session_id_seq"'::regclass);


--
-- Name: SiteSettings id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SiteSettings" ALTER COLUMN id SET DEFAULT nextval('public."SiteSettings_id_seq"'::regclass);


--
-- Name: Space id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Space" ALTER COLUMN id SET DEFAULT nextval('public."Space_id_seq"'::regclass);


--
-- Name: SpaceRuleEditHistory id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceRuleEditHistory" ALTER COLUMN id SET DEFAULT nextval('public."SpaceRuleEditHistory_id_seq"'::regclass);


--
-- Name: SpaceTime id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceTime" ALTER COLUMN id SET DEFAULT nextval('public."SpaceTime_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserCost id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCost" ALTER COLUMN id SET DEFAULT nextval('public."UserCost_id_seq"'::regclass);


--
-- Data for Name: Ban; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Ban" (id, "createdAt", "conversationId", public, "userId", "spaceId") FROM stdin;
1	2023-11-27 21:15:25.856	\N	f	7	2
2	2023-11-27 21:15:25.872	\N	f	7	3
3	2023-11-27 21:15:25.882	\N	f	7	4
4	2023-11-27 21:15:25.892	\N	f	7	1
5	2023-11-27 21:15:25.9	\N	f	7	5
6	2023-11-27 21:15:25.909	\N	f	7	6
7	2023-11-27 21:15:25.917	\N	f	7	7
8	2023-11-27 21:15:25.924	\N	f	7	8
9	2023-11-27 21:15:25.933	\N	f	7	9
10	2023-11-27 21:15:25.941	\N	f	7	10
11	2023-11-27 21:15:25.95	\N	f	7	11
12	2023-11-27 21:15:25.96	\N	f	7	12
13	2023-11-27 21:15:25.969	\N	f	7	13
14	2023-11-27 21:15:25.978	\N	f	7	14
15	2023-11-27 21:15:25.992	\N	f	7	15
\.


--
-- Data for Name: BanReason; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."BanReason" (id, "createdAt", "ruleId", "banId") FROM stdin;
\.


--
-- Data for Name: BotSetting; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."BotSetting" (api, types, "userId") FROM stdin;
\N	{OPENAI_LANGUAGE,OPENAI_IMAGE}	5
\.


--
-- Data for Name: Coin; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Coin" ("productId", "premiumDays", "awardTitle", quantity) FROM stdin;
price_1MeotEDS6lFTllE61URh48EH	0	Premium	200
price_1MGu0TDS6lFTllE6BqybwcsE	36500	Lifetime Premium	2000
price_1MMEzsDS6lFTllE6GjjrtD9W	36500	Lifetime Premium	3000
price_1MMF3RDS6lFTllE6cgK0xec7	36500	Lifetime Premium	4000
eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	1	Bronze	10
price_1MGu3qDS6lFTllE6h6YgMmQl	7	Silver	200
price_1MartCDS6lFTllE6fFgyZvxI	31	Gold	1000
price_1MarsIDS6lFTllE6SnBpfVkO	183	Platinum	5000
price_1MLvQ8DS6lFTllE6BCNkQkSh	730	Diamond	25000
\.


--
-- Data for Name: CoinRewardItem; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."CoinRewardItem" (id, title, quantity, description, "expiresAt", "createdAt") FROM stdin;
PUBLISH_10TH_POST	Publish your 10th post	5	You will be rewarded 5 coins when you create your 10th post on Factiii. To claim this, you just have to create 10 posts (including replies). This is only rewarded once.	\N	2023-11-27 21:15:25.528
GET_100_UPVOTES	Get 100 upvotes on a post	100	You will be rewarded 100 coins when one of the post you created on Factiii recieves 100 upvotes. To claim this, once your post must have a total vote count of 100 (upvotes - downvotes). This is only rewarded once.	\N	2023-11-27 21:15:25.528
VERIFY_EMAIL_ADDRESS	Verify your email address	5	You will be rewarded 5 coins when you verify your email address. To claim this, you must verify your registered email via an OTP. This is only rewarded once.	\N	2023-11-27 21:15:25.528
VERIFY_PHONE_NUMBER	Verify your phone number	10	You will be rewarded 10 coins when you verify your phone number. To claim this, you must add your phone number to Factiii and verify it via an OTP. This is only rewarded once.	\N	2023-11-27 21:15:25.528
\.


--
-- Data for Name: Conversation; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Conversation" (id, "createdAt", "lastMessageId") FROM stdin;
\.


--
-- Data for Name: ConversationParticipants; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."ConversationParticipants" ("userId", "conversationId", "joinedAt") FROM stdin;
\.


--
-- Data for Name: Error; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Error" (id, "createdAt", ip, description, "userId") FROM stdin;
\.


--
-- Data for Name: ExpoPushToken; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."ExpoPushToken" (id, token, "createdAt") FROM stdin;
\.


--
-- Data for Name: Factiii; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Factiii" ("userId", "spaceId", "avatarId", "bannerId", "createdAt", description, id, requirements, slug, name, status, types, data) FROM stdin;
2	1	1552dc54-d215-4de1-b5e5-ce8db5254ae8	\N	2023-11-27 21:15:24.988	\N	1	{NONE}	funny	Funny	APPROVED	{}	\N
2	1	b779393b-5f8e-4565-bf91-582b19494a8f	\N	2023-11-27 21:15:24.988	\N	2	{NONE}	informative	Informative	APPROVED	{}	\N
2	1	316c1b08-a15b-44b8-9613-5cf77e231821	\N	2023-11-27 21:15:24.988	\N	3	{NONE}	troll	Troll	APPROVED	{}	\N
2	1	10082c05-96a4-4899-aec3-52508e6e2fab	\N	2023-11-27 21:15:24.988	\N	4	{NONE}	politics	Politics	APPROVED	{}	\N
2	1	8caa1d13-5029-4a24-9c38-a7b63dc51139	\N	2023-11-27 21:15:24.988	\N	5	{NONE}	misleading	Misleading	APPROVED	{}	\N
2	1	64834b13-a66c-484c-b2ca-4d3c69533a7c	\N	2023-11-27 21:15:24.988	\N	6	{NONE}	nsfw	NSFW	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	All posts tagged with this must contain at least 1 picture of items to be sold as well as have the location of the items for sale.	7	{MEDIA_REQUIRED}	for_sale	For Sale	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	All posts tagged with this must contain at least 1 picture of the item being summed. The factiii must contain a summation of the components of the calories found in the food in the picture.	8	{MEDIA_REQUIRED,DATA_REQUIRED}	count_calories	Count Calories	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	All posts tagged with this must contain at least 1 picture or video of a workout.	9	{MEDIA_REQUIRED}	work_out	Work Out	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	All posts tagged with this must contain proof of a run to include distance.	10	{MEDIA_REQUIRED,DATA_REQUIRED}	run	Run	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	\N	11	{LOCATION_REQUIRED,TIME_REQUIRED}	space_time	Space Time	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	\N	12	{LOCATION_REQUIRED}	location	Location	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	\N	13	{TIME_REQUIRED}	date_time	Date Time	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:24.988	\N	14	{DATA_REQUIRED}	data	Data	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:24.988	\N	15	{CONTENT_REQUIRED}	content	Content	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:24.988	\N	16	{WIKI}	wiki	Wiki	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:24.988	\N	17	{NO_POST_DUPLICATES}	no-duplicates	No Duplicates	APPROVED	{}	\N
2	1	\N	\N	2023-11-27 21:15:24.988	\N	18	{BUDGET}	budget	Budget	APPROVED	{}	\N
2	2	\N	\N	2023-11-27 21:15:25.014	This is where you can view all the history factiiis.	19	{DATA_REQUIRED}	history	History	APPROVED	{}	\N
6	1	\N	\N	2023-11-27 21:15:25.298	\N	20	{NONE}	science	Science	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.301	\N	21	{NONE}	ford	Ford	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	22	{NONE}	ford2	Ford 2	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	23	{NONE}	ford3	Ford 3	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	24	{NONE}	ford4	Ford 4	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	25	{NONE}	ford5	Ford 5	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	26	{NONE}	ford6	Ford 6	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	27	{NONE}	ford7	Ford 7	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	28	{NONE}	ford8	Ford 8	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	29	{NONE}	ford9	Ford 9	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	30	{NONE}	ford10	Ford 10	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	31	{NONE}	ford11	Ford 11	APPROVED	{}	\N
6	\N	\N	\N	2023-11-27 21:15:25.304	\N	32	{NONE}	ford12	Ford 12	APPROVED	{}	\N
3	\N	\N	\N	2023-11-27 21:15:25.309	\N	33	{NONE}	technology	Technology	APPROVED	{}	\N
3	\N	\N	\N	2023-11-27 21:15:25.311	\N	34	{NONE}	lonely_topic	Lonely Topic	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:25.313	I'm a human. https://factiii.com/about	35	{HUMAN_SOURCE}	jonathan-snyder	Jonathan Snyder	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:25.315	The Environmental Protection Agency is an independent executive agency of the United States federal government tasked with environmental protection matters. https://www.epa.gov/	36	{GOVERNMENT_SOURCE}	epa	EPA	APPROVED	{}	\N
2	2	\N	\N	2023-11-27 21:15:25.317	This is the unofficial Wikipedia factiii. https://en.wikipedia.org/wiki/Main_Page	37	{ENTERPRISE_SOURCE}	wikipedia	Wikipedia	APPROVED	{}	\N
2	\N	\N	\N	2023-11-27 21:15:25.319	\N	38	{ANONYMOUS_SOURCE}	mr-anonymous	Mr Anonymous	APPROVED	{}	\N
6	15	\N	\N	2023-11-27 21:15:25.42	Private factiii in s/private_Factiii if you see me then something is broken.	39	{NONE}	private-factiii	Private Factiii	APPROVED	{PRIVATE}	\N
6	15	\N	\N	2023-11-27 21:15:25.42	Public factiii in a private space s/private_Factiii.	40	{NONE}	public-factiii	Public Factiii	APPROVED	{}	\N
\.


--
-- Data for Name: FactiiiPreferences; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."FactiiiPreferences" ("factiiiId", "userId", "userPreferenceUserId") FROM stdin;
\.


--
-- Data for Name: Feedback; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Feedback" (id, message, "userId", "mediaId", type, "includeDiagnosticsData", discarded, "createdAt") FROM stdin;
\.


--
-- Data for Name: Follows; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Follows" ("followerId", "followingId") FROM stdin;
12	2
12	3
2	13
3	13
14	21
14	15
14	22
14	18
14	17
14	19
14	16
14	20
15	18
15	19
15	20
15	14
16	21
16	19
16	20
16	18
17	21
17	16
17	18
17	22
17	23
17	15
17	14
17	19
17	20
18	16
18	23
18	19
18	17
18	21
18	15
18	22
18	20
19	18
19	17
19	22
19	21
19	20
19	15
19	16
19	23
19	14
20	15
20	21
20	16
20	17
21	23
22	14
22	23
22	15
22	20
22	17
22	21
22	16
22	19
22	18
23	14
23	17
23	21
23	16
23	18
23	19
23	20
23	15
23	22
\.


--
-- Data for Name: History; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."History" (id, "createdAt", "userId", "spaceId", "column", value) FROM stdin;
\.


--
-- Data for Name: Item; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Item" (id, quantity, discount, "productId", "orderId", price) FROM stdin;
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Message" (id, "createdAt", content, "senderId", "conversationId") FROM stdin;
\.


--
-- Data for Name: Model; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Model" (id, cost, query, "maxTokens", description, "perTokens", active, type) FROM stdin;
1	20000	davinci	4000	OpenAI's best AI.	1000	t	OPENAI_LANGUAGE
2	2000	curie	1000	OpenAI's 2nd best AI.	1000	t	OPENAI_LANGUAGE
3	500	babbage	1000	OpenAI's 2nd cheapest AI.	1000	t	OPENAI_LANGUAGE
4	400	ada	1000	OpenAI's cheapest AI.	1000	t	OPENAI_LANGUAGE
5	20000	1024x1024	1000	OpenAI's best image.	1000	t	OPENAI_IMAGE
6	18000	512x512	1000	OpenAI's medium size image.	1000	t	OPENAI_IMAGE
7	16000	256x256	1000	OpenAI's cheapest image.	1000	t	OPENAI_IMAGE
8	400	\N	\N	OpenAI EMBEDDING_ADA	1000	t	OPENAI_EMBEDDING
9	30000	\N	\N	OpenAI FINE_TUNED_DAVINCI	1000	t	OPENAI_FINE_TUNED
10	3000	\N	\N	OpenAI FINE_TUNED_CURIE	1000	t	OPENAI_FINE_TUNED
11	600	\N	\N	OpenAI FINE_TUNED_BABBAGE	1000	t	OPENAI_FINE_TUNED
12	400	\N	\N	OpenAI FINE_TUNED_ADA	1000	t	OPENAI_FINE_TUNED
\.


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Notification" (id, type, "targetUserId", "referenceUserId", "createdAt", read, "referenceSpaceId", "referencePostId") FROM stdin;
\.


--
-- Data for Name: OTPBasedLogin; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."OTPBasedLogin" (id, code, "userId", "createdAt", disabled) FROM stdin;
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Order" (id, "createdAt", "userId") FROM stdin;
\.


--
-- Data for Name: PasswordReset; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PasswordReset" (id, "createdAt", "userId", "invalidatedAt") FROM stdin;
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Payment" (id, "createdAt", "paymentIntent", completed, refunded, "orderId", "userId", type, "subscriptionId") FROM stdin;
\.


--
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Post" ("userId", content, "createdAt", status, "trendingRank", "voteCount", "spaceId", uuid, id, "parentPostId", "referencePostId") FROM stdin;
2	This is a post about history.	2023-11-27 21:15:25.017	PUBLISHED	0	0	\N	c365fe3d-5864-4c95-9ea3-8b66e1bbf16b	1	\N	\N
2	Post with factiiis science and politics	2023-11-27 21:15:25.322	PUBLISHED	0	0	\N	b87effd7-e13b-4c06-8765-3d377c9e115d	2	\N	\N
2	Post with factiiis science and history	2023-11-27 21:15:25.327	PUBLISHED	0	0	\N	6445be10-9f73-4491-86e3-ce8ee46179bd	3	\N	\N
2	Post with factiiis science and ford	2023-11-27 21:15:25.334	PUBLISHED	0	0	\N	508e458e-a7d8-4d3e-bafc-804f58fab8f9	4	\N	\N
2	Post with factiiis science and technology	2023-11-27 21:15:25.34	PUBLISHED	0	0	\N	98a3ce50-7107-49bc-8b9f-ff0c958406a2	5	\N	\N
2	Post with factiii lonely	2023-11-27 21:15:25.345	PUBLISHED	0	0	\N	71fed23e-9183-4569-9ed3-61f74c39d910	6	\N	\N
6	haha you all are foolish loser robot people!	2023-11-27 21:15:25.35	PUBLISHED	0	0	\N	0209f060-1df9-4857-98b9-2920754b36ba	7	\N	\N
6	removed post if you see this then it was not removed	2023-11-27 21:15:25.386	PUBLISHED	0	0	\N	ead50822-1c68-49da-8c6b-c7aba93b2104	8	\N	\N
2	private paid space post in s/paid	2023-11-27 21:15:25.401	PUBLISHED	0	0	13	e3fd138e-2e61-41cf-a807-e1ee4d7010c0	9	\N	\N
6	Private post in s/private if you see me then something is broken.	2023-11-27 21:15:25.416	PUBLISHED	0	0	14	558c7e56-96f0-4764-a795-12aa17229c84	10	\N	\N
6	Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.	2023-11-27 21:15:25.43	PUBLISHED	0	0	15	832041ce-3b14-4715-9484-c212470984bd	11	\N	\N
6	Public post in s/factiii with a private and public factiii attached.	2023-11-27 21:15:25.436	PUBLISHED	0	0	1	693a5efe-2c7f-4795-b0b8-31cf20c56449	12	\N	\N
6	Hi All! Post with 6 images and 15 awards!	2023-11-27 21:15:25.465	PUBLISHED	0	0	\N	0e406f31-c146-4bda-9a0a-4a4abfba997d	13	\N	\N
6	Post with 1920x1080 image.	2023-11-27 21:15:25.496	PUBLISHED	0	0	\N	472825f4-4def-402e-8ccc-afe013f28bbb	14	\N	\N
6	Post with very wide short image.	2023-11-27 21:15:25.501	PUBLISHED	0	0	\N	370e07c4-ad3d-43a6-aa07-355a428873dc	15	\N	\N
6	Post with very tall thin image.	2023-11-27 21:15:25.506	PUBLISHED	0	0	\N	0db33c6d-6775-4b0c-8ded-ec4397aeb5a2	16	\N	\N
6	This is a fun video.\n\nVideo by KoolShooters: https://www.pexels.com/video/a-young-an-squeezing-an-orange-6975806	2023-11-27 21:15:25.511	PUBLISHED	0	0	\N	24d38113-1c83-45ba-a877-49e87910e3c0	17	\N	\N
6	Very fucking NSFW post by @janice78 .	2023-11-27 21:15:25.515	PUBLISHED	0	0	\N	c7a0bc97-661d-43a2-930e-8af7ccafbc8b	18	\N	\N
4	Post 0	2013-11-29 21:15:25.54	PUBLISHED	-5671899.432444445	0	2	ac994156-008b-4688-8b5d-86e18ade12d2	19	\N	\N
4	Post 1	2013-11-29 21:15:26.543	PUBLISHED	-5671899.410155555	0	2	931db83a-c749-47e9-9a0e-6c40cc23e158	20	\N	\N
4	Post 2	2013-11-29 21:15:27.546	PUBLISHED	-5671899.387866667	0	2	1727914c-7788-4e77-8b47-b58e598ad79c	21	\N	\N
4	Post 3	2013-11-29 21:15:28.548	PUBLISHED	-5671899.3656	0	2	1124fc2f-2905-43de-bdb5-bfe7e64525f6	22	\N	\N
4	Post 4	2013-11-29 21:15:29.55	PUBLISHED	-5671899.343333334	0	2	86c60692-ad0e-4b33-8fa5-e3848979542b	23	\N	\N
4	Post 5	2013-11-29 21:15:30.553	PUBLISHED	-5671899.321044444	0	2	8ad2eb2a-08c1-431e-b8ab-25a11d7070be	24	\N	\N
4	Post 6	2013-11-29 21:15:31.555	PUBLISHED	-5671899.298777778	0	2	16621ea5-43c7-464e-88d4-88152c13a782	25	\N	\N
4	Post 7	2013-11-29 21:15:32.557	PUBLISHED	-5671899.276511111	0	2	be7fb6c7-ec35-4bf0-b7bb-dd372f35be06	26	\N	\N
4	Post 8	2013-11-29 21:15:33.56	PUBLISHED	-5671899.254222223	0	2	6370cacf-c49e-47f4-8e17-49296f5104aa	27	\N	\N
4	Post 9	2013-11-29 21:15:34.563	PUBLISHED	-5671899.231933333	0	2	c9ccfb4a-daf0-4b2e-8fe8-e063f93bc827	28	\N	\N
4	Post 10	2013-11-29 21:15:35.566	PUBLISHED	-5671899.209644444	0	2	42c0a218-33be-478d-ac3f-6d021bb4c31e	29	\N	\N
4	Post 11	2013-11-29 21:15:36.569	PUBLISHED	-5671899.187355556	0	2	978de116-1750-42a9-8c7d-f54f0985eb07	30	\N	\N
4	Post 12	2013-11-29 21:15:37.571	PUBLISHED	-5671899.165088889	0	2	9bc132c7-f960-4c05-8f54-2bedb39c8051	31	\N	\N
4	Post 13	2013-11-29 21:15:38.573	PUBLISHED	-5671899.142822222	0	2	4f1b1114-4d15-41c0-a097-7835859f922c	32	\N	\N
4	Post 14	2013-11-29 21:15:39.575	PUBLISHED	-5671899.120555555	0	2	ade33655-faaf-4689-82f1-be366eee615d	33	\N	\N
4	Post 15	2013-11-29 21:15:40.578	PUBLISHED	-5671899.098266667	0	2	8497d0e9-9374-4bbf-9c0a-fef4caaa3bd2	34	\N	\N
4	Post 16	2013-11-29 21:15:41.58	PUBLISHED	-5671899.076	0	2	1871718f-974e-4cc7-98d7-729d07278b0f	35	\N	\N
4	Post 17	2013-11-29 21:15:42.582	PUBLISHED	-5671899.053733333	0	2	100c699d-07ad-4240-9c26-bd3057b6709e	36	\N	\N
4	Post 18	2013-11-29 21:15:43.584	PUBLISHED	-5671899.031466667	0	2	70e5812a-9dd4-4dfb-9fba-e71b17518d60	37	\N	\N
4	Post 19	2013-11-29 21:15:44.586	PUBLISHED	-5671899.0092	0	2	d958e75e-ae60-40d1-bca1-69e3a51ba326	38	\N	\N
4	Post 20	2013-11-29 21:15:45.588	PUBLISHED	-5671898.986933333	0	2	277c3ac0-fe8a-4faf-8060-0ea383b59b15	39	\N	\N
4	Post 21	2013-11-29 21:15:46.59	PUBLISHED	-5671898.964666666	0	2	eea43211-ebc7-407f-a265-1f4d743027ec	40	\N	\N
4	Post 22	2013-11-29 21:15:47.592	PUBLISHED	-5671898.9424	0	2	10ff6f50-b51d-4455-9208-cac7f066c7d8	41	\N	\N
4	Post 23	2013-11-29 21:15:48.595	PUBLISHED	-5671898.920111111	0	2	7b6c85e2-5a14-4564-a74b-45f7385710b8	42	\N	\N
4	Post 24	2013-11-29 21:15:49.597	PUBLISHED	-5671898.897844444	0	2	b071ebb6-e305-4efa-8037-7af22cbd7790	43	\N	\N
4	Post 25	2013-11-29 21:15:50.601	PUBLISHED	-5671898.875533333	0	2	f7774a6d-ec09-4c11-8a97-e1c0b8ae0518	44	\N	\N
4	Post 26	2013-11-29 21:15:51.603	PUBLISHED	-5671898.853266667	0	2	698c96aa-e548-4626-95e5-8ca33d41d66d	45	\N	\N
4	Post 27	2013-11-29 21:15:52.605	PUBLISHED	-5671898.831	0	2	0bcd8a98-2b1a-4b8b-bd2c-ed7cd38d4fb9	46	\N	\N
4	Post 28	2013-11-29 21:15:53.607	PUBLISHED	-5671898.808733333	0	2	0ec351ba-0392-4519-850f-f7da613e60c9	47	\N	\N
4	Post 29	2013-11-29 21:15:54.608	PUBLISHED	-5671898.786488889	0	2	2293bbaa-f5c5-4b97-abc9-67d6ea00d450	48	\N	\N
4	Post 30	2013-11-29 21:15:55.611	PUBLISHED	-5671898.7642	0	2	6c880013-adf5-457c-965d-883f900d0c12	49	\N	\N
4	Post 31	2013-11-29 21:15:56.613	PUBLISHED	-5671898.741933334	0	2	5564f6ab-9d59-4fb8-bdd4-97817b49afbf	50	\N	\N
4	Post 32	2013-11-29 21:15:57.615	PUBLISHED	-5671898.719666666	0	2	4fcdc039-3f42-4145-8a00-af44c412efd3	51	\N	\N
4	Post 33	2013-11-29 21:15:58.618	PUBLISHED	-5671898.697377778	0	2	5342eb38-08d9-41f4-b9f5-185502c36a27	52	\N	\N
4	Post 34	2013-11-29 21:15:59.621	PUBLISHED	-5671898.675088889	0	2	f01bbc85-e1b0-4458-9bc9-dee1a69cec85	53	\N	\N
4	Post 35	2013-11-29 21:16:00.624	PUBLISHED	-5671898.6528	0	2	5f1850ae-01b9-4d66-941c-502cac1bdd7e	54	\N	\N
4	Post 36	2013-11-29 21:16:01.627	PUBLISHED	-5671898.630511111	0	2	16dbef72-42eb-4803-845a-f51aaad5b5ce	55	\N	\N
4	Post 37	2013-11-29 21:16:02.629	PUBLISHED	-5671898.608244444	0	2	36629c4e-3681-4289-be3a-782ced900d50	56	\N	\N
4	Post 38	2013-11-29 21:16:03.632	PUBLISHED	-5671898.585955556	0	2	cadb5cbf-ace7-4681-a568-5e7e19d39cb5	57	\N	\N
4	Post 39	2013-11-29 21:16:04.634	PUBLISHED	-5671898.563688889	0	2	37e72c63-3ab8-4a59-8796-91edee3ddc39	58	\N	\N
4	Post 40	2013-11-29 21:16:05.637	PUBLISHED	-5671898.5414	0	2	ac142139-8305-4ad3-bdc2-3ae321805965	59	\N	\N
4	Post 41	2013-11-29 21:16:06.639	PUBLISHED	-5671898.519133333	0	2	e1bed761-f2b8-4d2b-9188-4d4cc990df61	60	\N	\N
4	Post 42	2013-11-29 21:16:07.641	PUBLISHED	-5671898.496866667	0	2	a096df13-c8a2-4d9d-b5a3-c47d1c52fa9a	61	\N	\N
4	Post 43	2013-11-29 21:16:08.643	PUBLISHED	-5671898.4746	0	2	5ce47520-1adf-465b-a025-4a54fc830699	62	\N	\N
4	Post 44	2013-11-29 21:16:09.645	PUBLISHED	-5671898.452333333	0	2	8b431c93-4e7d-44ae-9649-784a792fec81	63	\N	\N
4	Post 45	2013-11-29 21:16:10.647	PUBLISHED	-5671898.430066667	0	2	e523a24c-bb4b-44ef-aab8-5a0a96d55f9c	64	\N	\N
4	Post 46	2013-11-29 21:16:11.649	PUBLISHED	-5671898.4078	0	2	1d4e9edf-7eee-405b-bef8-a48d86e8abc3	65	\N	\N
4	Post 47	2013-11-29 21:16:12.651	PUBLISHED	-5671898.385533334	0	2	abc2ad5f-51a6-459e-9d91-3bf5675173ac	66	\N	\N
4	Post 48	2013-11-29 21:16:13.653	PUBLISHED	-5671898.363266666	0	2	14bdb60a-3b00-40fd-a6c9-0101c1aed32a	67	\N	\N
4	Post 49	2013-11-29 21:16:14.655	PUBLISHED	-5671898.341	0	2	6907265f-4adb-4423-ad7f-1003f804cac8	68	\N	\N
4	Post 50	2013-11-29 21:16:15.657	PUBLISHED	-5671898.318733334	0	2	83db2892-44cf-4cb1-8864-634e51ef6f5e	69	\N	\N
4	Post 51	2013-11-29 21:16:16.66	PUBLISHED	-5671898.296444444	0	2	aaf5faee-b9b0-41e8-9960-4dbe089c8117	70	\N	\N
4	Post 52	2013-11-29 21:16:17.666	PUBLISHED	-5671898.274088888	0	2	757236a6-2e04-43f9-b84c-0b52f25127de	71	\N	\N
4	Post 53	2013-11-29 21:16:18.669	PUBLISHED	-5671898.2518	0	2	ec347110-89ed-4942-b661-5fd898e1b616	72	\N	\N
4	Post 54	2013-11-29 21:16:19.671	PUBLISHED	-5671898.229533333	0	2	842a98ee-1ed7-45a4-85c2-a438092b2ccc	73	\N	\N
7	banned post in space: Wikipedia	2012-11-29 21:15:25.863	PUBLISHED	-6372699.425266666	0	2	a18fb18b-eb22-436b-a44b-e4ea23a9636a	74	\N	\N
8	muted post in space: Wikipedia	2012-11-29 21:15:25.863	PUBLISHED	-6372699.425266666	0	2	37e688e1-d603-4394-bdbc-0a8155447fb6	75	\N	\N
10	I blocked you post in space: Wikipedia	2012-11-29 21:15:25.863	PUBLISHED	-6372699.425266666	0	2	ebbe7137-551d-49c0-b088-c4ff00cfa525	76	\N	\N
7	banned post in space: founders	2012-11-29 21:15:25.874	PUBLISHED	-6372699.425022222	0	3	6e1332c8-a515-412e-9c0c-86c0ddf07371	77	\N	\N
8	muted post in space: founders	2012-11-29 21:15:25.874	PUBLISHED	-6372699.425022222	0	3	0e2a5c4a-59f9-4679-b4e9-00c2dcaf1973	78	\N	\N
10	I blocked you post in space: founders	2012-11-29 21:15:25.874	PUBLISHED	-6372699.425022222	0	3	990629aa-c66f-42f1-a422-7da334ffa7f0	79	\N	\N
7	banned post in space: premium	2012-11-29 21:15:25.883	PUBLISHED	-6372699.424822222	0	4	e2a36003-95e5-440b-807f-66c5eef4ad26	80	\N	\N
8	muted post in space: premium	2012-11-29 21:15:25.883	PUBLISHED	-6372699.424822222	0	4	57956581-318e-40b3-81f1-e54f9e1bc656	81	\N	\N
10	I blocked you post in space: premium	2012-11-29 21:15:25.883	PUBLISHED	-6372699.424822222	0	4	a0ac3907-b150-4e81-82e9-f0ba820a9648	82	\N	\N
7	banned post in space: factiii	2012-11-29 21:15:25.893	PUBLISHED	-6372699.4246	0	1	44f80711-0795-4fb4-beb4-9a12f2831f27	83	\N	\N
8	muted post in space: factiii	2012-11-29 21:15:25.893	PUBLISHED	-6372699.4246	0	1	c3911dc0-26dd-465a-974f-ed6523f87e6e	84	\N	\N
10	I blocked you post in space: factiii	2012-11-29 21:15:25.893	PUBLISHED	-6372699.4246	0	1	27dc3488-288f-47fa-95ab-14428378fbff	85	\N	\N
7	banned post in space: about	2012-11-29 21:15:25.901	PUBLISHED	-6372699.424422222	0	5	56e4141f-b0ab-45cd-97b4-b8a972760574	86	\N	\N
8	muted post in space: about	2012-11-29 21:15:25.901	PUBLISHED	-6372699.424422222	0	5	25c6ba30-bbe0-4aa0-81d3-78115879792d	87	\N	\N
10	I blocked you post in space: about	2012-11-29 21:15:25.901	PUBLISHED	-6372699.424422222	0	5	4d96c04d-1815-437e-929c-6ad0e7561746	88	\N	\N
7	banned post in space: science	2012-11-29 21:15:25.91	PUBLISHED	-6372699.424222223	0	6	b4d628e1-4487-43a4-80bc-b0d7f4568899	89	\N	\N
8	muted post in space: science	2012-11-29 21:15:25.91	PUBLISHED	-6372699.424222223	0	6	98a566e6-6b8f-4704-972e-16618f844e46	90	\N	\N
10	I blocked you post in space: science	2012-11-29 21:15:25.91	PUBLISHED	-6372699.424222223	0	6	29d80941-118d-4591-a201-491c232835db	91	\N	\N
7	banned post in space: history	2012-11-29 21:15:25.918	PUBLISHED	-6372699.424044444	0	7	2ff8921a-cc8d-46e9-837f-6e50db31ab40	92	\N	\N
8	muted post in space: history	2012-11-29 21:15:25.918	PUBLISHED	-6372699.424044444	0	7	ed676302-3199-4b20-81cd-6133e1ae32e9	93	\N	\N
10	I blocked you post in space: history	2012-11-29 21:15:25.918	PUBLISHED	-6372699.424044444	0	7	e3a20edf-37ce-44e8-9177-54061360e39d	94	\N	\N
7	banned post in space: pics	2012-11-29 21:15:25.925	PUBLISHED	-6372699.423888889	0	8	4a6a85f5-c44d-4c96-b6ca-7e0bc4cf27f7	95	\N	\N
8	muted post in space: pics	2012-11-29 21:15:25.925	PUBLISHED	-6372699.423888889	0	8	d84552bb-024f-4cd3-aef9-c50be9181a81	96	\N	\N
10	I blocked you post in space: pics	2012-11-29 21:15:25.925	PUBLISHED	-6372699.423888889	0	8	6747cecc-a482-453e-8266-a53d08f9b11c	97	\N	\N
7	banned post in space: videos	2012-11-29 21:15:25.934	PUBLISHED	-6372699.423688889	0	9	c2534a51-e438-445c-9214-fbafcf04b276	98	\N	\N
8	muted post in space: videos	2012-11-29 21:15:25.934	PUBLISHED	-6372699.423688889	0	9	4d5f608f-e6fa-484c-b7d6-de538df207d5	99	\N	\N
10	I blocked you post in space: videos	2012-11-29 21:15:25.934	PUBLISHED	-6372699.423688889	0	9	9cf60630-151e-4532-8002-4081412cfedc	100	\N	\N
7	banned post in space: news	2012-11-29 21:15:25.942	PUBLISHED	-6372699.423511111	0	10	dd661395-072b-4b6c-b4cf-c063d452b103	101	\N	\N
8	muted post in space: news	2012-11-29 21:15:25.942	PUBLISHED	-6372699.423511111	0	10	daecf810-e9d5-48a8-80bc-0627e418ce65	102	\N	\N
10	I blocked you post in space: news	2012-11-29 21:15:25.942	PUBLISHED	-6372699.423511111	0	10	5f9a9f2d-4170-4ec9-b46a-71a915de3a9c	103	\N	\N
7	banned post in space: announcements	2012-11-29 21:15:25.951	PUBLISHED	-6372699.423311112	0	11	c1a8c171-6966-4c0e-bd25-c126249ab231	104	\N	\N
8	muted post in space: announcements	2012-11-29 21:15:25.951	PUBLISHED	-6372699.423311112	0	11	f4ad5493-d03a-4372-829e-9f6244ad012e	105	\N	\N
10	I blocked you post in space: announcements	2012-11-29 21:15:25.951	PUBLISHED	-6372699.423311112	0	11	5b93fc06-1b45-4f51-9119-712cbd43e777	106	\N	\N
7	banned post in space: OpenAI	2012-11-29 21:15:25.961	PUBLISHED	-6372699.423088889	0	12	f31ba016-65d8-440b-adb7-7230859c7278	107	\N	\N
8	muted post in space: OpenAI	2012-11-29 21:15:25.961	PUBLISHED	-6372699.423088889	0	12	a22e7c3c-4944-4523-84bc-9187d49d1e21	108	\N	\N
10	I blocked you post in space: OpenAI	2012-11-29 21:15:25.961	PUBLISHED	-6372699.423088889	0	12	f38cb78f-fbc7-4d31-ac10-db45fe88e86b	109	\N	\N
7	banned post in space: paid	2012-11-29 21:15:25.97	PUBLISHED	-6372699.422888889	0	13	26577717-6980-4e78-a244-a6c627f4c138	110	\N	\N
8	muted post in space: paid	2012-11-29 21:15:25.97	PUBLISHED	-6372699.422888889	0	13	b657cdc7-247a-4ee2-b3de-a3b4a0dbbde5	111	\N	\N
10	I blocked you post in space: paid	2012-11-29 21:15:25.97	PUBLISHED	-6372699.422888889	0	13	cfb8d3f6-6540-4234-a8ea-df5c371ab3f4	112	\N	\N
7	banned post in space: Private Test	2012-11-29 21:15:25.979	PUBLISHED	-6372699.422688889	0	14	857f7fb9-773b-4332-8840-f095a3e677f5	113	\N	\N
8	muted post in space: Private Test	2012-11-29 21:15:25.979	PUBLISHED	-6372699.422688889	0	14	568b81b8-0cec-4f45-896f-0f5137d6f572	114	\N	\N
10	I blocked you post in space: Private Test	2012-11-29 21:15:25.979	PUBLISHED	-6372699.422688889	0	14	2ec0d5f9-13a5-4f4e-8393-9b75c910d74d	115	\N	\N
7	banned post in space: Private Factiii	2012-11-29 21:15:25.993	PUBLISHED	-6372699.422377778	0	15	01e7b278-ea86-4eac-85cc-6f2c6297542c	116	\N	\N
8	muted post in space: Private Factiii	2012-11-29 21:15:25.993	PUBLISHED	-6372699.422377778	0	15	190e7da3-b186-4ab4-9969-e8f7be074d0b	117	\N	\N
10	I blocked you post in space: Private Factiii	2012-11-29 21:15:25.993	PUBLISHED	-6372699.422377778	0	15	47940fc7-96c5-482b-98df-f161dbe19b6a	118	\N	\N
7	banned reply to post	2011-11-30 21:15:26.002	PUBLISHED	-7073499.422177778	0	\N	e6cadf5f-296f-48ec-99a2-ede7cad7be48	119	1	\N
8	muted reply to post	2011-11-30 21:15:26.002	PUBLISHED	-7073499.422177778	0	\N	b185ceb1-6431-407f-b7fa-3e46d45211d7	120	1	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.002	PUBLISHED	-7073499.422177778	0	\N	7fa6ac30-e3d9-4dcb-9636-26d789e4f4ae	121	1	\N
7	banned reply to post	2011-11-30 21:15:26.01	PUBLISHED	-7073499.422	0	\N	2bcfac90-5c6f-4003-9f59-fe3a5984c914	122	2	\N
8	muted reply to post	2011-11-30 21:15:26.01	PUBLISHED	-7073499.422	0	\N	b18fde5c-b384-44ac-b3c4-645e3ee7bdf5	123	2	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.01	PUBLISHED	-7073499.422	0	\N	c21264ac-01fc-43c4-9866-f897cf6a6925	124	2	\N
7	banned reply to post	2011-11-30 21:15:26.017	PUBLISHED	-7073499.421844444	0	\N	4e0d3f0c-78e4-4b62-86c4-4fbf0f503960	125	3	\N
8	muted reply to post	2011-11-30 21:15:26.017	PUBLISHED	-7073499.421844444	0	\N	fd452be2-c9da-499d-9fda-47bf3ac9cfb5	126	3	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.017	PUBLISHED	-7073499.421844444	0	\N	43c9ed51-df07-4ba9-8586-c016c34cc9ce	127	3	\N
7	banned reply to post	2011-11-30 21:15:26.024	PUBLISHED	-7073499.421688889	0	\N	f1b52586-216c-4d76-9965-f6125129d2ee	128	4	\N
8	muted reply to post	2011-11-30 21:15:26.024	PUBLISHED	-7073499.421688889	0	\N	d63b5bf1-0630-4687-899d-1dae730d8831	129	4	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.024	PUBLISHED	-7073499.421688889	0	\N	a4b851a1-ab36-46b5-b495-14e888052e6f	130	4	\N
7	banned reply to post	2011-11-30 21:15:26.031	PUBLISHED	-7073499.421533333	0	\N	07d71985-03f5-4810-a155-0ab2d2f78043	131	5	\N
8	muted reply to post	2011-11-30 21:15:26.031	PUBLISHED	-7073499.421533333	0	\N	aba61c10-d350-4275-b960-8466dd5580c6	132	5	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.031	PUBLISHED	-7073499.421533333	0	\N	2dcef9a4-9aba-4876-9370-5969e74fa10f	133	5	\N
7	banned reply to post	2011-11-30 21:15:26.038	PUBLISHED	-7073499.421377778	0	\N	60b4be4f-61a0-4591-a117-4edaecad9c4f	134	6	\N
8	muted reply to post	2011-11-30 21:15:26.038	PUBLISHED	-7073499.421377778	0	\N	4b553c43-0a7f-4352-bb6f-5849d04f2e5d	135	6	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.038	PUBLISHED	-7073499.421377778	0	\N	5ee1988e-875b-4fb2-9c34-96fd9acd4399	136	6	\N
7	banned reply to post	2011-11-30 21:15:26.044	PUBLISHED	-7073499.421244444	0	\N	9108989f-d4ea-4389-85f8-9f2e77c2dd94	137	7	\N
8	muted reply to post	2011-11-30 21:15:26.044	PUBLISHED	-7073499.421244444	0	\N	2d7742bf-5509-40bb-b8c8-fd7835b43f7b	138	7	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.044	PUBLISHED	-7073499.421244444	0	\N	d1d1d212-3826-4382-9538-ace847b83b03	139	7	\N
7	banned reply to post	2011-11-30 21:15:26.051	PUBLISHED	-7073499.421088889	0	\N	5a867654-ac57-41a3-9d6e-1caa83e27232	140	8	\N
8	muted reply to post	2011-11-30 21:15:26.051	PUBLISHED	-7073499.421088889	0	\N	f83d413e-53f7-4420-9718-4129a7d745ed	141	8	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.051	PUBLISHED	-7073499.421088889	0	\N	99f76536-8f52-4bd3-9187-151d28009614	142	8	\N
7	banned reply to post	2011-11-30 21:15:26.058	PUBLISHED	-7073499.420933333	0	\N	2c39d792-69dd-4efc-9291-050451b1db45	143	9	\N
8	muted reply to post	2011-11-30 21:15:26.058	PUBLISHED	-7073499.420933333	0	\N	ced1a43e-1ee0-4abe-8d95-1ea00d016f8a	144	9	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.058	PUBLISHED	-7073499.420933333	0	\N	1676c3b2-a155-4930-8b35-4fbf75d8b4fa	145	9	\N
7	banned reply to post	2011-11-30 21:15:26.064	PUBLISHED	-7073499.4208	0	\N	a3f633cc-2aba-4faa-9050-dd5da497f595	146	10	\N
8	muted reply to post	2011-11-30 21:15:26.064	PUBLISHED	-7073499.4208	0	\N	881099db-1a0a-43a2-89bb-f78b75971768	147	10	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.064	PUBLISHED	-7073499.4208	0	\N	f16e9e1e-4401-4624-a2b2-4e6c6e418dc4	148	10	\N
7	banned reply to post	2011-11-30 21:15:26.071	PUBLISHED	-7073499.420644444	0	\N	342d2761-1005-4a03-a34c-b86f1c311249	149	11	\N
8	muted reply to post	2011-11-30 21:15:26.071	PUBLISHED	-7073499.420644444	0	\N	e235787a-b6c9-4375-b1db-f16329519546	150	11	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.071	PUBLISHED	-7073499.420644444	0	\N	0e564040-79d7-4415-b214-3ff3da1959ef	151	11	\N
7	banned reply to post	2011-11-30 21:15:26.077	PUBLISHED	-7073499.420511111	0	\N	a6e6878f-4a8a-43e0-b915-5c890a66b18f	152	12	\N
8	muted reply to post	2011-11-30 21:15:26.077	PUBLISHED	-7073499.420511111	0	\N	7c43961d-a1fd-4283-b241-087a9b50f786	153	12	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.077	PUBLISHED	-7073499.420511111	0	\N	a24f48d7-186c-40e7-aa1d-0525ff791e3a	154	12	\N
7	banned reply to post	2011-11-30 21:15:26.083	PUBLISHED	-7073499.420377778	0	\N	918c425a-5082-4013-9b9a-cd8b4440c03e	155	13	\N
8	muted reply to post	2011-11-30 21:15:26.083	PUBLISHED	-7073499.420377778	0	\N	42415ac0-ef05-4ebe-a880-94bf4fb91598	156	13	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.083	PUBLISHED	-7073499.420377778	0	\N	535cbf58-606a-4f94-a805-2a6abcd93645	157	13	\N
7	banned reply to post	2011-11-30 21:15:26.089	PUBLISHED	-7073499.420244444	0	\N	53017b3d-0b7c-41a3-96a6-9d531e0a0835	158	14	\N
8	muted reply to post	2011-11-30 21:15:26.089	PUBLISHED	-7073499.420244444	0	\N	96a63cf0-ad60-43ff-9f05-d487ff56c656	159	14	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.089	PUBLISHED	-7073499.420244444	0	\N	5bf7cfa7-0bd7-4845-8d3f-06dd430b27aa	160	14	\N
7	banned reply to post	2011-11-30 21:15:26.096	PUBLISHED	-7073499.420088889	0	\N	1e17e9ed-fe8d-4947-ae1f-d9d065b41ca2	161	15	\N
8	muted reply to post	2011-11-30 21:15:26.096	PUBLISHED	-7073499.420088889	0	\N	2e82a968-12a6-44f9-9262-4833d7821a1e	162	15	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.096	PUBLISHED	-7073499.420088889	0	\N	021dbff7-6f23-402b-ac0a-ebfcf64aa8fa	163	15	\N
7	banned reply to post	2011-11-30 21:15:26.102	PUBLISHED	-7073499.419955555	0	\N	0e756d27-2d67-449c-9444-06e560c0f3c6	164	16	\N
8	muted reply to post	2011-11-30 21:15:26.102	PUBLISHED	-7073499.419955555	0	\N	cb6eb014-cc99-4f94-be79-d2085b5863af	165	16	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.102	PUBLISHED	-7073499.419955555	0	\N	3945bfb5-f707-45e1-9c55-aa1c16f6cb52	166	16	\N
7	banned reply to post	2011-11-30 21:15:26.109	PUBLISHED	-7073499.4198	0	\N	00a7d921-73f6-4205-98b2-e50ee76d16ee	167	17	\N
8	muted reply to post	2011-11-30 21:15:26.109	PUBLISHED	-7073499.4198	0	\N	a90320ee-ce4d-45e8-a0de-f6e4349b8edc	168	17	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.109	PUBLISHED	-7073499.4198	0	\N	93ecb524-9b73-4320-beb0-24bdbef3e001	169	17	\N
7	banned reply to post	2011-11-30 21:15:26.115	PUBLISHED	-7073499.419666667	0	\N	be5c1071-db58-49c1-ac3c-55fb82e5e22a	170	18	\N
8	muted reply to post	2011-11-30 21:15:26.115	PUBLISHED	-7073499.419666667	0	\N	318cf8a4-0654-43e8-a0c6-80aebcbb954e	171	18	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.115	PUBLISHED	-7073499.419666667	0	\N	d4e879c9-9bcb-4c6d-a9ae-4cbcff98f661	172	18	\N
7	banned reply to post	2011-11-30 21:15:26.122	PUBLISHED	-7073499.419511111	0	\N	3f33dfe4-c421-4413-92b5-fb4252e2fcdf	173	19	\N
8	muted reply to post	2011-11-30 21:15:26.122	PUBLISHED	-7073499.419511111	0	\N	4d79f9c7-4232-462b-9c13-3a5de166886a	174	19	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.122	PUBLISHED	-7073499.419511111	0	\N	a20b114a-4aae-4da3-86b1-00055fc3c41d	175	19	\N
7	banned reply to post	2011-11-30 21:15:26.131	PUBLISHED	-7073499.419311111	0	\N	c3909caf-aa4c-4fd9-a905-359eda920950	176	20	\N
8	muted reply to post	2011-11-30 21:15:26.131	PUBLISHED	-7073499.419311111	0	\N	da296e7d-15a7-489d-8902-0ebb4fce54b6	177	20	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.131	PUBLISHED	-7073499.419311111	0	\N	ff9ce62f-7a01-43ca-bbd4-bd0dfaed5baf	178	20	\N
7	banned reply to post	2011-11-30 21:15:26.14	PUBLISHED	-7073499.419111111	0	\N	41358bb8-f43d-433a-9a3c-d4bb28f23ba5	179	21	\N
8	muted reply to post	2011-11-30 21:15:26.14	PUBLISHED	-7073499.419111111	0	\N	b4cf29e3-ba16-489c-83d2-70f4dc5bb228	180	21	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.14	PUBLISHED	-7073499.419111111	0	\N	8b0d37d2-e123-40d3-90e4-c8e72a8d8429	181	21	\N
7	banned reply to post	2011-11-30 21:15:26.147	PUBLISHED	-7073499.418955555	0	\N	a06467ff-0d55-4927-ad93-5f10a8ef5ced	182	22	\N
8	muted reply to post	2011-11-30 21:15:26.147	PUBLISHED	-7073499.418955555	0	\N	fcdfaeb9-c9c2-497f-a12e-8aa628fbe8cc	183	22	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.147	PUBLISHED	-7073499.418955555	0	\N	71ee8450-7bcc-4f11-bb5d-0e356ed05a58	184	22	\N
7	banned reply to post	2011-11-30 21:15:26.154	PUBLISHED	-7073499.4188	0	\N	d1edb9f2-bfda-4fdb-80b3-509a098037fe	185	23	\N
8	muted reply to post	2011-11-30 21:15:26.154	PUBLISHED	-7073499.4188	0	\N	4d22fd8b-bb42-49d0-a5fa-a4d9c4c620e0	186	23	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.154	PUBLISHED	-7073499.4188	0	\N	44c3b89e-314e-4ee1-b68d-43817428be87	187	23	\N
7	banned reply to post	2011-11-30 21:15:26.161	PUBLISHED	-7073499.418644444	0	\N	19b5b070-893b-441f-b20c-71ecb56a19cf	188	24	\N
8	muted reply to post	2011-11-30 21:15:26.161	PUBLISHED	-7073499.418644444	0	\N	525e695d-a7ec-4f6c-a2af-3a5ff6b24ce7	189	24	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.161	PUBLISHED	-7073499.418644444	0	\N	bc8b8d20-3baa-4d61-965f-19f9c97be759	190	24	\N
7	banned reply to post	2011-11-30 21:15:26.168	PUBLISHED	-7073499.418488889	0	\N	4c39fc40-443a-414d-82fb-cc3ccc5b3145	191	25	\N
8	muted reply to post	2011-11-30 21:15:26.168	PUBLISHED	-7073499.418488889	0	\N	a668781f-7df4-4b37-92ee-d1fa689f2392	192	25	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.168	PUBLISHED	-7073499.418488889	0	\N	d4f4693f-f739-459a-bc53-dbda46d97ae5	193	25	\N
7	banned reply to post	2011-11-30 21:15:26.178	PUBLISHED	-7073499.418266667	0	\N	bbbca03f-e828-49a9-90a7-05e3ecbcc651	194	26	\N
8	muted reply to post	2011-11-30 21:15:26.178	PUBLISHED	-7073499.418266667	0	\N	b6b639eb-d72f-4b49-88c2-7dd70844a1d3	195	26	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.178	PUBLISHED	-7073499.418266667	0	\N	2889df73-2bea-4630-9778-feab0d658d3f	196	26	\N
7	banned reply to post	2011-11-30 21:15:26.186	PUBLISHED	-7073499.418088889	0	\N	538615af-6100-4d5b-a4f4-fbd558997448	197	27	\N
8	muted reply to post	2011-11-30 21:15:26.186	PUBLISHED	-7073499.418088889	0	\N	4eca8ad9-79f3-445d-b4ad-b986960db49a	198	27	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.186	PUBLISHED	-7073499.418088889	0	\N	ed198898-5259-4b30-91cf-e632bb39490a	199	27	\N
7	banned reply to post	2011-11-30 21:15:26.194	PUBLISHED	-7073499.417911111	0	\N	5c0882d6-563c-468c-81a2-1a7083223f49	200	28	\N
8	muted reply to post	2011-11-30 21:15:26.194	PUBLISHED	-7073499.417911111	0	\N	9b3ac2b5-9c03-42e7-8a2f-bb5586b0a75b	201	28	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.194	PUBLISHED	-7073499.417911111	0	\N	9d5d981b-32d9-48a2-aab0-c61a7f059960	202	28	\N
7	banned reply to post	2011-11-30 21:15:26.202	PUBLISHED	-7073499.417733333	0	\N	1ae7d971-8792-4f6a-8368-160cea097199	203	29	\N
8	muted reply to post	2011-11-30 21:15:26.202	PUBLISHED	-7073499.417733333	0	\N	e4b39f39-5c1c-4794-b886-574cf8988002	204	29	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.202	PUBLISHED	-7073499.417733333	0	\N	8065a567-a841-4a25-a874-016b0e1b4d2b	205	29	\N
7	banned reply to post	2011-11-30 21:15:26.21	PUBLISHED	-7073499.417555556	0	\N	4a0a9eec-e1ac-4200-9dba-5b447557394f	206	30	\N
8	muted reply to post	2011-11-30 21:15:26.21	PUBLISHED	-7073499.417555556	0	\N	c2deb925-7242-42e5-a975-cbba8021d6f3	207	30	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.21	PUBLISHED	-7073499.417555556	0	\N	815e5b78-6173-4553-ba49-e02293aa045b	208	30	\N
7	banned reply to post	2011-11-30 21:15:26.217	PUBLISHED	-7073499.4174	0	\N	794e2f41-5f6b-476e-ac87-3902dfb94397	209	31	\N
8	muted reply to post	2011-11-30 21:15:26.217	PUBLISHED	-7073499.4174	0	\N	cb33d906-bf4d-4e09-a65d-b8c48d881a11	210	31	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.217	PUBLISHED	-7073499.4174	0	\N	fae36c74-8c65-41dd-99d4-f9a67dab667a	211	31	\N
7	banned reply to post	2011-11-30 21:15:26.225	PUBLISHED	-7073499.417222222	0	\N	b4925f2c-a741-4ff8-b877-7ece5111c9e1	212	32	\N
8	muted reply to post	2011-11-30 21:15:26.225	PUBLISHED	-7073499.417222222	0	\N	b6e676bd-2ab3-4746-8159-a67421525e47	213	32	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.225	PUBLISHED	-7073499.417222222	0	\N	c4c6f3ca-7d98-4a7c-beb0-0bbc12466f45	214	32	\N
7	banned reply to post	2011-11-30 21:15:26.231	PUBLISHED	-7073499.417088889	0	\N	0721b958-a2de-41da-9202-3aa779126fb0	215	33	\N
8	muted reply to post	2011-11-30 21:15:26.231	PUBLISHED	-7073499.417088889	0	\N	3931b3fa-8e64-4087-a7db-01d07a653678	216	33	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.231	PUBLISHED	-7073499.417088889	0	\N	ae320a72-2a38-4f7f-859e-c02405d393b7	217	33	\N
7	banned reply to post	2011-11-30 21:15:26.238	PUBLISHED	-7073499.416933334	0	\N	be1c8fcb-170e-4f40-b15b-829078212532	218	34	\N
8	muted reply to post	2011-11-30 21:15:26.238	PUBLISHED	-7073499.416933334	0	\N	afe1a93c-e48e-40c3-abd7-93fcfbe9bf23	219	34	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.238	PUBLISHED	-7073499.416933334	0	\N	073d58c2-0adb-4626-870d-e645b44e3c1c	220	34	\N
7	banned reply to post	2011-11-30 21:15:26.244	PUBLISHED	-7073499.4168	0	\N	fad0c813-4149-4288-8a8f-e02ead93df64	221	35	\N
8	muted reply to post	2011-11-30 21:15:26.244	PUBLISHED	-7073499.4168	0	\N	41d0e8c5-96f8-4f99-a402-aeff32e8125a	222	35	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.244	PUBLISHED	-7073499.4168	0	\N	4461f0de-31dc-4a43-a0de-bb7c45df96ec	223	35	\N
7	banned reply to post	2011-11-30 21:15:26.25	PUBLISHED	-7073499.416666667	0	\N	cb9d5d38-c961-4848-8a9b-376dafcdea4f	224	36	\N
8	muted reply to post	2011-11-30 21:15:26.25	PUBLISHED	-7073499.416666667	0	\N	2842ea7a-df7d-4c08-ba3b-f6b6be02762d	225	36	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.25	PUBLISHED	-7073499.416666667	0	\N	c4203cf5-bebe-4c80-a16f-101d4f0d7439	226	36	\N
7	banned reply to post	2011-11-30 21:15:26.256	PUBLISHED	-7073499.416533333	0	\N	01888e21-1b97-45a5-b137-8d3d9e0b5d4c	227	37	\N
8	muted reply to post	2011-11-30 21:15:26.256	PUBLISHED	-7073499.416533333	0	\N	0952ad78-7d41-4fbf-bd48-262007dbf735	228	37	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.256	PUBLISHED	-7073499.416533333	0	\N	31bed570-f22d-4969-95ec-80e612b66825	229	37	\N
7	banned reply to post	2011-11-30 21:15:26.263	PUBLISHED	-7073499.416377778	0	\N	ca885d94-4d06-4218-8661-294ccfa4a730	230	38	\N
8	muted reply to post	2011-11-30 21:15:26.263	PUBLISHED	-7073499.416377778	0	\N	cdb07d30-7fdb-4014-8ddd-90f1baa3c8da	231	38	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.263	PUBLISHED	-7073499.416377778	0	\N	19a4373e-98d2-4cd5-8630-34ca07f79dbd	232	38	\N
7	banned reply to post	2011-11-30 21:15:26.269	PUBLISHED	-7073499.416244444	0	\N	7c7eaa42-a2db-4cfc-926a-526a2fdc11b0	233	39	\N
8	muted reply to post	2011-11-30 21:15:26.269	PUBLISHED	-7073499.416244444	0	\N	a40be856-915d-49c4-895e-1f87a5656a78	234	39	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.269	PUBLISHED	-7073499.416244444	0	\N	6e78c996-e8c1-4b40-abf2-1a0919be5bd8	235	39	\N
7	banned reply to post	2011-11-30 21:15:26.275	PUBLISHED	-7073499.416111111	0	\N	5d62d2a0-40cc-4ed0-8b50-a7960fd34085	236	40	\N
8	muted reply to post	2011-11-30 21:15:26.275	PUBLISHED	-7073499.416111111	0	\N	8745be97-a507-4d1d-a551-346f356a04ec	237	40	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.275	PUBLISHED	-7073499.416111111	0	\N	f32167e7-1b84-406f-8d09-b9da0ffde776	238	40	\N
7	banned reply to post	2011-11-30 21:15:26.28	PUBLISHED	-7073499.416	0	\N	a8e97b60-283f-4505-bc4f-9298cbb7123a	239	41	\N
8	muted reply to post	2011-11-30 21:15:26.28	PUBLISHED	-7073499.416	0	\N	07e06ab5-6544-4742-b441-f960502dc490	240	41	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.28	PUBLISHED	-7073499.416	0	\N	e794f807-4b28-432c-9f88-7e075b30f337	241	41	\N
7	banned reply to post	2011-11-30 21:15:26.287	PUBLISHED	-7073499.415844444	0	\N	6f02bd8e-835c-4cc9-9cd1-57ba1b9137f7	242	42	\N
8	muted reply to post	2011-11-30 21:15:26.287	PUBLISHED	-7073499.415844444	0	\N	3392d8a0-c770-4281-b533-af44ac8c1ea7	243	42	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.287	PUBLISHED	-7073499.415844444	0	\N	d1577a20-45b2-4a35-a63a-2453ff0e622b	244	42	\N
7	banned reply to post	2011-11-30 21:15:26.293	PUBLISHED	-7073499.415711111	0	\N	a19c714b-baa0-426f-8128-4d41fc80f423	245	43	\N
8	muted reply to post	2011-11-30 21:15:26.293	PUBLISHED	-7073499.415711111	0	\N	01e44ead-7e93-479e-93e8-a100743f9dbf	246	43	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.293	PUBLISHED	-7073499.415711111	0	\N	b4e014fc-0413-4e68-85e1-8e0b0658ff5a	247	43	\N
7	banned reply to post	2011-11-30 21:15:26.3	PUBLISHED	-7073499.415555555	0	\N	57771b1c-3fce-4949-aae6-f76da3857935	248	44	\N
8	muted reply to post	2011-11-30 21:15:26.3	PUBLISHED	-7073499.415555555	0	\N	f0d535ea-ba6e-4143-97d3-651911237200	249	44	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.3	PUBLISHED	-7073499.415555555	0	\N	b451f5c9-9935-49e9-8de7-9a82f8d08ace	250	44	\N
7	banned reply to post	2011-11-30 21:15:26.307	PUBLISHED	-7073499.4154	0	\N	18efb08f-bf39-4bd8-ad21-519511630233	251	45	\N
8	muted reply to post	2011-11-30 21:15:26.307	PUBLISHED	-7073499.4154	0	\N	887d1ae3-8efe-46ca-910b-2db2a92b7550	252	45	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.307	PUBLISHED	-7073499.4154	0	\N	d652dfd5-8928-44f0-b146-dc6fe384d445	253	45	\N
7	banned reply to post	2011-11-30 21:15:26.312	PUBLISHED	-7073499.415288889	0	\N	10fccf0d-702c-469b-a196-408f84e1d6c5	254	46	\N
8	muted reply to post	2011-11-30 21:15:26.312	PUBLISHED	-7073499.415288889	0	\N	59057a67-198d-4322-ab33-cadd4b4f6dde	255	46	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.312	PUBLISHED	-7073499.415288889	0	\N	fc4bb210-f7b2-4adc-a26d-a8f2f8421d78	256	46	\N
7	banned reply to post	2011-11-30 21:15:26.319	PUBLISHED	-7073499.415133334	0	\N	2b9713ed-05e3-4258-80f8-c201bb8f7ba5	257	47	\N
8	muted reply to post	2011-11-30 21:15:26.319	PUBLISHED	-7073499.415133334	0	\N	b4fbe2ed-cf96-4c04-a836-7f1cf81377be	258	47	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.319	PUBLISHED	-7073499.415133334	0	\N	eb85695d-57be-4354-bb66-c30170d6b1c2	259	47	\N
7	banned reply to post	2011-11-30 21:15:26.328	PUBLISHED	-7073499.414933333	0	\N	ee156726-7a23-45f8-9fbb-d356ff602d7b	260	48	\N
8	muted reply to post	2011-11-30 21:15:26.328	PUBLISHED	-7073499.414933333	0	\N	e102d94a-6934-488a-b79c-a5818ba9d915	261	48	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.328	PUBLISHED	-7073499.414933333	0	\N	e6494dad-cdfb-4e4a-99fd-2ed748ebdfc3	262	48	\N
7	banned reply to post	2011-11-30 21:15:26.338	PUBLISHED	-7073499.414711111	0	\N	ad510e14-2942-44e0-a41e-e416ed14b0ae	263	49	\N
8	muted reply to post	2011-11-30 21:15:26.338	PUBLISHED	-7073499.414711111	0	\N	53562609-f437-4ac5-b6d8-9baa72583a63	264	49	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.338	PUBLISHED	-7073499.414711111	0	\N	12eb0ebc-a717-44cf-9e8b-f67c9884da78	265	49	\N
7	banned reply to post	2011-11-30 21:15:26.349	PUBLISHED	-7073499.414466667	0	\N	8c0f09e0-c030-41e3-9798-08a1ac9ec87c	266	50	\N
8	muted reply to post	2011-11-30 21:15:26.349	PUBLISHED	-7073499.414466667	0	\N	15532890-6086-4482-8e0a-26736561017f	267	50	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.349	PUBLISHED	-7073499.414466667	0	\N	ff4ba367-474e-4b99-9f95-be4939b6c0e6	268	50	\N
7	banned reply to post	2011-11-30 21:15:26.358	PUBLISHED	-7073499.414266666	0	\N	db969b38-aa93-40fc-92f7-feb66fa13133	269	51	\N
8	muted reply to post	2011-11-30 21:15:26.358	PUBLISHED	-7073499.414266666	0	\N	3e0c8663-5c99-4973-8491-c09fde1e7755	270	51	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.358	PUBLISHED	-7073499.414266666	0	\N	6460c574-956d-4113-91cc-80baca006479	271	51	\N
7	banned reply to post	2011-11-30 21:15:26.366	PUBLISHED	-7073499.414088889	0	\N	73efa99e-cf49-419a-9e52-b36e684491c6	272	52	\N
8	muted reply to post	2011-11-30 21:15:26.366	PUBLISHED	-7073499.414088889	0	\N	02703007-2bd5-48d1-992b-2bbbf5d69508	273	52	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.366	PUBLISHED	-7073499.414088889	0	\N	21e5c47e-423b-4c83-bb63-d27b366944fa	274	52	\N
7	banned reply to post	2011-11-30 21:15:26.375	PUBLISHED	-7073499.413888888	0	\N	17519175-d6cf-42c2-86e7-01cc2e759169	275	53	\N
8	muted reply to post	2011-11-30 21:15:26.375	PUBLISHED	-7073499.413888888	0	\N	8292b81f-4c76-4db1-b320-0b93ac242b5d	276	53	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.375	PUBLISHED	-7073499.413888888	0	\N	ecf3377f-bf10-465c-b4e2-1ac7ff45e5c8	277	53	\N
7	banned reply to post	2011-11-30 21:15:26.386	PUBLISHED	-7073499.413644444	0	\N	dd95030a-b53a-454e-8526-9e6a83aeaf5b	278	54	\N
8	muted reply to post	2011-11-30 21:15:26.386	PUBLISHED	-7073499.413644444	0	\N	34e5b0ec-37fe-4323-80d1-42e40be7feca	279	54	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.386	PUBLISHED	-7073499.413644444	0	\N	b2e4efd1-2258-47a0-9945-d7b05aea9990	280	54	\N
7	banned reply to post	2011-11-30 21:15:26.4	PUBLISHED	-7073499.413333333	0	\N	4247a3d3-23c9-4269-9221-2bd0ebe8d79a	281	55	\N
8	muted reply to post	2011-11-30 21:15:26.4	PUBLISHED	-7073499.413333333	0	\N	c2af2085-81a8-4363-80bb-c6db1478312f	282	55	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.4	PUBLISHED	-7073499.413333333	0	\N	872edce9-b830-4e6a-ac2f-4bab5b0d0fd9	283	55	\N
7	banned reply to post	2011-11-30 21:15:26.409	PUBLISHED	-7073499.413133333	0	\N	efe6beec-9e85-455c-8262-bf7d24446cbd	284	56	\N
8	muted reply to post	2011-11-30 21:15:26.409	PUBLISHED	-7073499.413133333	0	\N	e687b162-dfd0-4868-b539-7aca88cc0a3d	285	56	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.409	PUBLISHED	-7073499.413133333	0	\N	9750bb19-e038-4444-a7de-b067200761f8	286	56	\N
7	banned reply to post	2011-11-30 21:15:26.427	PUBLISHED	-7073499.412733333	0	\N	cd635c9d-b5aa-4614-856a-93387d96dc88	287	57	\N
8	muted reply to post	2011-11-30 21:15:26.427	PUBLISHED	-7073499.412733333	0	\N	8921245e-ed54-441b-b18c-97c9f52457ca	288	57	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.427	PUBLISHED	-7073499.412733333	0	\N	f502ce4d-426c-4255-9f36-4b200f7a955c	289	57	\N
7	banned reply to post	2011-11-30 21:15:26.439	PUBLISHED	-7073499.412466667	0	\N	9aba984d-93aa-492a-9025-d91842dfc426	290	58	\N
8	muted reply to post	2011-11-30 21:15:26.439	PUBLISHED	-7073499.412466667	0	\N	4cf40fa8-2690-42f1-a651-165843ea890f	291	58	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.439	PUBLISHED	-7073499.412466667	0	\N	db3cec48-334f-4656-95f4-d558fb49a4e4	292	58	\N
7	banned reply to post	2011-11-30 21:15:26.452	PUBLISHED	-7073499.412177778	0	\N	20319aae-1f5a-486c-b3f2-b1bc1b78ac0f	293	59	\N
8	muted reply to post	2011-11-30 21:15:26.452	PUBLISHED	-7073499.412177778	0	\N	7318b0ec-fe1a-4444-8622-4af7fe7c9a40	294	59	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.452	PUBLISHED	-7073499.412177778	0	\N	6f50615c-3b92-495a-99a8-66fb02e5715c	295	59	\N
7	banned reply to post	2011-11-30 21:15:26.462	PUBLISHED	-7073499.411955556	0	\N	cbddbc73-f450-4a00-bb39-40b728256154	296	60	\N
8	muted reply to post	2011-11-30 21:15:26.462	PUBLISHED	-7073499.411955556	0	\N	a3fa5052-25ca-464d-a704-9f2f43cb4f24	297	60	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.462	PUBLISHED	-7073499.411955556	0	\N	0db6987f-2720-49ab-a0b2-23de8a413c28	298	60	\N
7	banned reply to post	2011-11-30 21:15:26.474	PUBLISHED	-7073499.411688888	0	\N	55f1faad-b5b0-4611-a606-f4643545dedf	299	61	\N
8	muted reply to post	2011-11-30 21:15:26.474	PUBLISHED	-7073499.411688888	0	\N	9346b551-2715-4fb3-8697-e17d3c52fd71	300	61	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.474	PUBLISHED	-7073499.411688888	0	\N	17182e04-f1e2-4798-b3fd-11d018b6f79d	301	61	\N
7	banned reply to post	2011-11-30 21:15:26.482	PUBLISHED	-7073499.411511111	0	\N	b23a97b2-7caa-408c-9498-ba9579e4f7f4	302	62	\N
8	muted reply to post	2011-11-30 21:15:26.482	PUBLISHED	-7073499.411511111	0	\N	e9568044-982f-4514-87d5-15c860025c4c	303	62	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.482	PUBLISHED	-7073499.411511111	0	\N	11b655c1-6e51-4a3c-ae35-bce5f0d2989c	304	62	\N
7	banned reply to post	2011-11-30 21:15:26.495	PUBLISHED	-7073499.411222222	0	\N	c36cc1d4-85af-4062-b522-8316cdb0775f	305	63	\N
8	muted reply to post	2011-11-30 21:15:26.495	PUBLISHED	-7073499.411222222	0	\N	6267e1f5-1cc0-4224-85b7-ecff4577ecd2	306	63	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.495	PUBLISHED	-7073499.411222222	0	\N	2a3aa157-2c8d-40fd-8fe2-f786b8f26d88	307	63	\N
7	banned reply to post	2011-11-30 21:15:26.51	PUBLISHED	-7073499.410888889	0	\N	99f7f443-41f3-4068-b490-613093423a93	308	64	\N
8	muted reply to post	2011-11-30 21:15:26.51	PUBLISHED	-7073499.410888889	0	\N	a7a5f3c4-d786-410d-a4cd-51520894b8d2	309	64	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.51	PUBLISHED	-7073499.410888889	0	\N	6abe9ddc-f791-4b0b-b50b-00ddd2722c62	310	64	\N
7	banned reply to post	2011-11-30 21:15:26.518	PUBLISHED	-7073499.410711112	0	\N	c82f5d3d-ee9a-4631-8d2d-219477dabcab	311	65	\N
8	muted reply to post	2011-11-30 21:15:26.518	PUBLISHED	-7073499.410711112	0	\N	e4ceb8c9-b818-4d07-bfa6-e644c9e2cefc	312	65	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.518	PUBLISHED	-7073499.410711112	0	\N	937e5b75-31cf-4e00-b557-a2c59a554ff7	313	65	\N
7	banned reply to post	2011-11-30 21:15:26.546	PUBLISHED	-7073499.410088889	0	\N	138a1a8b-c4c9-485a-87db-1da3f590a62c	314	66	\N
8	muted reply to post	2011-11-30 21:15:26.546	PUBLISHED	-7073499.410088889	0	\N	08655389-d5d2-42cc-8ab7-33a72f58b6f9	315	66	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.546	PUBLISHED	-7073499.410088889	0	\N	37ba3ae9-35ad-46dd-8713-e69c9004dab2	316	66	\N
7	banned reply to post	2011-11-30 21:15:26.555	PUBLISHED	-7073499.409888889	0	\N	5ca48502-6fed-4a02-b498-a2c4b7ca8088	317	67	\N
8	muted reply to post	2011-11-30 21:15:26.555	PUBLISHED	-7073499.409888889	0	\N	bd166811-ba8a-4710-aa26-00e7dd1bd02c	318	67	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.555	PUBLISHED	-7073499.409888889	0	\N	90be3d52-d732-425e-bee6-a27886d9bf12	319	67	\N
7	banned reply to post	2011-11-30 21:15:26.563	PUBLISHED	-7073499.409711111	0	\N	bef629cc-e9a6-4e21-a3f3-e119d3ac30bf	320	68	\N
8	muted reply to post	2011-11-30 21:15:26.563	PUBLISHED	-7073499.409711111	0	\N	ef9f2126-b844-4699-b24d-451ede648f24	321	68	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.563	PUBLISHED	-7073499.409711111	0	\N	3608e762-97cf-425a-b302-c517525ae8a2	322	68	\N
7	banned reply to post	2011-11-30 21:15:26.571	PUBLISHED	-7073499.409533333	0	\N	bfb82983-4256-48e0-94b9-520de611c8f5	323	69	\N
8	muted reply to post	2011-11-30 21:15:26.571	PUBLISHED	-7073499.409533333	0	\N	f97e3a50-0512-4742-9e4c-be42c8e0f905	324	69	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.571	PUBLISHED	-7073499.409533333	0	\N	d3fb9404-9e26-432c-8b5b-9281407658ef	325	69	\N
7	banned reply to post	2011-11-30 21:15:26.581	PUBLISHED	-7073499.409311111	0	\N	4e1bb342-9798-4321-95ec-81045f278b92	326	70	\N
8	muted reply to post	2011-11-30 21:15:26.581	PUBLISHED	-7073499.409311111	0	\N	1e2d9b4f-8754-416e-bed0-57315d259fca	327	70	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.581	PUBLISHED	-7073499.409311111	0	\N	69c59e53-0474-4fba-a64f-37bf3803ca87	328	70	\N
7	banned reply to post	2011-11-30 21:15:26.598	PUBLISHED	-7073499.408933333	0	\N	8534744d-b324-471f-91a0-546c6bf55c64	329	71	\N
8	muted reply to post	2011-11-30 21:15:26.598	PUBLISHED	-7073499.408933333	0	\N	c2e7ef0d-14fd-4fca-984a-ae3c8d089edd	330	71	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.598	PUBLISHED	-7073499.408933333	0	\N	4b838552-1d71-4b9f-ae09-68b71d02e08e	331	71	\N
7	banned reply to post	2011-11-30 21:15:26.607	PUBLISHED	-7073499.408733333	0	\N	295b33f9-8b68-4865-9c40-b297e0e85b71	332	72	\N
8	muted reply to post	2011-11-30 21:15:26.607	PUBLISHED	-7073499.408733333	0	\N	d7c8ce73-33aa-40b8-8810-8eac0aadbe0c	333	72	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.607	PUBLISHED	-7073499.408733333	0	\N	b0cd5852-2305-4755-a807-b4877997b857	334	72	\N
7	banned reply to post	2011-11-30 21:15:26.616	PUBLISHED	-7073499.408533333	0	\N	de5b4415-3ebf-456d-938b-2bc6cf169e19	335	73	\N
8	muted reply to post	2011-11-30 21:15:26.616	PUBLISHED	-7073499.408533333	0	\N	5cf66b93-ecd4-4e91-abee-e3ec6c736575	336	73	\N
10	I blocked you and replied to your post	2011-11-30 21:15:26.616	PUBLISHED	-7073499.408533333	0	\N	c1c96fce-80c0-4fc7-af78-1bf4d4f9ab2d	337	73	\N
18	Quo nostrum quidem facilis laboriosam rerum. Quod recusandae molestiae. Animi mollitia architecto. Laborum voluptate nihil facere magnam. Cum nam id distinctio aspernatur molestias laudantium deleniti.	2023-10-29 05:58:14.023	PUBLISHED	0	0	\N	449903d7-caf3-4884-8af1-bce04b92a5a2	340	\N	\N
16	Voluptatem quia culpa nesciunt magni. Dolorem quos est. Ullam aliquid deserunt laudantium.	2023-01-14 15:48:27.155	PUBLISHED	0	0	\N	3c73763b-e311-437f-bda0-e76502ddbd8e	341	\N	\N
21	Incidunt porro quas porro. Eius harum labore accusamus quasi odit iure architecto magnam. Illum in dolores nulla.	2023-09-21 10:01:45.148	PUBLISHED	0	0	\N	4d57e774-16a2-4dc9-a554-7a8b9637dbbe	342	\N	\N
20	Beatae quos delectus eaque. Praesentium quas animi aliquid nam voluptate rerum ipsa quod. Corrupti asperiores delectus quasi nemo tenetur at. Rerum id eos repellendus. Inventore possimus corrupti suscipit sed aliquid illum ut dicta. Consequatur a minima voluptates non perferendis totam voluptates excepturi sapiente.	2023-08-28 14:28:06.142	PUBLISHED	0	0	\N	8874b98c-2668-43ee-9fcd-a584b4f19615	343	\N	\N
17	Ipsam deserunt hic provident. Labore voluptates ducimus repellendus ad. Eius voluptatum ullam porro quo laborum ut. Hic dolorum vitae possimus quaerat quisquam aspernatur debitis. Ex quasi sapiente fuga ratione.	2023-02-15 09:31:42.544	PUBLISHED	0	0	\N	1bb181be-ea5f-47ae-b2ef-d94ee00b676a	344	\N	\N
21	Ipsum magni dolore voluptatum consequuntur repellendus quasi. Vero alias quae laudantium velit vitae error. Cumque ipsum quo sequi facilis libero harum quo. Nobis laudantium suscipit esse debitis eos. Dolorum at esse dicta. Corrupti pariatur dicta ut veritatis eligendi optio cum.	2023-04-04 06:38:26.661	PUBLISHED	0	0	\N	c2c4e14a-98d6-48a8-a564-8d4af24694d8	345	\N	\N
20	Facere incidunt ut reprehenderit quibusdam veniam nisi debitis. Cum provident ad facere soluta corrupti in nostrum. Repellat laborum modi iure nihil deleniti optio. Amet rerum id recusandae nam. Vero ex esse placeat soluta.	2023-06-27 09:20:20.625	PUBLISHED	0	0	\N	cb067832-6f3a-4232-b3ae-d9a3f26a6cf4	346	\N	\N
17	Corrupti aperiam quos laboriosam ipsam rem quibusdam nulla explicabo earum. Eius commodi sapiente ipsum corrupti recusandae. Odit itaque consectetur doloribus harum voluptate. Minus reiciendis deleniti dolorum minima quaerat incidunt aspernatur quo facilis.	2023-05-24 02:57:17.839	PUBLISHED	0	0	\N	66ad475c-7b06-49b4-81d3-1ff0745ff74d	347	\N	\N
23	Fugiat soluta consequatur autem veritatis et reprehenderit explicabo fuga. Culpa ullam nobis ipsum qui. Accusantium doloremque in minima unde ad error necessitatibus. Quis facilis inventore iusto soluta maxime repellat.	2023-01-21 11:02:31.402	PUBLISHED	0	0	\N	2193f6db-15c0-4681-8a72-3d21a19c38e0	348	\N	\N
23	Aperiam velit libero consequuntur illo voluptate debitis quam fugiat possimus. Fuga animi repellat maxime animi. Inventore voluptatem itaque dignissimos temporibus quisquam perferendis alias tempora quasi. Repudiandae exercitationem architecto perferendis. Excepturi incidunt accusamus numquam commodi quam esse voluptates sint. Officia praesentium voluptatum quas nemo voluptate minima.	2023-04-12 14:48:38.919	PUBLISHED	895904.8648666666	1	\N	b71485d1-c166-4f64-86f1-3046087912a8	349	\N	\N
21	Quas sint perferendis tempore quam aliquid nostrum. Libero harum molestias enim doloremque deleniti dicta a. Provident doloribus tenetur expedita.	2023-01-21 05:27:19.032	PUBLISHED	739636.4229333333	1	\N	e14fcb2c-c637-414e-a362-d11799089257	350	\N	\N
19	Excepturi error velit quo atque quis ipsa aliquam. Qui officia earum recusandae molestiae repellendus sequi. Nemo voluptatum eligendi. Adipisci dolorum modi praesentium. Ea consequuntur at.	2023-05-10 20:56:46.878	PUBLISHED	0	0	\N	6645bbb9-d095-4c50-b502-016b6a100d34	351	\N	\N
17	Vitae atque natus temporibus harum quam distinctio illum at. Nemo quasi accusamus eaque. Nobis in ducimus consectetur maiores repellendus. Sunt hic necessitatibus voluptatem doloremque. Id amet enim sit occaecati sapiente impedit minima tempore.	2023-10-12 04:12:09.582	PUBLISHED	0	0	\N	cbd7204f-b75c-4450-b1a2-1a633933926c	352	\N	\N
16	Impedit veritatis repellat quisquam tempore repellat eum. Veritatis at id voluptas libero sint molestiae aut. Nostrum recusandae maxime veniam qui veritatis maiores totam modi nobis. Odio voluptatum quasi iure assumenda vel. Doloremque aspernatur possimus voluptatem at soluta inventore expedita ab. Odit alias atque aut dicta repellat ea eius.	2023-04-08 14:09:25.981	PUBLISHED	0	0	\N	c24408d0-6110-41aa-8057-b103fc9378d2	353	\N	\N
21	Incidunt tenetur dolores repellat dolor delectus animi. Alias veniam non repudiandae debitis laudantium beatae quibusdam quia. Exercitationem nostrum earum. Dignissimos laboriosam explicabo fugiat consequatur iusto molestias doloribus. Nostrum atque ratione praesentium maiores.	2023-10-03 10:35:13.576	PUBLISHED	0	0	\N	8e8c93b9-242f-4102-983a-90482c171ae6	354	\N	\N
20	In molestiae magnam atque ex voluptate saepe blanditiis tenetur dolor. Ipsam quisquam earum molestias rerum accusantium neque animi culpa quia. Vero adipisci eos perferendis id exercitationem.	2023-09-26 12:24:09.072	PUBLISHED	0	0	\N	cecd216b-284e-4362-b1a3-43c5803ed545	355	\N	\N
17	Consectetur facere veritatis natus praesentium. Ratione cum perferendis tenetur. Sunt officia at autem. Necessitatibus quisquam ab unde quo ea deserunt.	2023-03-03 16:48:57.46	PUBLISHED	0	0	\N	880f0cdf-ea9d-4eff-8163-41620e508a35	356	\N	\N
19	Harum id accusantium vel. Voluptatum odio animi. Beatae ad minima deleniti.	2023-04-27 10:22:32.077	PUBLISHED	0	0	\N	2b7a8694-469d-470b-84d2-5fb623d7f46e	357	\N	\N
21	Voluptatem error aperiam explicabo. Laborum repellat consequuntur labore. Dolore sed molestias hic.	2022-12-09 17:16:23.23	PUBLISHED	0	0	\N	5b3670b0-0d4a-4e0c-9d65-b4d966883136	410	\N	\N
16	Deleniti quis voluptatem cum neque. Voluptas sunt soluta perspiciatis molestias. Officia dicta fugiat odit similique aperiam dolorum assumenda.	2023-11-09 21:10:50.49	PUBLISHED	0	0	\N	e10842b2-99a6-48da-82e6-69593c55e31f	359	\N	\N
14	Laboriosam suscipit quibusdam voluptates eum reprehenderit consectetur laborum earum vel. Consectetur itaque natus inventore explicabo sapiente possimus. Nulla perspiciatis aut sapiente.	2023-11-04 00:31:46.855	PUBLISHED	0	0	\N	ac813e66-922b-480b-85a4-b858be55c7b4	360	\N	\N
18	Nulla repudiandae aliquam nobis doloremque. Minima possimus voluptatibus assumenda odit corrupti at. Tenetur vel accusamus molestiae illum eum ducimus laborum.	2023-09-22 23:56:50.127	PUBLISHED	0	0	\N	2464942c-fe0f-445b-b320-7128202edb09	362	\N	\N
22	Incidunt nostrum cupiditate odio nostrum quis. Odio accusamus alias. Magnam molestias recusandae cumque eos cupiditate rerum. Molestiae esse officia iure mollitia nam fuga minima. Sit odio totam illo numquam hic libero doloribus. Facilis suscipit laboriosam sequi.	2023-09-02 13:31:45.973	PUBLISHED	0	0	\N	d9fd98fc-8dfd-4514-b37e-63223c65c53e	363	\N	\N
19	Odio sit maxime asperiores exercitationem. Minus libero aperiam eius similique aut explicabo cum. Qui est perspiciatis. Quos incidunt quasi laudantium.	2023-07-16 02:06:31.664	PUBLISHED	0	0	\N	48c72d98-61c7-4e69-9f64-82c76d4d7f01	364	\N	\N
15	Sit quis alias pariatur occaecati at libero officiis quisquam magni. Nisi suscipit repudiandae necessitatibus eveniet harum esse. Magni voluptatibus temporibus hic dolor soluta quos. Blanditiis veniam quaerat ab tempora deleniti sapiente.	2023-05-04 17:52:00.306	PUBLISHED	0	0	\N	b1c82c22-2534-4048-9146-7b54603daf7c	365	\N	\N
23	Voluptatum repellendus aspernatur provident quas similique et unde nisi. Consequuntur iusto assumenda. Deleniti sit delectus rerum ut nostrum mollitia doloribus quas. Cumque repellat sint soluta consectetur natus rerum. Dolor iusto fuga. Magnam fugit aspernatur ipsa natus rerum.	2023-02-07 20:32:38.211	PUBLISHED	0	0	\N	f5cb6f8c-94d5-478a-9e1e-ff53fd809916	366	\N	\N
23	Unde eum fugit hic culpa atque. Quia excepturi a tempore animi voluptatem aperiam recusandae accusantium ipsam. Nisi tenetur hic laboriosam consequatur officiis itaque maxime eligendi. Quisquam amet harum aliquid distinctio vero molestiae non.	2023-10-10 11:48:45.827	PUBLISHED	0	0	\N	e3dd649f-5738-439d-b642-f5320fd5e0b9	367	\N	\N
20	Hic porro in error. Nemo deserunt reprehenderit delectus. Repudiandae dignissimos porro. Fugiat officia cupiditate officia id. Veritatis explicabo voluptates eveniet dolorem.	2023-09-06 03:45:51.709	PUBLISHED	0	0	\N	06c95e1f-2a38-4440-9cf6-ace9d891c8ff	368	\N	\N
14	Voluptas id in assumenda qui ipsum. Voluptates esse molestias sint ut harum saepe quae inventore. Necessitatibus quidem aliquid quibusdam odit deserunt debitis aut. Non iste reprehenderit excepturi saepe ut dolor. Explicabo nobis aut consequatur doloremque.	2023-11-21 05:23:48.146	PUBLISHED	0	0	\N	ade54631-f00c-4000-893b-5081e642f861	369	\N	\N
18	Consequatur ad nam quia distinctio. Quaerat dolores ratione accusamus corporis dolore assumenda porro est error. Repudiandae ut fugit voluptatum consequatur esse aspernatur id accusamus.	2023-07-24 08:30:58.833	PUBLISHED	0	0	\N	6e4d17de-4b31-4cda-b896-3572056f09c4	370	\N	\N
21	Voluptas saepe praesentium molestias soluta molestiae necessitatibus deleniti maxime. Eveniet incidunt quam dolorum iste maiores beatae assumenda ab. Ut sit minus neque reprehenderit facilis debitis similique corporis incidunt. Voluptas ratione omnis ullam deleniti laboriosam quos corporis vel ut.	2022-12-13 17:09:04.333	PUBLISHED	0	0	\N	e994adaf-e00b-4928-8421-50803e36fca5	371	\N	\N
22	Quidem illum suscipit aliquam occaecati explicabo magni. Cum architecto rem provident tenetur culpa quam voluptate pariatur numquam. Saepe numquam iure nisi deserunt fugiat sed eos ratione. Autem ipsa facere minima. Animi facilis voluptatem perspiciatis omnis tempore.	2023-07-03 15:24:51.877	PUBLISHED	0	0	\N	34bf1067-3d49-4a8e-8676-e9fda916f1a0	372	\N	\N
15	Natus animi placeat. Explicabo architecto reprehenderit molestias fugit cupiditate assumenda aliquam. Praesentium corrupti ad.	2023-11-23 03:53:44.077	PUBLISHED	1327031.646155555	1	\N	0c2f7029-42db-465e-ab88-2225636cd7ef	373	\N	\N
22	Aut enim maxime recusandae recusandae consequatur cumque adipisci odit enim. Rem harum nulla. Ratione mollitia mollitia.	2023-03-30 11:28:53.739	PUBLISHED	0	0	\N	197ea8bc-67c6-4a4d-95fa-fe381348351b	374	\N	\N
19	Sint corporis magnam ut nemo consequatur ullam. Temporibus sunt quibusdam atque dolorum adipisci fugiat adipisci. Soluta doloremque non aut delectus dolorem facere voluptatem officia debitis. Maiores maiores odit. Nesciunt veniam perspiciatis. Omnis tempora maxime.	2022-12-14 17:00:28.94	PUBLISHED	0	0	\N	a750f4f8-a61e-4f35-8ed4-77a8cf8cf827	375	\N	\N
15	Accusantium laboriosam sed dolor earum aliquam repudiandae nisi accusantium. Minus ratione architecto distinctio voluptatum odio est. Iure rerum magni illo. Odit magni nesciunt suscipit atque ad quos dolor fuga qui.	2023-09-29 03:26:07.373	PUBLISHED	0	0	\N	adfe469f-ecc2-4e57-a532-03d7973e9c19	376	\N	\N
18	Dolorem tempore tempore. Saepe ab dolorum fugit ipsam perferendis commodi dolorem iure exercitationem. Aperiam modi dolor accusamus quos quas. Officiis dolorem expedita. Doloribus ipsa consequuntur ducimus commodi neque odit velit. Maiores commodi quam velit provident hic fuga.	2023-08-09 10:48:54.825	PUBLISHED	0	0	\N	74c0d8ab-afa8-4345-b8fe-d5110d825292	377	\N	\N
17	Reprehenderit error debitis inventore et cum nisi deserunt quos nisi. Libero delectus quis nisi nobis eveniet quia voluptas tempora. Voluptate voluptatibus iure voluptas nemo tempora harum nemo ex. Animi dolorem iusto praesentium quas animi quod harum quae.	2022-12-29 20:42:06.622	PUBLISHED	0	0	\N	08b84893-35ce-486d-a57d-7c8cf5dc1c09	378	\N	\N
21	Sint officiis sunt laboriosam voluptate itaque odit quis. Officiis laborum cum quos beatae fugiat atque eum quod. Et quis minus provident quo qui commodi eos recusandae. Dolore impedit quo recusandae asperiores ea dignissimos ut.	2023-05-24 03:40:47.704	PUBLISHED	0	0	\N	5c5c6294-0caa-4a5c-b4f5-211ce4649555	379	\N	\N
23	Quas a vero inventore consequatur inventore dolorum sunt. Magnam est provident odio placeat quo modi itaque. Nobis vel corporis corrupti odio culpa. Repellat odio magni voluptatibus nulla consequatur reiciendis ipsa. Numquam dolorem eos assumenda vitae corporis explicabo et aliquid omnis.	2023-09-19 09:40:16.892	PUBLISHED	0	0	\N	c7041c37-85da-4e6a-8118-185b080acea5	380	\N	\N
18	Corrupti praesentium unde quos quasi. Ab eligendi repellendus officiis. Ad unde veritatis accusamus nulla.	2023-02-06 21:01:18.833	PUBLISHED	0	0	\N	3c08eb7e-6872-47ea-8e82-a80ddd35cbc6	381	\N	\N
14	Culpa in temporibus esse eum. Nobis dolores aperiam cupiditate quidem repellendus temporibus. Eligendi consequuntur delectus quo amet minus aperiam. Consectetur neque explicabo sed vel minus tempore incidunt a. Corrupti eaque ex.	2023-07-31 01:19:42.068	PUBLISHED	0	0	\N	60f33dbc-cb72-4f27-b07b-200580dd9258	382	\N	\N
22	Soluta ipsum commodi. Eaque blanditiis ipsam culpa reiciendis molestias laborum. Nisi nihil quidem.	2023-01-03 04:45:56.359	PUBLISHED	0	0	\N	5b814066-7fe6-4291-be28-8684068ffe80	383	\N	\N
14	Assumenda illo velit. Fuga inventore velit.	2023-02-15 02:23:11.787	PUBLISHED	0	0	\N	8dce9bd5-a592-4e03-9da7-6cb11c5974c7	1242	760	\N
14	Voluptatem beatae aut voluptatibus dolor similique similique. At sequi beatae natus suscipit ab hic quis harum. Reprehenderit eligendi velit totam. Explicabo neque quo quidem quae accusamus. Quasi quos cumque harum consectetur eius tempore nihil sit sunt.	2023-07-03 10:13:35.439	PUBLISHED	1052978.120866667	1	\N	11a04518-5b22-4e67-bfdd-e71557e966f1	385	\N	\N
19	Natus magni tenetur aperiam. Similique quae eligendi cupiditate consectetur sed delectus ipsam temporibus voluptatibus. Debitis ullam a minima enim.	2023-03-22 15:01:14.885	PUBLISHED	0	0	\N	9c0a1476-734c-40a0-9d14-49da370d85c2	386	\N	\N
19	Exercitationem dolorem sed repudiandae autem ut recusandae ipsum. Deserunt consectetur ipsa. Dolorum omnis sit magnam fuga minus praesentium et accusantium. Incidunt possimus error explicabo quae aut sapiente ut alias. Quas doloremque quos consequuntur maiores dolores excepturi vel. Aliquid cupiditate tempora.	2022-12-25 10:21:09.011	PUBLISHED	0	0	\N	ae67de15-91b9-404f-b593-4b91726a23a3	387	\N	\N
23	Assumenda maiores aliquid libero adipisci totam totam adipisci eaque. Quidem velit veniam. Iure error expedita fuga ut non doloremque vel sapiente cupiditate.	2023-03-27 07:20:31.417	PUBLISHED	0	0	\N	2be9f8d9-cedd-4ca4-9091-c8366fc3bfe1	388	\N	\N
22	Quod numquam nemo minima. Velit illum fuga maiores. Doloribus totam commodi quae ad quae modi. Repellat accusantium nisi earum voluptates nihil necessitatibus perferendis inventore. Facilis veniam dolores qui laboriosam odio alias voluptate aut atque.	2022-12-09 10:44:29.885	PUBLISHED	0	0	\N	e6f3d20e-7cfa-41a6-acc1-7c3343f984a1	389	\N	\N
22	Architecto deserunt saepe officia molestiae. Incidunt similique explicabo minus fugit. Cupiditate harum nulla labore laboriosam cupiditate sequi. Itaque necessitatibus possimus corrupti in quibusdam.	2023-04-15 21:18:51.92	PUBLISHED	0	0	\N	102d26a4-50fa-4734-86ab-30b69dcf714c	390	\N	\N
20	Quo autem exercitationem similique asperiores atque libero adipisci. Tempora maxime neque suscipit enim soluta. Necessitatibus iste tempora. Aliquam id eius. Modi quas occaecati nihil ullam error ipsa.	2023-05-14 02:41:51.623	PUBLISHED	0	0	\N	61b96006-d699-4ba9-8c10-5ff1b427f5b4	391	\N	\N
20	Sunt sit consequatur. Aperiam asperiores autem quas aspernatur in. Iste ullam voluptates perferendis excepturi aperiam. Totam iusto commodi.	2023-07-09 06:45:09.993	PUBLISHED	0	0	\N	f8c30b8b-3029-441d-a223-e0c8975208aa	392	\N	\N
21	Debitis quibusdam fuga reiciendis blanditiis. Nemo voluptatum delectus consectetur quod laudantium. Cupiditate deserunt quo dolorum harum saepe alias autem. Quibusdam atque quisquam itaque. Sapiente hic odit sed architecto dolore. Impedit ipsam non delectus natus facilis.	2023-06-20 01:59:41.949	PUBLISHED	0	0	\N	8745c093-e9ad-439c-b239-4523bee44d7f	393	\N	\N
14	Vitae a voluptatum a repellat totam excepturi dolorem ut. Natus voluptatibus quasi molestiae vel. Molestias error quasi quibusdam optio. Minima quidem vel.	2023-10-17 12:48:41.987	PUBLISHED	0	0	\N	e95372af-dc3a-4cdd-b38e-b469600aeb26	394	\N	\N
17	Doloremque vero aspernatur in aperiam reprehenderit ex inventore. Occaecati dolor ullam sequi alias excepturi saepe impedit. Laborum architecto facere porro odit recusandae optio voluptate sunt.	2023-11-09 20:39:19.932	PUBLISHED	0	0	\N	701d21c0-8a23-44a0-915f-7418a5ff3945	395	\N	\N
16	Nam officiis quos quaerat nobis. Vel hic modi voluptatem sit minima. Nesciunt eaque et impedit dicta. Dolor cupiditate dolore. Exercitationem est quia nemo. Iste sunt rerum delectus neque atque ab sit unde repellat.	2023-04-11 14:31:05.005	PUBLISHED	0	0	\N	b8bae573-62eb-4953-bbf9-3f12a8a89131	396	\N	\N
17	Corrupti quia tenetur similique eius quaerat tempora. Aut quae eum molestias similique animi natus. Ducimus nostrum ut fugiat.	2023-02-10 08:51:33.8	PUBLISHED	0	0	\N	8bd584a2-fe12-4262-be18-ce8964c1ccc6	398	\N	\N
20	Qui nesciunt error labore eius sunt. Cumque quidem consequuntur beatae ullam veritatis sint cumque laborum ipsam. Itaque perspiciatis occaecati placeat vitae eaque autem iure ea. Dolore itaque harum in quia. Sit quam non aut excepturi facilis. Quaerat impedit dolorum delectus deleniti dolorum consequuntur in quidem.	2023-11-27 15:24:03.697	PUBLISHED	0	0	\N	35e0a47c-dfdd-4d79-8c6d-6804998ad440	399	\N	\N
20	Libero ab nulla pariatur quisquam officia autem saepe. Quo eveniet minima ea necessitatibus. Magnam ducimus adipisci consectetur quaerat quo nisi. Animi possimus totam.	2023-01-16 20:13:56.124	PUBLISHED	0	0	\N	358ef128-fafd-430b-bc18-ad3f2fd38f2e	400	\N	\N
19	Unde libero error ratione minus distinctio quidem. Quisquam nobis fuga. Dicta enim adipisci. Nemo culpa inventore ducimus optio ipsam ab magni nam quia. Commodi nihil pariatur doloribus aliquid quis.	2023-06-09 01:23:13.571	PUBLISHED	0	0	\N	7ad5c2ee-5342-47f7-b3b8-a3dc90453a83	401	\N	\N
16	Expedita optio maiores asperiores accusantium voluptate. Aspernatur corrupti minima at similique nesciunt soluta ipsum. Vitae eveniet culpa magnam tempore sequi qui ut explicabo. Porro tempora sapiente dicta. Delectus illum incidunt fuga porro. Fuga facilis eum.	2023-09-21 15:52:14.724	PUBLISHED	0	0	\N	cd7afa66-9b2a-4499-9fc7-1a5033219aad	402	\N	\N
17	Est porro velit ab blanditiis amet delectus atque. Molestiae aliquam facilis. Iure recusandae culpa earum facere cupiditate saepe. Architecto numquam vero deleniti ea provident.	2023-09-15 19:04:56.113	PUBLISHED	0	0	\N	6a4fa47f-22cf-432f-9ab8-b803ecf0b2cf	403	\N	\N
18	Eaque quas cum cum dignissimos quaerat assumenda pariatur labore. Ipsa dolore modi. Fugit enim dicta. Pariatur impedit id expedita nam. Possimus repellat unde beatae quae alias libero ad molestias.	2023-04-29 18:48:40.117	PUBLISHED	0	0	\N	598121cf-d811-4f9d-a5fc-ed71e11bea1c	404	\N	\N
23	A dolor reiciendis vero earum saepe laboriosam error odio culpa. Corporis necessitatibus tempore at eius eveniet iure. Vero voluptates et aspernatur dolorem. Quisquam ex suscipit sed ab labore id eum.	2023-07-28 10:49:09.542	PUBLISHED	0	0	\N	d1f52184-862d-4032-83fe-44761369d3c7	405	\N	\N
16	Tempore a fuga tempora quidem quasi. Aperiam magnam accusantium officia. Explicabo explicabo excepturi qui veritatis hic.	2023-11-23 23:08:23.05	PUBLISHED	0	0	\N	b2797fea-3414-483a-a123-b11b7791fa55	406	\N	\N
21	Rerum quas maxime alias vitae asperiores. Occaecati laborum unde tempore. Natus mollitia explicabo eius cum consectetur cum similique quam. Distinctio animi culpa. At blanditiis corrupti quibusdam.	2023-10-02 14:59:13.066	PUBLISHED	0	0	\N	2734c004-4727-45bf-bc58-82e7fca2e653	407	\N	\N
23	Voluptas consequuntur eos doloremque a. Perferendis odit ex eos natus voluptatem doloremque sint ipsa. Facilis sint nesciunt quia cumque harum similique temporibus. Deleniti numquam unde illo omnis. Porro ullam ex ea quidem inventore delectus.	2023-08-15 17:41:24.614	PUBLISHED	0	0	\N	915ed919-e996-4fb8-b78a-abbb5ed08c85	408	\N	\N
18	Porro quidem tenetur explicabo cupiditate quasi laboriosam debitis. Ratione incidunt impedit culpa nemo accusantium aliquam incidunt id enim. Reiciendis incidunt nesciunt cum. Dolorum id quis adipisci eveniet non ad accusamus molestiae. Dolorem sunt praesentium ipsam repudiandae aliquam. Dicta et architecto dolorem quas sint quisquam beatae pariatur temporibus.	2022-12-08 04:28:38.034	PUBLISHED	0	0	\N	9c495e1d-31f7-4696-aa55-7208df49d242	409	\N	\N
21	Dolor perferendis deserunt impedit debitis a. Quas libero quo. Tempora itaque nesciunt. Unde tempora praesentium. Provident odio minima placeat laboriosam sequi quo nam. Praesentium ab ratione reiciendis.	2023-06-29 17:33:41.396	PUBLISHED	0	0	\N	76175b38-661d-4b68-a573-6be0b3bf9152	412	\N	\N
20	Laudantium dolorum unde. Non praesentium in. Praesentium numquam vero mollitia dolores quibusdam.	2023-07-23 01:46:22.276	PUBLISHED	0	0	\N	c0de4cf8-531f-4f17-8c03-cd451b5a91ad	413	\N	\N
14	Iure tenetur officia. Veniam quas rem minima corporis repellat natus. Quaerat nesciunt dolore id.	2023-06-28 14:32:44.74	PUBLISHED	0	0	\N	ea4b5da1-3e95-4c86-912f-4a9a4ff939ee	414	\N	\N
19	Vitae quae in tenetur quidem blanditiis repudiandae minima sequi inventore. Accusantium consectetur sit ad et delectus ipsam temporibus porro. Voluptatum architecto sed enim aspernatur mollitia odio fuga.	2022-12-20 07:15:04.472	PUBLISHED	0	0	\N	7f3cc75d-d08b-4326-afb9-60db43f8de8b	415	\N	\N
15	Totam quis accusantium impedit doloribus minus. Impedit illo quis iure atque atque amet. Neque eaque necessitatibus voluptas illo. Nobis possimus unde impedit. Quos dolorum occaecati assumenda voluptatem ipsum odio velit. Accusantium qui facilis odio.	2023-01-14 05:36:26.782	PUBLISHED	0	0	\N	00537ee9-134f-4c0b-9e19-225e4374ca43	416	\N	\N
15	Iusto est id. Repudiandae magni qui voluptatem impedit recusandae error at. Ad dignissimos aspernatur illo aliquam voluptatem voluptatibus praesentium.	2023-07-28 13:47:23.197	PUBLISHED	0	0	\N	583cd5c6-b357-4942-a9bd-7b27586c1eae	417	\N	\N
15	Ipsam omnis labore non praesentium explicabo. Consequuntur odit quod dolor animi quasi impedit in eius. Tempore eos molestias. Aspernatur quo nisi laudantium deleniti quod velit rem maxime.	2023-08-14 20:09:45.647	PUBLISHED	0	0	\N	8c636e3f-e916-4b33-a331-703d181c59bf	418	\N	\N
19	Cum fuga fugiat nisi quaerat porro adipisci. Recusandae nostrum nesciunt dolore. Quae asperiores itaque. Laudantium laudantium atque accusantium quae.	2023-02-21 16:52:24.563	PUBLISHED	0	0	\N	26f70e09-121d-4332-93f2-e18692e04262	419	\N	\N
15	Neque sapiente repellendus aliquid. Magni optio fugiat ex omnis. Neque corporis ullam sit earum. Molestias quidem aliquid numquam similique aperiam numquam doloribus sapiente sit. Architecto ducimus optio iste voluptatum tenetur aut.	2023-06-18 17:37:49.508	PUBLISHED	0	0	\N	955971ad-16df-4c0a-bb77-998efc84f84e	420	\N	\N
17	A occaecati commodi delectus et neque ipsam. Quae aperiam at pariatur itaque. Delectus architecto voluptates voluptate facere. Perspiciatis in voluptas magnam assumenda.	2023-10-20 17:05:01.419	PUBLISHED	-1262806.6982	-1	\N	4911e1a0-7ee0-40b1-af2e-7c2f6e36d53f	421	\N	\N
19	Aliquid iure natus sunt odit quis ex blanditiis. Neque nemo laboriosam recusandae aspernatur. Pariatur rem numquam molestias sed delectus. Sed cumque soluta ipsa fugit. Nisi ratione consectetur esse odio.	2023-03-26 01:43:38.948	PUBLISHED	0	0	\N	0751b61a-d67e-48b0-a1c1-4e8268a920ec	422	\N	\N
21	Exercitationem illum quam officia. Beatae temporibus magnam cupiditate magni necessitatibus. Doloremque facere assumenda. Sit impedit delectus occaecati dolorem.	2023-07-24 13:55:46.795	PUBLISHED	0	0	\N	6cc940d1-5091-44de-9634-156e4059881d	424	\N	\N
23	Ex perspiciatis odit vero. Distinctio iure corrupti sapiente autem illo unde saepe sed quaerat. Nisi molestias et consequuntur occaecati totam qui commodi consectetur ex. Non tempore fuga ad voluptates quidem dolorum delectus. Voluptatibus beatae necessitatibus enim totam ratione recusandae cum. Voluptas possimus exercitationem.	2023-07-03 14:57:08.668	PUBLISHED	0	0	\N	a56f98b0-7273-4e3b-8850-367afbd51b94	425	\N	\N
16	Ipsam voluptates dolore repudiandae. Blanditiis aliquid placeat molestiae sint deserunt totam. Cum dolores cum accusantium voluptates. Cupiditate eligendi fugiat maxime deleniti dolores vel.	2023-11-06 18:00:30.363	PUBLISHED	0	0	\N	f4f39fc8-2e8b-45ee-a516-f7d0ea64c7f7	426	\N	\N
15	Asperiores fuga fuga tempore delectus pariatur veritatis odit. Nam possimus pariatur iusto possimus eius facilis expedita aperiam repudiandae. Architecto necessitatibus quae.	2023-04-13 09:02:28.692	PUBLISHED	0	0	\N	27181505-2bd7-453a-9bad-00b6e5e6fe1a	427	\N	\N
17	Nemo esse quas ducimus eum iste harum. Minus id magni eligendi enim repudiandae eius adipisci voluptas. Repudiandae asperiores unde autem expedita repellat aperiam.	2023-06-06 06:46:58.965	PUBLISHED	0	0	\N	5c959da3-c511-4696-9936-9cc8c4c483cb	428	\N	\N
16	Illum nisi minima. Dicta sapiente voluptate. Quos illum reiciendis corrupti ipsam aliquid ab consectetur similique amet. Officia ad cum fugit esse sint sequi cupiditate. Asperiores commodi sed. Dolor sit nihil molestiae.	2023-07-29 06:07:44.145	PUBLISHED	0	0	\N	251852e2-72f8-4386-94b0-cfaafa7888ff	429	\N	\N
23	Fugiat exercitationem quidem quos repellat minus dignissimos. Totam modi voluptatum non rerum recusandae. Fugit omnis totam facere dolore veritatis accusantium veritatis. Aliquam ad dolores.	2023-10-24 01:28:48.521	PUBLISHED	0	0	\N	210a859f-1b09-4b78-956f-224e68a869a4	430	\N	\N
14	Eligendi officia aliquam assumenda. Inventore esse consectetur. Eum deleniti voluptatum debitis illo qui tenetur. Amet voluptate ab ullam veritatis nemo assumenda dolore eius. Facere aliquam asperiores voluptatum expedita ab ipsam laborum aperiam enim.	2023-07-03 10:49:00.55	PUBLISHED	0	0	\N	c501575b-57f4-439a-b54b-171b022d237f	431	\N	\N
21	Mollitia ea nulla nobis deleniti tempore similique iste aperiam. Tenetur quia at ad corrupti ex non similique. Illo voluptatum soluta perspiciatis excepturi eligendi. Ratione provident sunt neque accusantium. Atque necessitatibus praesentium modi vitae eligendi eligendi cumque hic. Architecto et vero consectetur vitae sint eius reprehenderit ducimus.	2023-10-29 14:02:52.438	PUBLISHED	0	0	\N	5ae8f721-a146-4820-84bf-3d6289de1f5e	432	\N	\N
19	Nobis laborum maxime eveniet aliquid minus enim. Libero accusantium dolor ipsam nobis rerum. Reiciendis quasi nulla maxime quos magnam labore molestias atque. Vero sequi voluptatum. Hic voluptate ipsam magni eos.	2023-06-15 06:22:47.923	PUBLISHED	0	0	\N	6e6a59d8-fcda-4d30-a3f6-a253f2f6b4fb	433	\N	\N
20	Laudantium alias voluptatum numquam. Dolorem voluptatem minima placeat qui sequi. Repellat eum aliquid ipsa sunt a eligendi eos laboriosam. Ullam soluta quos quos maxime ducimus fuga sed. Dolorem a dolores a soluta.	2023-05-30 00:35:17.522	PUBLISHED	0	0	\N	bacb9634-932c-4d68-91de-ab88ed031759	434	\N	\N
17	Quia quibusdam quia. Ex ab labore assumenda ipsum ad harum sunt. Quos facilis nisi. Animi rem omnis facilis architecto illo autem commodi.	2023-06-22 16:49:24.034	PUBLISHED	0	0	\N	b7b8508e-c9ef-4e99-ade9-efe352ab0423	435	\N	\N
22	Ipsa at aperiam. Sunt debitis ex itaque ratione dolore possimus repudiandae. Aliquam vero error dicta quam qui eos odio. Ad officia minima possimus laborum. At exercitationem distinctio sint perspiciatis. Esse iste minima dicta molestias natus recusandae.	2023-05-24 11:59:14.826	PUBLISHED	0	0	\N	691c61cd-3f1d-4158-bde4-2d4402927680	436	\N	\N
15	Autem nesciunt ipsam. Ab similique perferendis quibusdam veritatis pariatur. Animi sit rem maxime aut voluptates.	2023-02-09 10:27:45.109	PUBLISHED	0	0	\N	a8adade3-e0b5-46af-a4b0-3677e4d9ba6c	437	\N	\N
19	Quaerat id mollitia fugiat impedit nulla nobis. Quibusdam eaque rem dolorum adipisci numquam praesentium nobis veritatis. Voluptate eos aperiam quam harum.	2023-04-07 20:55:58.356	PUBLISHED	0	0	19	0432490a-c29e-49fc-ad86-a3beeae3a1f4	439	\N	\N
14	Praesentium tempora fuga esse quo possimus sit. Sequi necessitatibus maiores quo accusantium nesciunt sit doloribus reprehenderit. Eius velit dolorem. Facere perspiciatis consequatur dolorem eaque.	2023-02-20 05:13:35.121	PUBLISHED	0	0	18	9273d04d-269f-481b-a09c-4224aa680f63	440	\N	\N
14	Maiores odio eius similique perferendis. Praesentium totam molestiae expedita suscipit. Atque occaecati libero. Pariatur sit veritatis nemo vel ab eius. Tenetur illum animi sequi quae ratione facere in quis.	2023-04-06 13:59:08.126	PUBLISHED	0	0	23	523ff55a-0136-4309-a497-e2da5f9708f9	441	\N	\N
23	Fugit ipsa consectetur quasi sed. Id omnis atque. Mollitia rem eaque provident sint molestias sed quas. Deserunt voluptates cum labore.	2023-02-09 17:33:53.721	PUBLISHED	0	0	22	526d75c9-9cbf-437f-8aa9-885f408b4572	442	\N	\N
17	Fugit aspernatur repellat eos perferendis voluptas dolor autem. Ullam veniam quaerat. Rem autem nam modi ea nostrum porro reprehenderit repudiandae. Doloribus hic praesentium quos explicabo reprehenderit iste assumenda.	2023-08-05 20:57:28.801	PUBLISHED	0	0	22	22dc989b-36bd-48a1-9128-bee6095a24cf	443	\N	\N
18	Iure porro a. Reprehenderit hic et commodi molestiae placeat. Odio laborum reiciendis unde id repudiandae. Libero veniam iure totam rem neque. Cum delectus itaque ab illum distinctio aliquam iure.	2023-10-28 14:31:21.143	PUBLISHED	0	0	24	a161ae6b-26a9-47b1-9eda-b86152d3b718	444	\N	\N
21	In non odio non provident iure dicta. Magni accusamus molestiae consequuntur magnam. Ipsum dignissimos quo.	2023-06-26 15:40:59.764	PUBLISHED	0	0	19	6a13397c-c39e-43f2-9732-b6c661f34fe5	445	\N	\N
19	Dicta quae tenetur libero culpa occaecati qui. Alias maiores expedita illo asperiores. Itaque mollitia commodi laudantium optio accusamus qui accusamus. Vero quam facilis doloribus sed in nisi.	2023-09-05 10:23:37.449	PUBLISHED	0	0	19	a72471e3-1478-4ef4-ad69-bacb3f60b228	446	\N	\N
23	Necessitatibus repudiandae explicabo eos ex magni sequi sequi doloremque. Doloremque inventore velit sint provident. Sunt enim unde quae.	2023-03-23 21:24:55.395	PUBLISHED	0	0	25	a7502eeb-536e-4218-928d-42fed97147a8	448	\N	\N
19	Illo reprehenderit ut quos sequi aperiam laudantium aliquam recusandae nostrum. Tenetur nobis numquam error laboriosam sed mollitia vitae minus. Debitis praesentium cupiditate fugiat odit dicta.	2022-12-10 05:57:02.652	PUBLISHED	0	0	20	16534c74-60cf-4c2e-bf1e-57b1c98a0620	449	\N	\N
18	Doloremque temporibus tenetur repellat aut nostrum magni. Eaque laborum ab eligendi ratione. Molestias blanditiis ratione expedita asperiores architecto nobis optio recusandae.	2023-03-13 09:22:08.187	PUBLISHED	0	0	21	1d9255ee-af4a-4210-9ab9-f53717a692c1	450	\N	\N
18	Consequatur eligendi nesciunt. Corporis magni fugiat odio. Iste voluptatum aperiam minima voluptatem sed ipsa officiis.	2023-10-11 08:09:26.778	PUBLISHED	0	0	21	2e4cea2f-7372-47b6-aa04-31f31149fa7b	451	\N	\N
19	Praesentium odio qui consequatur illo ad adipisci at. Vitae eius quam quisquam numquam quae aspernatur voluptatum dolore. Consectetur possimus fuga officiis blanditiis beatae ab porro modi ullam. Deleniti libero voluptatibus laudantium corporis natus labore. Laudantium ab dolores ullam vitae reprehenderit. Sint quas facere deserunt ratione.	2023-05-22 08:25:04.361	PUBLISHED	0	0	23	fb1b7b59-6ce8-49e8-a853-d805339f7809	452	\N	\N
22	Nam deserunt ipsam omnis vero. Eveniet magni nisi iusto. Facere consequuntur fuga soluta beatae odit nemo excepturi facilis.	2023-07-28 00:26:12.266	PUBLISHED	0	0	19	537a0ea6-215f-47ac-814f-726c27ddb21f	453	\N	\N
22	Dolor praesentium qui nisi excepturi asperiores quisquam aperiam. Autem numquam placeat ipsum velit illum quasi laboriosam molestiae officia. Consectetur repudiandae possimus molestias rem laboriosam nobis iste ipsam fugiat. Corrupti deserunt laboriosam recusandae pariatur similique. Quae consequatur eligendi. Quibusdam animi non porro velit.	2023-03-24 10:58:48.439	PUBLISHED	0	0	17	3b01c16a-1627-48bc-b252-3aec1d2c4e00	454	\N	\N
23	Nihil aspernatur id ipsum fugit a in. Qui esse veniam odio consequuntur veritatis ullam nulla. Et itaque atque illo voluptas eos. Natus iure laboriosam ea. Maxime dolore recusandae exercitationem libero harum ut maxime iure id. Debitis laborum ea sit.	2023-05-25 21:52:42.718	PUBLISHED	0	0	16	6e60eee7-172e-46e5-8485-62257431b509	455	\N	\N
14	Iusto minus sit repellendus eum maiores. Neque accusantium maiores nesciunt ullam cumque error. Sit itaque tempore odio quisquam. Commodi ut aperiam earum mollitia debitis temporibus.	2023-05-04 02:35:45.233	PUBLISHED	0	0	21	afc0540f-ef9b-4eaa-a58d-4de2a7b0d05c	456	\N	\N
14	Aliquid non velit enim vero eligendi cupiditate totam repudiandae quo. Tempore atque ad optio quae fugiat. Cumque doloribus nemo dolorem facere quis adipisci maxime minima rem. Ad beatae incidunt numquam maiores cum quas laborum voluptatem beatae. In quae consequatur cum magnam vel tempore facere minus.	2023-08-24 06:11:18.356	PUBLISHED	0	0	17	7e752d57-3f92-4d8f-bb84-81612af3ffd7	457	\N	\N
18	Fugit magnam doloribus voluptatibus dignissimos vitae inventore. Mollitia repudiandae amet repudiandae. Quaerat quos iure aliquam quos rerum deserunt explicabo quos. Enim enim impedit accusamus animi eaque quisquam veniam. Illo praesentium blanditiis ipsam deleniti maiores quibusdam labore iusto officia. Amet voluptatem hic ab harum.	2023-02-28 23:51:53.082	PUBLISHED	0	0	22	a008af91-526e-4216-8054-e2300d46c722	458	\N	\N
22	Laborum nostrum ipsam nesciunt asperiores. Quia quis perspiciatis sunt sint nam voluptates iure cumque beatae. Distinctio aut nisi excepturi natus saepe asperiores. Voluptas dolores voluptas iste.	2023-08-14 04:26:13.804	PUBLISHED	0	0	20	29844a52-13b0-494a-97e6-68c25142588a	459	\N	\N
15	Itaque nostrum delectus ab quod. Facilis quis libero accusamus aperiam. Neque consequuntur commodi inventore libero quia. Nisi mollitia veritatis molestiae numquam consequatur molestiae quae excepturi. Commodi ut magni a sapiente accusantium id eligendi et. Aliquid quisquam id ex dicta.	2023-11-25 19:45:42.244	PUBLISHED	0	0	22	22b397bb-f688-4786-9874-ed26adca3aee	460	\N	\N
20	Corporis asperiores repellat a. Quos ipsa dolor nemo numquam libero quis tempore. Optio ab aliquid natus eligendi quod. A deserunt libero fuga doloribus ratione tempore perferendis maxime nihil. Repellat molestiae dolores recusandae laborum sunt adipisci officiis ut natus. Consectetur soluta dolore voluptatem nemo adipisci numquam totam quibusdam.	2023-02-15 03:38:04.317	PUBLISHED	0	0	24	847fcd4d-e91e-432e-a4c1-97a8fc5513ef	461	\N	\N
14	Officia dolores voluptate deserunt laboriosam culpa. Expedita dignissimos culpa neque neque fuga unde nesciunt repellendus. Ex quos eaque odio dolores. Commodi iusto dignissimos omnis saepe. Natus itaque sunt. Veniam adipisci magni maxime minima necessitatibus alias natus quibusdam sint.	2023-11-03 19:23:00.347	PUBLISHED	0	0	24	82ebf9ea-c91d-48f5-ab6e-d444a1af52e5	462	\N	\N
15	Perferendis maiores quae eius at repudiandae fugit. Tempora perferendis officiis. Soluta voluptate nemo consequatur dolorem nam ratione. Accusamus minima placeat dolorem omnis natus debitis doloribus vel. Quos ullam officia quidem error perspiciatis magni incidunt placeat. Excepturi ut earum libero ducimus corrupti nesciunt.	2023-07-22 05:56:51.468	PUBLISHED	0	0	24	63ec3b9d-479d-490b-a940-9af7af30c647	464	\N	\N
22	Laborum itaque quisquam voluptatum adipisci illo magnam blanditiis perferendis odio. Dignissimos beatae magnam incidunt omnis. Perferendis repellendus quaerat repellat quia.	2023-10-07 13:11:33.052	PUBLISHED	0	0	22	cb96335b-f646-45b1-81f6-3134e710a9f7	465	\N	\N
18	Veritatis consequuntur repudiandae ad cum molestiae neque odio maiores. Provident quae facilis et quo rerum id voluptate quo. Alias accusamus aperiam ducimus facilis illum facere aspernatur quia laudantium. Perferendis quos cumque qui dolorem officia ex. Deserunt minima consequatur praesentium nemo error doloremque. Sit nesciunt ratione culpa laborum rem ea accusantium animi.	2023-05-09 06:49:07.038	PUBLISHED	0	0	23	12d4645f-53e8-4e26-a538-45610120bdf6	466	\N	\N
22	Enim eum nesciunt ipsam odio. Non consectetur perspiciatis sit eaque velit odit ea quia. Minima possimus sequi cupiditate ipsum quas iste. Provident magnam saepe consectetur ea a asperiores est laboriosam.	2022-12-08 08:36:31.161	PUBLISHED	0	0	25	ee93bf1a-d3b5-433d-8c25-88d70836a0c9	467	\N	\N
21	Voluptates natus nobis quod pariatur soluta. Cupiditate alias quam hic soluta tenetur quibusdam sunt debitis facilis. Eius natus aut error possimus earum dicta vero doloremque. Ut eligendi laboriosam aspernatur eos nesciunt esse sint. Voluptas excepturi minus.	2023-04-07 18:50:10.224	PUBLISHED	0	0	23	5fa31b44-16d8-411c-bde6-a16749d5b94f	468	\N	\N
14	Autem neque tempore optio dolorem voluptates maxime a dolore repudiandae. Sint rem qui perspiciatis quas quasi expedita cum eveniet. Quia vero reprehenderit deserunt aliquid exercitationem explicabo quae iusto quam.	2023-01-27 17:41:01.835	PUBLISHED	752134.7074444444	1	23	3b6bbcde-c686-46a2-b5c6-a679581cdf6c	469	\N	\N
19	Ut quis excepturi inventore laudantium. Ea repudiandae incidunt autem. Sapiente corporis eum cumque nulla iusto ipsa nulla quod aperiam. Consequatur cupiditate maiores tenetur tempore impedit alias magnam. Molestias nobis a velit.	2023-11-20 22:52:46.866	PUBLISHED	0	0	17	a49515ed-c136-4f86-9fb1-95c2ff80e9f0	470	\N	\N
23	Illum nisi deleniti totam quas. Molestiae veniam non odit quasi incidunt saepe explicabo nihil. Veniam maiores fugit. Odio ipsum laboriosam tenetur ex. Totam totam occaecati.	2023-06-27 08:21:32.529	PUBLISHED	0	0	19	da7722f2-93d8-4d2f-860e-367e891b60ed	471	\N	\N
17	Itaque neque deserunt accusantium quos. Laborum totam adipisci ducimus perferendis incidunt ab accusantium dolor. Cumque molestiae veritatis.	2023-08-28 16:44:31.92	PUBLISHED	0	0	19	88fe724e-f582-4944-84c4-cd6a4808802b	472	\N	\N
18	Illum magnam culpa accusantium. Magnam at enim quod aliquam excepturi doloremque facere exercitationem. Minus possimus sapiente esse quibusdam corporis quaerat.	2023-08-15 02:38:03.905	PUBLISHED	0	0	19	25955db9-09f7-4c05-b3e1-b7c3d7c44a01	473	\N	\N
18	Ut quis molestiae. Facere reiciendis quis molestiae. Cupiditate quos doloribus nostrum. Eius eligendi excepturi voluptatum quasi sapiente eveniet amet natus veniam. Ea odit totam eveniet beatae fugiat nesciunt.	2023-06-29 17:34:27.461	PUBLISHED	0	0	16	5ba2fa6b-c9d9-45ac-8e28-c37c82742002	474	\N	\N
18	Est sunt quos cumque dignissimos. Error hic incidunt. Blanditiis cumque suscipit. Nobis culpa velit assumenda consequuntur quasi cumque perspiciatis facere. Cum reiciendis vel perferendis harum.	2023-07-21 08:10:11.16	PUBLISHED	0	0	21	e735ef61-5379-4278-bab7-ecd1ed43bed7	475	\N	\N
18	Libero labore repellendus nihil a inventore reprehenderit accusantium unde. Temporibus quia dolorum. Molestias tempore excepturi enim minus. Tempore magni facere odio.	2023-10-09 17:36:39.175	PUBLISHED	0	0	24	c42f6c17-f1b9-42a6-b083-a4bb96d3b199	476	\N	\N
21	Placeat nemo dicta quisquam saepe ad quasi inventore pariatur. Recusandae illo quisquam eaque excepturi veritatis molestiae molestias culpa. Quidem perferendis ipsa deleniti praesentium molestias. Expedita iste alias eaque. Repellat provident totam officia alias.	2023-04-11 12:04:39.912	PUBLISHED	0	0	16	38ba0509-d101-499b-b833-81532f9ed612	477	\N	\N
15	Suscipit ducimus harum deserunt. Provident reprehenderit nihil rerum dolorum eligendi temporibus. Harum sunt deleniti corrupti. Quidem distinctio illo facilis doloremque. Illum quia commodi repudiandae corrupti ipsa esse ab ex. Est impedit esse consectetur.	2023-04-03 21:53:22.143	PUBLISHED	0	0	18	c038f133-9027-4301-9821-ecd94dd6129a	478	\N	\N
15	Aspernatur ullam voluptas suscipit placeat distinctio molestiae officia. A voluptas incidunt suscipit temporibus vero. Minima eaque animi perspiciatis totam non dolore voluptates repellendus. Dolorum est porro et nobis amet dolores sapiente veniam rem. Quibusdam distinctio quidem.	2023-02-09 10:43:35.632	PUBLISHED	0	0	21	d6e716a0-1815-4090-870b-c67d31e77bc2	479	\N	\N
14	Labore eos repellendus laboriosam sapiente alias quos. Sequi ullam sapiente velit voluptatem cupiditate perspiciatis quaerat esse voluptas. Impedit voluptatibus dolor aut tempore laborum similique. Necessitatibus labore odit officia deserunt explicabo tenetur sint deserunt. Repellat quae sunt nihil sapiente consequuntur culpa iure perferendis.	2023-03-22 16:24:01.137	PUBLISHED	0	0	21	763526d5-8acb-43d0-adc0-e7096ed77b79	480	\N	\N
15	Fuga occaecati voluptates pariatur incidunt praesentium quo fuga quidem. Laudantium quos fugiat vero unde fugiat quos consectetur. Quod molestias fugiat corrupti beatae reprehenderit illo sed ducimus. Soluta sunt minus. Facere libero similique perferendis suscipit debitis commodi officia porro.	2023-07-12 15:21:33.924	PUBLISHED	-1070668.753866667	-1	20	4cb1d70f-7c2e-4727-9016-211313fb263a	481	\N	\N
20	Velit error voluptas necessitatibus. Illo ab culpa fuga iure. Ut eveniet ipsa natus sequi tenetur non. Ducimus dolorem consequatur repellat. Eum ea fugit tempore voluptatibus. Aut consequatur in vitae ducimus.	2023-04-19 08:25:27.049	PUBLISHED	0	0	17	6cace0fc-1a07-4046-96aa-915eb0e4a624	482	\N	\N
19	Cumque voluptate mollitia provident explicabo. Ipsam dolore quas accusamus quasi libero provident voluptatibus et. Ratione iusto dolor. Exercitationem consectetur enim.	2023-02-07 21:58:10.105	PUBLISHED	0	0	23	8d76db93-0dd8-498a-a9e5-bef9e197d76e	483	\N	\N
20	Temporibus numquam soluta earum voluptates voluptatibus maxime ad sequi. Esse suscipit dolorum ipsam consequuntur assumenda dolor. Explicabo odio blanditiis. Modi itaque possimus in maxime voluptate ipsum a. Nostrum quos officiis rerum doloribus.	2023-11-09 13:59:39.826	PUBLISHED	0	0	23	c2018f14-d8f8-43bd-a8e9-069e6d942b42	484	\N	\N
14	Doloribus minima tempora laudantium fugit nisi facere inventore quaerat. Exercitationem eveniet at voluptates dicta error. Ut earum ullam dignissimos repellat amet quod. Quibusdam autem nihil.	2023-01-20 12:09:38.854	PUBLISHED	0	0	21	cc7a253a-a32e-4bbc-8c00-f2c6388e87e3	485	\N	\N
19	Accusantium officia expedita. Voluptate dolores impedit temporibus modi iste quisquam dolorum. Amet veniam maiores.	2023-08-14 06:06:12.667	PUBLISHED	1133288.974636069	2	\N	9c4103bc-6bfa-48e7-b0f0-77d75892b877	611	411	\N
19	Non suscipit aliquid sint fugiat. Natus minima temporibus. Ea minima consequuntur dolore. Incidunt cum ipsam suscipit hic error sed debitis minima. Magni culpa quis expedita nisi expedita. Vero harum facilis voluptatum voluptatem saepe quas eius velit neque.	2023-08-01 00:19:44.467	PUBLISHED	0	0	17	a68227e0-0c01-4465-840e-9b473c41a2a5	487	\N	\N
17	Pariatur officiis tenetur mollitia at veritatis. Est consequatur minima nam in. Nulla quas fugiat ullam accusamus. Nobis ad pariatur omnis eum distinctio eaque ipsam. Inventore accusantium distinctio id asperiores inventore quasi ex sit.	2023-05-23 21:42:28.218	PUBLISHED	0	0	24	184a5458-27ab-481e-9faa-5cb028086a5d	488	\N	\N
18	Assumenda officia provident expedita commodi facere repudiandae. Cumque impedit harum architecto quam officia quia fuga quod. Ut ducimus minus rem aliquid consequatur dolorem autem. Accusantium quos exercitationem ut. Temporibus sed laboriosam nihil hic error maxime eos maiores numquam. Officia dolore debitis delectus at voluptatum.	2023-05-01 15:57:05.264	PUBLISHED	0	0	22	b77d4cb0-8264-4430-9c10-6262a365a770	489	\N	\N
20	Vitae cumque vero. Consequatur sed veniam odio. Ex provident accusantium modi pariatur. Accusamus possimus voluptatem ex architecto enim. Unde expedita aspernatur vero odio illo architecto sit occaecati. Beatae magnam dignissimos deleniti quas ullam impedit fuga ducimus impedit.	2023-03-03 13:20:06.127	PUBLISHED	0	0	21	63eb61d7-9f64-44eb-a67f-81450ac947de	490	\N	\N
20	Aliquam minima esse. Placeat neque modi eius assumenda. Tenetur sint pariatur eius laboriosam amet. Eum labore ducimus aliquid nesciunt alias quas. Odit ab quisquam blanditiis velit ratione accusantium magnam perspiciatis unde. Ducimus maxime nihil quam magnam iste eveniet vero officia.	2022-12-29 23:35:19.733	PUBLISHED	0	0	22	d340cadb-1b07-449c-a59f-7f0b7ce082fa	491	\N	\N
16	Suscipit accusantium quas. Natus velit cum fuga neque ut corrupti similique deleniti. Quisquam totam in autem eligendi quidem ipsam neque atque. Ut consectetur in ipsam.	2023-06-13 02:22:15.16	PUBLISHED	1013950.363369403	2	17	2f927371-05ef-469d-9880-d82f554c9e00	492	\N	\N
22	Earum quo impedit officiis ullam voluptatem aliquid. A quia animi. Corrupti omnis temporibus. Adipisci repudiandae impedit. Laboriosam quis ducimus ratione minus accusamus omnis. Voluptatum expedita consequatur.	2023-04-28 13:32:09.048	PUBLISHED	-926522.8677333334	-1	22	4f46bb1f-56e8-4372-ae23-9d55b20e6906	493	\N	\N
19	At occaecati ea amet. Excepturi eos ex sit vel. Ipsa perferendis accusantium est ipsam. Id quae dolorem alias corporis.	2023-10-05 18:36:36.508	PUBLISHED	0	0	17	c15acb17-67f5-4623-8a1e-5b1df8b80525	494	\N	\N
19	Molestiae doloribus deserunt at repudiandae laboriosam delectus commodi eaque quisquam. Nam sequi optio quia beatae tempora alias aliquam eius repudiandae. Exercitationem explicabo a tenetur placeat inventore perferendis nulla ipsum.	2023-02-26 14:52:17.83	PUBLISHED	0	0	25	ba838d01-1b4c-4d71-b522-28664420405c	495	\N	\N
22	Veniam maiores quibusdam quos dolorem occaecati iste eius sit. Ab hic pariatur nulla officiis. Eius veritatis veritatis. Corporis dolorem corrupti adipisci temporibus eius magni repellat quo voluptatem.	2023-10-26 10:47:46.362	PUBLISHED	0	0	23	4c7e89f0-ca78-49a9-937a-3796cbdb3a25	496	\N	\N
15	Ut quaerat labore modi consequuntur vel dolorem alias eligendi quis. Nisi nisi eius aperiam perferendis. Rerum eveniet tempora deserunt ad voluptate labore ratione. Voluptas omnis iusto nam doloremque inventore.	2023-03-23 10:46:10.008	PUBLISHED	0	0	24	38d91b9c-3380-4b10-bd47-1bc30754ab81	497	\N	\N
19	Esse rem consequatur harum doloremque aliquam ullam. Fugit magnam saepe molestiae. Dignissimos libero rem occaecati non numquam quasi. Corporis id ratione nemo.	2023-06-28 01:26:39.916	PUBLISHED	0	0	21	516331a7-ff35-4283-b4f2-34fad063ba8e	498	\N	\N
23	Nisi error maiores. Veritatis repudiandae magni laudantium est dolor blanditiis. Illum autem at inventore velit. Numquam impedit quo repellat. Maxime dolorum illo nisi. Nesciunt repudiandae maiores.	2023-07-03 19:24:33.387	PUBLISHED	0	0	17	e37dac77-dbe6-4ce1-876e-0a566b4fffd2	500	\N	\N
19	Nisi molestiae consectetur sint eligendi. Doloribus alias asperiores impedit fuga. Molestiae facere consectetur culpa hic sed eius odit. Officiis nulla voluptate perspiciatis tempora occaecati ullam. Iusto at fuga tempora. Modi illum dolorem.	2023-03-15 10:33:18.531	PUBLISHED	0	0	17	2590be95-3b64-43d5-957a-66abc83140e6	501	\N	\N
16	Neque delectus qui dolores debitis. Odio quasi ut laboriosam cum occaecati libero fugiat. At impedit fuga expedita assumenda animi porro hic voluptas quod. Quas debitis ad tempore.	2023-11-14 03:36:33.491	PUBLISHED	0	0	21	9ccbfc0c-9f5b-484a-b163-54315b618e7d	502	\N	\N
15	Dolorem cumque aliquam numquam delectus perferendis earum dignissimos modi. Aut odit qui pariatur repudiandae libero aliquam rem. Ipsa necessitatibus minus delectus perferendis ipsum earum soluta quo. Dolore debitis architecto.	2022-12-14 11:36:03.297	PUBLISHED	0	0	22	4677e106-427d-48bf-8fe4-e5444e2c8783	503	\N	\N
22	Voluptates laboriosam eligendi nihil incidunt fugit. Ipsam doloremque corporis id cupiditate asperiores. Exercitationem dolorum aperiam vitae. Porro quia beatae sed excepturi voluptatem nulla consequuntur expedita doloremque.	2023-04-14 18:38:27.001	PUBLISHED	-900051.2666888889	-1	16	73c78525-3508-4810-b784-608724ae8326	504	\N	\N
22	Ducimus aliquam sapiente velit. Quod dicta praesentium numquam beatae dignissimos iste numquam occaecati. Saepe odit unde tempora temporibus odio nemo.	2023-10-29 11:38:09.481	PUBLISHED	0	0	22	c3a7d6ca-dff3-4608-9e9c-220a22ba96c6	505	\N	\N
17	Sapiente est delectus in pariatur. Non a sint assumenda odit laborum est magni. Molestias vel ipsum voluptates accusantium alias eum.	2023-01-24 00:55:31.403	PUBLISHED	0	0	20	dd23e3f6-a006-42ce-8924-5eb750c9a0ff	506	\N	\N
19	Iusto voluptatum magnam. Tempora repellat necessitatibus similique neque voluptatibus quod hic. Voluptatibus ducimus deleniti dicta veniam dolore fugiat. Voluptates impedit alias. Minus asperiores asperiores ratione necessitatibus nulla alias dolor. Soluta aliquid architecto laborum sapiente perspiciatis accusantium ex nihil fuga.	2023-08-26 17:00:35.774	PUBLISHED	0	0	24	61428cbf-8be2-443e-a00c-b018cddd6c51	507	\N	\N
18	Labore illum optio velit iste molestias. Sed accusamus soluta earum magni repellendus sed consequatur. Libero recusandae veniam totam repellendus quam nam repellendus.	2023-07-21 21:38:40.349	PUBLISHED	0	0	24	352e135d-2528-446a-b3bb-1550d1d622fc	508	\N	\N
23	Laudantium iste totam rerum repellendus eos. Perferendis expedita doloremque beatae. Cum possimus eos facilis deleniti nisi minima incidunt ullam.	2023-03-18 14:49:03.368	PUBLISHED	0	0	23	6192add2-f59c-4163-92ae-a99cd9dafe81	509	\N	\N
15	Laudantium voluptatum animi nemo iste magni odio est pariatur. Suscipit voluptates eligendi dolores modi quo commodi ratione.	2023-03-04 08:50:15.47	PUBLISHED	0	0	\N	03511f32-5b67-41f9-a785-7137cbe11745	612	545	\N
17	Optio sapiente sunt pariatur accusantium. Dolor laborum esse nihil. Possimus a quidem odit ad aperiam. Debitis saepe ex quae dolore dolor dolor. Ut occaecati cumque id dolor libero quibusdam.	2023-10-23 03:42:34.157	PUBLISHED	0	0	18	b5646060-5d6f-4963-b3df-252feea8997f	511	\N	\N
17	Repellat ratione ullam quisquam impedit rerum laboriosam harum. Officia animi earum ipsum animi non autem magnam deserunt. Optio similique ad delectus quas repellat explicabo neque cum. At ad tempora beatae quae aliquid laboriosam. Dolore accusamus sint ex quae blanditiis neque. Quod voluptate officia itaque ad eligendi autem voluptatum.	2023-08-20 06:38:02.107	PUBLISHED	0	0	19	a29b3913-2232-41d4-83f3-64a4d2cf460e	512	\N	\N
23	Ab minima suscipit enim similique cupiditate. Deleniti voluptate aliquid ab veritatis culpa. Mollitia commodi amet sequi corrupti fuga iste pariatur explicabo ullam. Excepturi maiores voluptatem placeat accusamus. Et delectus asperiores reiciendis nesciunt odio omnis odio.	2023-09-16 15:19:23.829	PUBLISHED	0	0	23	9b76e40e-6a88-4f5e-9f15-7c6e42402ad1	513	\N	\N
21	Quia rem tempora iusto. Omnis hic itaque provident unde corrupti. Illo quibusdam accusantium perferendis non. Facere eum at.	2023-08-13 16:52:11.552	PUBLISHED	0	0	21	2681e358-a732-4a2e-9f20-3d878d4af956	514	\N	\N
17	Explicabo vitae nemo quasi maxime et. Quaerat vel illum et dolor vero aut. Impedit ea cupiditate neque magnam.	2023-08-03 12:25:30.717	PUBLISHED	0	0	19	eb72d7f4-47f5-4fcb-b6d3-4d13327c8bff	515	\N	\N
16	Quos et maiores nulla. Corporis placeat dolore ratione modi nemo sequi vero. Dolor tempore inventore quaerat. Sunt ullam laboriosam.	2023-09-25 21:00:46.475	PUBLISHED	0	0	22	36a2e56f-7126-4d2b-9a6c-511c9071403a	516	\N	\N
19	Modi minus corporis modi quos est est repellat unde. Id sint minima quidem. Optio consectetur eius voluptatem. Vitae cum odit laboriosam quae ea laborum repudiandae.	2023-07-02 14:43:43.298	PUBLISHED	0	0	19	c69d3ec2-41ce-4f74-8fc7-24cdcef56705	517	\N	\N
14	Saepe natus nam dignissimos odit recusandae architecto voluptates repellat. Architecto vitae asperiores voluptatum quae magnam recusandae commodi quibusdam. Temporibus accusamus sequi. Laborum corporis ad maiores quos quia temporibus. Ipsum animi id fugiat sapiente temporibus nulla atque.	2023-08-12 17:44:39.164	PUBLISHED	0	0	25	e42c2178-dfe0-47dd-88f4-edd8984fa3b5	518	\N	\N
22	Itaque fuga sit eligendi accusamus impedit iure occaecati eaque. Explicabo nihil tenetur incidunt facilis. Rerum eaque ad quo tempore rem quisquam perferendis. Eum minus odit debitis aspernatur nam. Excepturi sit qui ratione maiores rem voluptatibus facere omnis quisquam.	2023-01-18 03:29:39.209	PUBLISHED	0	0	24	e10e0faf-d4e4-4c4e-8ac2-326659130821	519	\N	\N
14	Commodi recusandae ullam natus deserunt eius quisquam magnam. Porro cupiditate fugit doloribus nam atque nihil dolorem. Tempora quae nemo ad quam nobis debitis vero.	2023-08-14 12:37:01.421	PUBLISHED	0	0	24	5e210f90-c8b7-479f-bd8d-c25033ad1836	520	\N	\N
22	Fuga dolor cum voluptate iure. Commodi voluptatem totam fugit dolor fugit dignissimos. Deserunt nisi culpa fugit doloremque exercitationem.	2023-08-02 16:45:35.455	PUBLISHED	0	0	20	5599e7a2-4529-4a13-9676-a7eb9c58124b	521	\N	\N
23	Accusamus non delectus perspiciatis quis neque similique exercitationem similique nemo. Blanditiis ratione voluptates quia asperiores explicabo cupiditate. Sed iste quo voluptatum ab ratione voluptatem minima iste. Eius iure repellendus est.	2023-04-25 12:14:33.221	PUBLISHED	0	0	22	f625e863-2874-4224-b952-94eb3af09892	522	\N	\N
16	Corrupti fuga dolorum a voluptatem consectetur debitis. Aliquid quos sed sit ut molestias culpa quia in aspernatur. Nulla at facilis porro deserunt suscipit illum sapiente minus. Enim nisi est iste consequuntur quo dolorem. Facere quam veritatis dolores est tempore qui odio. Expedita quam eveniet delectus.	2023-10-25 10:23:09.061	PUBLISHED	0	0	19	851aa6db-9a38-46ec-9786-8f32e05118e6	523	\N	\N
21	Tempora commodi ipsa aperiam rem nemo officia enim voluptate. At illum inventore nesciunt numquam totam non nemo. Quos ipsa maxime provident laborum eum assumenda.	2023-05-03 08:06:23.838	PUBLISHED	0	0	23	394d9c51-bfe5-4fc0-8449-67d9fb57f1e8	524	\N	\N
15	Amet illum magnam expedita aspernatur. Enim et excepturi pariatur. Laborum atque et veniam nihil minima aut. Quis rem quas. Distinctio ea dolor architecto sunt repellendus quas iusto veniam atque.	2022-12-22 14:41:50.091	PUBLISHED	0	0	23	e2a1222a-8eee-4740-8f6b-4056f510168e	525	\N	\N
21	Odit officiis recusandae omnis nam. Ipsum corrupti quod. Dignissimos beatae debitis nihil ipsa illum accusantium deleniti sunt. Corporis nisi totam in. Reiciendis nisi similique dolores similique.	2023-03-20 23:28:19.799	PUBLISHED	0	0	21	2838e492-ccae-4936-ae19-2eb3f45c7561	526	\N	\N
22	Maiores tempora magni. Laborum nesciunt quod. Sapiente vitae modi autem dolor. Blanditiis dignissimos occaecati inventore ipsa asperiores.	2023-02-24 10:41:47.258	PUBLISHED	0	0	19	c928b36f-71a7-4278-9346-4538a6619396	527	\N	\N
18	Aliquid adipisci accusamus ipsa iure. Explicabo hic velit eum iusto maiores at at eos veniam. Debitis eius nostrum quibusdam aliquid. Explicabo nisi veritatis aut soluta laborum sit nihil exercitationem aut. Eveniet porro distinctio molestias hic error fuga optio harum.	2023-11-20 21:23:43.388	PUBLISHED	1322671.630844445	1	23	6cc077b2-397b-4410-8080-d805c0903994	528	\N	\N
20	Laborum corporis accusantium at nostrum asperiores. Asperiores facilis ipsum eum quis ea numquam atque neque vero. Voluptates id corporis ratione. Saepe deserunt minus. Magnam aperiam sapiente dolores architecto distinctio earum. Id accusantium dolore harum.	2023-08-31 09:40:44.011	PUBLISHED	0	0	21	731dae3a-d741-4757-bc33-0faca9989e97	529	\N	\N
20	Dolorum reprehenderit iusto eius. Atque ipsum culpa maxime esse commodi. Aut doloribus quisquam tenetur. Voluptas quod provident neque in.	2023-08-28 15:25:20.693	PUBLISHED	0	0	21	cff5c822-1652-4122-a950-152abaa7a4cd	530	\N	\N
17	Explicabo veritatis hic illo perferendis quis facilis dolorem. Voluptate a eos facere. Veritatis omnis iusto vel officiis. Repellat porro numquam inventore ducimus quod. Consectetur optio aliquid quos asperiores minus repellat qui atque dignissimos.	2023-11-05 09:52:52.587	PUBLISHED	0	0	21	56ddd723-ddda-4a0c-a4cf-5af5b67c02df	531	\N	\N
23	Molestias ipsam fugiat cumque nulla enim minus odit sunt. Fuga occaecati itaque optio dolor tempora. Necessitatibus excepturi voluptates voluptas voluptatem nobis.	2023-02-27 13:54:26.638	PUBLISHED	0	0	18	440b0492-0f19-454f-8744-2a7e3701171d	532	\N	\N
16	Cupiditate dolorum reiciendis. Assumenda cupiditate quod modi placeat ipsum. Voluptatem porro ab. Possimus suscipit laboriosam quam animi expedita eveniet excepturi illo. Maiores inventore debitis saepe. Sit architecto dicta voluptate ratione doloremque.	2022-12-27 01:33:00.791	PUBLISHED	0	0	23	3ea8a31c-726b-44fa-8428-1e6728afcb4f	533	\N	\N
22	Consequatur quis error fugit dolorum aut. Distinctio ducimus similique maxime perspiciatis. Modi iusto minus molestias at. Odio aut accusamus ad quo.	2023-07-03 01:21:27.675	PUBLISHED	0	0	17	c91ee056-4064-47a1-96d1-ec68988275bd	534	\N	\N
16	At esse distinctio reprehenderit quia corrupti culpa magni excepturi laboriosam. Facilis mollitia vel praesentium totam.	2023-05-06 11:29:13.159	PUBLISHED	0	0	\N	deb0e384-b072-4afc-9880-763da219345e	642	575	\N
18	Quia earum iste praesentium dolore aspernatur et repellat possimus adipisci. Enim velit doloremque fuga voluptatem aut corrupti suscipit. Officiis quis provident ullam quos minima amet omnis. Ex nulla maxime repellat at error repudiandae rerum. Eveniet magni facilis. Quisquam dolorem quos incidunt praesentium suscipit odio architecto.	2023-01-17 03:23:43.737	PUBLISHED	0	0	25	93517030-fef0-444f-8e43-ff151390f4ca	536	\N	\N
17	Asperiores eius voluptas tempore quidem expedita. Cum aspernatur repellat ab vero doloremque laudantium. Omnis quibusdam perferendis soluta unde cum.	2023-08-24 20:57:53.223	PUBLISHED	0	0	22	d3a3f999-4d83-46fd-8fda-f457c89a319c	537	\N	\N
23	Modi similique reprehenderit nam explicabo nam. Provident fugit nihil dicta iure ipsam modi sequi. Esse inventore pariatur.	2023-09-28 22:44:18.971	PUBLISHED	0	0	\N	005890bd-d9a0-4693-bd65-a55b4082ff3a	538	525	\N
23	Maxime reprehenderit iure quod maxime aliquam eaque non. Hic eum adipisci consequatur. Ducimus eveniet ut accusamus nisi nam perspiciatis. Eos reprehenderit voluptas expedita praesentium. Repellendus cupiditate eligendi excepturi tenetur.	2023-10-16 21:04:33.29	PUBLISHED	1255446.073111111	1	\N	25f993a5-8b59-4f77-88ee-9025015aec66	539	365	\N
16	Ea quisquam tempora. In est voluptatibus cumque voluptatem cumque voluptate totam facilis. Laboriosam nostrum blanditiis saepe. Cum illo doloremque id qui fuga eos accusamus blanditiis repellat. Nam voluptate rem pariatur recusandae amet aspernatur repudiandae beatae.	2023-11-20 16:46:52.171	PUBLISHED	0	0	\N	209ea601-da42-413f-98f5-3acb820c012a	540	353	\N
22	Quaerat fugit blanditiis amet doloribus ex ducimus ratione deleniti ullam. Enim odio libero iure.	2023-10-27 13:20:10.908	PUBLISHED	0	0	\N	38fd1198-117b-494e-8952-d47d8d6ccf40	541	382	\N
15	Vitae repellendus ut a in alias. Enim laudantium doloribus minima ducimus. Aperiam voluptates asperiores enim doloremque. Saepe eveniet eligendi nobis.	2023-09-22 13:30:57.283	PUBLISHED	0	0	\N	65b01c0f-e191-48ca-8d06-27e1c4c51211	542	533	\N
19	Error architecto pariatur. Itaque atque qui eum est in soluta nostrum odit vel. Quam placeat dolorum quasi. Minus velit tempora explicabo nam sint ea. Quia fugit commodi porro eveniet.	2023-04-22 20:00:16.727	PUBLISHED	0	0	\N	f8dd1c93-3d74-456d-8052-55a55ceb21b1	543	519	\N
16	Et voluptas dolores. Et repudiandae inventore. Consequatur veritatis voluptates hic ipsam eum incidunt reprehenderit quod. Voluptate quos adipisci. Iusto assumenda rem sunt vitae accusamus. Consequatur deleniti facilis sequi veniam earum inventore ipsam.	2023-03-08 22:38:14.119	PUBLISHED	0	0	\N	5aac9aa2-ba16-4bd6-876e-d0fed4273eed	544	500	\N
15	Sapiente accusantium omnis delectus placeat. Ducimus labore porro suscipit non ea perspiciatis alias cum.	2023-06-03 09:40:48.629	PUBLISHED	0	0	\N	ab8b26fb-8cb6-4b43-8d58-b59d2b8729ac	545	543	\N
19	Odio quod labore velit. Molestiae doloribus nemo earum provident.	2023-10-31 22:23:43.295	PUBLISHED	0	0	\N	a97aed6f-4d4b-4646-a1bf-eaae1f48b450	546	449	\N
17	Velit reiciendis nam distinctio sapiente consequuntur aperiam sequi. Voluptatem inventore neque numquam nobis ullam amet neque quia cumque. Perspiciatis hic numquam incidunt quod tempora. Ratione sequi odit similique deserunt id.	2023-06-08 01:28:37.512	PUBLISHED	0	0	\N	5231f37c-22f4-4b1e-967e-7c5fdc7a1356	548	528	\N
14	Ad explicabo necessitatibus voluptatibus vitae sapiente rerum cumque. Non saepe adipisci tempora esse. Ipsa reprehenderit aut nulla voluptas. Praesentium accusamus neque eum officiis laudantium inventore.	2023-02-12 16:32:43.906	PUBLISHED	0	0	\N	148e7a6f-cef1-4f6d-bc9b-a6eb078bb928	549	410	\N
18	Fugiat odio esse ex repellendus corporis atque rerum. Labore odit alias quis. Laboriosam neque facere architecto aperiam nemo animi distinctio. Unde dicta nesciunt commodi repudiandae dolores esse. Necessitatibus voluptatibus nihil unde libero sunt. Sit ipsum rem temporibus.	2023-09-01 00:20:26.051	PUBLISHED	0	0	\N	a5da0a31-131d-429b-947d-7155ee8ee0a5	550	510	\N
23	Illo cumque non adipisci quia. Sapiente ab labore molestiae. Provident sequi tempora consectetur ratione minus mollitia rem odit itaque.	2023-04-09 00:37:59.053	PUBLISHED	0	0	\N	49702d4a-baef-42fc-bfee-ca8e4726fdbb	551	342	\N
19	Molestias eius tempora exercitationem tempora ipsum illo neque. Itaque sed adipisci numquam voluptates eaque itaque cumque quos vitae. Nihil neque numquam sequi expedita quia similique necessitatibus. Aut officia doloribus excepturi nihil nihil recusandae id. Laboriosam iusto quia eius id aperiam inventore debitis. Distinctio dicta mollitia vero.	2023-02-07 11:49:42.727	PUBLISHED	0	0	\N	4f3107d6-cd9f-425f-af55-1b19402906b2	552	462	\N
23	Voluptatem sit quis qui aspernatur esse. Quo earum ipsum inventore rem numquam quia nisi cumque cumque. Impedit nam facere tenetur neque facilis at.	2023-05-05 09:05:49.243	PUBLISHED	0	0	\N	1c37e75f-921c-440d-a078-0e80fc8641e5	553	415	\N
23	Animi corrupti hic adipisci libero quam necessitatibus optio voluptatum omnis. Distinctio quisquam voluptatibus itaque. Ipsa nostrum est dignissimos similique numquam. Necessitatibus rem fugit excepturi labore tempora similique asperiores dicta.	2023-10-16 18:15:37.422	PUBLISHED	0	0	\N	fc921160-19c4-4970-ba01-b5ebffbf01cf	554	366	\N
22	Nam aspernatur doloribus totam adipisci assumenda perferendis. Deleniti voluptatibus nobis dolorum voluptate accusantium quas laborum aliquid. Corrupti animi illo temporibus distinctio nobis molestias sunt rerum facere. Quidem sed omnis corporis alias esse.	2023-01-25 01:03:39.723	PUBLISHED	0	0	\N	23829264-0077-4970-ac67-e87efe53a55d	555	415	\N
21	Aliquid quaerat voluptatem nemo mollitia a. Doloremque nemo at sed omnis excepturi cumque. Beatae a repellat numquam voluptates quasi repellendus itaque deserunt ducimus. Optio ad voluptatum in cum consequatur recusandae eligendi porro repellat. Voluptatem porro at deserunt molestiae id quibusdam ad. Iusto distinctio debitis nostrum deleniti rem sapiente.	2023-04-26 23:41:58.6	PUBLISHED	0	0	\N	77cc6cbe-b85c-4732-9aac-b039cf6985ac	556	424	\N
20	Possimus harum consectetur ipsam suscipit temporibus provident iusto. Inventore distinctio suscipit similique sed. Et nihil odio veritatis eos id sapiente voluptatum soluta. Molestias voluptatem repudiandae iusto non ab.	2023-09-20 16:26:07.226	PUBLISHED	0	0	\N	ba8e77e2-abe9-4c0b-8a26-b47fa2bde02e	557	386	\N
17	Voluptatem iste odio saepe facilis debitis. Assumenda deserunt delectus excepturi.	2023-04-25 16:53:22.655	PUBLISHED	0	0	\N	1088acd0-86ba-464c-bf7c-ce5666762754	558	434	\N
22	Omnis amet nesciunt hic commodi veritatis. Ullam aperiam inventore error suscipit dolores similique error quaerat ad.	2023-11-23 01:36:27.833	PUBLISHED	0	0	\N	2c9c7d3c-7cd1-4b63-b16a-8455eb86c697	559	479	\N
17	Minus illo quae modi adipisci sunt dolor distinctio. Repudiandae beatae cupiditate sunt distinctio iste expedita ratione. Corporis ipsa repellat tempora repudiandae vero eligendi quae dolores asperiores. Facere illum quas nemo dignissimos.	2023-06-28 10:41:24.972	PUBLISHED	1043415.2216	1	\N	87cb2141-3954-410c-b87f-76bb05d1e62b	613	359	\N
18	Dicta tempora vero delectus. Nemo voluptas nam magni expedita suscipit. Ea dolorem accusamus. Corrupti aliquid aliquam eaque. Nihil molestias incidunt iure omnis amet id repellat.	2023-11-27 04:29:03.801	PUBLISHED	0	0	\N	3d3bcb07-002a-4bb3-9b91-7a17c5bc767c	561	439	\N
20	Ipsa recusandae odio facere amet itaque. Consequatur deserunt laboriosam odit at ad voluptas placeat illum. Illum laboriosam exercitationem iste quas dignissimos et voluptates. Odio labore maiores culpa sit quos placeat modi magni. Illo totam rem voluptatibus amet dignissimos eum.	2023-07-31 15:58:20.869	PUBLISHED	0	0	\N	c56d27e7-d601-4a50-bd47-83a7cda9ba18	562	493	\N
14	Doloribus doloremque esse laborum. Consectetur aut velit quaerat beatae architecto omnis. Architecto reiciendis animi quisquam. Magnam laudantium doloremque iure ea nihil suscipit.	2023-08-06 00:09:37.832	PUBLISHED	0	0	\N	5cea3953-862e-4732-9eee-745c883cdbc6	563	377	\N
15	Eaque at quae numquam earum alias deleniti. Numquam doloremque aliquam doloremque delectus laborum nisi laudantium animi.	2023-10-27 19:24:19.839	PUBLISHED	0	0	\N	aa6d13da-550e-4423-beb0-49338a25ff2a	564	420	\N
19	Officia culpa consequuntur placeat exercitationem fuga ipsam voluptate ab. Repudiandae impedit aliquid suscipit ipsam modi sint molestias. Nulla voluptas repellendus reprehenderit alias aspernatur. Voluptatem soluta non quisquam. Ipsam illum sunt deserunt magnam quibusdam voluptatem rerum. Quasi officiis praesentium sunt aut.	2023-07-16 00:47:18.462	PUBLISHED	0	0	\N	911e1b06-a948-41b6-8c52-7bfb7a99e1b7	565	560	\N
15	A velit dolores ex culpa. Necessitatibus nostrum voluptatum perferendis.	2023-02-11 12:01:52.767	PUBLISHED	0	0	\N	5c4b2028-fdd9-4cbf-95fd-0ac8842ba56a	566	547	\N
14	Repellat dignissimos fuga eius necessitatibus neque. Minima odit labore tenetur atque ad numquam ab atque. Exercitationem facere pariatur saepe nulla. Placeat tempora quidem quod in pariatur perspiciatis eligendi porro. Incidunt expedita incidunt. Possimus nam incidunt unde accusamus illo unde aliquam deserunt.	2023-04-30 18:18:31.979	PUBLISHED	0	0	\N	79819ef3-0ec3-4bf8-bf2b-7dcc9d2cbc11	567	535	\N
19	Eius necessitatibus similique modi esse quod similique ab omnis. Quasi officia enim odit quam libero perferendis vitae soluta. Reprehenderit dicta dolores.	2023-11-26 20:28:22.699	PUBLISHED	0	0	\N	d78190b2-2cc4-40d6-9f21-9e9671e27294	569	352	\N
23	Aliquid explicabo ratione ad. Assumenda vitae velit deleniti beatae. Nesciunt odit ipsa facilis tempore at. Ipsam dicta est sed numquam delectus fugiat.	2023-06-18 02:37:11.602	PUBLISHED	0	0	\N	c6856056-77c6-400e-b53e-2c1d2df539f8	570	342	\N
15	Esse quidem assumenda natus. Reprehenderit reprehenderit id tenetur necessitatibus. Natus similique ipsam nam. Inventore quaerat quaerat labore. Officiis culpa quos.	2023-04-07 14:12:56.423	PUBLISHED	0	0	\N	a33cf74d-781d-41f5-80b7-64b136981687	571	519	\N
20	Nemo at omnis praesentium at. Quam ex corrupti adipisci saepe numquam perferendis recusandae. Nobis eaque maxime sapiente facere rerum quia optio recusandae quo.	2023-07-13 23:28:33.682	PUBLISHED	0	0	\N	f1a50df9-ae23-455b-b79b-8b5bec3c7972	572	390	\N
20	Deleniti ipsum officiis dolor nostrum neque dolores quae culpa ullam. Autem saepe nisi laborum possimus maiores at est dolorem. Distinctio totam eius deserunt iste numquam possimus. Saepe dolor facilis maiores assumenda.	2023-01-03 13:49:35.812	PUBLISHED	0	0	\N	2174ed16-721f-45b7-8c10-c527c3e7324c	573	403	\N
21	Officia non fugit dolorum eos maxime voluptatem. Blanditiis necessitatibus sunt pariatur sit. Vitae quae ab nisi molestias dignissimos. Consequuntur sunt commodi vitae sunt architecto architecto.	2022-12-12 23:40:21.514	PUBLISHED	0	0	\N	e60af2bf-171b-4513-8f7a-ed594042d354	574	417	\N
23	Ullam repellat nam. Magni quas voluptatum officia tempora eum voluptatibus at. Alias officiis voluptas itaque.	2023-03-12 16:56:04.902	PUBLISHED	0	0	\N	32ec4cb1-309a-4803-a443-c6b11b888c24	575	528	\N
19	Fugiat magnam consectetur optio impedit quae voluptatibus. Fugit occaecati sit quis ad ea debitis amet. Numquam asperiores perspiciatis rerum saepe sequi quas harum consequuntur totam. Molestiae laudantium rem nesciunt et. Est eius vero impedit perspiciatis ut saepe nam. Atque cumque aliquid quaerat id mollitia optio.	2023-08-17 01:36:01.429	PUBLISHED	1138688.031755556	1	\N	d51cb06b-c583-405a-ae98-0b9c7eaaec02	576	491	\N
17	Illum eius occaecati recusandae. Perspiciatis officiis totam sit. Earum atque nesciunt atque aut eligendi totam itaque. Aspernatur soluta consequuntur sapiente placeat quos vitae pariatur qui vel. Vel aspernatur odit ducimus earum reprehenderit itaque quidem. Blanditiis reiciendis accusamus ab.	2022-12-07 05:27:05.88	PUBLISHED	0	0	\N	4838ca26-7fb9-4376-9c30-93e3a6208c0f	577	461	\N
23	Accusamus sapiente eos ipsam fuga libero itaque deserunt officiis. Perspiciatis quos expedita pariatur nihil ipsa veniam. Neque deleniti in dolore sapiente illo. Quam cumque explicabo eum nisi reprehenderit deserunt.	2023-06-13 01:09:42.741	PUBLISHED	0	0	\N	e4a68970-e39e-481b-998d-8fa3399da48a	578	340	\N
14	Soluta sequi soluta. Similique voluptatibus eum laudantium assumenda. Error odio beatae delectus. Quaerat consequuntur quaerat magni rerum necessitatibus cupiditate sequi et porro. Cumque fugiat nostrum.	2023-06-06 13:56:20.052	PUBLISHED	0	0	\N	4ca7fb33-329b-48bf-b07d-eb298935600c	579	338	\N
14	Soluta saepe laudantium harum sit porro aliquam accusamus voluptatibus. Dolorum aliquid et molestias quas pariatur laboriosam laudantium reiciendis. Nostrum cupiditate debitis odio ut voluptate. Quasi harum in molestias enim recusandae sint assumenda non cupiditate. Eveniet sapiente magni voluptatum. Cumque illo possimus quo.	2023-07-29 09:00:56.547	PUBLISHED	0	0	\N	4035fa06-cd42-4f8f-a003-d2f65133d46d	580	390	\N
17	Temporibus repellat minima enim dolorum. Ab aut recusandae facere perferendis incidunt molestiae. Molestias assumenda reiciendis ducimus adipisci dolor. Nesciunt ducimus voluptate ipsam. Vitae officiis dolor ex.	2023-10-07 00:27:29.995	PUBLISHED	0	0	\N	abc7c288-1b6a-4bee-b8eb-0f5204cc12d1	581	398	\N
21	In nulla nesciunt. Laboriosam autem harum neque. Ut beatae mollitia quaerat optio laboriosam dicta. Molestiae illum numquam mollitia ad voluptates aliquid asperiores amet voluptates. Excepturi tenetur nihil laborum neque animi. Consectetur esse culpa voluptatem.	2023-10-14 09:30:03.007	PUBLISHED	0	0	\N	46cd5b3b-4939-40a5-867e-ea5a1ee5e0e8	582	505	\N
20	Odio architecto quaerat sit maiores cum. Beatae vel autem voluptate earum repudiandae doloremque a molestiae. Officia impedit porro debitis libero officiis maxime sit laborum. Tenetur omnis ipsa. Accusantium earum sit occaecati mollitia eveniet sint porro at. Distinctio reiciendis possimus voluptatibus cupiditate ad perferendis occaecati ex quos.	2022-12-19 11:30:12.804	PUBLISHED	0	0	\N	f1d8c0f7-3023-4c65-8d22-6500bcf23c55	583	345	\N
16	Omnis officiis reprehenderit animi iste atque voluptatem laboriosam. Quibusdam deserunt quod iure.	2023-04-12 05:56:14.203	PUBLISHED	0	0	\N	1037807c-3ac0-4777-bb7a-7384d662d448	584	379	\N
15	Cum dolor fuga voluptates autem possimus harum molestias magnam doloribus. Laboriosam nihil optio nostrum delectus cumque. Ut aut consequuntur repellat incidunt provident explicabo quae delectus. Temporibus maxime provident sit odio repellat. Quas tempora facere dolor doloremque quibusdam perferendis. Harum culpa provident reprehenderit qui perferendis perspiciatis id officiis.	2023-03-24 10:40:47.224	PUBLISHED	0	0	\N	c57fbf08-b0fe-4cdb-a746-2a04e1ef4bd1	586	511	\N
20	Aut laboriosam corporis in doloremque. Corrupti suscipit suscipit culpa minima.	2023-11-25 02:11:23.178	PUBLISHED	0	0	\N	66eb4ed7-e389-4f54-b694-ad506b509f25	587	469	\N
16	Laboriosam alias ducimus labore dolores fugiat delectus. Nam architecto sed deleniti quasi perspiciatis at quibusdam voluptate blanditiis. Nulla veritatis culpa doloribus vero alias vitae perspiciatis. Cupiditate ullam magni aliquid dolores tempora illum quisquam dolorum aut. Fugiat eum a natus eaque quas optio dolorem ducimus.	2023-08-18 17:24:39.491	PUBLISHED	-1141872.877577778	-1	\N	7af3d004-df1f-44af-927c-674199ee0733	588	440	\N
22	Aliquam dicta ipsa. Pariatur incidunt sapiente libero asperiores. Eius omnis velit iure eligendi occaecati molestiae est.	2023-03-25 08:14:16.585	PUBLISHED	0	0	\N	2ea5c0e5-7da3-4346-865b-50846f7ec683	589	463	\N
15	Architecto qui facere expedita. Molestias laudantium nobis adipisci consectetur reprehenderit natus assumenda libero exercitationem.	2023-06-11 10:13:40.331	PUBLISHED	0	0	\N	68a2c48f-5d27-4d9a-b103-9de88fdbe72d	590	351	\N
17	Ipsam itaque mollitia voluptatum non. Mollitia reprehenderit inventore suscipit voluptas reprehenderit nesciunt eos. Consequuntur sed ab odio illum perferendis quam nulla.	2023-08-18 19:14:11.246	PUBLISHED	0	0	\N	d532a44b-ab1d-4edd-ae5c-853ae04cf468	591	356	\N
16	Tempora provident dolor aliquid architecto quasi mollitia ab laborum porro. Quod eum ipsum porro quisquam tempora perferendis sunt. Excepturi reiciendis eius maxime. Hic praesentium dolores perspiciatis in soluta totam dolor ratione sunt. Et ratione veritatis quo dignissimos adipisci reprehenderit.	2023-06-01 17:06:05.412	PUBLISHED	0	0	\N	d29ebf92-8708-4876-beba-3ffc0c508b42	592	549	\N
14	Asperiores nam quod numquam excepturi quidem vel culpa facilis. Laboriosam possimus consectetur vero quas iusto laudantium fugiat animi. Rerum autem rerum non dolor quis. Veritatis iusto voluptatum officia fuga corporis. Laudantium sequi perspiciatis rerum repellat ab.	2023-01-07 16:46:35.782	PUBLISHED	0	0	\N	dc97d6e1-9df2-47f5-9006-a0cb3ca879bf	593	552	\N
21	Voluptate inventore molestiae voluptates. Voluptate incidunt odio ad tempora quaerat. Unde architecto ipsam quia possimus. Ratione aliquam assumenda quae dicta adipisci culpa distinctio itaque. Incidunt consequatur eos minima porro vero facere iusto labore voluptatem.	2023-02-19 14:36:53.913	PUBLISHED	0	0	\N	8ea7bf3a-981a-43a2-abe9-8eeac3386e1b	594	395	\N
15	Dolores doloremque totam voluptates quas quibusdam. Eum odit quia pariatur aliquid atque suscipit ex incidunt explicabo. Totam voluptas corrupti libero reiciendis necessitatibus.	2023-06-11 13:17:29.375	PUBLISHED	0	0	\N	a8110ed4-cd65-4f24-b817-a99363f06545	595	446	\N
17	Dolorum commodi repellendus aut quae vel. Numquam ut repellat. Consequatur magnam doloribus suscipit nam.	2023-06-22 10:29:09.735	PUBLISHED	0	0	\N	39fdc4b9-65ea-4fc4-8002-39b136dfc99e	596	353	\N
17	Illo id facere illo maxime aliquam. Laboriosam hic facilis minus eveniet. Perferendis architecto debitis eligendi laboriosam molestiae minus dolorem sint. Incidunt et iusto. Occaecati quisquam autem similique doloribus nulla est. Nemo magnam veniam amet non libero deserunt et voluptatibus quasi.	2023-02-28 03:50:36.61	PUBLISHED	0	0	\N	41f149e5-d6f7-47e9-8ace-47c280d5c273	597	436	\N
14	Corrupti quam voluptatem sunt quasi nisi illum totam necessitatibus molestias. Voluptatibus eos iste harum ipsum animi incidunt incidunt eius error. Temporibus occaecati perspiciatis consequatur porro quaerat.	2023-09-20 08:28:54.92	PUBLISHED	0	0	\N	f9860ba2-8b36-4bd7-a65d-ae63cca3a327	598	509	\N
22	Labore exercitationem neque nam rem ad ipsam iusto. Saepe ullam provident quibusdam ad accusamus qui totam eaque. Repellendus nihil quibusdam aut labore earum dolor inventore. Odio delectus assumenda quo quasi quis repellat.	2023-11-24 18:01:51.956	PUBLISHED	0	0	\N	12f64eab-f28e-4a41-a155-2655eb73bca0	599	498	\N
18	Ratione molestias eligendi velit accusamus dolor quas possimus temporibus repellendus. Debitis repellat quas. Cumque consectetur mollitia architecto totam.	2023-05-27 05:32:35.393	PUBLISHED	0	0	\N	a9f41b88-286f-412e-a893-f57ed3f5c829	600	452	\N
18	Assumenda ipsa aspernatur praesentium non. Quis tenetur iste commodi. Ullam vero occaecati earum quam quasi illo. Accusantium voluptatibus minus dicta dignissimos veritatis soluta provident perferendis consectetur.	2023-02-20 09:52:47.823	PUBLISHED	0	0	\N	3f716f27-0215-4376-b229-8b57ce5325ea	601	349	\N
23	Explicabo quibusdam odio vero assumenda fugit. Laudantium illo quos ut ullam suscipit.	2022-11-29 09:45:32.845	PUBLISHED	0	0	\N	a64df192-80ae-41af-ac57-741934b8158e	602	487	\N
16	Facere facilis veniam illum quos est ullam. Quaerat quaerat aspernatur praesentium voluptates. Placeat aspernatur cum deserunt quas. Velit possimus totam aspernatur exercitationem autem. Doloremque dolorem inventore debitis delectus ipsam quas tempore. Eius officia hic.	2023-10-20 23:25:06.934	PUBLISHED	0	0	\N	216cfc5a-bb88-4529-8d9b-10b72fb7136a	603	372	\N
21	Quia dolorem quisquam. Dicta laudantium necessitatibus ab in beatae animi fugit. Occaecati modi asperiores. Ex cum sint veniam esse.	2023-07-01 23:19:57.448	PUBLISHED	0	0	\N	8dc60f90-e95d-4eae-8517-643e277ac4a8	605	413	\N
20	A inventore iusto. Ratione in iure. Repellat officiis ullam possimus iste. Adipisci doloribus asperiores eaque veniam minima. Iure fugit eum. Excepturi quaerat sequi quasi reprehenderit.	2023-02-14 22:50:14.045	PUBLISHED	0	0	\N	19af829b-bfcf-4e68-8a7e-3920ff84cf00	606	361	\N
20	Recusandae eos odit. Occaecati dolor assumenda neque alias. Fuga maxime ad recusandae praesentium officiis eaque. Quibusdam maxime fugit officia nemo qui ut quaerat possimus. Asperiores assumenda eaque eos aliquam illo facere.	2023-10-10 09:44:34.402	PUBLISHED	0	0	\N	281c3dcc-1ccb-48af-974f-87f0d45caf04	607	585	\N
23	Voluptatibus officia necessitatibus sed qui consectetur. Itaque sed vero. Ullam a labore laboriosam error. Assumenda voluptatem omnis molestias velit voluptates. Dicta id enim esse autem. Corporis enim voluptatum libero culpa maxime.	2023-06-25 21:57:30.433	PUBLISHED	0	0	\N	17d35498-ff09-4d73-a6b6-09331024b41e	608	379	\N
18	Distinctio eveniet placeat ipsa impedit eius maxime laboriosam. Ex magnam quo debitis.	2023-02-23 14:11:37.971	PUBLISHED	0	0	\N	25348f62-072e-4253-b564-0c798aa721e7	609	413	\N
17	Debitis quibusdam eligendi. Quos expedita tempora nam culpa enim placeat tempore tempora.	2023-09-06 03:36:30.642	PUBLISHED	0	0	\N	fffc6b97-3b72-43c6-a8be-372ecdbe950c	610	580	\N
14	Reprehenderit in tenetur amet in voluptatibus praesentium at possimus. Esse aut molestiae.	2023-02-13 20:32:30.692	PUBLISHED	0	0	\N	e88fc677-5fb5-42c8-8070-ee769b938ce6	615	339	\N
15	Asperiores nemo error quae. Officia laboriosam veniam voluptate incidunt rem qui voluptatibus. Ipsam veniam asperiores placeat saepe unde illum. Id dignissimos nesciunt cum natus quod fugiat veniam. Commodi similique ullam libero amet necessitatibus nam aspernatur consequatur.	2023-04-24 08:00:37.997	PUBLISHED	0	0	\N	c66bfe3d-000f-44a7-9b62-d9b7603b7528	617	441	\N
18	Incidunt autem nobis et laborum doloremque similique ducimus incidunt magnam. Necessitatibus minima eum maiores tenetur rem excepturi nihil architecto. Exercitationem iusto quo fugiat amet qui libero. Consectetur ipsum voluptatum unde. Facilis officia labore voluptatem.	2023-10-11 15:32:12.238	PUBLISHED	0	0	\N	9be3c4f0-2bb6-4f4f-986a-0b6da37a7689	618	338	\N
17	Sapiente eveniet perspiciatis debitis nesciunt itaque quis ad. Optio sunt officia iste ratione.	2022-12-12 00:38:33.205	PUBLISHED	0	0	\N	26e6255a-aa45-4e3b-8e12-3206e5b39efc	619	387	\N
14	Minima consequuntur voluptate aliquid cumque cumque incidunt earum dignissimos. Eos magnam praesentium facilis quam laborum nam odio. Vel inventore fugiat quam excepturi occaecati laudantium quisquam.	2023-06-22 20:24:53.49	PUBLISHED	0	0	\N	6c8f257d-d070-4c43-96e5-fb90e10ca4d3	620	560	\N
14	Consequatur praesentium architecto voluptatum totam officiis saepe quisquam ex. Blanditiis facilis necessitatibus eum inventore quis asperiores. Commodi magnam maxime minima magnam deserunt tempora.	2023-05-30 15:21:28.81	PUBLISHED	0	0	\N	b4809e72-d07d-4fb8-be7b-039c95db7af5	621	516	\N
15	Dolore sequi officia quis. Explicabo ratione molestiae.	2023-03-06 08:10:46.264	PUBLISHED	0	0	\N	4a476e1f-21cb-4aaf-8192-f835487a91c9	622	546	\N
23	Totam officia incidunt non reprehenderit dolorem incidunt harum odit. Fugit et id dolorum iste quam temporibus commodi. Modi laudantium eligendi occaecati ipsum voluptatem tenetur autem. Ad quia rerum omnis. Nihil ullam consequatur ex aspernatur voluptatibus.	2023-11-02 07:06:09.793	PUBLISHED	0	0	\N	a2ba86b1-8804-4aa9-a995-7694204cad1b	623	615	\N
15	Quia necessitatibus eaque fugit minus nam dolorum. Magni deleniti sapiente. Dolores omnis odio dolor. Mollitia fuga nobis dolore et veniam. Tenetur blanditiis perspiciatis nesciunt omnis numquam harum quos assumenda quam.	2023-10-11 14:48:13.801	PUBLISHED	0	0	\N	c9d2f7eb-012e-4ad0-8568-11c13e7227b7	624	537	\N
17	Impedit maxime et atque adipisci officiis dolor. Quam beatae alias enim sapiente praesentium exercitationem. Debitis eveniet veniam nostrum consequuntur dignissimos error.	2023-07-29 15:13:30.05	PUBLISHED	0	0	\N	fa9d4732-7bbe-4e2b-9d54-db272f1876de	625	450	\N
17	Quod reprehenderit illo pariatur rem praesentium dicta. Rerum rem nemo distinctio nihil.	2023-03-10 20:11:18.525	PUBLISHED	0	0	\N	15a00392-95f4-4060-942c-77a9ac2de267	626	409	\N
20	Magni voluptatibus neque rerum numquam harum quod in voluptatum. Accusantium corporis eum quibusdam possimus quos officia reprehenderit repellat autem. Maiores iste doloremque qui. Rerum itaque maxime eligendi. Quo nulla rerum minus.	2023-09-17 05:34:18.523	PUBLISHED	0	0	\N	13640357-1651-4aea-9473-7799b96267c7	627	367	\N
17	Mollitia dolore aspernatur. Aut animi distinctio tempora suscipit dolores commodi voluptates. Commodi ipsam error. Fugiat mollitia omnis nesciunt optio pariatur fuga. Magni illum repellat libero in dolorem sed consequatur consectetur.	2023-07-17 16:24:01.947	PUBLISHED	0	0	\N	e1758a63-a717-4799-a596-84c8c815dab2	628	626	\N
15	Fugiat dolorum totam deserunt cumque atque. Molestiae provident dolore perferendis repudiandae nisi maiores. Tempore architecto sequi eius perferendis facere. Sunt provident ratione repellendus ullam eos exercitationem porro.	2023-01-21 16:36:29.426	PUBLISHED	0	0	\N	3c1fb4be-f874-44e9-84fe-0b97694c0c8f	629	605	\N
17	Error cum repudiandae veniam dicta in officia quia repellat officiis. Amet tempore necessitatibus voluptates rem consequatur ipsa suscipit quibusdam illo. Cupiditate fuga harum.	2023-10-17 05:19:09.766	PUBLISHED	0	0	\N	0a92f6de-109c-45b4-afb8-e1aab726bc78	630	563	\N
22	Veniam sapiente harum nisi ut a. Quis odio ullam vitae modi eveniet. Iste animi in assumenda eos eum. Nesciunt odio placeat. Distinctio sapiente adipisci ducimus quisquam harum velit nam. Molestiae magnam necessitatibus.	2023-10-17 12:23:13.69	PUBLISHED	0	0	\N	4e4e4f3b-f89a-4118-ad39-c051402a7a70	631	394	\N
20	Iure minima ipsam ipsam possimus. Nemo fuga quas quaerat aliquam magni excepturi maiores repudiandae repellat. Natus quaerat occaecati reiciendis veniam facilis qui fugiat tempore. Quis unde cumque similique quidem libero fugiat corporis omnis. Odit nobis deserunt minima.	2023-07-04 12:05:54.22	PUBLISHED	0	0	\N	702105e6-dde3-4f6e-8a48-23cc014ff1b8	632	481	\N
23	Blanditiis quos occaecati praesentium dicta officiis sequi ipsum adipisci. Dolorum quod deserunt ullam doloribus rem voluptas natus quasi. Tempore fugiat optio. Repellendus animi laudantium saepe quo eum. Autem corrupti accusamus debitis quibusdam quasi.	2023-05-04 00:33:14.045	PUBLISHED	0	0	\N	85d92109-a510-4859-91da-8ecc5325713b	633	484	\N
15	Iure reiciendis aut. Totam suscipit deleniti.	2023-11-27 03:14:29.1	PUBLISHED	0	0	\N	729a6df2-083b-47d8-a5d1-03a19c16d3c0	634	622	\N
20	Cupiditate temporibus eaque quas. Quibusdam suscipit dolorem consectetur. Harum sed nihil dolorem ut laborum quidem sequi.	2023-04-10 14:19:25.652	PUBLISHED	0	0	\N	a12d929f-91cd-4a45-836f-929429ab7fdd	635	446	\N
19	Tempora excepturi voluptas totam et quisquam laborum voluptas. Est porro omnis molestias qui. Cumque corrupti ut minima quo quibusdam. Esse facilis minima. Ipsa unde quasi veniam repellendus rem provident optio. Beatae mollitia quo.	2023-03-01 19:20:29.726	PUBLISHED	815627.3272444444	1	\N	af78994b-4134-4504-84f1-2e19d4f78ea1	636	572	\N
18	Molestiae odit mollitia laudantium voluptatibus optio. Atque ut incidunt recusandae occaecati ab. Nobis beatae porro architecto voluptatem repellat labore. Nisi pariatur quam dolores. Mollitia consequatur delectus dolorem tempora fuga iure placeat laborum sint.	2023-11-24 00:34:17.641	PUBLISHED	0	0	\N	096b1fd9-2610-44a0-84cf-c2cb84cdaf9d	637	415	\N
19	Incidunt autem harum distinctio. Nihil nulla repellat quidem facere ipsa consectetur at.	2023-10-03 17:01:15.338	PUBLISHED	0	0	\N	55b38c4c-ea16-495c-af6b-38311127df9a	638	420	\N
19	Optio quibusdam consequatur expedita fugit doloribus sunt quidem. Aperiam esse eveniet numquam distinctio. Suscipit accusamus repellat maiores soluta fugit ipsum.	2023-10-28 16:23:55.522	PUBLISHED	0	0	\N	e5b20c00-cac7-4f56-88ea-f6ed31408f9b	639	350	\N
19	Placeat tempore omnis libero repellat tempora. Blanditiis dolor tempore eaque distinctio dolor. Perferendis molestiae autem modi impedit. Debitis hic corporis qui sunt. Magnam fugiat fuga iste laborum asperiores blanditiis voluptates esse esse. Culpa sit at libero cumque fugit ullam earum ut ratione.	2023-06-18 08:45:55.043	PUBLISHED	0	0	\N	97e9f421-81fd-43cb-8b41-e8de48c29ffe	640	344	\N
14	Quasi nihil iusto. Laudantium laborum aliquid iusto.	2023-04-25 06:44:25.645	PUBLISHED	0	0	\N	5c38dcb5-44a8-4cbd-813e-0560a3b7ceb8	641	500	\N
14	Illo velit veniam atque ratione. Est aut aspernatur impedit aspernatur quasi veniam dicta fuga voluptatum. Distinctio quibusdam accusamus molestias hic. Natus saepe incidunt dolores necessitatibus vero repellat tempora reiciendis earum.	2023-11-03 06:48:21.757	PUBLISHED	0	0	\N	a8b3ba6c-d208-4ca3-8be3-d7a364cfe15c	645	553	\N
16	Voluptas quia facilis tempora consequuntur dolores ab dolor blanditiis. Sed facere placeat temporibus quo veniam voluptas. Commodi et qui excepturi nobis ratione sunt.	2023-02-19 23:26:59.239	PUBLISHED	0	0	\N	b33c0600-8c53-43b3-bf28-ade86c2185dd	646	361	\N
16	Ab quasi voluptas labore molestias veritatis voluptate occaecati. Quos eos omnis quam. Temporibus nostrum tenetur similique est voluptas. Tenetur consectetur nostrum eius. Maiores cumque voluptate temporibus autem qui enim. Maxime officia dolorem placeat aut dolore a dolore reiciendis sint.	2023-07-17 16:02:12.101	PUBLISHED	1080322.935577778	1	\N	14462f94-4d69-43c0-bcf2-cc7fcf8a9c22	647	397	\N
14	Eius beatae aliquam odio nam sint adipisci vel ratione unde. Eveniet aliquam sunt et id beatae ipsam provident nulla. Velit harum reprehenderit animi necessitatibus cumque repellat.	2023-05-05 04:19:22.309	PUBLISHED	0	0	\N	21e335d8-af9d-4dc1-803f-74e6a49bd873	648	528	\N
19	Earum minima qui illo occaecati doloribus ea optio. Dicta est beatae voluptatem quia veritatis illum suscipit. Incidunt recusandae rem deserunt aspernatur at architecto voluptas quas consequatur. Ut dicta aperiam quis iusto autem.	2023-08-30 19:53:23.096	PUBLISHED	0	0	\N	97a3d5f7-54a7-410a-a421-51f754e9410e	649	600	\N
19	Cupiditate aperiam odio ipsum enim rerum vero expedita nemo. Animi aliquam sit. Maxime repellendus quia ad vel sed natus minus atque.	2023-01-10 23:18:27.21	PUBLISHED	0	0	\N	3fbe857a-9fe8-4d58-8477-ecda001b2b46	650	535	\N
20	Quod mollitia nihil voluptas qui qui voluptate quidem. Expedita ut animi libero fugit. Inventore est distinctio corporis autem voluptatum. Sunt qui nobis quia magni exercitationem. Mollitia iure tenetur magnam. Itaque expedita eligendi aliquid quidem rem hic necessitatibus corrupti distinctio.	2022-12-08 15:36:07.181	PUBLISHED	0	0	\N	e77743ad-d644-4169-bb3f-5f5d88ca55c4	651	423	\N
22	Praesentium in repellendus quam atque quidem. Dignissimos minus est asperiores quod vero laudantium.	2023-04-15 04:14:25.659	PUBLISHED	0	0	\N	4d9685a7-188c-4d05-8187-13a24d21f4be	652	650	\N
22	Distinctio alias voluptates fugiat vero accusantium reprehenderit sed sunt ipsam. Eos culpa sit dolores id. Quas inventore accusantium molestiae assumenda consequatur dolorem quaerat. Corporis fuga aperiam sed quasi provident. Quisquam sit illum esse suscipit quisquam temporibus sit fugit. Adipisci aut ex expedita non asperiores nam quisquam totam magnam.	2023-04-09 00:33:38.159	PUBLISHED	0	0	\N	4474c7e6-41f5-45bf-9b0b-4837ab37a850	653	636	\N
17	Voluptatibus similique magni aliquam ratione vel id earum est. Nesciunt facilis tempora repellendus voluptatibus saepe. Et veniam nisi ducimus quo quisquam enim itaque deserunt quaerat.	2022-12-09 00:13:38.229	PUBLISHED	0	0	\N	625d6a44-8694-4441-91d9-78d2ecd0c08e	654	454	\N
14	Sunt suscipit suscipit. Veniam ipsam excepturi pariatur ducimus nostrum vitae nostrum. Sed rerum id. Incidunt amet ullam unde magni vel aperiam dolorum. Incidunt sunt sequi dignissimos ad praesentium repellat veniam recusandae.	2023-07-11 16:29:09.433	PUBLISHED	0	0	\N	863e4324-dff4-4881-bb1c-4992abd9e381	655	389	\N
21	Debitis reprehenderit maiores. Voluptate animi corporis unde asperiores assumenda laborum quas architecto. Dolorem saepe incidunt cumque rerum ab officiis ratione reiciendis.	2023-11-10 00:46:09.338	PUBLISHED	0	0	\N	c1290216-0ded-42f0-82cb-6a13a7159558	656	566	\N
16	Accusamus unde magnam ducimus aut. Magnam enim quasi magnam. Ipsum autem aliquam. Iusto quisquam numquam. Quasi qui repellat consectetur molestias quidem numquam porro recusandae ut. Illum aspernatur vel reiciendis qui suscipit laudantium porro amet.	2023-06-18 07:50:59.012	PUBLISHED	0	0	\N	d92423df-7c42-4b8a-a58d-de014570808b	657	407	\N
19	Numquam quos unde. Quibusdam quae dignissimos laboriosam odio quibusdam reiciendis.	2022-12-20 19:42:52.789	PUBLISHED	0	0	\N	33fe5390-1b30-4ed4-82d3-deba00a8c57c	658	644	\N
18	Quas blanditiis provident laboriosam dignissimos. Error mollitia ratione magnam vel asperiores odit sunt.	2023-05-25 19:41:47.674	PUBLISHED	0	0	\N	977955c8-33a4-49d9-b922-66e4f0341318	659	539	\N
21	Nam velit inventore. Vero blanditiis placeat corrupti impedit explicabo voluptas cupiditate voluptatem sed.	2023-05-27 03:11:10.881	PUBLISHED	0	0	\N	764aabc0-9e33-49a7-93d0-fce27eed3584	660	619	\N
16	Aspernatur delectus delectus suscipit optio quaerat laudantium. Tenetur ipsum neque porro. Nesciunt reprehenderit quis nisi.	2023-05-17 18:24:40.365	PUBLISHED	0	0	\N	a838da18-dad6-4cb5-9bed-4d6c37a93d57	661	526	\N
17	Eveniet blanditiis dolor possimus veritatis cupiditate ab. Eligendi rem magni accusantium maxime corporis ad. Possimus odio architecto. Accusamus maxime commodi. Praesentium aperiam officia quidem laudantium voluptate ab eos.	2023-02-15 02:41:48.587	PUBLISHED	0	0	\N	6dc35d72-df61-4f0f-80bc-5a654afcc6be	662	431	\N
20	Deleniti harum soluta cum in ipsum voluptate. Voluptates blanditiis similique sunt consequuntur voluptatibus dolore delectus unde magnam. Animi optio cumque harum et modi molestiae voluptates. Sunt ratione unde doloribus nisi ad consequatur commodi quisquam. Vero debitis modi quia atque repellendus corrupti porro repudiandae.	2023-06-05 23:28:14.238	PUBLISHED	0	0	\N	fadac20e-4b68-432a-a6da-3761bf43d140	663	556	\N
20	Consequuntur inventore vel incidunt non dolores cum quia. Atque iste odit illo iste dolor dolores. Similique enim deleniti incidunt. Ducimus error omnis assumenda id fugiat inventore deleniti explicabo. Beatae veniam alias. Delectus aliquam ratione illum eos cum.	2023-05-12 21:34:11.173	PUBLISHED	0	0	\N	43006a56-2db8-411a-95de-8bae01d8f6cb	664	435	\N
15	Natus saepe officia repellat expedita quisquam iusto id magni. Praesentium quos tempora odio inventore quasi id saepe eveniet.	2023-11-10 05:43:10.194	PUBLISHED	0	0	\N	7c040378-b55d-4e9c-994e-0d46a533e517	665	573	\N
14	Vero sit fugiat temporibus enim labore. Ea earum laudantium consequatur explicabo aperiam autem dolore veniam ipsa.	2023-02-14 12:36:52.193	PUBLISHED	0	0	\N	197f869c-c2e1-436d-a178-51eda425a084	666	646	\N
15	Labore nihil quae officia necessitatibus error ex vero quos totam. Facilis iusto eum sed totam aspernatur. Nisi saepe sunt adipisci atque qui quos eos at. Praesentium autem corporis vero animi tenetur deleniti voluptates. Impedit sunt iusto tenetur id unde. Consequatur iure id veniam provident qui rerum qui ratione incidunt.	2023-04-27 19:55:11.331	PUBLISHED	0	0	\N	c48ee9e7-92d4-42cf-bdc8-98fdda69771e	667	516	\N
23	Esse perferendis qui deleniti aliquid. Deserunt itaque quos tempora. Possimus modi vero. Voluptates nostrum officiis id necessitatibus.	2023-10-13 09:02:16.435	PUBLISHED	0	0	\N	6546a0a9-38ec-42c0-84d5-8aa128f8e08d	668	499	\N
20	Tempore in magnam eos itaque magnam. Facere nostrum ipsa voluptatum accusamus ipsum. Molestiae quasi asperiores nulla ad soluta voluptatem nisi eligendi dolores. Blanditiis placeat odio rerum dignissimos eaque. Nihil delectus tempore veniam odit pariatur. Perferendis ab quas iure earum error doloribus dignissimos.	2023-09-26 12:24:10.969	PUBLISHED	0	0	\N	828e4c57-6316-46ab-88a8-bc3eb2ca124e	669	380	\N
23	Recusandae perspiciatis at nisi modi. Aperiam animi iste ex accusantium nemo cumque illo suscipit. Officiis labore natus neque tempora minus corporis. Blanditiis debitis dolor vitae.	2023-08-07 12:51:53.474	PUBLISHED	0	0	\N	d77789e9-aab1-425a-90ea-f101930c141d	671	655	\N
20	Quia facilis vitae mollitia. Atque vel quod rerum aperiam earum corporis aut. Nesciunt provident eaque placeat dolorem.	2023-11-16 07:56:17.531	PUBLISHED	0	0	\N	49d84a5b-db5d-4693-86da-c2f3e29b67d6	672	532	\N
19	Accusamus unde temporibus similique autem exercitationem ullam eligendi iusto. Nulla voluptatem architecto debitis vel magnam tempora velit dolore eius.	2023-03-26 18:53:00.871	PUBLISHED	0	0	\N	bd8901cf-0ffb-4968-ab22-dc52aea0efe7	673	402	\N
20	Impedit voluptatibus accusantium dolor. Excepturi sed beatae consequuntur recusandae labore quasi. Repudiandae quaerat saepe perspiciatis quisquam mollitia. Ex fugit quam dolores commodi corrupti.	2023-03-05 22:19:59.164	PUBLISHED	0	0	\N	7d9fc02c-92a3-48ce-a858-82195235d8e6	674	339	\N
21	Sunt nobis iure officiis labore suscipit nulla quo mollitia. Ut optio rem voluptatum doloremque. Adipisci architecto aliquid.	2023-04-27 13:47:57.896	PUBLISHED	0	0	\N	04c2a48d-e0bf-40c1-b01f-36c2686395ab	675	368	\N
16	Mollitia rerum inventore voluptates accusamus. Earum voluptas ex at. Dolorum quos asperiores officiis in tenetur quisquam dolorum.	2023-09-09 10:34:28.731	PUBLISHED	0	0	\N	8fd7f18e-da12-4ba2-bc24-c50dba2efe24	677	673	\N
19	Consequatur nisi eius labore architecto at quod. Omnis necessitatibus reprehenderit. Repellat omnis consectetur iure. Mollitia repellendus cupiditate ab pariatur dicta. Asperiores et ab ab dolorum minima dignissimos quis consequuntur. Optio asperiores magnam quod.	2023-01-18 22:02:34.223	PUBLISHED	0	0	\N	c21efb63-c303-419d-9713-03778f9f864d	678	633	\N
18	Laudantium rem aspernatur accusantium pariatur quam nisi eveniet. Illum maxime animi sequi itaque. Quod iure atque ut illum in quidem nihil. Eveniet tempora quas praesentium provident dolorem consequatur.	2023-06-06 02:30:08.892	PUBLISHED	0	0	\N	ec69199a-a88c-4647-b2b3-c7e7c273f35c	679	652	\N
22	Unde at ut voluptates error similique tempora beatae in omnis. Iure eos voluptas neque illo iusto alias ipsa quisquam blanditiis. Fugiat nihil enim. Similique at eos dolore porro dolor. Veritatis aliquam quo corporis magnam voluptatem ducimus ipsam a. Maxime quos delectus mollitia a quibusdam modi.	2023-02-17 04:38:41.862	PUBLISHED	0	0	\N	8f0c2a79-08ab-4b78-994a-9a75b2b968d7	680	550	\N
15	Perspiciatis similique porro aspernatur recusandae ut cupiditate hic dolores nemo. Voluptatibus eius nulla atque. Laudantium maxime vitae. Doloribus voluptatum repudiandae quasi dolorum quidem ut iure quis. Dolorem praesentium officiis.	2023-10-25 17:06:10.676	PUBLISHED	0	0	\N	b7d38310-9932-4809-ace9-457ccfc3bb99	681	421	\N
20	Animi sapiente molestiae non. Ipsum repudiandae doloribus quis dolores. Natus saepe commodi. Asperiores saepe voluptatum repellendus vel. Ullam reiciendis rerum ullam repellat dignissimos.	2023-03-17 08:41:28.66	PUBLISHED	0	0	\N	f564f6d5-eba1-4d5d-8c46-0b0bd6c3b28b	682	577	\N
17	Repellendus natus laborum cum est molestiae molestias maiores. Rem nobis eos asperiores harum hic. Officia voluptas occaecati. Asperiores quo nihil animi illum dolor quis laboriosam ad. Rerum voluptas hic error reprehenderit consequatur.	2023-03-18 15:37:07.849	PUBLISHED	847969.5077555556	1	\N	b41cac4e-1899-4886-8cc7-bc4857ff010a	683	399	\N
16	Optio sapiente sit officia dignissimos nam. Temporibus cupiditate aliquam. Laboriosam sint veritatis nemo accusamus. Tempore facere adipisci rerum rem minima natus ad. Repudiandae earum deserunt sint itaque numquam amet quasi inventore totam.	2023-02-06 12:06:54.357	PUBLISHED	770889.2079333334	1	\N	1e2bb289-00b0-4dbc-85bd-ff25ee732d95	684	540	\N
22	Placeat pariatur provident nesciunt. Officia minima sequi perferendis sit laboriosam. Provident placeat quaerat aperiam amet ducimus modi odit. Cupiditate esse soluta natus totam odit repellat delectus. Doloremque sint quaerat ratione vel illum commodi ut.	2023-02-22 23:56:51.096	PUBLISHED	0	0	\N	25811175-d5e7-4bf4-a748-6c6bb6752555	685	648	\N
16	Quibusdam repudiandae occaecati. Cum cum suscipit.	2023-06-18 19:12:22.084	PUBLISHED	0	0	\N	a8101bd1-5810-4338-9f84-ef0bf991b727	686	457	\N
14	Commodi doloremque eveniet sed dolores. Enim ea nesciunt dignissimos porro nam pariatur. Magnam doloribus autem accusamus vel perferendis deserunt. Corrupti dolorum nostrum fugiat voluptas fuga temporibus accusamus explicabo.	2023-06-14 04:35:29.663	PUBLISHED	0	0	\N	e6f41db3-2042-43d0-881e-5111b9c9f2b2	687	536	\N
21	Occaecati aperiam id magni. Voluptates cupiditate delectus minus occaecati corporis laudantium. Itaque laborum ducimus illo architecto. Provident illum ad voluptatibus. Sunt necessitatibus fuga atque.	2023-05-22 11:23:07.985	PUBLISHED	0	0	\N	da70636e-493b-4061-8136-763bb4c54dbe	688	532	\N
15	Magnam cumque rerum ullam. Cum officia nam iste corporis quaerat. Beatae reprehenderit porro.	2023-06-11 02:08:57.754	PUBLISHED	0	0	\N	0dafdfae-fab0-4aee-87c5-9e4f13f50b82	689	568	\N
17	Quod placeat quaerat animi explicabo laborum voluptates magnam repellendus sunt. Magnam rerum aliquam delectus ullam maxime laudantium soluta. Eveniet doloribus illo id facilis. Quod occaecati molestias.	2023-03-14 16:58:23.669	PUBLISHED	0	0	\N	9cb5e32a-06e0-4897-8a8c-f3fd8af20476	690	377	\N
23	Minima eos debitis aspernatur. Ut fuga quam omnis earum ad ad. Tempora blanditiis voluptatem vero nisi quis numquam quaerat tempora. Repellendus vel assumenda natus ut quidem hic inventore repellat. Qui voluptas dolorum consequuntur dolor possimus.	2023-04-25 19:36:11.793	PUBLISHED	0	0	\N	d2133b24-c4a9-4ba5-ada4-6bb845a9a880	691	518	\N
22	Rem rerum velit animi quia officiis quidem amet a. Eligendi facilis expedita. Ea nulla repellat fugiat eligendi. Voluptas nobis perferendis sapiente sed suscipit. Molestiae at nam.	2023-11-22 08:46:18.416	PUBLISHED	0	0	\N	0d8e1051-0417-4397-b5b0-8af77f4a92c3	692	442	\N
17	Ut libero voluptatem reiciendis fugiat. Adipisci magni a eligendi alias. Asperiores ea quia doloremque nostrum doloribus. Ea quisquam blanditiis accusantium deserunt dolor laudantium similique. Architecto recusandae sit laborum dolorem ducimus odit totam libero.	2023-11-18 05:54:22.303	PUBLISHED	0	0	\N	faf4c79e-eb88-4e55-bd51-495b0ecfb8c4	693	484	\N
17	Voluptatem exercitationem ex sapiente labore. Quia quos quibusdam ducimus dolores ut quisquam nemo dolore. Explicabo dolore aspernatur cupiditate corrupti. Quibusdam totam iste ratione. Cum rem et rem. Neque maiores velit.	2023-08-25 21:53:38.243	PUBLISHED	0	0	\N	4ea5855a-bf45-4a68-86ad-1e08aa811672	694	662	\N
15	Facere eius pariatur ut vitae. Occaecati dolorum voluptatem minus inventore dolorum dolore culpa ea suscipit. Similique deserunt aliquam exercitationem reiciendis provident ex delectus ipsum.	2022-12-16 10:11:24.502	PUBLISHED	0	0	\N	00b1fbca-bc80-4a3b-b6e2-7d68ec310428	695	470	\N
22	Consectetur repudiandae sapiente iusto sit at suscipit placeat doloremque iure. Dicta repellendus nam.	2023-04-06 10:31:15.72	PUBLISHED	0	0	\N	5852ed20-8ae3-4476-befd-37b23963722f	749	637	\N
18	Id est occaecati. Quisquam nesciunt dolore labore. Quaerat pariatur voluptatibus dolorem iure voluptas.	2023-11-13 15:58:44.028	PUBLISHED	0	0	\N	ddf37951-0733-4e9f-afdb-a062da286fc5	697	490	\N
19	Impedit iste voluptatibus minima iure delectus ducimus fugiat minima debitis. Repudiandae non esse praesentium. Soluta minus perferendis dolor magnam neque ipsum fugiat cupiditate.	2023-05-05 14:26:27.438	PUBLISHED	0	0	\N	7be63430-d2ef-4ffb-87e5-9e7d981c6609	698	609	\N
20	Eum eius odit consequatur quis. Inventore harum iure hic quo. Voluptatibus autem beatae ullam quasi. Repellendus cumque hic a.	2023-04-23 03:51:19.73	PUBLISHED	0	0	\N	a107e8c4-28b1-4398-94d7-7c6dfa35f777	699	593	\N
18	Dolorum eum tempora aperiam perferendis sequi similique ipsum accusantium. Asperiores totam magnam officia harum accusantium. Aliquam commodi at corrupti. Rem sequi consequuntur recusandae error.	2022-12-31 21:38:26.696	PUBLISHED	0	0	\N	b19faaa1-b7d1-4338-ab03-8d47d93ef5bc	700	419	\N
16	Officiis quod eveniet dolores aliquid repellendus quos placeat aut ullam. Iusto blanditiis voluptatum numquam voluptas et repellendus rem ad consectetur. Sapiente magnam cum odio. Eveniet a reiciendis. Earum nemo aliquid occaecati earum repudiandae.	2022-12-20 00:54:13.905	PUBLISHED	0	0	\N	3fbad953-818e-4ff3-ba1c-c17d5da9b12c	701	489	\N
19	Illo sapiente nisi quae sit quidem consectetur quo. Nam magnam nulla cum totam dolor autem consectetur quibusdam eaque. Labore quia hic a aliquid commodi modi. Iste velit ab error.	2022-12-09 23:08:58.293	PUBLISHED	0	0	\N	26297610-0836-4e38-a6d3-fb7d2de598c1	702	530	\N
16	Sapiente odit accusamus explicabo eveniet architecto ut perspiciatis error. Nulla pariatur eveniet debitis maxime sint deleniti incidunt ad dolores. Eius reprehenderit veniam quisquam saepe autem dolorem ducimus labore. Non ab ipsum recusandae hic itaque. Necessitatibus dolorum velit velit consectetur eaque corrupti.	2023-02-04 02:31:36.257	PUBLISHED	0	0	\N	30ccca3d-37dc-4e3b-8e1e-5c0fa41db298	703	600	\N
19	Vel fuga tempore accusantium quia. Temporibus facere enim magnam ratione nesciunt labore provident fuga. Dolore non iste facere corporis praesentium. Dolor odio deserunt nisi fugiat. Provident nam omnis fugit repellat. Aliquid voluptatibus aspernatur corrupti.	2023-08-01 19:24:23.444	PUBLISHED	0	0	\N	cc7756e6-005f-4855-979b-54f4e28ee01a	704	520	\N
14	Ullam doloribus sunt nemo dolor odio optio doloribus. Debitis veniam facilis magni. Laudantium pariatur quisquam laudantium ducimus asperiores veritatis nihil. Ab consequatur sit neque sed laborum tempora. Consequuntur cumque blanditiis.	2023-10-19 07:34:32.309	PUBLISHED	0	0	\N	2aaa7b7f-89c7-455a-b1ae-1b8eefcc0e90	706	675	\N
18	Enim aliquid pariatur dolore accusamus optio quaerat quas nesciunt praesentium. Veritatis harum quis architecto quod incidunt laborum consequuntur. Laudantium quas nihil ab non eaque unde.	2023-11-17 08:48:58.453	PUBLISHED	0	0	\N	e681f676-200e-43d0-b564-ff80adbc564b	707	571	\N
16	Quibusdam quam quam nemo eligendi nam nam voluptatem aut. Excepturi ipsum aliquam veritatis cumque ut fugiat amet tempora dolorum. Blanditiis necessitatibus ea itaque incidunt voluptate.	2023-08-22 14:55:53.696	PUBLISHED	1149354.526577778	1	\N	2176c3a2-a2a9-41b3-b39d-c6ac746e3435	708	623	\N
17	Earum impedit aut ipsum. Dignissimos incidunt sapiente at debitis molestiae dolorem.	2023-02-22 01:07:12.988	PUBLISHED	0	0	\N	7e9e086e-4e5e-43ff-8bb5-b9fb2c957c05	709	425	\N
19	Accusamus provident consequuntur soluta vero. Natus natus consectetur minima quisquam corporis. Hic sunt reprehenderit beatae numquam.	2023-03-05 20:25:46.514	PUBLISHED	0	0	\N	89006fc0-3b46-43d1-b8a0-95e5ac6542d0	710	595	\N
16	Error quae ducimus accusamus earum neque voluptatum facere. Laudantium similique debitis. Dicta debitis eaque laboriosam blanditiis sapiente optio laboriosam provident. Vitae enim ipsa nesciunt ipsum. Enim quam qui optio porro inventore exercitationem dignissimos sunt. Occaecati illum numquam sit laborum.	2023-05-03 14:37:44.742	PUBLISHED	0	0	\N	c55c21ca-84f4-4d0a-8b80-a157e27634ae	711	708	\N
14	Quod consectetur facilis vitae repellat modi pariatur. Voluptate aliquam iste odio commodi tempore.	2022-12-22 10:41:43.709	PUBLISHED	0	0	\N	7b7ce9c2-8c50-4d49-b095-bc66ac733af8	712	573	\N
21	Rerum hic laborum accusamus natus odio laboriosam officiis iusto illo. Officiis et beatae omnis placeat facilis ullam soluta quo. Quaerat iure vero nulla.	2023-08-31 16:04:52.007	PUBLISHED	0	0	\N	ad72fd31-7603-4e1c-a67d-cbc59c6df439	713	548	\N
18	Consequuntur in odio commodi est. Dolores doloribus provident qui atque officia quia esse. Iure explicabo dolorum vero quae porro nisi quasi. Earum saepe molestiae dolorem excepturi accusamus atque labore cumque. Pariatur voluptas quasi unde vero ratione ad possimus.	2022-12-24 00:17:06.803	PUBLISHED	0	0	\N	9e2a19e3-d133-4d20-84a5-52577fd19887	714	470	\N
19	Consectetur est pariatur voluptatem eveniet maxime cumque voluptates. Natus provident quae debitis dolores temporibus numquam praesentium iure. Asperiores aliquam optio ea dignissimos voluptates neque blanditiis error. Dolorem corporis deserunt vero quod temporibus et. Accusantium magnam eos ex totam error est blanditiis assumenda.	2023-06-11 03:39:48.205	PUBLISHED	0	0	\N	62bc674d-3764-4d14-8a9c-70e75e760bfd	715	567	\N
15	Consectetur harum placeat occaecati nam facere illum. Neque blanditiis earum aut odit exercitationem magni. Excepturi cupiditate quia enim odio. Laborum at asperiores. Exercitationem impedit iusto illo voluptatum dolorem. Perspiciatis illo labore officiis facilis.	2023-09-03 14:20:52.638	PUBLISHED	0	0	\N	555e26fc-6d4b-41b4-8680-e0d9ec5e9844	716	397	\N
22	Dolores nulla minus error commodi. Culpa expedita deserunt veritatis nesciunt. Cumque asperiores eaque quasi. Ipsam voluptates atque blanditiis ratione repellat deserunt voluptates. Minima ipsa dignissimos dolores blanditiis itaque accusantium. Aspernatur quidem dolorem sunt pariatur explicabo sunt quo consectetur.	2023-03-25 17:51:09.734	PUBLISHED	0	0	\N	1f33b9c3-3221-4470-9d0a-12a2eedfa661	717	505	\N
23	Pariatur veniam repellendus rerum. Itaque voluptate corporis temporibus doloremque. Minus tempora hic. Veniam aspernatur itaque. Sapiente eius illo dolorum ad. Ipsam reiciendis quibusdam.	2023-10-05 06:37:25.632	PUBLISHED	0	0	\N	cabf5db3-4c20-427b-8e61-ebe9e4e07e89	718	710	\N
15	Incidunt beatae ut alias deleniti officiis. Molestiae commodi culpa commodi accusantium eum. Totam officiis ipsum accusantium. Magni enim quia quod magnam voluptate repellat veritatis quas soluta. Cupiditate similique iure pariatur corporis eius quod deleniti architecto.	2023-09-28 22:00:08.323	PUBLISHED	0	0	\N	58cb2e80-86cf-4d13-91be-b657086d904e	719	392	\N
16	Illo vitae iste similique modi porro recusandae eos perspiciatis id. Occaecati eos asperiores quasi accusantium tempore. In doloremque fuga. Vitae cum ab. Fugit odio totam iste. Laboriosam perspiciatis excepturi a reprehenderit architecto error.	2022-12-09 04:43:53.721	PUBLISHED	0	0	\N	8ce17c15-40b4-418a-9cef-a14dc0e563c9	720	398	\N
17	Beatae autem officiis officia ducimus fugit. Odio accusantium temporibus blanditiis beatae quisquam. Quibusdam laudantium iste excepturi iste itaque porro id laudantium voluptatibus.	2022-12-16 03:08:00.749	PUBLISHED	0	0	\N	609396ec-a04c-4c27-9667-71c427795f31	722	562	\N
22	Natus adipisci reiciendis impedit eaque deleniti commodi expedita. Neque magnam accusantium totam fugit. Exercitationem numquam tempora eius sit saepe hic voluptate. Ipsa fuga cumque fugiat unde a beatae. Alias repellat quisquam. Exercitationem quibusdam quisquam minima.	2023-10-18 10:40:36.166	PUBLISHED	0	0	\N	67c13774-a428-4a9e-9f06-5a75242dd2be	723	627	\N
21	Id perspiciatis voluptatem similique. Consequuntur libero esse quos sit perspiciatis autem qui odio. Distinctio nihil exercitationem minima ratione.	2023-03-03 18:01:47.752	PUBLISHED	0	0	\N	61fb787f-81e4-4872-bfeb-05d29be0015c	724	699	\N
20	Magnam earum assumenda perspiciatis ad. Consequatur distinctio quidem.	2023-05-02 08:15:42.81	PUBLISHED	0	0	\N	ac5e0dd6-a51a-4358-b4ad-5cf824b9a636	725	499	\N
14	Iste nisi nihil neque consequuntur voluptates quos maiores. Error error voluptas nisi ipsa dolore tempora suscipit voluptas eligendi. Natus debitis ullam.	2023-04-17 05:25:32.2	PUBLISHED	0	0	\N	134068bf-4e93-4619-8fb9-93eaa221818c	726	445	\N
14	Voluptate dicta nemo. Quos modi mollitia quo molestiae non alias.	2023-03-06 12:33:40.554	PUBLISHED	0	0	\N	133d0142-1650-4844-9a13-ce4270f46b4c	727	582	\N
16	Maxime culpa quisquam eius. Molestiae minus quos similique aliquid. Corporis aspernatur alias voluptas quae quasi blanditiis porro. Minima occaecati et nostrum exercitationem alias nostrum laborum. Repudiandae voluptatem explicabo sint.	2023-02-04 01:35:13.475	PUBLISHED	0	0	\N	90dd1c74-5060-4c89-a507-bff9f9163832	728	677	\N
21	Culpa incidunt omnis. Impedit dolorem quos perspiciatis amet quas. Officia possimus esse impedit nemo. Odit vel corrupti autem beatae. Asperiores eius exercitationem sapiente nisi odio quibusdam cupiditate recusandae. Accusamus perspiciatis vitae labore provident doloribus iure veritatis excepturi earum.	2023-07-10 01:52:06.857	PUBLISHED	0	0	\N	04c12064-ea9f-46ce-ba15-de8aaf1bca49	729	505	\N
22	Ratione maxime a illum ducimus iure dolores quod asperiores. Nulla cupiditate eveniet.	2023-05-05 21:50:32.399	PUBLISHED	0	0	\N	771ead18-d9bd-4f6c-8302-56212227e44e	730	634	\N
22	Fugiat totam eum. Sit reprehenderit veniam natus temporibus labore autem. Ducimus qui molestiae aspernatur. Ducimus ducimus expedita repellat ullam vitae tenetur fuga fugiat.	2023-11-02 08:43:58.974	PUBLISHED	0	0	\N	30a12b72-fc50-4c9a-a669-20b2c38690f5	731	606	\N
23	Perspiciatis sed ut earum neque. Architecto vero ut tempore eaque eaque magnam sit. Tempore earum expedita doloremque porro. Repellat itaque quaerat quo tenetur aliquid.	2023-05-01 10:48:15.737	PUBLISHED	0	0	\N	092ab603-51a5-4464-8a74-1df6bb2feb6b	732	551	\N
15	Eius adipisci cum voluptatibus suscipit. Modi nemo minima inventore necessitatibus at illum atque nobis sed. Fugit ipsum nostrum porro tenetur a odit laudantium. Beatae dolores ipsum commodi illum cumque aliquam magni ipsam sint. Error architecto voluptates incidunt quia saepe sit minima.	2023-08-16 12:45:57.519	PUBLISHED	0	0	\N	161c5d0b-25e6-4320-af02-53a1d94ea22c	733	642	\N
18	Amet maxime in. Delectus a saepe reprehenderit tempora numquam. Quidem reiciendis consequuntur quia vero in earum.	2023-07-21 05:02:47.776	PUBLISHED	0	0	\N	ed3f179b-a366-4c5b-8cdc-535d499a93b5	734	679	\N
17	Aliquam molestias distinctio quaerat aspernatur. Adipisci rerum animi consequatur. Laborum accusantium ab. Aliquid non quis fuga. Praesentium laboriosam vitae quasi dolor.	2023-09-25 04:53:42.161	PUBLISHED	0	0	\N	99ac927d-e39d-41f8-84ff-f3154c811cf0	735	562	\N
19	Facere sed odio fugit officia minima. Eum voluptas nam porro ut incidunt odit excepturi. Mollitia atque pariatur odit ratione dicta. Eum nisi repellat doloremque veniam. Laboriosam quis voluptatum veritatis quo voluptatibus deserunt consequatur. Fugit corrupti veritatis consequatur.	2023-01-21 03:37:19.943	PUBLISHED	0	0	\N	ae352674-0582-497a-afd3-e83ce4691612	736	376	\N
23	Dolores assumenda error perferendis. Odit architecto vitae fugit totam omnis perspiciatis occaecati asperiores officia. Modi repellendus quod ab suscipit. Molestiae aliquid deleniti dolorum rerum doloribus tempore ratione ipsum optio. Quo cumque et ex non blanditiis sunt.	2023-06-26 20:07:50.994	PUBLISHED	0	0	\N	33955dfe-da14-41cf-acd2-161ed2ff57fb	737	415	\N
21	Autem aspernatur magni quisquam quibusdam. Perspiciatis velit molestias mollitia ipsum fugit minima a. Dolorum assumenda odit recusandae dignissimos non dolorum delectus doloremque aperiam. Ut maxime sed ratione. Corporis perspiciatis tempore ea alias soluta soluta sint quasi officia.	2023-06-20 22:32:16.085	PUBLISHED	0	0	\N	9e97ee98-c3af-4184-af94-0a97251a7605	738	376	\N
15	Saepe veniam hic blanditiis rem atque. Alias nam ipsum quos reiciendis itaque vel recusandae commodi voluptas. Consectetur voluptatum est consectetur. Dolores nulla eum modi. Iure tempora libero nobis dolorum inventore voluptates facere iusto. Eveniet in omnis.	2023-07-19 23:21:06.338	PUBLISHED	0	0	\N	b0931691-60e1-4331-8d1c-f14657628caf	739	662	\N
15	Eligendi ea ratione ullam. Nulla veniam neque maiores animi quae officia aut sunt.	2023-04-10 13:41:32.596	PUBLISHED	0	0	\N	688fe688-b2cf-4735-92b1-84e01085571e	740	722	\N
17	Ex maxime deserunt deleniti minima veniam. Aliquid illum amet sed sequi.	2023-02-28 23:25:12.242	PUBLISHED	0	0	\N	5b7da0b5-50ca-4f8e-8d18-70445ca8f53b	741	606	\N
14	Ipsam nemo laudantium ea commodi ex magnam. Magnam iusto excepturi dignissimos quos ab.	2023-07-30 01:07:49.189	PUBLISHED	1104090.426422222	1	\N	e4647f80-bbe8-4e52-9c50-b7556bff443b	742	407	\N
23	Quam rem minima nihil tempore vero. Repellat odio aliquid eaque modi sint deleniti aspernatur iure aut. Illo corporis possimus voluptates corrupti inventore voluptas iste ipsum.	2023-04-02 15:09:58.786	PUBLISHED	0	0	\N	d4fbf413-10cd-4163-82ba-2f5cf3e0493f	743	450	\N
17	Facere officia reprehenderit exercitationem quo magnam. Ea explicabo numquam quod. Accusamus odio laborum incidunt unde aspernatur atque nesciunt molestiae praesentium. Id quibusdam veritatis incidunt. Delectus repellendus necessitatibus voluptas.	2023-04-29 12:05:21.994	PUBLISHED	0	0	\N	79240068-8b3b-46c7-a115-c15d1bfb65c1	744	583	\N
19	Perferendis earum velit consequatur illum nulla reprehenderit consequatur. Voluptates sequi at totam quasi temporibus. Amet blanditiis rem.	2023-08-08 04:58:45.92	PUBLISHED	0	0	\N	da2ebe5d-564a-4b51-b7bf-6f5968fae82f	745	537	\N
20	Facere accusantium ea odit veritatis ullam fugit eveniet. Adipisci fugit commodi odit saepe accusantium. Voluptatibus earum consequatur ducimus illum laudantium eveniet ducimus.	2023-02-23 06:31:14.252	PUBLISHED	0	0	\N	27ecc5ba-6e7a-486f-b847-3a4f6dec5ad1	746	503	\N
15	Voluptatum saepe fugiat nam labore facere ea corrupti exercitationem. Illo dolorum tempora voluptates voluptates recusandae. Corrupti quasi amet in deserunt. Sequi quasi est minima magni impedit.	2023-08-24 09:58:27.991	PUBLISHED	0	0	\N	0b58eb24-1f21-47d3-8745-1a5776f61d3b	747	728	\N
21	Illum deserunt deserunt eius. Sunt facilis nam pariatur illo iste ipsum ad magni. Saepe repellat quis temporibus quo harum doloribus praesentium nam.	2023-03-16 16:37:05.882	PUBLISHED	0	0	\N	12858a3c-f62b-4bcf-9107-78f0c938e226	748	530	\N
22	Laudantium quo doloribus ducimus iure quam. Illum suscipit quibusdam dolor libero repellat.	2023-01-26 16:57:10.831	PUBLISHED	0	0	\N	35342dd1-356a-4ef7-87c2-096b00005a45	752	495	\N
23	Voluptate ex consequatur fugit quos provident facere eius quos. Non qui aperiam accusantium repellat at. Itaque magni accusantium temporibus voluptatibus quasi vitae. Maxime culpa nostrum accusamus officiis ipsum voluptate quaerat voluptatum.	2023-01-23 22:55:17.139	PUBLISHED	0	0	\N	9d146519-9f46-458a-8328-4a23528e06a7	753	419	\N
19	Fuga tempore ex incidunt ex blanditiis at. Deserunt libero distinctio voluptatum repellendus praesentium totam esse autem. Esse deserunt incidunt reprehenderit esse vel corrupti provident expedita. Rerum saepe totam.	2023-04-08 19:36:54.795	PUBLISHED	888609.2176666667	1	\N	42629787-513b-4bd2-b18e-b893881fd90c	754	371	\N
14	Aliquam debitis occaecati iusto. Dolor commodi ex asperiores ratione nemo.	2023-10-23 20:05:14.582	PUBLISHED	0	0	\N	3a7f426f-5078-46eb-92df-3c490c178250	755	348	\N
17	Quis minus ducimus maiores non quibusdam rerum. Veritatis placeat tempore architecto.	2023-01-21 02:47:11.522	PUBLISHED	0	0	\N	d4c97690-7cbb-4b03-a705-0288e91b30ad	756	400	\N
18	Quis magni officia voluptatem alias fugiat. Voluptatum odit nihil ut veritatis consectetur optio.	2023-02-11 12:46:40.677	PUBLISHED	0	0	\N	ed540493-770e-40a7-8f9b-19c4ca460e0b	757	733	\N
17	In doloremque ex vitae aperiam laborum exercitationem numquam quibusdam aut. Ea cupiditate at dolorem deleniti dignissimos aspernatur. Ratione perspiciatis aperiam est nulla.	2023-09-20 20:49:14.094	PUBLISHED	0	0	\N	d70d878c-f7e7-4fd3-9166-c37055ee50c5	758	446	\N
14	Aut quae dolorem voluptatem illo beatae eum velit tempora. Pariatur quae nemo necessitatibus aperiam. Ratione veniam in nihil rem minus error tempora repellat.	2023-04-24 08:58:41.361	PUBLISHED	0	0	\N	c7d534a2-503e-464a-b13d-a1d61a80b0e1	759	555	\N
21	Recusandae laborum eius occaecati. Sint nisi at. Minus debitis suscipit atque ut eligendi quibusdam voluptate fuga a. Iste quidem nam enim non fuga deserunt nemo. Recusandae minima earum aliquam vitae commodi dolor vitae.	2023-08-07 13:04:03.13	PUBLISHED	0	0	\N	ea276d61-9822-4cb3-96b6-3ef615cb3bae	760	379	\N
23	Repellat consequatur est nesciunt modi accusantium assumenda dolorum inventore iste. Corrupti maxime tempore officia. Vero officiis tenetur optio magni. Recusandae doloremque vero consectetur numquam alias esse perferendis quo. Doloribus minus eos aperiam officia modi repudiandae a ratione. Tempore fuga repellat similique nulla accusantium porro.	2023-10-22 08:14:17.54	PUBLISHED	0	0	\N	6927f447-9628-49c2-875f-a6b8358196f6	761	547	\N
18	Accusantium earum ad omnis voluptatibus. Nisi iure perspiciatis eius rerum. Ipsam ex nisi ab saepe sequi.	2023-08-15 22:15:59.75	PUBLISHED	0	0	\N	1a976cfb-72c5-4a84-b04e-8aa5ae753cfa	762	582	\N
21	Mollitia eos laboriosam officia ipsum laboriosam sed eaque. Dolore sunt minima quas velit eaque quisquam voluptate laudantium. Alias fuga nisi facere. Recusandae accusantium laborum deserunt alias corrupti dolore.	2023-11-02 16:13:01.774	PUBLISHED	0	0	\N	0c336844-3240-46d9-8b0e-7d5871740474	763	456	\N
23	Laborum consectetur minus modi eos mollitia neque occaecati error amet. Illo saepe debitis placeat laboriosam porro occaecati quo quia. Debitis quisquam totam. Voluptate cum laudantium necessitatibus.	2023-01-14 23:36:21.325	PUBLISHED	0	0	\N	70d7cba8-56a4-4610-8864-43d159b2a167	764	539	\N
21	Cumque sed voluptates occaecati vel. Quasi quisquam ut neque voluptates mollitia. Perferendis voluptatibus commodi. Architecto ut nemo a at temporibus inventore iure. Nulla dignissimos suscipit at voluptas nesciunt sequi maxime. Suscipit iusto illum perspiciatis consectetur consequuntur nam eum reiciendis alias.	2023-04-09 02:15:52.423	PUBLISHED	0	0	\N	d1a284c1-3acd-463f-a45e-aae80a7945b8	765	440	\N
22	At optio repellendus exercitationem aperiam culpa consectetur tenetur. Quas voluptatem aut nam architecto qui voluptatum optio nobis veritatis. Et fugit blanditiis nemo laborum placeat sunt quidem ipsa voluptate.	2023-06-15 21:20:51.211	PUBLISHED	0	0	\N	26292627-6adf-4163-bbc8-b9ccac284a0f	766	365	\N
21	Magni iusto voluptatibus nostrum explicabo ipsum. Earum vitae eius neque. Iure numquam at occaecati ut architecto hic. Nam eius corrupti nulla iusto et. Atque possimus quis eum debitis. Eos laborum totam nihil deserunt inventore rem rerum.	2023-06-16 14:04:11.045	PUBLISHED	0	0	\N	dc07ae82-feff-4092-93d3-4b7b489fc91c	767	716	\N
14	Sint doloribus inventore a vitae eos aspernatur facere. Itaque incidunt quaerat molestiae beatae eaque animi maxime pariatur facilis.	2023-09-05 07:59:58.894	PUBLISHED	0	0	\N	28ffec17-576c-4468-8888-db3c4d20e05a	768	457	\N
22	Veritatis consectetur modi. In quod fugit non nesciunt nesciunt quibusdam sint.	2023-05-19 21:46:08.809	PUBLISHED	0	0	\N	fc58b8e8-8e84-4640-84ea-79d00dac2407	769	767	\N
20	Quasi ratione sunt. Non voluptatibus libero. Voluptates esse necessitatibus reprehenderit natus laudantium reiciendis. Illo quos repellendus suscipit in suscipit quaerat. Vero nulla sed doloremque modi sapiente quam.	2023-02-22 22:23:25.617	PUBLISHED	0	0	\N	d4c0838a-6646-4079-b47e-5612c2c9226d	770	402	\N
21	Tempora sed veritatis sed sapiente vel explicabo tenetur ad. Veniam occaecati molestias eveniet tempore nostrum dicta nulla illum earum. Nobis aliquam nihil praesentium dolorum impedit. Ratione at provident neque illum consequatur corporis. Similique omnis occaecati nihil iusto ab ratione reprehenderit. Impedit repudiandae mollitia.	2023-06-29 10:14:48.559	PUBLISHED	0	0	\N	7cca2ce7-1b98-4944-8ab4-117cf36b3765	771	742	\N
23	Voluptate minima officia repellendus at saepe aliquid quaerat accusantium id. Blanditiis exercitationem sunt dolor doloremque. Aliquid assumenda deleniti harum perspiciatis. Numquam sapiente iste quis necessitatibus repudiandae.	2023-02-27 11:08:57.818	PUBLISHED	0	0	\N	0edf1c78-8bf1-4c74-82c8-268b48af1660	772	476	\N
20	Aut nihil laborum at necessitatibus praesentium debitis. Adipisci sit quisquam perspiciatis nesciunt magnam.	2023-11-07 15:12:52.565	PUBLISHED	0	0	\N	cb7d5b10-f56c-4ee5-b2fb-d38f127278f9	773	467	\N
21	Soluta aliquid reprehenderit blanditiis necessitatibus autem ratione suscipit provident. Cum modi maiores aliquam maxime occaecati harum minus tenetur nihil. Enim natus consequatur odio necessitatibus maiores ullam doloremque. Tempore nesciunt dolores fugiat porro. Maiores explicabo nisi unde commodi nam perspiciatis ex. Nesciunt eligendi quas.	2023-11-10 07:54:22.561	PUBLISHED	0	0	\N	67683675-3f61-407b-b9ad-3364a3b66eed	774	359	\N
21	Inventore autem consequuntur repellat et quos nesciunt sed facilis. Nobis atque voluptates nesciunt excepturi culpa veniam. Rem optio explicabo temporibus neque molestiae quo.	2023-03-09 19:26:19.416	PUBLISHED	0	0	\N	d56d0208-89b6-44b8-af81-02eeae13329b	775	542	\N
16	Esse corporis ullam distinctio in atque qui nostrum blanditiis. Dolores architecto enim architecto commodi aliquid adipisci corrupti minus.	2023-03-10 18:24:58.371	PUBLISHED	0	0	\N	54eaf7fc-e172-48c7-bfb7-de2f7b95f72b	776	713	\N
16	Culpa voluptas voluptatum reiciendis a commodi exercitationem nisi vitae eligendi. Aut voluptate tempora.	2023-01-15 04:46:24.489	PUBLISHED	0	0	\N	b3e15bdc-0c12-4397-b910-361fbd888231	777	678	\N
16	Consequatur animi dolor corrupti voluptates ullam iste dicta officia. Non officiis recusandae. Repellendus minus quaerat. Rerum eius vitae explicabo inventore ut dolore expedita. Accusamus occaecati error esse praesentium in impedit pariatur eveniet nulla.	2023-04-18 02:57:05.128	PUBLISHED	906476.1139555556	1	\N	fe771707-0edc-4c6d-bc94-e65d7a20bd98	779	413	\N
15	Dolorum quas soluta magni vitae commodi officia. Itaque ab ducimus. Inventore quibusdam placeat.	2023-02-27 02:06:12.334	PUBLISHED	0	0	\N	105083ec-de79-471b-b0b1-dcc453ccf272	780	765	\N
18	Atque nisi commodi quae distinctio quaerat sequi praesentium a. Mollitia animi culpa earum quas numquam laudantium velit ad. Porro iste odit adipisci eum quod.	2023-11-09 19:53:41.525	PUBLISHED	0	0	\N	f14a38c7-da2d-475f-8e68-26068d511dc2	781	409	\N
14	Quasi aspernatur dolorum voluptatum vero quasi quasi exercitationem. Delectus id sequi voluptate. Quos non eum ipsum possimus hic autem necessitatibus.	2023-03-07 18:13:13.971	PUBLISHED	0	0	\N	38911a2a-9b3b-483c-b562-c8ad35983347	782	363	\N
22	In quae velit beatae maxime velit illum. Saepe ratione adipisci ad veritatis dolore eos. Sed mollitia deserunt earum molestias laudantium ex ut ducimus. Placeat ut enim autem vitae exercitationem cumque enim eius. Voluptates repellat ducimus tempore mollitia. Qui quo temporibus.	2023-05-01 02:00:51.737	PUBLISHED	0	0	\N	4a1e582c-b071-4b5f-9d95-3d1e9538c823	783	364	\N
16	Cupiditate tempora dolor placeat est. Animi at tempora fugit iste voluptate totam atque placeat. Adipisci quae veniam hic. Voluptate officiis esse corporis distinctio vitae velit quaerat.	2022-12-09 01:47:58.516	PUBLISHED	0	0	\N	ff8f4956-ae3b-4bc1-b5f7-9a53e878c779	784	525	\N
14	Vel vel assumenda aperiam itaque sed vel. Ducimus doloremque fuga rerum corporis molestias tempora eum ut eveniet. Minus repudiandae nesciunt.	2023-01-31 23:41:47.954	PUBLISHED	0	0	\N	5976b39b-b7fb-4de5-997c-911af704e414	785	424	\N
21	Numquam veritatis eligendi maiores iure. Commodi amet cum incidunt.	2023-07-03 13:37:50.512	PUBLISHED	0	0	\N	4ca7ee18-b122-4da0-92da-d4555cee87da	787	633	\N
15	Neque error at debitis ea nemo repudiandae optio eos. Explicabo recusandae velit illo laborum. Omnis quasi quo minima fugiat atque inventore rem natus vero. Distinctio impedit illum voluptates totam. Asperiores repellat cum fugit accusamus reiciendis hic.	2023-06-14 03:58:33.682	PUBLISHED	0	0	\N	2bc90c17-31b5-4373-aafd-48e5c56f30ca	788	629	\N
22	Vitae nulla nisi iste quidem labore saepe. Ducimus in doloremque reprehenderit accusamus incidunt debitis non tempora. Eveniet nostrum excepturi sit molestiae quam hic ipsum nemo. Itaque ea ea veniam.	2023-06-24 07:41:27.512	PUBLISHED	0	0	\N	a3b96ecc-e137-4002-838e-d46b7ba5cf18	789	345	\N
17	Dolorum numquam voluptas officiis exercitationem aliquid. Illo numquam mollitia minus. Ab magnam sint facilis aperiam laudantium illo iusto. A dolor praesentium cum officiis architecto. Quasi quaerat sapiente cum qui necessitatibus fugiat ducimus aperiam. Eius quo eum.	2022-12-20 15:39:19.105	PUBLISHED	0	0	\N	f02925d9-b53f-4644-83f6-27ab4d6f8920	790	562	\N
17	Officiis at et dolorum aperiam rerum eum. Ab velit unde tempore. Quae veritatis dicta quasi ab. Illo facere sequi repellat molestiae eius.	2023-05-29 13:30:30.066	PUBLISHED	0	0	\N	32fbd86b-a385-462a-85ae-88da54aacabc	791	458	\N
14	Tenetur id a et quaerat totam ullam ducimus. Itaque neque quia. Similique earum placeat totam optio. Sequi error ex corporis. Assumenda dolorum ut sequi nisi recusandae voluptas. Laudantium alias explicabo exercitationem natus quod quia neque.	2023-11-27 12:07:56.242	PUBLISHED	0	0	\N	f82b10d6-4106-4749-a681-cbecd297c696	792	419	\N
16	Mollitia expedita consectetur dicta provident optio. Molestiae quam a id suscipit aliquid accusantium velit atque. Tempora modi hic nesciunt nostrum vitae eligendi repudiandae. Sunt voluptate sit dolores enim nam explicabo vero totam. Ipsa praesentium assumenda consectetur quas minima enim illo itaque repellat.	2023-11-03 15:04:23.194	PUBLISHED	1289525.848755555	1	\N	aed807df-29ed-48f7-9f4d-584d339b9c29	793	661	\N
16	Voluptas tempora quibusdam natus voluptas ipsa delectus unde facilis. Assumenda molestias dolorem voluptates nisi sequi labore nihil ullam.	2022-12-02 05:13:07.676	PUBLISHED	0	0	\N	774ec9f0-394b-44d7-a5c0-d35848bee508	794	732	\N
23	Soluta unde consequatur ut nulla delectus. Qui quasi pariatur aspernatur minima. Minima voluptatem hic delectus dignissimos delectus aspernatur neque.	2023-03-28 21:49:44.903	PUBLISHED	0	0	\N	b5ca8624-4682-4866-a47e-1ae63e47e366	795	569	\N
14	Quia amet corrupti ex magnam ad recusandae odio accusantium ipsam. Sequi voluptates qui doloribus eum.	2023-08-23 04:48:07.568	PUBLISHED	0	0	\N	e90cc45d-064f-4aba-b2ae-deca1b4f5c20	796	485	\N
23	Veritatis dolores expedita. Excepturi modi magni recusandae nihil amet alias saepe. Modi numquam eaque facilis fugiat dolor doloremque esse. Explicabo quam nulla adipisci odit fugiat tempore corrupti. Pariatur at neque veritatis. Praesentium quod veritatis eum dolorem.	2023-07-11 05:23:40.592	PUBLISHED	0	0	\N	5d902dde-bdf4-4ebc-b62d-5333dfb28086	797	389	\N
17	Nam recusandae ducimus placeat. Omnis recusandae consequatur voluptatem ad laboriosam iure sapiente est eveniet. Ea cupiditate cum sed culpa facilis dolorem quibusdam. Nam rerum fuga dolore blanditiis. Nemo enim odit repellat aut molestiae quae repudiandae.	2023-09-24 22:48:45.985	PUBLISHED	0	0	\N	3d6f996e-62e9-468a-92bb-0226fada4081	798	408	\N
16	Perferendis consequatur vero corrupti. Sint fugiat nobis. Ad sint illum illum alias itaque. Tempora aut quos odit aut neque voluptates accusantium esse accusantium. Magni fuga accusantium aliquam quisquam.	2023-07-20 17:12:27.273	PUBLISHED	0	0	\N	797f0793-5960-473f-aac8-d80a03581560	799	447	\N
21	Atque temporibus esse corporis magnam occaecati omnis esse. Nulla earum praesentium aperiam. Eaque reprehenderit soluta. Repellendus modi quidem libero alias hic beatae asperiores ut facere. Mollitia corporis rerum maiores.	2023-04-22 03:57:15.393	PUBLISHED	0	0	\N	e32c7f0d-3c46-4987-9d91-5aad956bd522	800	408	\N
20	Debitis laudantium cupiditate quae molestias nemo sint mollitia repudiandae ex. Dignissimos perferendis eos dolore magnam nam amet aspernatur harum. Doloremque vel ducimus voluptatum officiis voluptas aspernatur.	2023-02-10 10:14:00.155	PUBLISHED	0	0	\N	8b8dccbf-2d68-464d-a87a-30846c81663d	801	478	\N
21	Vero necessitatibus deserunt beatae qui. Aliquam ullam officia laboriosam numquam esse id. Assumenda occaecati ea dicta praesentium reiciendis in dignissimos ipsa.	2022-12-27 04:42:38.433	PUBLISHED	0	0	\N	4694b310-d99e-44b1-8d9d-665cc1198964	802	577	\N
15	Mollitia facere illum officia accusantium. Aliquam repudiandae repellat. Sed minus dolorum deleniti natus praesentium commodi.	2023-07-01 11:25:51.553	PUBLISHED	1049234.478955555	1	\N	eceff13d-1eb9-4c65-bd6e-56ed7e1f505a	803	745	\N
14	Enim adipisci aliquid quaerat qui impedit. In amet sunt commodi tempora.	2022-12-21 08:40:35.223	PUBLISHED	0	0	\N	da5b488f-3dfd-4679-be25-c01fa0cee58b	804	562	\N
19	Aperiam quia magni. Delectus eligendi nobis eum placeat omnis asperiores adipisci ducimus ex. Perferendis dolore possimus inventore.	2023-11-14 16:59:08.889	PUBLISHED	0	0	\N	f1951b9f-ed40-42d1-910d-f9956d6664e8	806	735	\N
16	Recusandae accusamus quas ad. Laborum sunt accusamus ex.	2023-07-04 20:39:59.156	PUBLISHED	0	0	\N	515e61a2-75e4-45bf-8545-2d4313fe8c67	807	417	\N
15	Perferendis voluptatibus possimus. Autem cumque atque ut. Provident tenetur tempora minima magnam laudantium. Officia iste error incidunt praesentium pariatur impedit aliquid veritatis distinctio.	2023-01-19 15:16:20.802	PUBLISHED	0	0	\N	7495d9a5-b7d6-4551-9cca-d0ca3d1787f3	808	763	\N
22	Sunt labore aspernatur recusandae tempore nesciunt voluptas. Est asperiores consectetur maiores consequuntur minus deserunt ipsa.	2023-10-29 17:51:51.073	PUBLISHED	0	0	\N	e9c99486-d2c6-47fd-a543-82fb73375bd7	809	684	\N
16	Molestiae error culpa quae reiciendis. Quos ea eum vitae numquam distinctio sint itaque tempore. Totam voluptas eligendi quo quod saepe consequatur esse incidunt. Aperiam sed dicta fugiat nobis sit dolorum iure.	2023-06-26 17:14:59.863	PUBLISHED	0	0	\N	e3fb6df7-4f35-453b-a9fe-0613ea87a9fe	810	442	\N
22	Commodi eos sapiente. Itaque dicta ab. Veritatis mollitia ex error sint quia nemo autem quae neque.	2023-09-05 03:10:56.168	PUBLISHED	0	0	\N	bebd5e0f-5032-42a0-8a57-b73b65b334af	812	575	\N
22	Aperiam optio molestiae magni recusandae. At natus nostrum. Omnis eveniet quidem ex soluta rerum blanditiis culpa.	2023-03-13 13:22:42.359	PUBLISHED	0	0	\N	4a924fef-9204-4a47-b9f2-3d251b3d8128	813	733	\N
15	Quae aperiam dolores quo mollitia a velit deserunt nisi. Esse eos quaerat tenetur enim error ex. Dolore esse sed cupiditate non molestiae minima numquam. Ipsa eveniet ratione aspernatur cum facere repellendus esse.	2023-02-21 22:17:35.505	PUBLISHED	0	0	\N	4a21e4d0-cf8d-45da-92e6-d09c98cb9964	814	503	\N
23	Ex repellendus quidem aliquam dignissimos. Vitae fugiat asperiores doloribus vitae ducimus aspernatur. Libero sapiente quis vitae atque ipsam. Cumque consequatur fuga. Nihil saepe voluptatem harum porro ad voluptates fugiat.	2023-07-09 09:19:27.075	PUBLISHED	0	0	\N	3a4a834a-49ac-4b05-910c-6488136efacc	815	482	\N
17	Inventore perferendis nostrum neque tenetur aut. Tempora illo vero tenetur laborum enim labore. Occaecati asperiores debitis aliquid culpa. Impedit nobis inventore ducimus eius. Asperiores dolores dignissimos sint repellendus tempora. Provident quam cum aperiam.	2022-12-02 03:14:19.211	PUBLISHED	0	0	\N	5ce9cea1-acce-400b-a3bd-abe93d3f7db7	816	751	\N
20	Assumenda eaque labore mollitia architecto ratione quae quia. Inventore repellendus deserunt amet. Quia aut quis rem mollitia perferendis maiores eos. Quisquam repellendus beatae quasi dolorem voluptate dolores aliquam. Officiis libero non dolore sapiente consequatur tenetur eaque.	2023-02-13 10:13:33.432	PUBLISHED	0	0	\N	9e80b7da-031d-4084-8e6b-74d3da819cfc	817	467	\N
21	Nisi veniam dolore laborum illum nihil. Dolor explicabo rerum odit. In provident provident. Dignissimos amet repellat.	2023-03-30 17:29:48.845	PUBLISHED	0	0	\N	e6eb397d-5777-4295-b549-f7bbaee4beeb	818	473	\N
21	Odio culpa dolores vitae quo nisi. Saepe veritatis dolore quos ratione perferendis veniam dicta nisi velit. Aliquid consectetur cumque quidem. Nobis tempore dolore. Perspiciatis architecto sequi laborum harum voluptatibus eum cumque similique enim. Labore beatae dolore mollitia labore qui.	2023-09-16 18:16:32.222	PUBLISHED	0	0	\N	0af4e982-3c1e-4057-9458-5cf9a3e66dec	819	365	\N
19	Perferendis beatae enim dolor reiciendis dignissimos tempora quidem ipsum. Mollitia natus accusantium qui doloribus magni iure saepe doloribus. Officia iusto quisquam accusantium deleniti facere est ab excepturi.	2023-07-26 16:18:49.025	PUBLISHED	0	0	\N	9933ac02-fb7c-47f3-901f-45c22d2b8294	820	507	\N
21	Odio ipsam quidem nihil eum error. Sapiente magni quos excepturi tenetur molestias explicabo. Ducimus ipsam fugit ut. Hic quibusdam expedita vel quibusdam. Libero numquam velit.	2023-02-06 03:05:13.449	PUBLISHED	0	0	\N	c14f3628-865a-4feb-a032-36949f6c30c6	821	797	\N
23	Quaerat consequuntur dicta eligendi. Voluptas ipsum quibusdam labore beatae. Sunt ducimus cumque omnis a enim velit. Labore tempora ea at animi aperiam. Pariatur veritatis cumque dicta.	2023-03-10 14:56:02.174	PUBLISHED	0	0	\N	04283f8b-2db8-4a15-8ca1-152b28c7e54a	822	359	\N
23	Ducimus sunt voluptate. Id deserunt aliquid asperiores vitae cum delectus quos eos occaecati. Optio repudiandae nam accusamus inventore. Natus occaecati iusto fuga facilis perspiciatis aliquam sapiente minima ex. Dignissimos veritatis sit.	2023-11-02 05:59:55.651	PUBLISHED	0	0	\N	ffee2a18-0599-4da4-be26-730091ea13b0	823	539	\N
22	Aliquid vel beatae doloribus commodi dolores dolores assumenda. Debitis delectus vitae pariatur.	2023-02-15 05:58:10.615	PUBLISHED	0	0	\N	cc496492-7a4a-43cd-8420-ea011e5c0eae	824	455	\N
19	Velit aspernatur hic doloremque enim. Pariatur unde quisquam molestiae asperiores quaerat officia illum sint id. Atque consequatur at.	2023-02-19 06:06:29.13	PUBLISHED	0	0	\N	7d29a31e-1411-4e89-9816-1b4f2f257ad2	825	366	\N
22	Rem consequatur natus cum officia. Fuga similique quis officia maxime atque at illo hic delectus.	2023-11-12 14:22:35.663	PUBLISHED	0	0	\N	c2fd35c8-ba41-4690-a0b1-51ea250cbb67	826	597	\N
14	Rem tempore molestias illum. Laboriosam sapiente impedit ducimus ducimus distinctio sapiente reiciendis perspiciatis dicta. Tempore eligendi cupiditate veniam. Recusandae dolores inventore quae ea. Necessitatibus veniam eveniet adipisci odio illum maxime. Aut ad error molestias non quae id recusandae molestiae qui.	2023-06-22 07:42:04.807	PUBLISHED	0	0	\N	3d320281-a718-4f45-98e4-30bec717be90	827	600	\N
20	Ipsa placeat optio quod. Aperiam ducimus velit. Commodi placeat minus corporis deleniti alias soluta expedita voluptatum. Fugiat exercitationem modi possimus non voluptates praesentium quas. Minima consectetur ut voluptatum itaque reprehenderit illum provident placeat quisquam. Dolorum possimus odio aliquam totam officiis reiciendis doloremque cum.	2023-10-09 01:30:07.817	PUBLISHED	0	0	\N	db7db580-011e-4996-9ca4-720117f59599	828	718	\N
22	Accusantium animi quam corporis dolorem ut sequi explicabo mollitia culpa. Officia nemo asperiores quam optio quis. Consectetur cum animi dolore repellendus. Possimus numquam sit. Deserunt voluptates ipsam dolorem assumenda neque.	2023-09-22 20:57:01.985	PUBLISHED	1209356.044111111	1	\N	0d995dea-5f39-40c2-9e60-4d86024b0cc6	829	795	\N
21	Earum assumenda maiores provident nemo similique nostrum. Architecto atque voluptates. Facilis rem doloribus sapiente quis quisquam quidem aliquam vitae minus. Recusandae velit ipsa incidunt aut ad amet.	2023-01-30 01:15:52.856	PUBLISHED	0	0	\N	f652317b-2f5e-4762-8080-4e80631aa0ca	830	475	\N
14	Quisquam hic quisquam accusantium nostrum illo hic occaecati. Nemo distinctio eum voluptatibus ab. Inventore doloremque error minus iste nulla odit eum nostrum iusto.	2023-02-05 08:43:42.275	PUBLISHED	0	0	\N	c8d6332a-352d-4588-8a23-b3ae56b27af2	831	464	\N
23	Tenetur ex eaque quam. Quam eius ad dolorum nihil atque commodi praesentium. Nostrum dolore facilis minus nihil.	2023-11-08 18:16:02.289	PUBLISHED	0	0	\N	ed294c8a-ea9b-48d6-83b1-57196e077c86	833	432	\N
22	Consequatur at ipsum repellendus mollitia debitis repellendus placeat. Vel vero ipsa.	2023-03-24 02:15:43.335	PUBLISHED	0	0	\N	6080446d-7013-432e-b791-c530d8ed7e8d	834	615	\N
16	Hic vel numquam nobis omnis. Consectetur doloribus quia adipisci nobis dolores eaque assumenda error officiis. Nostrum vel minima est expedita nemo facere nostrum.	2023-03-15 00:36:12.442	PUBLISHED	0	0	\N	3e6bb150-c1ff-4c5c-90b5-c3744c67a73a	836	788	\N
17	Earum facilis ipsam ab quae accusantium tenetur reprehenderit. Itaque odio eligendi voluptatem repellat. Aut placeat veritatis voluptates fugit perspiciatis eligendi et quis. Corrupti id necessitatibus libero minima voluptate. Voluptates sed cumque fuga eveniet aspernatur possimus numquam fuga voluptates.	2023-10-16 16:23:28.53	PUBLISHED	0	0	\N	f3014241-f71f-4a28-bb21-2eadf69f56b9	837	789	\N
22	Cum eius nisi recusandae error harum velit. Ea nisi voluptatum nulla.	2023-10-25 18:00:07.576	PUBLISHED	0	0	\N	7cc819e6-78c6-4343-823f-526155d6e05a	838	660	\N
16	Mollitia distinctio et facilis vitae possimus minus nihil at. Veniam quae animi corporis placeat aut reiciendis nihil quas soluta. Temporibus repellendus inventore magni saepe blanditiis error ex vitae temporibus. Nemo quis commodi vero. Rem dolores laboriosam qui voluptatum nihil eaque voluptatibus. Id consequuntur ipsam.	2023-01-09 22:54:25.159	PUBLISHED	0	0	\N	22aadc7e-eb49-4bbd-a29b-07b3f6718b5f	839	468	\N
14	Quia ea quam perspiciatis ab accusantium sed. Odit impedit reiciendis architecto provident. Recusandae minima aperiam laboriosam ducimus nesciunt earum quae dolorum repudiandae. Sapiente excepturi id incidunt cumque quibusdam at necessitatibus. Suscipit officiis quod laudantium saepe sequi quis.	2023-01-07 20:52:37.404	PUBLISHED	0	0	\N	22f58114-92ae-48aa-a0b8-59626fdcc8f2	840	580	\N
17	Dicta asperiores tenetur sequi earum maxime cupiditate totam. Velit minus laudantium illo sit itaque rem quod ea odit. Facere expedita doloremque rerum minima fuga alias ipsam. Quam consequuntur dignissimos provident explicabo inventore sequi error. Velit est sapiente veritatis esse impedit sequi.	2023-08-12 17:29:39.226	PUBLISHED	0	0	\N	efad9089-46af-46d8-a88d-22f7ba2cb11a	841	658	\N
23	Dignissimos culpa quo distinctio ratione eligendi. Corporis recusandae fugiat adipisci. Odit ex et culpa eligendi est saepe officiis. Optio officiis adipisci eligendi labore explicabo provident praesentium ea. Perferendis odio quibusdam est commodi dicta magnam optio odio. Eveniet sapiente rem incidunt sunt aut veniam.	2023-07-18 20:08:47.457	PUBLISHED	0	0	\N	10c043d0-1830-4e2b-93a8-5c0a3a52f7ef	842	396	\N
23	Ab corporis culpa temporibus ea laudantium quas dolore error. Maxime eos animi facere porro id. Sit ullam aliquid ipsam distinctio quod ullam ad.	2023-02-02 07:15:06.527	PUBLISHED	0	0	\N	b8fd9e4a-4e0a-4a1d-8ee2-617709a42a45	843	524	\N
19	Deleniti adipisci quia suscipit dolore sunt recusandae sunt est. Eligendi velit occaecati sunt amet corrupti nisi assumenda delectus sapiente. Quae excepturi iste libero architecto cumque magni. Consequatur atque reiciendis aperiam similique maiores recusandae. Consectetur eveniet facilis vero suscipit pariatur. Qui corporis fugit.	2023-11-05 17:44:25.513	PUBLISHED	0	0	\N	9af8ae01-e000-44e9-8094-4a688a4c3a8b	844	592	\N
23	Odit fuga nostrum soluta ad aspernatur repellendus. Fugiat blanditiis ullam. Vitae sapiente commodi. Fugit at possimus fugiat similique minus totam.	2022-11-30 19:14:54.348	PUBLISHED	0	0	\N	d19d1bc9-1c5c-457c-9e90-798d1d47b1d7	845	819	\N
21	Dolorem libero deleniti pariatur ratione doloremque earum nostrum. Consequuntur quos praesentium excepturi ipsam quisquam sint facere fugit.	2023-01-05 15:00:44.929	PUBLISHED	0	0	\N	458ddf63-386b-4ced-8c64-e9a376b7582a	846	770	\N
20	Reprehenderit nemo veniam incidunt dolorum. Perspiciatis qui quasi cumque.	2023-02-02 20:56:22.192	PUBLISHED	0	0	\N	06f84b2d-b54a-4035-87f5-76e8c544ec8c	847	816	\N
20	Sit sunt explicabo est ducimus voluptate consequuntur odio pariatur. Totam iusto eaque quibusdam nemo sequi quos repellat. Nobis laborum dolorum debitis quasi minima ut et. Architecto illo pariatur repellat eveniet eveniet non ipsa voluptatum. Eum incidunt nobis. Voluptas quaerat atque voluptatibus ipsum saepe eligendi.	2023-04-10 10:20:39.777	PUBLISHED	0	0	\N	52ca3b71-dcaa-4595-81c4-ffd32effdb49	848	643	\N
17	Dolore facere omnis maxime odit. Ratione expedita tempore voluptatum cum provident. Doloribus vel fugiat unde eum quod harum quidem. Voluptate in praesentium aliquam quis iure atque. Quisquam dolore voluptatibus. Sit reiciendis tempore perferendis molestiae error.	2023-08-21 23:40:26.113	PUBLISHED	0	0	\N	c7471f55-d8b4-44ec-9ce7-e0baa9ecc3b0	849	340	\N
21	Exercitationem distinctio nihil neque modi optio non iure atque. Incidunt culpa esse. Nisi dolorem facilis reiciendis quasi minima commodi sed eveniet amet.	2022-12-25 08:18:49.574	PUBLISHED	0	0	\N	181f8ac4-cb25-42f6-91b4-33ec64de92f4	850	514	\N
16	Earum quo quisquam doloribus. Repellat reprehenderit rerum placeat earum labore officiis ea. Earum maxime vitae. Ipsam temporibus rerum mollitia recusandae similique quasi eius.	2023-09-05 06:52:55.641	PUBLISHED	0	0	\N	4368dc9d-88b9-4131-aed3-d9f1729a1c46	851	536	\N
15	Eos quisquam fuga quidem debitis facilis harum. Aliquid unde neque fugit. Laborum minus nihil ipsam possimus aliquid quas. Nisi aperiam repellat atque magnam alias ut corporis ex voluptatem. Nulla illo deleniti. Mollitia est nisi laborum sed molestias magni officia magni commodi.	2023-06-07 17:41:27.431	PUBLISHED	0	0	\N	18924883-c0d9-47c6-b914-bbd974372ffc	852	611	\N
20	Cumque facere odit maiores. Hic ipsa vel corporis. Debitis porro numquam. Modi quidem quia.	2022-12-12 18:23:44.2	PUBLISHED	0	0	\N	321f50a6-c27b-4fbf-b26e-e307cada233f	853	719	\N
23	Officiis saepe magni corrupti dolor magni ex ea cum. Commodi illum quae aperiam dignissimos fugiat repellat enim repellendus. Ipsum inventore modi aliquid deserunt nemo ex. Recusandae inventore eos. Esse excepturi assumenda quos eveniet sapiente. Quisquam blanditiis eum omnis quia ratione eaque.	2023-05-16 21:06:49.861	PUBLISHED	0	0	\N	2bcacee9-57a1-49f3-a5f3-3e73e2459602	854	821	\N
16	Illo officiis soluta sapiente animi dolorum. Exercitationem error ad. Laudantium fugit corrupti assumenda ipsa illo iste iusto.	2023-03-13 21:08:15.293	PUBLISHED	0	0	\N	a6831ca2-610e-452f-bd98-641bfe1419fc	855	405	\N
17	Possimus sapiente sequi sit itaque consectetur incidunt aliquid. Vero officia fuga occaecati natus incidunt quaerat accusantium atque amet. Similique possimus ipsa nulla dolore repellat eos perspiciatis. Perferendis suscipit a ab iure totam molestias totam.	2023-07-13 10:21:34.586	PUBLISHED	0	0	\N	cfe13a10-e38a-402d-9789-ca7661e5c501	856	616	\N
21	Minus omnis aut similique corporis. Ea expedita fuga odit. Corporis rem quas voluptate similique dolore animi. Reprehenderit ducimus veritatis accusantium possimus. Vero similique consectetur neque.	2023-02-09 00:54:20.542	PUBLISHED	0	0	\N	14adfc1d-a25f-4f34-82b1-d95286fe40ce	857	466	\N
19	Ipsum occaecati assumenda doloribus consequatur blanditiis neque molestiae labore. Cum repellat fugit error quam suscipit. Doloremque dicta itaque illo dolore quibusdam.	2023-10-10 12:12:23.113	PUBLISHED	0	0	\N	1106e64d-bfd1-4e16-89fd-d7e866350533	859	852	\N
14	Ratione voluptas et et itaque a facilis excepturi molestias. Quos suscipit ab asperiores asperiores dolorem praesentium explicabo sint expedita.	2023-05-13 00:07:33.518	PUBLISHED	0	0	\N	43303ad7-f84f-4a59-ae9c-b3696528b721	860	424	\N
23	Assumenda nulla sapiente natus in culpa dolore vero itaque. Perferendis consequuntur aliquam sed delectus dicta.	2023-08-24 20:31:57.661	PUBLISHED	0	0	\N	54f60c24-46cd-425a-a0f6-5743339ddc12	861	555	\N
15	Qui iste pariatur aliquam distinctio incidunt. At aliquid repellat animi magni odit. Maxime beatae numquam expedita et reprehenderit adipisci debitis accusantium laudantium.	2023-06-01 10:36:26.767	PUBLISHED	0	0	\N	8b7d5b42-9ce1-40d5-ab09-4350d5aa2063	862	356	\N
21	Laudantium inventore quia natus laudantium aliquid. Debitis occaecati cum ratione. Molestias occaecati non possimus saepe recusandae pariatur. Tempore quia ea velit modi voluptate illum.	2023-09-15 07:20:34.448	PUBLISHED	0	0	\N	d89c9ea0-e554-4834-a608-af24199f82ce	863	600	\N
14	Unde eos aliquam incidunt quae quisquam ipsa sed. Iste exercitationem voluptatum beatae voluptatum nisi ut sapiente. Reiciendis molestiae quod possimus exercitationem animi. Quas saepe nesciunt excepturi repudiandae laboriosam fugiat.	2023-04-06 04:23:24.085	PUBLISHED	0	0	\N	f0405083-11c2-435f-992c-627b1b5851c1	864	580	\N
16	Dolorum esse sapiente nobis perferendis. Dignissimos exercitationem unde corrupti quidem facere.	2023-02-17 22:32:36.146	PUBLISHED	0	0	\N	ef82ac99-a2bf-426a-9eaf-a06fed31f26f	865	850	\N
22	Deserunt rerum suscipit ab alias ut repellat nobis quas. Repudiandae non repellat reprehenderit non at doloribus dolores repellat. Natus dolor nisi sint omnis. Ducimus dicta excepturi nihil minima magni.	2023-07-01 15:23:52.181	PUBLISHED	0	0	\N	17964463-49e6-4d68-abaa-f9f881d7555e	866	492	\N
20	Reprehenderit fugiat magni. Rerum quod odit velit eos asperiores sed magni ut non. Eius nulla beatae voluptates voluptatem voluptatibus beatae voluptatibus fugiat consequatur.	2023-10-15 02:37:29.612	PUBLISHED	0	0	\N	f68873ad-5349-4e84-ab26-0261518b4f5f	867	758	\N
19	Labore dolore quae odit modi perferendis mollitia deleniti. Dolor qui ullam.	2023-02-12 18:05:15.972	PUBLISHED	0	0	\N	935a67f4-509d-4f87-8b6d-385b1e74c36b	868	854	\N
22	Perspiciatis quidem quis voluptas. Sequi earum maxime itaque quos iure. Repellendus corrupti vel. Quae fugit fuga cum. Similique eos repellat quis fugit soluta expedita velit provident exercitationem. Eum voluptas molestiae ipsam eligendi unde nihil odit.	2022-12-15 18:44:59.236	PUBLISHED	0	0	\N	340ed5a6-4b56-4218-8670-fedad265fe1a	869	755	\N
23	Quaerat minima assumenda velit possimus est. Accusantium eveniet in at provident autem. Culpa voluptatum temporibus temporibus cum nemo nulla quaerat. Quam modi ex vero. Reiciendis nostrum in sit maxime nisi laborum. Laboriosam aliquam aut sint.	2023-03-25 00:54:47.542	PUBLISHED	0	0	\N	94e17515-1e07-4182-b8df-bab830ad2d10	870	696	\N
23	Architecto impedit sunt. Aliquam adipisci sint officiis. Ipsum minus incidunt consequuntur aut voluptatibus similique eius. Amet excepturi ipsa.	2023-11-11 14:50:53.396	PUBLISHED	0	0	\N	27ac4117-f68f-4c51-9982-2c7c29e4fa34	871	402	\N
19	Hic itaque necessitatibus nihil accusamus repellat. Amet accusantium enim rem minima numquam qui deleniti dicta similique.	2023-11-26 08:47:53.907	PUBLISHED	0	0	\N	c79dc3b1-2211-4a64-8166-880d21b5b363	872	401	\N
18	Voluptatum quaerat voluptatum blanditiis autem occaecati magnam fugit adipisci. Animi dignissimos at minima magni dolores aspernatur sapiente porro. Nemo consectetur nobis.	2023-01-14 06:08:39.692	PUBLISHED	0	0	\N	d0f890b6-3045-4c7c-8ee3-08b3ae717ea2	873	773	\N
17	Reiciendis voluptatibus molestiae. Repellat quae aperiam doloremque rem eveniet. Molestiae officiis fugiat ex doloribus esse occaecati.	2023-09-01 16:13:44.191	PUBLISHED	0	0	\N	51e6daa8-7a0d-434e-bee0-8e307d2835f3	874	731	\N
19	Laudantium voluptas commodi in eum optio cumque facere. Maiores rerum omnis soluta porro earum. Quas quis est amet.	2023-09-24 10:35:08.576	PUBLISHED	0	0	\N	4404fc72-0d4d-4c7d-8a56-427c757fe666	876	559	\N
17	Nemo facilis est. Repellendus illo molestias vero in hic necessitatibus. Eum vel veritatis. Molestias excepturi incidunt neque aliquam nobis quibusdam.	2023-02-02 14:16:21.628	PUBLISHED	763382.5071027362	2	\N	90eded68-6d82-4dcd-9e53-37d5b4936682	877	436	\N
18	Molestiae neque et hic quis libero repudiandae. Odit vero animi illum neque alias modi laboriosam quidem. Sequi eligendi eos nulla repellendus tenetur reprehenderit assumenda unde ipsum. Quam officiis sit accusamus occaecati enim. Illum odit nihil.	2023-09-27 09:02:59.237	PUBLISHED	0	0	\N	2dde3382-2476-41c5-8a29-6f7a76859ead	878	798	\N
22	Inventore est rerum fugiat vero. Nobis qui perspiciatis quis explicabo aliquam maxime expedita facere culpa.	2023-02-09 03:46:07.249	PUBLISHED	0	0	\N	942aeba9-2424-4b59-b7fb-df39552d46d7	879	500	\N
22	Labore quaerat pariatur libero impedit exercitationem harum a repudiandae deserunt. Voluptates tempore corrupti temporibus nam ipsum nesciunt consequuntur dolorum fugiat. Natus quia quis suscipit earum itaque ipsum. Aspernatur tempora eius quibusdam assumenda tempore iure veritatis quia. Dicta quas repellendus recusandae culpa. Mollitia illo vero expedita quae voluptatum.	2023-01-20 11:26:58.234	PUBLISHED	0	0	\N	5636cef2-c534-410a-bacd-18434c034312	880	763	\N
21	Nulla placeat adipisci omnis aut itaque aut ex. Itaque esse nam est totam. Reprehenderit voluptatibus quia culpa. Nobis molestias a libero a. At eos voluptatem quas vel. Blanditiis perferendis error.	2023-08-09 07:23:14.841	PUBLISHED	0	0	\N	79661379-ab71-4b87-a02e-154e798cc363	881	445	\N
16	Fugit ipsam vitae sed placeat. Natus id explicabo ducimus dicta eveniet. Dolore quod accusantium porro. Autem hic ipsam quos aliquid facilis quod.	2023-03-10 14:56:01.351	PUBLISHED	0	0	\N	937ee6e9-e42f-4513-8481-0b0fa2949677	882	487	\N
23	Praesentium corrupti expedita doloribus eos expedita. Ab enim harum. Quas blanditiis quam ex a.	2023-09-19 21:49:28.436	PUBLISHED	0	0	\N	6459aca1-075e-4561-8495-5a73c58fe341	883	657	\N
22	Necessitatibus eum pariatur officiis veniam quisquam aut. Officia libero earum minus blanditiis sit. Qui dicta enim quaerat.	2023-03-16 09:36:38.766	PUBLISHED	0	0	\N	50f523e0-2424-4a7e-be50-3561871cbb39	884	357	\N
17	Tenetur qui neque veritatis. Iure odit labore dolores dolor quam fugiat. Eligendi enim consequuntur vel. Quas at in molestias quod quas maiores sit quaerat modi. Vitae iste exercitationem officiis libero assumenda at. Dolorum pariatur illum.	2023-05-26 13:26:05.189	PUBLISHED	0	0	\N	0d7018b2-2f11-4982-b4ae-f7565e5e4370	885	568	\N
22	Magni dolores est sit odio perspiciatis vel alias. Inventore beatae nostrum quisquam sint veritatis vel. Atque neque numquam soluta quisquam recusandae enim. Repudiandae quis nulla a earum ab.	2023-11-26 21:29:54.825	PUBLISHED	0	0	\N	1069d0a9-2136-4346-b9e0-78add8c69ee9	886	488	\N
15	Quos totam quis quia. Ipsa illum provident ab animi quia consequatur eaque recusandae.	2023-10-07 11:21:50.631	PUBLISHED	0	0	\N	528065fe-8433-489a-960c-4bbb9e274f1e	888	672	\N
17	Similique voluptatibus tempore quisquam. Molestias alias impedit iure dolores. Voluptas occaecati quod eum voluptatibus magni.	2022-12-28 13:36:05.092	PUBLISHED	694208.1131555556	1	\N	3576dc4c-9164-4a46-9bdd-c15ea8c1d593	889	570	\N
20	Minima nobis soluta voluptas optio soluta inventore asperiores. Voluptatem ratione rem nam quas ipsa est officiis. Libero esse expedita impedit ex aliquam.	2023-07-15 09:56:39.834	PUBLISHED	1075995.551866667	1	\N	199e6bea-ef33-4edb-bd78-713333190dfe	890	652	\N
22	Iure facilis cupiditate iusto ullam. Excepturi esse tenetur rerum veniam. A qui nihil facilis quo dolorum ex.	2023-04-23 14:54:17.952	PUBLISHED	0	0	\N	8e9983b1-00bf-420c-8dad-bcdd46f17e96	891	673	\N
15	Ex rerum laboriosam voluptates eaque quia iste dolorum distinctio veritatis. Soluta reiciendis at. Hic veniam cupiditate labore eos odio voluptatibus error enim tempora. Tenetur inventore placeat esse facere est quidem quod. Eaque libero fugit voluptatibus illum hic consequuntur.	2023-01-27 08:32:44.306	PUBLISHED	0	0	\N	744525ce-53b4-42d7-9a6b-8872f843f950	892	810	\N
19	Natus distinctio fugiat consequuntur ipsam deleniti accusantium. Et rem reiciendis earum. Adipisci deserunt ullam quia veritatis. Nam iusto error ad vero iure. Dolores illo ex atque provident aliquam nostrum saepe voluptas. Minus soluta quod vitae ea excepturi vitae sit ipsum molestiae.	2023-08-27 21:25:23.006	PUBLISHED	0	0	\N	0ec5ca4c-d787-4ef2-8fdd-79a5152ee7c1	893	463	\N
18	Maxime quaerat asperiores autem ratione nemo eaque aperiam dicta. Quia aliquam quae. Vel soluta harum nostrum excepturi.	2023-08-21 23:36:42.79	PUBLISHED	0	0	\N	57e9d52b-8732-45c1-9a58-44ee97d19bf1	894	829	\N
16	Corrupti soluta sunt nesciunt laboriosam ipsam ipsam deserunt sequi accusamus. Suscipit accusantium est cupiditate a sunt maxime dolor. Distinctio ratione maxime.	2023-10-13 14:07:46.146	PUBLISHED	-1249130.3588	-1	\N	2cc8ef95-20dc-4c6e-91e5-7aa7dc694dda	895	687	\N
15	Laudantium doloribus velit pariatur. Ea ducimus incidunt earum. Repellat architecto eum alias possimus ad et. Pariatur amet omnis ipsa. Possimus impedit ipsum quae enim delectus. Blanditiis ipsam expedita asperiores.	2023-08-23 22:46:45.023	PUBLISHED	0	0	\N	aa1e8f94-24b8-4e74-a0ed-509ab7c3cbfa	896	556	\N
14	Quo sapiente consequuntur necessitatibus. Animi aut doloremque debitis unde quis itaque omnis temporibus similique. Nihil iure suscipit aspernatur animi sed impedit nihil. Rerum libero nostrum velit vel ipsum ipsum dolor aliquam beatae.	2023-05-17 22:38:20.298	PUBLISHED	0	0	\N	6b987a43-6125-43ba-8cf0-2b2898f042aa	897	671	\N
19	Placeat quia maxime dolorum dolor. Asperiores nesciunt nam pariatur praesentium dolor repudiandae voluptas fugit delectus. Id molestiae modi ad rem. Sapiente hic itaque similique possimus veritatis aliquam molestias. Quod quos inventore.	2023-03-13 21:51:02.091	PUBLISHED	838868.0464666666	1	\N	0622497e-1cad-4f65-ba6d-0ba411e10472	899	568	\N
17	Vero officia perferendis cumque aliquam praesentium ipsa architecto. Doloremque culpa vitae aspernatur. Rem nemo at. Modi consequatur beatae modi praesentium ab quasi cumque. Consequuntur qui porro quis officia maxime accusamus deserunt tempora voluptas.	2023-01-20 03:37:50.873	PUBLISHED	0	0	\N	731868a5-b5aa-44f3-b9d7-0ec04046640b	900	354	\N
21	Natus atque aspernatur. Veritatis nemo cumque laudantium corrupti deserunt nemo sint laudantium delectus.	2023-05-20 11:37:44.054	PUBLISHED	0	0	\N	a1322d71-ce45-4bcb-a3f1-6670481ac6c9	901	809	\N
14	Maiores quo saepe odit repudiandae ipsum facere sapiente. Minima maiores pariatur itaque aut nihil dolore nisi.	2023-06-17 19:08:13.384	PUBLISHED	0	0	\N	c086948a-f83a-4342-ae0d-a82ebf22e3a3	902	593	\N
18	Eum iure nulla dicta est exercitationem. Mollitia illo quidem ipsa voluptatibus odio consequuntur.	2023-03-29 14:04:24.953	PUBLISHED	0	0	\N	c4865b94-e4b2-447e-a770-6a57b7af3d0c	903	517	\N
19	Sequi voluptatibus labore. Pariatur alias numquam odio assumenda dignissimos. Adipisci molestiae porro nemo laborum facilis tenetur.	2023-05-02 07:40:07.75	PUBLISHED	0	0	\N	ea067336-c04a-49df-9590-ca92345b5361	904	485	\N
18	Temporibus molestias ullam modi corporis nihil. Maiores qui perferendis placeat nesciunt soluta quidem. Ipsam esse non ullam libero veniam quas neque. Quod animi quis officia quasi vero odit aspernatur. Tempora sint laudantium autem nulla est laborum facilis facere repudiandae. Nam vel quaerat.	2023-07-27 03:17:19.432	PUBLISHED	0	0	\N	ae6426f2-b624-4f09-97dd-5f8d7a2ccd5b	905	618	\N
22	Dolorem distinctio molestiae architecto esse quae hic quibusdam impedit. Perferendis aut recusandae eius perferendis. Fuga tempore suscipit maiores iusto ab officiis ea.	2023-08-22 11:56:08.811	PUBLISHED	0	0	\N	581078a8-4da8-4189-b073-3ef6da4816ef	906	404	\N
18	Beatae alias repudiandae ut et. Doloremque tempore alias necessitatibus labore voluptates vel vitae dolores iure. Natus similique illum debitis quae eum veritatis qui. Necessitatibus totam temporibus explicabo velit eligendi. Cum voluptatum et.	2023-09-28 20:38:56.257	PUBLISHED	0	0	\N	66fb435c-2a7c-497b-81c6-70f961c6e204	907	779	\N
23	Fuga nisi id quo. Voluptatum at praesentium maiores velit laborum labore tempora repellendus repudiandae. Inventore natus culpa recusandae sapiente corrupti error perferendis modi enim. Alias libero non natus occaecati quas. Quo ipsa ea. Ex laborum deleniti porro consectetur libero unde accusamus maxime.	2023-06-05 03:23:49.07	PUBLISHED	0	0	\N	1f210752-ad73-49fa-9200-1a0ed121d45a	908	896	\N
17	Pariatur temporibus veniam esse unde molestiae. Libero laboriosam corrupti quisquam natus odit unde deleniti molestiae expedita. Sapiente tempora expedita aliquid placeat quo eligendi. Dolor culpa laborum tempora perspiciatis cumque sequi fuga earum sed.	2022-12-05 23:02:19.752	PUBLISHED	0	0	\N	2c70abac-9f33-4a41-af87-af46b1e0685b	909	853	\N
15	Voluptas quisquam quos porro omnis mollitia cumque ullam. Accusantium tempore dolor magni. Natus consequuntur eaque dolor. Iste vero ducimus sequi. Recusandae tenetur ipsa porro eligendi dignissimos. Veniam alias quo nemo perferendis ullam ipsa.	2023-06-08 00:17:24.87	PUBLISHED	0	0	\N	647b316c-efda-404d-9cb4-19ffa895f2f2	910	376	\N
20	Magnam nisi enim deleniti. Ullam fuga magnam officia dolor impedit quos sapiente provident. Aliquid quae ullam itaque cumque. Unde beatae facere suscipit sit. Consequatur sunt reiciendis eligendi a quod suscipit.	2023-07-22 06:42:01.816	PUBLISHED	0	0	\N	18b81d4e-36d8-4344-8218-c582ba81bcee	911	504	\N
19	Esse omnis ea pariatur. Expedita magni perferendis tempore ipsam magnam necessitatibus velit eaque magnam.	2023-05-23 13:20:06.064	PUBLISHED	0	0	\N	d5623190-69a9-440c-a20b-9e49b4c9611d	912	649	\N
20	Nesciunt in omnis magnam dicta aliquid vero asperiores. Nesciunt error quod quas ullam deserunt consequuntur. Eius nostrum aliquid praesentium praesentium vitae.	2023-06-12 18:35:40.666	PUBLISHED	0	0	\N	7cbc3a92-49f7-4b2d-bfdd-3a062cb48aef	913	385	\N
20	Ducimus accusamus veniam. Necessitatibus aperiam omnis libero. Hic quod quasi. Eaque quibusdam eos magnam. Maiores praesentium velit molestias nam iure aliquam consectetur veritatis. Corrupti ipsum vitae quidem placeat sint debitis quas.	2023-03-08 14:04:07.948	PUBLISHED	0	0	\N	e17a7af2-7174-42e3-8478-5468d1549545	915	607	\N
15	Et explicabo aliquid aut fugiat temporibus facilis. Reprehenderit quam recusandae ipsa aut sequi temporibus. Optio repudiandae libero ipsam consequuntur vel quae sed. Ipsum culpa nam aperiam in ipsum. Sit officia adipisci non autem aliquam.	2023-10-03 11:54:07.569	PUBLISHED	0	0	\N	2e02b92e-858e-4cdf-89bc-d0a499122dd9	916	749	\N
17	At sit nulla sapiente harum asperiores. Laboriosam nihil tempora eos libero veritatis delectus dignissimos reiciendis quis.	2022-11-30 10:50:50.804	PUBLISHED	0	0	\N	d745c296-011f-4722-a55d-5f0c058f9143	917	583	\N
18	Quod exercitationem sunt nihil nobis esse ducimus quam enim fugiat. Velit quo perspiciatis deserunt quae occaecati aut voluptates adipisci ab. Totam consequatur rem.	2023-03-04 01:45:07.741	PUBLISHED	0	0	\N	93a1fdef-0dd0-4c92-a58f-131de3524873	918	852	\N
19	Modi expedita veritatis dolorem. Neque maiores perferendis culpa deleniti quasi. Fuga voluptatem velit. Totam totam mollitia autem eos aspernatur quae perspiciatis consequuntur.	2022-12-19 08:39:22.578	PUBLISHED	0	0	\N	83c96413-26e4-48e9-adc3-7fb6bfdc4563	919	386	\N
22	Qui a inventore laborum perspiciatis porro tempore. Ipsa itaque deleniti quo aliquid non deserunt iure impedit.	2023-03-17 03:08:46.247	PUBLISHED	0	0	\N	ba86b088-7184-42c3-a803-619e3e142cfd	920	499	\N
21	Molestias ad voluptatum id sed architecto laborum. Voluptatem id accusantium autem. Facere non reiciendis dolorum quia qui asperiores cupiditate iure repudiandae.	2023-09-11 08:11:55.568	PUBLISHED	0	0	\N	bf42c0eb-74f5-4963-8988-8b4e9305fa37	921	402	\N
22	Eius voluptatibus unde alias ut debitis voluptates aut explicabo soluta. Minima ratione deleniti vitae illo aspernatur iusto corporis temporibus cum. Sunt amet consectetur. Ullam assumenda cum numquam cum fuga quasi quas consequatur.	2023-08-07 21:49:27.442	PUBLISHED	0	0	\N	2fedb439-3bc2-4c42-b5ad-1a848db003dc	922	824	\N
22	Itaque optio sunt itaque incidunt hic accusantium sequi illo. Soluta labore aut laboriosam necessitatibus. Reiciendis necessitatibus sequi blanditiis. Ex ipsum ratione vel iure quibusdam adipisci sapiente.	2022-12-04 16:20:28.709	PUBLISHED	0	0	\N	bbacece0-f6bd-4eef-96ab-8abe61a27a9f	923	904	\N
15	Iusto porro cumque architecto. Dolorem voluptate nam perspiciatis aperiam earum quam facere.	2023-07-21 06:05:07.055	PUBLISHED	0	0	\N	7807c66d-ad7f-4901-bcee-567510eb3ea7	924	909	\N
22	Nisi ducimus placeat laudantium quisquam. Eius quisquam tempora animi necessitatibus consequuntur repellendus.	2023-06-03 18:00:39.164	PUBLISHED	0	0	\N	ed82271c-dc72-4ca6-85e9-704c856191d3	925	587	\N
22	Inventore veritatis ab. In debitis esse magnam fugit modi aut maiores illo.	2023-03-30 01:09:24.125	PUBLISHED	869852.536111111	1	\N	a285390a-7b3c-48a1-aa29-cb773bdabd6a	926	716	\N
20	Id perferendis iusto necessitatibus sed nulla earum. Sapiente doloribus tempore quas harum vero possimus vitae odit laborum. Consequuntur culpa inventore. Fuga quibusdam nemo modi nisi illum voluptates. Excepturi sit vero consequuntur.	2023-09-07 11:09:10.062	PUBLISHED	0	0	\N	f3275c94-9ee6-451a-9c28-39ac013df96b	927	651	\N
21	Molestiae blanditiis dicta sapiente delectus minima quia repellendus assumenda quibusdam. Architecto illo corrupti cumque labore quis. Architecto non natus autem quos illo dolores eos.	2023-10-03 01:09:14.817	PUBLISHED	0	0	\N	2fb107b1-fdf2-4495-b286-e6180e405ed0	928	339	\N
17	Maxime unde animi. Exercitationem vero adipisci sint laudantium aliquam.	2023-05-29 09:23:30.013	PUBLISHED	0	0	\N	5caa3e8f-0d29-4362-a95e-e0a80c603d80	929	522	\N
17	Nesciunt sint culpa natus. Vero itaque rem eius hic quae minima quo occaecati. Commodi eligendi minima distinctio dicta voluptates ut doloremque. Provident natus porro temporibus.	2023-08-07 10:50:11.974	PUBLISHED	0	0	\N	70c68b34-b4e3-4a88-8d7a-370f41f5a3e1	930	606	\N
17	Quos dolore aspernatur temporibus. Dolores quam maiores rem minima debitis non. Debitis aperiam pariatur exercitationem nulla nobis blanditiis soluta assumenda. Cupiditate repellat dolor quisquam nobis ut qui.	2023-01-17 15:04:53.728	PUBLISHED	0	0	\N	b67b3042-1392-489e-94ec-f2fae224c7cf	931	442	\N
18	Blanditiis labore delectus nesciunt sequi. Repellat officia nulla et aperiam ipsam corporis. Maiores voluptas blanditiis dolore earum exercitationem sint magni eveniet provident. Ex tempore eius.	2023-01-18 10:38:29.019	PUBLISHED	0	0	\N	6a03c864-8c5d-4a64-a9df-c592e4aeb3f1	932	701	\N
17	Fugiat similique sed excepturi excepturi minima repudiandae expedita nisi. Optio qui libero ex architecto. Impedit tempora aspernatur. Ab dolorum voluptas saepe earum error eaque. Porro dolores reiciendis hic labore perferendis beatae. Libero voluptates quod illo at et.	2023-01-03 06:55:16.4	PUBLISHED	705193.6977777778	1	\N	d61fea78-7af7-422e-8ded-ee112905f71b	933	704	\N
19	Sapiente recusandae expedita quia repellendus non. Explicabo hic maxime quaerat repellat.	2023-09-22 21:45:00.956	PUBLISHED	0	0	\N	406e2d2f-965c-4659-81b4-00c0fac7a51b	934	402	\N
15	Doloremque libero eius pariatur repellat perferendis earum eum quis. Optio quam autem itaque corporis doloremque harum soluta rerum.	2022-12-24 05:50:43.348	PUBLISHED	685907.6299555555	1	\N	ff04b6be-de83-43b0-bf68-eecb502808ad	935	562	\N
18	Ad eligendi eum nulla eveniet nemo eligendi. Necessitatibus eaque reiciendis corrupti iusto cum fuga fugit. Animi officiis dignissimos est dolor. Tenetur consectetur quis provident. Veniam ipsum provident.	2023-07-05 13:00:13.108	PUBLISHED	1057040.291288889	1	\N	571fbd6e-997e-42cb-8715-6289d190995e	936	890	\N
19	Perferendis vitae id vero pariatur maiores repudiandae magni. Quae harum animi.	2023-11-20 16:47:26.558	PUBLISHED	0	0	\N	da7b9037-80b4-45d8-9543-8b7ad0d8e0f9	937	403	\N
17	Ipsam dicta inventore quisquam error iure magni laboriosam animi. Dignissimos consequuntur debitis reiciendis maxime. Doloribus aliquid earum voluptatem consequatur. Qui ut non reprehenderit similique exercitationem sapiente commodi necessitatibus. In dicta nemo.	2023-09-03 01:34:39.03	PUBLISHED	0	0	\N	5c1f0d76-71fb-4785-9ae0-8bc2271701b9	938	866	\N
20	Blanditiis accusamus minima accusantium ab nobis debitis mollitia. Odio odit natus autem aspernatur at labore libero. Totam inventore repellendus voluptatum.	2023-08-06 17:37:26	PUBLISHED	0	0	\N	b18fe858-1cda-4ce8-be88-62c6fab0bc1d	940	549	\N
14	Ut sint deserunt sed aperiam est dolore molestias alias. Nobis nisi quibusdam ipsam possimus ad dolore cupiditate quas. Incidunt ullam veniam.	2023-04-09 14:38:00.714	PUBLISHED	0	0	\N	d5ebae11-64e1-4262-aaa9-c6e800492d7e	941	772	\N
21	Odit perspiciatis inventore culpa iure. Consequuntur aliquam assumenda autem. Enim quae aliquam veniam delectus temporibus eius pariatur.	2023-03-08 11:59:23.615	PUBLISHED	0	0	\N	06ab346a-671b-4169-9830-eb7f5f8ff4aa	942	580	\N
22	Molestias quia dolores unde est animi asperiores adipisci. Molestias quidem esse velit excepturi quibusdam tenetur accusamus. Numquam ad vitae atque quod nostrum architecto tempora perspiciatis ducimus. Expedita atque laudantium a fugiat nostrum vitae sequi exercitationem.	2023-09-22 15:12:08.493	PUBLISHED	0	0	\N	536cb453-fed4-4baa-9101-e6bea4f288ef	945	936	\N
18	Tempore atque blanditiis pariatur commodi excepturi doloribus tempore officia illum. Sit eligendi provident voluptatum. Esse debitis veniam dolores nisi quidem temporibus dolorem architecto. Quasi debitis dolorum voluptatem incidunt veritatis dolore. Eos odio repudiandae aspernatur enim.	2023-05-15 07:27:22.89	PUBLISHED	0	0	\N	5cf1bfa3-9f3a-414e-b2c1-3ec4cf83c090	946	858	\N
21	Laboriosam aspernatur quo quod neque et. Quibusdam unde quisquam illo eos odit iste sed eveniet illo. Perferendis vel id ratione architecto sapiente. Dolores magnam vero. Nobis repudiandae itaque ducimus hic. Quis aut inventore nostrum.	2023-03-11 16:40:23.244	PUBLISHED	834613.8498666667	1	\N	c9520be1-0633-4ac8-befb-2695661d85d9	947	462	\N
16	Expedita debitis ab doloremque at dignissimos. Ullam animi eum esse quasi modi odio quia. Deserunt distinctio sint eveniet aut laborum assumenda.	2023-06-21 23:36:26.935	PUBLISHED	0	0	\N	c2b3d2e5-5d53-41e5-b40c-9548850dd6b1	948	420	\N
22	Provident saepe reprehenderit. Ipsam neque molestias perferendis error maiores. Officia alias nulla. Blanditiis excepturi iste ut cum nisi molestias. Sit aperiam eveniet. Perspiciatis dolorum cum itaque quia saepe error.	2022-12-01 08:54:05.047	PUBLISHED	0	0	\N	7b5322d2-dd8f-4da7-8e59-ca7bdff5fd68	949	919	\N
16	Distinctio ducimus modi tenetur enim saepe officiis inventore. Expedita consequatur exercitationem impedit mollitia eaque corporis debitis perspiciatis minima. Id illo sequi laborum eveniet eum quod consequuntur sequi aperiam. Voluptatem atque ex dolore.	2023-05-01 21:28:53.76	PUBLISHED	0	0	\N	03e22125-2c0e-4377-89e6-65259ccf89c9	950	539	\N
14	Repellat ipsam aliquid ipsa totam. Quos asperiores cupiditate placeat dolores mollitia animi nulla deserunt. Repudiandae hic modi. Alias quasi laudantium perferendis occaecati corporis laudantium sapiente voluptatem quae. Architecto repellat perferendis tempora fugiat. Assumenda itaque architecto in.	2023-05-01 22:50:52.409	PUBLISHED	0	0	\N	b92a7026-c5e9-42df-a288-4c83f6f126a9	951	567	\N
21	Molestiae voluptatem temporibus. Distinctio velit soluta velit tenetur inventore doloribus quia officiis.	2023-05-15 03:28:38.122	PUBLISHED	0	0	\N	4c83754a-6840-460c-911f-b798ded38ffc	952	680	\N
19	Commodi repellat hic. Ab facilis blanditiis illum accusamus ad expedita distinctio asperiores ipsam. Quibusdam natus voluptates iure dicta nam aperiam possimus. Nisi velit eos ratione libero nobis. Temporibus labore sit reiciendis. Ducimus nam distinctio quidem voluptatum temporibus.	2023-11-15 10:56:21.633	PUBLISHED	0	0	\N	22f585b3-f8f0-4a48-96ca-940bff401123	953	677	\N
20	Eos aut voluptatibus in commodi sunt. Doloremque impedit id nisi ratione suscipit officia. Possimus nulla ab maxime repellendus maiores. Eaque consequatur eum possimus minus similique tempora eius dolor ut. Esse doloremque pariatur occaecati eligendi voluptates perferendis nisi.	2023-03-28 04:19:08.733	PUBLISHED	0	0	\N	a4138e88-1754-4a3c-9839-4a131dab8677	954	340	\N
15	Dolor voluptas enim sit ea id molestias fugiat libero. Quis omnis commodi dignissimos.	2023-01-03 10:31:34.83	PUBLISHED	0	0	\N	3316c637-588e-44b1-bd1b-308538cab7ba	955	562	\N
21	Sunt id iste aspernatur aut nesciunt molestias excepturi. Ratione molestias assumenda ut vero excepturi voluptas cum nostrum temporibus. Dolor inventore sint voluptates facere explicabo officia.	2023-07-12 02:30:18.259	PUBLISHED	0	0	\N	3b49b60d-a4a3-4595-bbb5-9aeab5ec23f0	956	737	\N
22	Consequatur qui iste nulla officiis ea. Dicta dolorem dignissimos maiores. Nulla tempora explicabo beatae ducimus atque hic reprehenderit quisquam consequuntur. Excepturi perferendis at. Necessitatibus a enim ullam odio eaque tempore numquam. Deserunt nisi maiores quam.	2022-11-30 09:05:39.362	PUBLISHED	0	0	\N	b4a38356-083a-4651-851d-3e715f9b3bb1	957	804	\N
22	Magnam neque eaque quis fugiat. Autem consequatur vel ullam dolorem id voluptatum. Magnam iure labore. Repellendus voluptates delectus qui iusto nobis veniam excepturi unde a. Architecto dolor accusantium soluta dolores nulla officia fugit tenetur. Vitae amet quaerat culpa expedita illo consequatur.	2023-05-05 05:36:17.137	PUBLISHED	0	0	\N	605232d6-42ff-4aaf-8474-4a65d20373c2	958	655	\N
21	Placeat perspiciatis nihil. Saepe aliquid vel blanditiis nemo quasi.	2023-04-14 04:45:34.529	PUBLISHED	0	0	\N	886d3c0c-2aaf-4224-87ea-fd45e32fcdc1	959	826	\N
21	Velit placeat error aspernatur aliquid tenetur tempora. Quis maiores et. Corrupti commodi dignissimos debitis veniam. Officiis quam enim aspernatur sunt tenetur inventore dolorum veritatis. Beatae possimus totam ipsum placeat quos culpa voluptates in.	2023-11-27 15:44:15.623	PUBLISHED	0	0	\N	965fd765-0454-4d5c-95ad-2ea791f295ab	960	510	\N
16	Ipsum impedit commodi tempore. Tenetur assumenda libero qui officia incidunt.	2023-11-17 06:31:22.244	PUBLISHED	0	0	\N	666e38d7-f6e4-4fdc-9b2f-4f28f032254c	961	697	\N
23	Magnam esse at nesciunt aperiam quo cumque enim. Facere totam doloremque amet distinctio et recusandae dolorum consequatur. Ducimus non nemo explicabo veritatis dolore quibusdam tempora consectetur amet. Nobis neque delectus itaque repudiandae quae magni.	2023-09-19 11:08:21.424	PUBLISHED	0	0	\N	77d4038b-be12-4954-9def-fb0f0bd44076	962	814	\N
20	Odio corrupti animi impedit. Repellat possimus ducimus magnam necessitatibus molestiae quae.	2023-10-04 08:33:59.861	PUBLISHED	0	0	\N	26c8be95-ecd1-4fae-a49a-4e4b304c954c	963	676	\N
20	Eveniet facere fugit. Voluptates optio dicta officia quam asperiores. Perferendis repellendus eaque. Blanditiis quis exercitationem ipsam facere fugiat ratione dolore veritatis. Dolores perferendis id asperiores nemo eveniet. Nobis vitae in reprehenderit in.	2023-09-29 11:15:15.448	PUBLISHED	0	0	\N	45f40bf6-e818-4736-9f71-a671ab41a74d	964	484	\N
23	Sequi rerum possimus expedita accusantium aperiam explicabo debitis molestias. Distinctio eveniet deleniti perferendis nobis maxime id. Vitae amet beatae velit praesentium cumque dolore sed saepe. Numquam facilis atque nobis. Commodi accusamus inventore suscipit.	2023-07-02 17:34:18.412	PUBLISHED	0	0	\N	32bc3cb8-5e35-42cd-bdb5-0fce356b7c1e	965	511	\N
16	Sit non nesciunt. Deserunt sapiente harum repudiandae veniam exercitationem consequatur distinctio tempore sint. Architecto quos magni tenetur sed ut odio aut voluptatum.	2023-03-08 10:03:32.201	PUBLISHED	0	0	\N	b1d821c9-13fa-49e2-970c-17d6e8c0f692	966	533	\N
22	Quia placeat expedita ut vero minus. Libero eos occaecati rerum doloremque distinctio in occaecati adipisci. Quisquam quo facere. Nobis atque natus.	2023-05-17 04:22:59.253	PUBLISHED	0	0	\N	16b66362-e32c-46c8-9022-78bd71701f67	967	431	\N
20	Excepturi quas aspernatur est perferendis accusamus. Voluptatem quam laudantium suscipit quam excepturi deleniti.	2023-11-08 18:06:57.405	PUBLISHED	0	0	\N	506c9151-0322-430f-b859-57530d4f052b	968	858	\N
14	Quidem earum tempora illum. Quo consequatur debitis amet laborum ipsa. Architecto explicabo expedita ipsum.	2023-02-28 23:49:46.255	PUBLISHED	814066.3612222222	1	\N	d776b918-5113-4469-a49e-42f1bd8ba0e8	969	657	\N
15	Quam eligendi fuga fuga magni nulla. Eaque officia odio harum ex dolorum. Pariatur ipsum iusto inventore sed minus corrupti. Nesciunt adipisci quaerat omnis quidem incidunt.	2023-01-10 23:27:31.715	PUBLISHED	0	0	\N	ce71c498-8e90-4c2c-ae3e-9a10ab7a60da	971	668	\N
16	Iusto exercitationem earum in consectetur tempore molestias eum doloremque. Nobis magni a quam culpa est.	2023-02-27 00:17:59.801	PUBLISHED	0	0	\N	14f58d3c-7424-40e3-8e15-c17d0c003e80	973	825	\N
21	Consequatur impedit sequi libero accusamus. Ratione aliquid voluptates provident ipsum odio aliquid quae nobis excepturi. Itaque consequuntur vel fugiat quis exercitationem iure incidunt magnam. Consequatur molestiae animi. Amet exercitationem excepturi eligendi. Eaque corrupti quod rerum.	2023-03-20 00:39:10.481	PUBLISHED	0	0	\N	e910333d-ea36-4069-b469-9a4d348ac70a	974	608	\N
20	Aperiam ducimus quod possimus. Fuga alias aliquam libero. Praesentium deserunt labore sapiente modi maiores temporibus saepe.	2023-05-29 19:34:15.417	PUBLISHED	0	0	\N	4f6e7a57-5a6d-4ad4-9a18-e6d399ada7ed	975	711	\N
15	Provident tempora cum dolores voluptatum praesentium beatae commodi totam. Mollitia vel voluptatibus nobis natus ad culpa illo. Explicabo sapiente modi. Dolorem ut dicta vitae culpa molestias dolorem hic odit. Illo rerum quam.	2023-02-12 12:15:14.005	PUBLISHED	0	0	\N	1bb620c3-e00f-4d17-9b64-9f84998fd505	976	751	\N
20	Quia architecto a et soluta mollitia repudiandae ipsum aspernatur. Animi id blanditiis quo facilis ullam. A modi minus sapiente. Dignissimos tenetur repellendus. Repellat ratione accusantium quod dolorem itaque.	2023-07-03 22:34:35.184	PUBLISHED	0	0	\N	fe0fe90f-ef23-468f-abe7-46fb1d01d8aa	977	868	\N
22	Modi ratione dicta suscipit quam cum deserunt neque. Provident explicabo sunt commodi iusto ex. Exercitationem dolorum doloremque numquam tenetur tenetur velit ad.	2023-08-13 07:17:09.775	PUBLISHED	0	0	\N	147ba0d5-25c3-4e3e-9256-12bef5ebd88d	978	589	\N
15	Quibusdam deleniti at est aperiam ducimus. Accusamus deserunt molestiae natus eos quas quod. Eligendi numquam non porro deserunt nemo. Ipsum aliquam tempora rem eius qui molestias nostrum nesciunt ad. Est unde necessitatibus ipsam aut maiores cum consequuntur culpa quisquam. Doloremque optio id sed.	2023-08-26 13:18:10.615	PUBLISHED	0	0	\N	57204caf-3e3b-413b-a7fb-d18b7937d7ea	979	594	\N
15	Pariatur provident omnis sunt recusandae tempore eaque. Magni nostrum accusamus tempore. Nobis odit veniam veniam adipisci distinctio nesciunt doloremque cumque dolores. Magnam alias dicta eveniet neque molestiae. Deleniti qui illo repellendus repudiandae consectetur cumque. Quis officiis optio provident doloremque asperiores atque reprehenderit nemo.	2023-06-07 06:58:51.606	PUBLISHED	0	0	\N	fc75e4f3-0136-4ade-9b18-1fa198987cbc	980	679	\N
16	Ut quaerat incidunt eius consequuntur magnam. Eos omnis sit ratione ex qui nam quo sunt pariatur. Consectetur tempora tenetur culpa veniam quod dolore fugit. Ipsam animi temporibus vitae sit facilis minima. Distinctio harum itaque consequuntur impedit maxime veritatis rem sunt.	2023-10-29 15:51:24.209	PUBLISHED	0	0	\N	5be28273-a6ef-4897-af18-12965eb809b8	981	362	\N
23	Ad distinctio ipsam. Totam est quia quo maxime omnis error iusto. Ducimus id corporis ut quia iusto.	2023-01-25 22:48:03.511	PUBLISHED	0	0	\N	0faa522f-aeda-4fe2-936e-ad95e76a7845	982	565	\N
15	Alias illum nam dolores repudiandae numquam explicabo placeat commodi repudiandae. Tempora ipsa explicabo aliquid iusto consequatur eveniet at incidunt. Veniam velit architecto delectus ea error quod perspiciatis qui. Autem voluptas nihil.	2023-02-22 18:52:02.517	PUBLISHED	0	0	\N	8c5dfe5d-72ae-4546-ba26-21ab117e57d0	983	806	\N
17	Eveniet in fuga. Laborum beatae architecto ipsam.	2023-01-09 10:58:40.533	PUBLISHED	717038.2340666667	1	\N	75332aac-9749-424d-bd5b-82ae28935c4f	984	465	\N
16	Repellendus totam at mollitia odit earum necessitatibus eligendi itaque dolores. Libero autem aspernatur quod labore ipsum alias. Voluptates architecto doloribus placeat esse dignissimos possimus. Officiis facere molestias dolorem ab itaque magni. Quidem eveniet cumque nihil error nostrum voluptatibus iste. Non quidem alias ipsa similique labore labore doloremque.	2023-03-21 20:05:24.006	PUBLISHED	0	0	\N	fe2cb476-dc86-4554-8272-be5680760665	985	962	\N
18	Accusantium dolorum omnis consectetur. Dolorem harum debitis molestiae voluptatum vel sint possimus excepturi in. Reiciendis quod quidem excepturi pariatur beatae assumenda soluta laboriosam nesciunt. Animi deserunt dolorem. Occaecati esse eos hic.	2023-05-08 19:28:04.135	PUBLISHED	946197.4252222222	1	\N	5cb69372-db47-4d3e-b3d6-83091b8cf68f	986	537	\N
18	Laborum quas provident. Quaerat explicabo ipsam sit accusamus pariatur doloremque maxime quia. Earum nam ad. Omnis nostrum eligendi eum. Ipsum mollitia non. Doloribus voluptatum non eaque explicabo.	2023-08-29 14:53:48.926	PUBLISHED	0	0	\N	35252258-2084-4e0e-8a55-1663d03a9f3c	987	955	\N
15	Quas inventore natus placeat nostrum provident tempore. Quibusdam modi beatae harum. Aliquam quod assumenda ipsum.	2023-11-20 08:24:38.917	PUBLISHED	0	0	\N	f796a3ec-7f9a-4e26-ba32-94ed9d572c41	988	828	\N
18	Corrupti quas rem iure cum repellat eligendi iste nobis eveniet. Enim saepe minima ad aliquam cum. Ipsam minima atque sit ea rem reiciendis beatae. Aut vitae iure harum amet praesentium deleniti quos libero. Corrupti veniam unde adipisci eaque fugit aspernatur facilis quidem. Asperiores autem iste rerum tempore laboriosam neque.	2023-04-06 23:10:43.884	PUBLISHED	0	0	\N	41474ff0-6679-4d48-b320-541664324bde	989	468	\N
14	Aliquam laboriosam illo dignissimos ut voluptate illo quo reprehenderit. Esse quibusdam accusamus quae alias vitae ea quis.	2023-02-13 13:57:07.938	PUBLISHED	0	0	\N	a87bc189-2852-46da-9c79-526a6f1618ad	990	876	\N
17	Nulla reprehenderit placeat ratione molestiae. Ipsa voluptatem reprehenderit vero vero eius iure facilis repudiandae autem. Ducimus facilis minus dolorem amet illo excepturi voluptate cupiditate. Quibusdam odit repellendus.	2023-10-07 00:40:02.412	PUBLISHED	0	0	\N	ead6c1c1-2a9c-44d6-b518-3e45b00a6580	991	690	\N
23	Amet tempora debitis veniam fugiat amet porro sequi expedita repellendus. Accusantium delectus reprehenderit quae neque dolor. Minima numquam eos voluptate. Ducimus ab dolorem delectus ex recusandae.	2023-07-30 10:49:02.703	PUBLISHED	0	0	\N	9ec28cb4-b924-4ec9-ba20-92558307da12	992	423	\N
14	Veniam veritatis praesentium soluta tempore repellat. Ipsum officiis illo impedit nostrum iste. Distinctio debitis incidunt quae voluptatem. Dicta sit maiores.	2023-03-27 13:19:16.508	PUBLISHED	0	0	\N	d083ad1b-e6b1-418e-b9a8-4ae329b4b253	993	368	\N
16	Dolorum nisi fuga est quis fugiat cumque officia. Accusantium veritatis animi totam repudiandae est error. Soluta velit expedita maiores dolore assumenda velit at fugiat. Possimus beatae nulla vitae. Distinctio esse qui sequi doloremque ducimus possimus minus. Maiores consequuntur corporis quia temporibus minus quis accusantium.	2023-02-19 12:58:20.378	PUBLISHED	0	0	\N	da8ba008-8b25-4a95-995f-3114501888e9	994	556	\N
21	Sapiente ipsa nihil quaerat dolorem quod quas beatae magni doloremque. Eos laboriosam ullam nisi.	2023-01-24 14:32:07.951	PUBLISHED	0	0	\N	f817d476-6e0a-4cd2-aa3e-be300f7c9b0e	1050	924	\N
20	Nisi magni et architecto expedita reprehenderit laudantium placeat. Velit ab laudantium nisi eligendi cumque doloremque quod. Laboriosam consectetur commodi. Similique laboriosam perferendis neque tempora aut velit. Eligendi mollitia quo at nisi.	2022-12-24 10:11:30.32	PUBLISHED	0	0	\N	46d5ef56-b5ff-44d1-8432-3196fa6c8f43	996	738	\N
19	Temporibus architecto deleniti vel architecto numquam. Officia doloribus officiis ratione. Laudantium rerum nulla odio perferendis. Distinctio impedit sequi delectus veritatis quidem eveniet. Exercitationem est commodi cupiditate consequuntur aperiam laborum harum vel.	2023-09-29 11:02:12.245	PUBLISHED	0	0	\N	7ff898ba-78d6-4d1d-91e4-33496e8441e3	997	414	\N
20	Dolor iure tempora reprehenderit necessitatibus deleniti voluptatem suscipit quos facilis. Facere vero atque nulla accusamus excepturi. Voluptates ea voluptatibus modi perferendis tempore. Vero consectetur eum vel explicabo possimus cum nemo.	2023-07-24 17:19:47.111	PUBLISHED	0	0	\N	e89b9c6f-851a-4a7e-8d74-1652628342fe	998	440	\N
14	Cupiditate quo excepturi nobis recusandae autem dignissimos. Voluptate quam voluptates. Aliquid quia earum. Molestias repudiandae error excepturi incidunt quaerat libero.	2023-03-03 19:45:05.503	PUBLISHED	0	0	\N	4a8e3129-5807-48d2-b3e3-60332224fca5	999	618	\N
16	Amet facere tempora. Natus veritatis quibusdam voluptatem voluptatibus. In quia fugit pariatur.	2023-03-11 04:35:44.144	PUBLISHED	0	0	\N	071d30d7-dcf8-4dbf-b8cc-ef86a699a698	1000	883	\N
21	Adipisci exercitationem libero. Nobis dolorem magnam. Voluptatibus labore magni laborum ipsum explicabo iusto.	2023-11-14 15:13:52.65	PUBLISHED	0	0	\N	72e2db8d-dadf-4998-9c80-444d15f98890	1001	563	\N
23	Ex dolor corporis maxime ratione modi dolore quaerat libero quia. Asperiores ex fuga iusto provident ut nam quam quam.	2022-12-01 04:29:58.41	PUBLISHED	0	0	\N	79f8dfdb-a585-49d9-87b9-414fe4ea9ead	1002	496	\N
15	Iusto odio unde voluptatem. Voluptatem quibusdam modi nisi. Ipsa numquam quae illum natus quibusdam. Nulla laborum incidunt aliquam fugiat alias iusto fugiat quibusdam.	2023-04-21 16:31:47.687	PUBLISHED	0	0	\N	0848d528-9780-44bb-912a-df5b10b88f06	1003	473	\N
21	Amet laboriosam explicabo commodi ipsa ducimus. Rerum enim accusantium deleniti soluta ducimus cupiditate corrupti animi voluptates. Nihil praesentium aliquam numquam dicta eum odio.	2023-10-16 16:18:22.61	PUBLISHED	0	0	\N	1397532f-93f2-4a2b-970a-30708319a0da	1004	403	\N
14	Ab quaerat reiciendis ex tenetur. Nihil sint accusamus commodi commodi natus. Nam fugit neque assumenda corrupti ducimus nobis. Eveniet perspiciatis ratione corrupti quae.	2023-09-18 21:41:05.663	PUBLISHED	0	0	\N	d4719234-70a9-4e8a-a077-306598755c47	1005	375	\N
22	Neque occaecati porro. Quidem nemo corporis totam. Impedit rerum maxime perferendis id corrupti quisquam. Facilis esse deleniti nemo eligendi. Placeat quibusdam deleniti. Voluptate fugit quidem beatae beatae.	2023-04-03 21:18:16.142	PUBLISHED	0	0	\N	fc2251d1-8110-4675-ba69-cf0577e58850	1006	703	\N
21	Tempora quo consectetur beatae harum sed. Ducimus quia fugit quod dolorem iste. Natus dignissimos quia tenetur vero saepe. Cum quaerat sed qui unde temporibus voluptatum modi. Sunt harum similique libero tempora dignissimos quisquam ipsa rerum.	2022-12-26 05:13:02.869	PUBLISHED	0	0	\N	144a8938-cb8d-4605-a471-fa83503d4ee9	1007	828	\N
21	Nemo molestiae cumque aut. Asperiores adipisci magnam architecto quisquam aliquam nobis ea necessitatibus facere. Incidunt eveniet molestias fugit ad animi iste. Facilis distinctio unde. Ipsa iste nihil eos natus adipisci porro ut earum.	2023-03-25 13:15:56.639	PUBLISHED	0	0	\N	944923c2-9b79-44c8-9d00-3f25013e3f69	1008	729	\N
19	Cupiditate soluta accusantium corrupti provident dolorem maxime ratione adipisci. Suscipit voluptates quisquam odio rerum voluptates atque. Aliquid voluptatibus laudantium nulla accusamus. Tempore deserunt nostrum quo quis.	2023-07-25 14:23:43.11	PUBLISHED	0	0	\N	9b253bdd-1a2a-4e4a-8733-c1269e2432f2	1009	958	\N
14	Esse corrupti ipsam quae veritatis distinctio vero tempore. Dolor tempore odit facilis nobis eos nam impedit. Recusandae quibusdam soluta nesciunt suscipit a optio optio. Facilis laboriosam dolorem nisi sint praesentium.	2023-10-23 11:54:29.203	PUBLISHED	0	0	\N	69d75267-15f5-4101-ab9e-83e79fc7bf4e	1010	839	\N
21	Laboriosam commodi id facilis corporis. Blanditiis possimus unde porro ad a doloremque. Quibusdam ipsa quia doloremque error dicta doloremque rem. Temporibus eaque laboriosam quae.	2023-01-16 12:15:55.855	PUBLISHED	0	0	\N	e78b79e6-7c8d-46d2-923e-476959e6e65d	1011	584	\N
16	Rem exercitationem ab nihil ab velit unde. Aliquid accusamus magni esse provident dolorum velit sunt iste. Corrupti sunt veniam tenetur id. Nisi saepe veritatis nulla.	2023-07-08 14:27:53.806	PUBLISHED	0	0	\N	80aed874-4212-437f-9e06-b1062f4e4697	1012	730	\N
19	Iusto cum ad animi. Itaque quo non eaque aperiam unde voluptates asperiores. Unde fugit delectus quo autem asperiores itaque tenetur.	2023-07-05 11:13:50.946	PUBLISHED	0	0	\N	024c1056-2bbf-4472-a368-d079d00c4c35	1013	895	\N
22	Quia tenetur facilis officiis quae vero numquam architecto. Necessitatibus cum deserunt esse suscipit ut praesentium. Quas assumenda quam non accusantium. Vel vitae incidunt eum perferendis cupiditate a.	2023-07-07 15:24:41.303	PUBLISHED	0	0	\N	9fc084db-0216-4dc0-bae7-29a5aea83b20	1014	382	\N
19	Sequi deleniti autem ea voluptatum aut asperiores ipsum aliquid explicabo. Officia ullam facilis quod aspernatur. Quos veritatis sed magni.	2023-06-15 16:06:56.072	PUBLISHED	0	0	\N	29b63574-54ef-49d8-95c0-a30601f7812c	1015	595	\N
15	Quam eligendi eius aliquam asperiores maxime. Dolores velit consectetur quo. Sunt rerum animi ut alias temporibus.	2023-11-10 23:59:09.841	PUBLISHED	0	0	\N	51302b16-bc9f-42ba-b071-724c9bd5e53d	1016	585	\N
20	Quia eius nesciunt non architecto dolore qui sapiente. Officiis ipsum cum iusto consectetur. Natus perferendis facilis molestiae voluptatibus molestias incidunt.	2023-09-17 13:34:31.115	PUBLISHED	0	0	\N	7f7f3a6b-069c-43b5-8aed-e1888bf5f2d9	1018	949	\N
16	Ducimus eveniet hic ipsam. Dicta et impedit commodi vel similique nisi molestias voluptas tempora. Iste occaecati accusantium repellat cumque. Minima quaerat reiciendis numquam sit. Similique id quia.	2023-08-02 02:19:57.902	PUBLISHED	0	0	\N	54bcf25d-551e-47b9-935a-c8ec4bbd4b81	1019	344	\N
22	Recusandae quia similique dolores dolorum. Officia hic cum quos. Eaque fugit autem illo deleniti expedita.	2022-12-13 19:38:37.874	PUBLISHED	665891.5083111111	1	\N	01daf865-dd91-42f4-b8f8-c4cf1419b3cc	1020	340	\N
22	Harum veritatis alias. Dolores perspiciatis eius ea vitae quia porro qui expedita. Velit dolorum nisi provident voluptate necessitatibus libero. Alias et exercitationem laboriosam. Consequuntur ex adipisci deleniti praesentium dolore voluptate omnis ipsam. Quam provident repellendus sed ad.	2023-10-13 06:10:16.401	PUBLISHED	0	0	\N	eec18820-ed94-464d-a96b-fb3d2932e272	1021	792	\N
22	Aspernatur commodi corporis natus dolorem at ex placeat vero quibusdam. Eaque ea accusantium illum ratione accusantium.	2023-04-29 03:37:27.567	PUBLISHED	0	0	\N	ae3eb625-0485-4c54-9f10-c04d48482f4d	1022	402	\N
19	Facere minus voluptates distinctio autem porro tempore officiis. Voluptates qui ex.	2023-02-08 09:09:00.153	PUBLISHED	0	0	\N	e8fff252-6c42-4c70-a739-d1c8b885957b	1024	762	\N
17	Quae illum beatae sequi sit. Accusantium occaecati odit eligendi numquam ratione. Fuga dicta itaque. Fugit dignissimos aut quod eaque autem unde aperiam. Veniam magni dolore delectus eum. Harum consequatur possimus alias accusamus totam quos.	2023-03-28 20:15:50.766	PUBLISHED	0	0	\N	e3b637f6-6ddd-46c6-97fa-d33a4b70e7e5	1026	799	\N
17	Iusto libero cumque numquam doloremque eos cumque eos sed. Neque minima nam numquam aperiam ea rem earum blanditiis atque.	2023-08-05 11:42:33.808	PUBLISHED	0	0	\N	293347ce-857e-4dff-9b6a-0a2b20b1748f	1027	804	\N
15	Eos eius sunt excepturi. Facilis ullam aliquid recusandae hic dolore aspernatur corrupti. Incidunt consequuntur ipsam officiis praesentium minus.	2022-11-27 21:22:50.55	PUBLISHED	0	0	\N	77dc9b13-3169-4fbe-8d00-8715a78e7592	1028	771	\N
18	Voluptatem et esse reprehenderit maxime. Quasi tempore nam ipsa.	2023-07-28 20:17:26.206	PUBLISHED	1101783.249022222	1	\N	ece80457-c9b1-4bee-a4e6-87d58d8f443d	1029	676	\N
20	Occaecati suscipit beatae ipsa dicta aperiam magni illum. Ipsum deserunt quaerat laboriosam amet facilis amet. Sint velit accusantium. Necessitatibus aspernatur at laborum provident ducimus. Minus dolores quo similique.	2023-09-01 19:34:05.603	PUBLISHED	0	0	\N	b4855c75-b552-42c0-8c19-642c413fb1d4	1030	731	\N
23	Officia sapiente asperiores sed error perferendis natus rerum. Distinctio consequatur a maiores. Sit repudiandae doloribus esse illum nostrum quisquam reprehenderit ex nulla.	2023-10-11 11:33:20.489	PUBLISHED	0	0	\N	d425df2c-a9ce-446a-a494-bfddccd128c7	1031	886	\N
23	Recusandae et sunt ipsam libero. Iusto vitae provident. Tempore corporis laboriosam quae culpa voluptates non.	2023-11-18 16:48:00.049	PUBLISHED	0	0	\N	a6fba261-a279-4e1a-b363-b6072d8adc3e	1032	851	\N
22	Laudantium sed cupiditate blanditiis dolorem perspiciatis cupiditate. Perferendis doloribus tenetur dignissimos accusantium placeat consequatur explicabo quidem facere. Nemo quidem similique earum. Alias fugit explicabo iusto quam quam quae in. Quibusdam officiis dicta voluptatum expedita illo magnam provident harum. Ipsa similique ipsa soluta repudiandae laboriosam sequi asperiores ad.	2023-10-04 09:43:51.156	PUBLISHED	0	0	\N	12483770-65f3-4508-87b3-3322532dda5c	1033	669	\N
21	Facilis ab asperiores amet cum. Aliquam sit vitae modi consectetur. Deleniti harum nobis pariatur laudantium.	2023-03-18 10:04:58.372	PUBLISHED	0	0	\N	c6bd6d84-e9ce-4a22-9b1d-9cb1e5406c57	1034	579	\N
21	Quisquam fugiat tenetur omnis eligendi reprehenderit fugit. Sit enim fugit. Debitis sint optio architecto debitis illo. Labore tempora numquam dolorem aliquam doloribus distinctio est ab in. Consectetur repudiandae facere repellat.	2023-04-21 04:18:21.336	PUBLISHED	0	0	\N	a22bc1f8-5337-403e-9f60-b06e14fb28da	1035	755	\N
17	Tenetur optio cum rerum veritatis sunt iure vero. Quo natus dolorum corporis voluptatum itaque deleniti praesentium totam. Sapiente suscipit commodi. Est cumque fuga atque similique. Eveniet quas quas minus beatae aspernatur adipisci sed praesentium nisi. Est ab in laborum eaque officiis id.	2023-04-22 01:59:37.791	PUBLISHED	0	0	\N	7511889e-ac11-42da-92aa-8632d17cb965	1036	594	\N
23	Facere ut omnis quidem. Vitae nisi adipisci nihil minima suscipit. Molestias expedita distinctio harum unde ratione explicabo libero officiis dolorum. Iusto officiis illo facere. Nulla id dolorum odio molestias iure qui dignissimos repudiandae.	2023-09-29 23:23:25.386	PUBLISHED	0	0	\N	debe09cc-876b-4089-a729-2b256534b239	1037	808	\N
14	Temporibus officia doloremque voluptates. Impedit nobis voluptatibus saepe quasi. Quis officia quaerat dolores reprehenderit itaque expedita.	2023-06-03 07:35:38.927	PUBLISHED	0	0	\N	bea8785c-b67b-4374-b62d-ab98becc3050	1038	1005	\N
15	Commodi odit vitae ducimus corrupti odio. Numquam fuga dolores porro delectus ad.	2023-07-30 14:33:30.471	PUBLISHED	0	0	\N	4e5b9782-5f21-4559-8730-1973c271f485	1039	599	\N
14	Sint eaque natus. Maiores consequatur neque reprehenderit alias eius ratione blanditiis.	2023-05-11 08:23:28.703	PUBLISHED	951071.3045111111	1	\N	c49afd5e-bcfa-4fb4-b856-6f04a1030d3e	1040	720	\N
20	Inventore temporibus aut saepe recusandae ipsam vel perspiciatis veniam. Quibusdam delectus cum quo consequatur quia nisi voluptas doloribus. Qui cum pariatur vero debitis temporibus eum optio sequi. Ipsam adipisci ducimus dignissimos corporis quos quaerat quos. Facere facere incidunt labore voluptatum ducimus consequatur error cumque dolore.	2023-10-04 01:29:25.985	PUBLISHED	0	0	\N	0deec233-30fa-41f4-89fb-86dca66d710c	1041	781	\N
15	Sapiente libero maxime occaecati autem quod sunt tenetur quam. Minima impedit aliquam eligendi tenetur quia ea. Est culpa voluptatum. Culpa quam et tempora. Placeat quam omnis deserunt ipsum soluta. Iure eveniet atque.	2023-07-08 13:39:19.384	PUBLISHED	0	0	\N	12497b79-1646-4492-8aac-9b134ead04c5	1042	690	\N
19	Magni esse doloremque voluptatibus dolore enim earum placeat. Omnis soluta illo pariatur voluptatibus molestiae voluptatibus tenetur atque corporis.	2023-08-08 01:19:37.604	PUBLISHED	0	0	\N	d4ee059e-857b-40da-94f5-fce11628240f	1043	370	\N
15	Deserunt necessitatibus explicabo voluptatum ratione totam laudantium corporis deserunt. Omnis tempore maiores dolores voluptas qui ut voluptas occaecati ad. Earum nisi vero vitae. Debitis est iste repudiandae totam ipsa quibusdam eligendi eaque. Unde molestias debitis cupiditate explicabo aut illum. Rem veritatis libero.	2023-03-23 11:00:18.809	PUBLISHED	0	0	\N	1977dcd3-cd15-408f-96f2-70f87aadc29c	1044	418	\N
17	Cum eum saepe nemo dolore corporis est minus doloribus debitis. Consequuntur reprehenderit sed in enim dolore natus tempora ab molestias.	2023-10-27 10:42:14.433	PUBLISHED	0	0	\N	4a9496ec-6652-49f0-8611-688acf1987fa	1045	920	\N
22	Atque distinctio similique distinctio. Possimus voluptates rerum laboriosam esse atque. Corporis assumenda eveniet sapiente dolores deserunt cum possimus. Minus sequi vel nemo asperiores quisquam quia unde excepturi.	2023-08-03 22:30:25.028	PUBLISHED	0	0	\N	10953079-dd45-4614-a5f7-72526dec1866	1046	709	\N
23	Fuga impedit in. Fuga debitis dolor unde. Similique distinctio nesciunt quidem molestias deserunt laboriosam consequuntur odit deleniti. Delectus corrupti ex incidunt soluta dolorum fuga eius quidem laboriosam.	2023-10-24 11:54:01.114	PUBLISHED	0	0	\N	0ea749fd-6e67-433f-bfd7-9d01db6498e6	1047	797	\N
16	Ducimus soluta sunt beatae natus laudantium. Ullam repudiandae asperiores fugit. Repellendus magni distinctio eaque fugiat dolorum. Earum ipsam repudiandae officia eveniet laborum aliquid nulla sapiente. Pariatur quisquam dolores maxime. Itaque officia aut accusantium.	2023-11-18 18:17:49.476	PUBLISHED	0	0	\N	e95dc592-a312-4e1a-be3f-96de56175c5c	1048	872	\N
22	Rem officiis recusandae consequuntur quam aliquam. Minus distinctio repellendus fuga quis ipsa soluta accusamus magnam deleniti. Expedita natus dicta hic odit sequi. Tempora praesentium quidem deserunt.	2023-05-15 17:31:18.306	PUBLISHED	0	0	\N	141a14af-1a67-4fa4-ba2d-b1e83f3480e5	1049	590	\N
16	Maxime expedita sit nam molestiae unde laborum amet totam neque. Sed saepe quae laborum voluptates illo blanditiis neque placeat. Corrupti corrupti dicta dicta vitae quam atque accusantium nesciunt.	2023-07-31 02:47:34.153	PUBLISHED	1106143.425622222	1	\N	51474f43-8a3e-4789-b1c1-9de1e1f67702	1053	724	\N
17	Repellat facilis totam modi accusamus. Ipsam ullam omnis cumque corporis unde laborum dolorem ipsam ullam. Corrupti quibusdam iste vel. Voluptate eius a nihil.	2023-10-08 08:00:28.004	PUBLISHED	0	0	\N	53082c6e-96c3-4024-afb2-f186bfddfeec	1054	787	\N
16	Nam repellendus recusandae corporis non dolorum molestias accusantium fugit omnis. Expedita reiciendis quam excepturi libero distinctio. Nulla veniam delectus commodi voluptates modi commodi cum. Id cum excepturi commodi. Eum architecto earum nisi sint ut deserunt alias ullam.	2023-01-22 12:30:32.512	PUBLISHED	0	0	\N	2f819945-0687-4754-a4c6-bc8eb5360a40	1055	684	\N
16	Quibusdam non expedita. Repellat commodi quo iusto odio accusantium. Odio dolores amet itaque occaecati placeat tenetur quaerat repellat in.	2023-11-03 04:05:32.589	PUBLISHED	0	0	\N	82ff3c8b-7b41-46c2-a887-7d41ed400c67	1056	372	\N
15	Numquam saepe ducimus rerum dignissimos nulla. Laboriosam doloribus aliquid occaecati repellendus esse rem dignissimos. Expedita asperiores voluptate nobis non.	2023-02-15 19:18:13.554	PUBLISHED	0	0	\N	95c96c0d-08a8-4c27-9216-0b4c5dacdedd	1057	913	\N
17	Maiores facere ratione. Voluptatum animi ad suscipit culpa. Porro totam quas voluptatum soluta eos magnam. Non vitae quaerat ea vitae. Unde vitae corporis. Quo pariatur iste vitae veniam.	2023-04-23 19:19:10.417	PUBLISHED	0	0	\N	e64b2c6c-9256-46db-b772-afffa95e5a03	1058	451	\N
21	Ex animi voluptatem nobis voluptatum suscipit dolores perspiciatis iure accusantium. Ea veritatis exercitationem.	2023-08-26 18:39:55.764	PUBLISHED	0	0	\N	2dddd97c-04d5-458d-a2d6-0ea5c0545fe8	1059	389	\N
21	Similique consequuntur voluptas earum praesentium. A reiciendis ex quaerat soluta nulla.	2023-01-21 18:34:32.393	PUBLISHED	0	0	\N	ead08222-f5f2-4247-941e-76aca3f8d895	1060	882	\N
21	In dicta et nobis. Quae ullam nesciunt modi porro cum quod praesentium earum. Quas doloribus velit. Impedit saepe sint dolore facilis voluptatibus porro dignissimos incidunt doloremque. Sint necessitatibus deleniti. Molestias iure cum distinctio autem labore.	2023-11-08 13:29:00.093	PUBLISHED	0	0	\N	6d198f04-b1b5-4220-8f6e-0a456ac48c65	1061	955	\N
23	At asperiores ea porro impedit quisquam hic dignissimos repudiandae. Deleniti sapiente earum occaecati eius ut. Totam dolor neque quas numquam sunt. Voluptatibus aut beatae molestiae quidem debitis sed. Distinctio autem rerum voluptates laborum ipsum cum delectus consequatur.	2023-11-04 16:40:35.295	PUBLISHED	0	0	\N	851f9ff4-09f6-4fbf-8a61-a7e49c8a86e2	1062	341	\N
21	Quos voluptate culpa. Non suscipit sint nihil vero vitae praesentium quidem. Sint repellendus dolores molestias fuga in aut ipsam aliquam. Aperiam necessitatibus provident. Asperiores facilis a cum.	2023-09-14 08:51:20.368	PUBLISHED	0	0	\N	f5dbc242-415e-4c22-8b52-75ffca0f6b5f	1063	546	\N
15	Voluptas vel quidem cum. At adipisci maiores modi enim molestias. Minus illo explicabo. Harum et modi. Aperiam nostrum nam a quas nemo cum voluptatum. Voluptatum provident animi aliquam laborum.	2023-09-10 16:44:33.509	PUBLISHED	0	0	\N	b91eefe0-c058-4b52-9a1f-0d8c1adbcfa7	1064	547	\N
23	Reiciendis adipisci voluptatum animi. Suscipit itaque cupiditate numquam ipsam vero dolores magni.	2023-01-07 13:00:12.991	PUBLISHED	0	0	\N	37914d90-3803-4978-8125-f1ed14ef799c	1065	505	\N
14	Fugiat occaecati vero. Eius explicabo hic deserunt doloribus. Temporibus voluptates labore aut. Tempora hic quod voluptas voluptates aspernatur voluptates quisquam tempore illum. Voluptas iure illo commodi. Libero recusandae fugit ex aliquid.	2023-11-25 23:11:43.235	PUBLISHED	0	0	\N	b7899f99-6bb0-4d2b-afea-dad70b93eba1	1066	834	\N
15	Soluta cumque incidunt fugit incidunt quasi in eius. Ipsam velit nostrum at assumenda. Nostrum nam beatae illum fuga molestias. Veritatis quisquam rerum unde blanditiis tenetur dignissimos deleniti.	2023-01-02 06:50:29.74	PUBLISHED	703267.3275555555	1	\N	0b74671b-1d9f-4619-90d7-dd3b10a31db2	1067	375	\N
16	Odit voluptates et illo sint dicta. Laboriosam corporis enim molestiae. Adipisci debitis suscipit assumenda maiores magni. Deleniti eaque ex. Perferendis nihil iusto voluptatibus.	2023-09-11 10:23:38.189	PUBLISHED	0	0	\N	8138004e-8564-4114-985b-e8af9ccead82	1068	1064	\N
21	Quibusdam officiis architecto quasi eum. Illo minus aliquid beatae magni. Commodi tempore et. Cum temporibus beatae nobis dolore libero omnis quisquam.	2022-12-05 13:05:17.643	PUBLISHED	0	0	\N	5ba37a64-fd14-41a5-bcc9-edca3fa7860e	1069	479	\N
20	Iusto et deserunt error iure. Saepe ut quam cupiditate quam dolores debitis voluptatibus. Harum quam doloremque dolor.	2023-08-06 23:09:16.193	PUBLISHED	0	0	\N	1e331987-48a0-48b5-89e1-40a4d98c8fd6	1070	476	\N
16	Omnis nobis voluptate similique ex laborum repellat ad sint ea. Possimus laboriosam commodi facere qui officiis. Sequi blanditiis blanditiis tempore dolorem nisi ratione neque sit saepe. Numquam rem dolorum vitae facilis maiores aspernatur.	2023-02-12 23:14:44.903	PUBLISHED	0	0	\N	bdfbbb6d-66c6-4181-8b29-85106ea029f4	1071	854	\N
14	Saepe fuga voluptatem fugit. Laboriosam corporis omnis libero nulla repellat sunt dignissimos nemo. Consequatur et molestiae exercitationem iste quasi esse amet.	2023-07-22 07:54:11.861	PUBLISHED	0	0	\N	6a1507fc-f87f-4ea4-b2d2-4063a7ba8d1e	1072	977	\N
23	Fuga quasi nihil itaque officiis minima in. Culpa iure possimus quod maxime totam. Porro est et blanditiis minima sit assumenda. Optio harum dolorum vero. Rerum fugit consectetur unde sint perspiciatis.	2023-06-04 02:52:20.581	PUBLISHED	0	0	\N	c7d8354c-d088-4810-a652-3be72c7bf305	1073	923	\N
23	Ducimus recusandae in odio repudiandae est. Nemo laboriosam incidunt tempore. Sed quod molestiae. Officia eveniet libero commodi accusamus similique repudiandae. Libero quo voluptas corporis. Esse possimus esse magni illo.	2023-10-09 04:08:23.598	PUBLISHED	0	0	\N	7217154d-f96f-42a5-b5a4-597795dd4f82	1074	846	\N
19	Laudantium suscipit sed exercitationem doloremque esse quam quas. Quisquam quam aspernatur recusandae ullam. A tempora eligendi quae ut illo quisquam molestiae aut. A itaque laudantium incidunt sapiente. Adipisci a nam asperiores quam a voluptas inventore voluptates.	2023-02-20 09:42:15.287	PUBLISHED	0	0	\N	5ebf0ea1-48b6-4849-8b8c-37cd0d7499f3	1075	659	\N
20	Voluptatum veniam saepe temporibus ipsum ratione non. Ducimus distinctio consequatur illo occaecati provident. At ab ratione ducimus. Laborum voluptatum possimus reiciendis veritatis optio modi. Nobis magnam laudantium provident odit. Itaque rerum natus ipsam nostrum.	2023-03-14 11:58:03.164	PUBLISHED	0	0	\N	38f155f7-e8c1-483d-9a47-c3ef580033d8	1076	524	\N
14	Nostrum at cumque saepe delectus. Animi adipisci harum dolor voluptatum. Iusto reprehenderit expedita aut. Asperiores voluptates ex accusantium laboriosam porro possimus asperiores magni quod.	2023-10-11 14:11:26.83	PUBLISHED	0	0	\N	4a827fff-be2b-4f07-8681-9f48bbe8292e	1077	991	\N
21	Soluta excepturi distinctio. Est natus eveniet ex modi. Ab odio impedit natus expedita itaque exercitationem. Commodi vel a ratione repellat.	2023-04-22 04:48:11.627	PUBLISHED	0	0	\N	12e56374-efdd-4d25-80e0-f992eedf55c4	1079	410	\N
19	Voluptatibus ut cumque eligendi reiciendis quasi excepturi rem tempore aut. Impedit est dicta omnis. Animi magni consectetur sit fugit deserunt omnis ex dignissimos culpa.	2023-10-09 01:25:58.919	PUBLISHED	0	0	\N	b6463d4f-70e1-4caf-b744-8426044babb4	1080	441	\N
22	Non earum sunt debitis esse dicta quaerat aliquid aliquam. Quia recusandae explicabo pariatur ex. Ipsa tenetur unde pariatur neque. Nostrum porro ducimus dignissimos aut ad quia vero rem.	2023-06-03 14:11:18.459	PUBLISHED	0	0	\N	d942b054-ccb8-4b63-8c0a-55a524f04a38	1081	757	\N
15	Ullam vero corrupti fugit neque. Molestiae laborum incidunt. Provident quam vitae ab at necessitatibus illo eos quae saepe. Sequi unde animi omnis. Hic inventore quod explicabo eaque velit similique.	2022-12-13 03:57:34.853	PUBLISHED	0	0	\N	d4c49238-7b8e-4c8b-bc61-1871f076ca77	1083	624	\N
22	Ipsum quam cum officiis explicabo sapiente suscipit ex eveniet ut. Pariatur eum labore tempora.	2023-10-12 08:29:16.26	PUBLISHED	0	0	\N	87005a80-93f3-4aa1-b2a4-b9ac87b253ce	1084	583	\N
21	Error consectetur aliquam maxime quia voluptates. Eligendi nihil modi quae aliquam qui optio voluptates quidem. Cumque voluptates consectetur. Aliquid quisquam exercitationem quidem quisquam voluptate.	2023-10-31 10:22:49.006	PUBLISHED	0	0	\N	0f747299-69bb-42fa-b097-9539f524b810	1085	797	\N
19	Neque odit magnam laudantium eveniet. Odio cupiditate excepturi rem maiores aperiam. Ipsa dicta perspiciatis facere sequi cumque. Dolores corporis quasi distinctio hic aut autem consectetur. Error repellendus ullam pariatur corporis aspernatur qui quas maxime.	2023-10-13 22:49:53.958	PUBLISHED	0	0	\N	a45c7484-6fb3-4802-8e50-ac37dc0604c7	1086	685	\N
20	Saepe animi laborum atque dolores totam quasi blanditiis quaerat. Cum deleniti harum explicabo. Praesentium amet illum atque modi facilis maiores asperiores ipsum.	2023-03-04 11:51:24.638	PUBLISHED	0	0	\N	9d2c8b7f-0def-4717-8649-9b480e16285a	1087	538	\N
15	Esse autem deserunt ullam dolore odit omnis earum possimus. Quaerat rem aspernatur eum. Asperiores unde mollitia quo illo sapiente. Fugit consequatur veniam exercitationem veritatis doloribus animi a.	2023-11-23 01:17:03.689	PUBLISHED	0	0	\N	405a38c0-cdbb-4046-82a9-79da336c6d20	1088	548	\N
18	Voluptate autem cupiditate eos voluptas aliquam voluptates tempora. Porro soluta necessitatibus quos quasi at distinctio culpa id. Repellat quia consectetur perspiciatis quis accusamus esse sed perspiciatis. Delectus reiciendis eius ipsa maxime sed nesciunt. Architecto fuga blanditiis veritatis nam.	2023-07-05 15:06:17.424	PUBLISHED	0	0	\N	4d5b846e-0beb-4d8b-aa52-5da0af491398	1089	511	\N
23	Illum possimus ullam quam praesentium eveniet. Eaque magnam vero odit eos cum repellendus.	2023-06-30 03:02:41.778	PUBLISHED	0	0	\N	0bae2551-14f7-4143-8c90-73dbfc9e656d	1090	453	\N
23	Tempore quam temporibus illo ut magni voluptatibus eius at qui. Facere recusandae repellat enim eligendi molestias. Sapiente eligendi fugiat. Asperiores soluta quasi voluptas. Saepe consequatur voluptatibus ullam maiores odit rerum.	2023-07-15 19:16:40.4	PUBLISHED	0	0	\N	7d97aca5-54f2-477a-b57c-640cf7d60767	1091	971	\N
23	Quidem commodi quibusdam doloribus eveniet. Quaerat pariatur quaerat ipsa.	2023-03-01 03:54:32.322	PUBLISHED	0	0	\N	a861c818-a40e-46cc-9eb7-f729c7345311	1092	954	\N
18	Mollitia perferendis ipsa unde quos. Provident repudiandae placeat excepturi in molestias exercitationem tempora tenetur. Iusto dolorem praesentium modi quis. Itaque exercitationem tempora.	2023-03-31 14:34:23.992	PUBLISHED	0	0	\N	ac79546f-c2db-4ade-b4bb-77016eb6ba32	1093	892	\N
21	Quas cumque porro velit ipsam animi. Quod itaque ducimus commodi eligendi laboriosam libero repudiandae quae. Hic quaerat soluta harum. Labore esse ipsam molestias libero quidem sequi adipisci sed vitae.	2022-12-23 20:38:22.872	PUBLISHED	0	0	\N	83d844db-7af1-4719-86f2-173fb824611a	1094	621	\N
22	Velit consequatur expedita facere optio consequatur exercitationem vel. Officiis eaque veniam optio minima officia enim voluptatem laborum. Modi totam quisquam non similique voluptas minima magni soluta dicta. Vel iusto soluta tempora rerum qui totam tempore dignissimos. Temporibus minus amet amet rem animi aliquid. Rerum ex tempora.	2023-01-22 08:52:39.979	PUBLISHED	0	0	\N	d0c383c4-94a5-4ed5-80fd-1d56361829a5	1095	952	\N
16	Occaecati hic quod illo alias quaerat tenetur. Fugit labore quae cum impedit ratione ut illo. Laborum iusto facere quos distinctio quaerat blanditiis officia voluptatum. Repellat tempore eos eligendi in fugiat optio.	2023-03-12 02:40:35.21	PUBLISHED	0	0	\N	edd67bf3-1159-4a54-9e13-de69febcfa86	1096	897	\N
20	Ea suscipit enim dicta labore quibusdam. Numquam esse quod porro. Quos distinctio esse doloremque atque iusto nobis quos. Praesentium voluptatibus tempore dolorum quod dolorum. Accusantium temporibus architecto ab reprehenderit deserunt harum. Quaerat cum odit quas.	2023-09-15 04:56:00.802	PUBLISHED	0	0	\N	2fcf67bd-8f55-4d53-8b1b-907b082cd41b	1097	617	\N
21	Quis accusamus nostrum. Voluptatibus doloribus tempore nesciunt occaecati. Fugit voluptates impedit. Impedit amet vel distinctio nobis sequi tenetur.	2023-02-05 09:37:53.821	PUBLISHED	0	0	\N	4325170c-42ce-45ad-b4b0-60164106983e	1098	435	\N
19	Dicta excepturi vitae unde cupiditate. Iusto modi non esse voluptatum sint reprehenderit quisquam animi vero.	2023-10-25 11:55:29.095	PUBLISHED	0	0	\N	5e97d73c-891d-4189-ae92-730ed95b544a	1099	886	\N
21	Nobis quaerat perferendis odio occaecati a quod. Vero nesciunt delectus possimus. Magnam deleniti quia odio vero hic culpa repudiandae mollitia quidem. Nam dolorem debitis ipsam.	2023-01-17 22:33:50.12	PUBLISHED	0	0	\N	58814ab4-7346-4b67-ae8d-a0e949195b87	1100	1099	\N
15	Eaque veniam pariatur doloribus magnam quisquam repudiandae facere. Aliquid veniam sint itaque. Laboriosam natus sapiente voluptate temporibus facilis non aliquam. Asperiores velit quam doloremque qui nulla exercitationem nihil in.	2023-07-21 07:08:12.365	PUBLISHED	0	0	\N	23b2c8fc-9648-4619-bb98-933eb6f5fb4a	1101	768	\N
19	Nisi aut laboriosam repellat numquam odit quisquam cum tempora dignissimos. Occaecati illum error perspiciatis.	2023-09-16 10:07:06.815	PUBLISHED	0	0	\N	a29b6a97-7d7b-4096-82ac-2b80b9b44f3e	1102	728	\N
16	Accusantium voluptatum provident assumenda quasi quisquam quibusdam quasi repudiandae. Officia dignissimos eaque itaque veniam aut. Voluptatem architecto aliquid dicta dolorum ut ipsum repellendus reiciendis.	2023-06-14 04:01:55.414	PUBLISHED	0	0	\N	fed85e13-34b5-46a3-8fd4-ae6250fa148c	1103	962	\N
21	Dignissimos tenetur voluptas rem harum sequi occaecati quasi. Recusandae voluptatem commodi blanditiis.	2023-11-26 01:51:30.376	PUBLISHED	0	0	\N	fd572d3f-a9c1-47ff-9b52-b9de9e086620	1104	819	\N
15	Officia voluptatum sequi. Natus alias ullam dolor dolor dicta dolores odit. Earum temporibus quam ad.	2023-09-16 12:02:18.361	PUBLISHED	0	0	\N	8c32c87b-ed9f-4649-a0e1-21d8ceac11c0	1105	563	\N
21	Soluta omnis sed alias consectetur a nostrum. Beatae commodi similique aliquam. Earum tenetur et culpa quisquam est sunt dolorum magni. Dignissimos saepe doloribus nam nihil vitae consectetur voluptate similique esse.	2023-05-17 13:40:00.606	PUBLISHED	0	0	\N	a6e8b56c-e78d-4170-8555-e788eb1dac82	1107	761	\N
20	Voluptatibus facere pariatur. Temporibus impedit deleniti nemo quia soluta a cumque. Molestias laboriosam a rem laudantium fugit sit laudantium debitis.	2023-02-02 03:38:29.04	PUBLISHED	0	0	\N	e59e4090-22a5-48a9-8745-b47d457dcac3	1108	356	\N
21	Commodi ullam placeat alias repudiandae minima recusandae eligendi quibusdam sapiente. Perspiciatis doloribus eveniet harum soluta nostrum vero quidem ab. Quasi totam accusamus exercitationem nulla.	2023-04-16 04:28:29.057	PUBLISHED	0	0	\N	7425fd85-89e5-4bbd-a540-b54f32eed543	1109	779	\N
20	Porro voluptatibus error enim ipsam ipsa voluptatem vero. Consequatur unde sapiente illum modi corrupti tenetur ullam. Ea suscipit ratione ex. Labore libero repellendus. Hic ipsum placeat sint natus veniam commodi nemo aut quas.	2023-11-26 18:26:53.864	PUBLISHED	0	0	\N	e9e78a2c-ecbd-47bc-899a-df409cab71ad	1110	359	\N
15	Illum corporis ab temporibus similique quas provident amet unde fugit. Voluptatibus harum ipsa occaecati corporis quia sit eum sed cumque. Occaecati provident porro autem quisquam exercitationem.	2023-09-18 06:17:59.668	PUBLISHED	0	0	\N	b1657b03-92de-4b91-9ac8-6262d62aff40	1111	982	\N
14	Autem eum eum incidunt illo sed quas delectus natus. Neque repellat sequi autem ea. Deserunt doloremque laboriosam ut veniam neque perferendis porro.	2022-12-29 12:03:44.327	PUBLISHED	0	0	\N	ab728a9f-c812-4b45-818c-4f5e083ad921	1113	700	\N
18	Mollitia magni minus recusandae ratione architecto ex corporis cumque. Placeat perferendis distinctio voluptas dicta suscipit ipsa natus vel.	2023-01-22 16:18:22.999	PUBLISHED	0	0	\N	dec8df1a-c785-4c37-bcb2-004712392a98	1114	364	\N
20	Ex voluptatibus debitis. Cupiditate cumque quod explicabo dignissimos distinctio quia voluptates eos.	2023-05-13 06:31:24.506	PUBLISHED	0	0	\N	b69ff4a4-fb70-450b-926f-cc07225a5c8e	1115	508	\N
22	Assumenda repellat error quasi laboriosam saepe maxime rerum. Deleniti labore nesciunt fugiat facilis perferendis quos reprehenderit a excepturi. Reiciendis officiis facere.	2023-02-03 03:17:17.011	PUBLISHED	0	0	\N	acc4692a-ea78-4464-a2ab-70f14ed50951	1116	540	\N
20	Ipsam nisi magnam amet itaque recusandae. Exercitationem reiciendis eius. Explicabo ullam accusamus excepturi optio quibusdam sequi quos aliquam inventore. Quidem ullam animi maxime eos ullam libero consequuntur alias.	2023-03-28 22:30:24.657	PUBLISHED	0	0	\N	d325dca9-f43b-4423-9f43-9f9ef8949c7b	1117	763	\N
19	Ullam asperiores minus nesciunt. Fugit aut corporis accusamus accusantium vero impedit. Vel eum corrupti cupiditate dolorem saepe.	2023-10-12 21:24:15.55	PUBLISHED	0	0	\N	2e777958-e476-4d51-896f-3a656ff81d44	1118	876	\N
14	Tempore at rem earum ipsum architecto corporis. Praesentium laudantium totam asperiores illum. Molestiae delectus eligendi sapiente qui error eaque repellendus adipisci.	2023-02-07 15:21:10.671	PUBLISHED	0	0	\N	575e0d75-3bbb-49a0-9c84-15bd2cd21652	1119	878	\N
20	Animi libero commodi amet. Molestias architecto sed voluptate laborum libero. Ut nobis illum quia fugit ipsa voluptate beatae recusandae repellendus.	2023-06-25 19:49:24.131	PUBLISHED	0	0	\N	9bce400f-a2e9-4771-bfd1-63c74d7bb731	1120	355	\N
21	Excepturi numquam earum. Quas porro aut aliquid voluptate. Perspiciatis quae quo rerum ipsa. Facilis dolorum optio aliquid modi suscipit nesciunt a sed. Sapiente repudiandae aspernatur corrupti. Veniam deleniti qui.	2023-11-02 21:03:03.481	PUBLISHED	0	0	\N	65d12192-f2b4-4c5c-8a9e-f98ae69e09d9	1121	437	\N
16	Ipsa blanditiis quisquam deleniti assumenda quasi quidem explicabo sunt. Tempore deserunt earum. Possimus explicabo nostrum nesciunt. Corporis delectus odit animi dolores inventore.	2023-03-30 08:11:17.352	PUBLISHED	0	0	\N	efaf4974-1d91-443b-8b68-1db6b2213c4c	1122	481	\N
14	Hic vero tempore nobis animi ea. Enim quae dignissimos nesciunt corporis illo eum hic ad. Facilis temporibus porro. Consectetur assumenda necessitatibus reiciendis maiores ratione sunt odit doloribus. Corporis dignissimos nobis. Ad rem voluptas ipsa similique sed temporibus libero.	2023-08-30 10:37:44.222	PUBLISHED	0	0	\N	8a68bb38-8076-4e4e-a126-9e897c3039b0	1123	998	\N
17	Quidem consequuntur libero reiciendis alias aspernatur voluptas perspiciatis accusantium. Veritatis assumenda qui. Officia porro sapiente aliquam harum nesciunt sit officia nihil. Voluptatem corporis ut qui mollitia excepturi nesciunt saepe dicta voluptate.	2022-12-02 20:35:20.967	PUBLISHED	0	0	\N	b9c9ba1b-3f99-41ae-916a-452e3425b7e3	1124	1089	\N
22	Voluptates repellat vel molestias voluptate ipsam corporis. Nisi dignissimos perferendis officiis quo labore ducimus ut.	2023-01-14 17:43:20.024	PUBLISHED	727177.7783111111	1	\N	17fb0738-1cd8-4628-bf35-c1073c7cd7d1	1125	803	\N
14	Corrupti blanditiis voluptas exercitationem nisi sint nemo ullam. Rerum officiis voluptate ab. Quae dolorum voluptate. Magni quod amet expedita. Totam illo earum ratione. Quibusdam reiciendis cupiditate quia natus repellat in adipisci.	2023-07-06 19:01:24.083	PUBLISHED	0	0	\N	35f763e1-88d8-4119-acd4-2aca4361fe3c	1126	1016	\N
18	Assumenda dolores magnam architecto corporis nostrum quae vero. Accusantium delectus sit soluta id expedita. Explicabo dolor iste molestiae eius totam soluta. Explicabo saepe adipisci recusandae reprehenderit quae. Ipsa quos repellendus modi nam. Delectus voluptate tempora occaecati repellendus eum enim quisquam ratione molestiae.	2023-11-25 21:29:42.359	PUBLISHED	0	0	\N	25c1d1e4-1033-445a-868f-be56d918f0f0	1127	655	\N
20	Dolorum quae repellat voluptas nemo inventore at. Excepturi modi debitis aut totam. Necessitatibus eligendi optio accusamus reiciendis consequatur perferendis itaque. Doloremque quae reiciendis possimus placeat delectus. Corrupti eligendi quos dolorem sequi occaecati vel molestiae. Occaecati soluta nostrum exercitationem nobis dolorem labore non facere aliquam.	2023-03-23 15:08:36.649	PUBLISHED	0	0	\N	b1ce7203-01a3-45a1-8010-2fb334127546	1128	372	\N
20	Accusamus tempora optio harum distinctio. Accusamus maiores dolores eveniet ullam velit consequuntur nulla ad. Doloremque omnis ratione aliquid. Dolor sapiente fuga. Fugiat distinctio occaecati tenetur blanditiis fugiat doloremque non cum. Consequatur reiciendis sequi iure ipsa cupiditate temporibus architecto neque.	2023-02-14 11:05:13.744	PUBLISHED	0	0	\N	38fb347c-a70d-4a30-9082-126ed8238601	1129	670	\N
16	Ab accusamus nulla rem repellendus quam explicabo fuga autem eos. Recusandae voluptas amet ipsam saepe libero voluptatum. Recusandae laudantium ipsum. Eum sequi nostrum. Nobis hic aliquam porro porro cupiditate suscipit at.	2023-08-01 04:20:45.298	PUBLISHED	0	0	\N	2dd175db-fd09-4f94-bdbf-b556407b0dd6	1130	719	\N
22	Voluptatibus a culpa eveniet quas atque commodi nulla optio. Ducimus aliquid iure tempora minima corporis laudantium cumque.	2023-01-20 03:13:04.026	PUBLISHED	737537.4228	1	\N	d93b273a-b5c9-4ee5-a580-428c4ce78b0f	1211	625	\N
19	Corrupti perspiciatis numquam iure et ex. Aliquid nostrum asperiores. Necessitatibus nam voluptatem pariatur excepturi consequatur deleniti quis sit tempore. Id consequuntur fugiat tempora quis consectetur culpa. Eveniet optio aliquam necessitatibus earum molestias nostrum aliquam error magni.	2022-11-29 06:53:54.184	PUBLISHED	0	0	\N	176eb645-1a7e-4554-95aa-df437e6a9a0b	1132	612	\N
15	Blanditiis quasi magnam nesciunt quidem exercitationem ad beatae nostrum. Assumenda magnam consequatur quae nam unde. Adipisci facere inventore quisquam earum quidem temporibus.	2023-05-29 05:55:56.925	PUBLISHED	0	0	\N	3f61c793-7bc3-45a2-b034-7852bc35300d	1133	463	\N
20	Ab nisi excepturi. Corporis mollitia aperiam fugit nisi consequatur nisi labore modi. Fugiat expedita ab expedita aut.	2023-08-30 01:31:25.09	PUBLISHED	0	0	\N	f74f3b08-b8fb-4a3a-b061-5976ba224337	1134	1110	\N
15	Quidem unde ea expedita magni animi ab iste odit accusamus. Deleniti illo architecto iusto recusandae consequuntur cum ipsam magni ullam. Quos laboriosam nulla nostrum perspiciatis neque dolore natus ea. Ipsa consequuntur est nihil asperiores natus vero aperiam. Fuga dignissimos itaque molestiae. Quam quos dolores tenetur suscipit doloribus beatae nihil itaque.	2023-05-15 15:38:33.671	PUBLISHED	0	0	\N	c71c68ce-adcc-4f34-976d-faeaea0a76fb	1135	1110	\N
21	Enim eius natus veniam numquam pariatur. Minus nemo est illo incidunt dolor temporibus a. Aliquam blanditiis sunt incidunt quibusdam dolore. Ipsa nostrum asperiores repellat quidem labore eum maxime. Amet voluptatibus quaerat quam laboriosam voluptatem atque nesciunt dignissimos. Nemo odit voluptate sit asperiores.	2023-03-23 08:58:35.367	PUBLISHED	0	0	\N	de33563b-5301-470f-81ad-76b64f6ba77b	1136	531	\N
16	Suscipit voluptatibus velit consequatur ratione. Temporibus odio ex dignissimos quidem tempora consequuntur minus atque voluptatum. Facilis iusto soluta quis non praesentium libero aut ipsum accusantium. Aperiam ut ea itaque itaque temporibus. Vero fugiat dignissimos at expedita perferendis temporibus.	2023-01-19 18:19:34.881	PUBLISHED	0	0	\N	962f65f6-08fe-4b36-907a-650a69c9967b	1137	998	\N
18	Alias minus beatae. Cumque debitis quisquam accusamus sapiente. Ipsam molestias provident aut aut velit reprehenderit quis earum blanditiis. Itaque sint eos occaecati expedita in odit quae provident ducimus.	2022-12-14 19:56:04.247	PUBLISHED	0	0	\N	80cbefe3-3375-4298-91c2-2a7890cb6e76	1138	529	\N
16	Magnam quasi id quae deleniti consectetur in quo. Eveniet occaecati odio optio eligendi corrupti quas laboriosam.	2022-12-05 23:14:25.575	PUBLISHED	0	0	\N	991ab197-ef92-47e3-a8a9-b59fe6e0c290	1139	541	\N
15	Repudiandae fugit a veniam debitis quos excepturi aliquid. Vero veniam magni voluptates hic odit id. Officia dolore ipsam. Numquam reprehenderit magni quos assumenda illum suscipit magnam repellendus. Tenetur assumenda tempore numquam magni enim sunt. Nam architecto praesentium reprehenderit quasi assumenda quis eos accusamus fugiat.	2023-07-27 05:24:47.589	PUBLISHED	0	0	\N	065cc8b8-5c47-4547-910d-12c3d17de20d	1140	461	\N
19	Mollitia blanditiis nulla eligendi explicabo modi earum incidunt corporis. Voluptatem et saepe eaque quae.	2023-09-26 17:26:21.182	PUBLISHED	0	0	\N	f372bd95-d86a-4c2a-963f-c4bd96394321	1141	812	\N
14	Tempore asperiores eveniet. Optio at sapiente facere cumque.	2023-11-17 20:51:01.549	PUBLISHED	0	0	\N	b3bc2d53-e98f-4bca-a8e6-c6183e519049	1142	892	\N
15	Nobis repudiandae ab voluptatibus aliquam possimus aliquid deleniti. Cum porro enim dolorum sunt cumque quae inventore officiis. Dolorem nemo cumque omnis. Molestiae eos excepturi odit. Provident eum mollitia. Vel consequatur quas sequi asperiores aspernatur sint.	2022-12-21 17:29:51.894	PUBLISHED	0	0	\N	0dfc5203-249a-49dc-bfe7-65ae8acef187	1143	859	\N
22	Nam minus exercitationem cupiditate nemo omnis laudantium voluptates adipisci. Assumenda explicabo voluptatum inventore esse saepe suscipit asperiores. Perspiciatis rerum consectetur error mollitia placeat eligendi architecto.	2023-03-23 09:23:54.368	PUBLISHED	0	0	\N	87466848-6824-4f89-a664-0f5fece6ec22	1145	576	\N
23	At voluptas amet doloremque iure ratione qui. Eaque nulla eveniet illo et atque explicabo inventore cum. Earum optio at. Excepturi neque architecto a magni aspernatur quas veritatis et.	2023-06-26 12:25:23.134	PUBLISHED	0	0	\N	dd50325f-a7d2-422e-bdb6-04fb7e06fa90	1146	545	\N
23	Assumenda dolore libero. Odio minus porro quisquam maiores corporis voluptatem. Quaerat quos ab eos quam architecto. Sunt sunt corporis rem mollitia. Porro nulla dignissimos dolore. Ipsam hic quis similique quaerat.	2023-07-23 13:41:46.584	PUBLISHED	0	0	\N	6a1a38e0-8164-4a47-8c6a-2e617b687da5	1147	572	\N
18	Ad temporibus voluptatibus ab asperiores dolore autem tenetur iste ipsam. Enim dicta doloribus. Ex fugit facere esse ab nihil. Molestias dolores veritatis exercitationem enim cum ut quaerat. Maxime nostrum accusantium dicta dicta aliquam reprehenderit odio.	2023-09-19 20:46:40.442	PUBLISHED	0	0	\N	1d93af44-e5ec-474e-adc9-f708e3a594f2	1148	464	\N
16	Mollitia suscipit harum. Dignissimos iusto aperiam quae minus beatae ab modi iure recusandae. Vel iure facilis pariatur dolor repudiandae. Esse natus sed assumenda. Veniam pariatur quas dolorem consectetur. Facere exercitationem alias totam veritatis dolorem accusantium hic voluptas.	2023-01-21 05:37:12.689	PUBLISHED	0	0	\N	fc13e023-53da-471d-adee-a8a3e32aef08	1149	837	\N
17	Facilis alias labore excepturi ad officiis molestiae. Earum unde nobis nam maxime et.	2023-07-27 17:44:37.771	PUBLISHED	0	0	\N	b30744f7-6a89-454b-9574-93f28a5b0b4f	1150	1011	\N
21	Velit quisquam numquam nulla velit. Soluta aliquid soluta architecto exercitationem. Eveniet voluptate quia ipsum doloribus illo. Deserunt consequuntur ipsam provident ullam saepe. Quo maiores voluptas inventore perspiciatis adipisci voluptates facilis dolorum vitae. Quas perferendis ducimus.	2023-07-09 04:56:21.426	PUBLISHED	0	0	\N	0215a2da-2f31-4e83-a8f4-8278208807cb	1151	1103	\N
17	Velit in quis. Iusto impedit at libero odio porro dolores. Maxime aut assumenda soluta explicabo eum asperiores enim voluptate perferendis. Quo debitis provident numquam consequatur doloremque. Ipsum eligendi odit debitis harum labore quia voluptas et ducimus. Ipsa nemo in expedita reiciendis facere saepe asperiores magnam.	2023-02-26 15:22:51.986	PUBLISHED	0	0	\N	b76bfce8-e22c-4b6f-9747-8b69a9ed429f	1152	841	\N
23	Temporibus dolor vitae. Rerum distinctio voluptatem. Sunt quis debitis libero at. Sint inventore odit quam modi at. Perferendis incidunt molestias.	2023-01-24 11:24:17.385	PUBLISHED	745872.3863333333	1	\N	b24f4ea2-efc0-4112-afce-c81486a40a40	1153	583	\N
23	Accusamus eum nostrum. Delectus illo perspiciatis laboriosam. Fugit id ducimus officiis expedita fugit delectus deleniti aliquid quia. Incidunt at facilis expedita eaque nobis fugiat et nihil. Aliquid neque mollitia a temporibus repellat architecto officia.	2023-04-24 02:28:15.824	PUBLISHED	0	0	\N	f68dae23-d03d-4281-ac0a-097c87fd4473	1154	1080	\N
16	Facilis facilis sint. Nisi commodi dolorem laborum temporibus mollitia veritatis accusantium. Facere temporibus doloremque ratione. Nesciunt ea temporibus quia labore maiores repellat. Consequuntur nesciunt error sequi illo adipisci saepe similique dolorum.	2023-11-05 00:56:51.769	PUBLISHED	0	0	\N	1b8caf65-c1b3-4f0d-93cb-143cbd7dd1d0	1156	981	\N
23	Accusamus veniam autem explicabo doloremque occaecati animi laborum ab. Voluptas sequi explicabo quisquam hic impedit ex recusandae laudantium nam. Ex excepturi repellat dolorum quisquam ab.	2023-06-23 07:30:28.986	PUBLISHED	0	0	\N	0fc71fa2-eb89-4c1d-8262-1d6672146267	1157	541	\N
15	Consectetur quos laudantium vel quia error similique omnis. Cum quaerat consequatur occaecati maiores accusantium maiores ad magnam veritatis.	2023-10-06 22:51:32.665	PUBLISHED	0	0	\N	11f26432-1d9e-4b7a-b002-c9b4b77fcfa2	1158	689	\N
22	Optio nemo consectetur nulla architecto enim dolores amet eos voluptas. Laudantium enim neque enim commodi. Ea voluptate possimus.	2023-07-05 05:46:53.93	PUBLISHED	1056462.531777778	1	\N	b034c3a5-8c79-45cb-99c9-1b810addeafd	1159	891	\N
20	Nemo commodi aspernatur quas. Placeat non quo optio distinctio at. In quo eaque.	2023-10-21 02:29:59.264	PUBLISHED	0	0	\N	599740f6-6de6-4e86-93e8-659996af1a96	1160	718	\N
16	Laborum aliquid repudiandae consequuntur maxime voluptates placeat necessitatibus. Pariatur consectetur voluptatem aut quas dolore vel laudantium praesentium. Voluptate tempore hic sunt ipsum repellendus. Minus excepturi beatae sequi blanditiis facilis beatae neque.	2023-06-29 02:38:45.19	PUBLISHED	0	0	\N	6b5895a1-1a3e-4efe-94b8-34488730b72b	1161	350	\N
17	Possimus earum velit deleniti officiis hic deleniti sapiente eveniet. Fugit ex incidunt amet dolorum vitae fugit quod corporis amet. Eius debitis rerum rerum dolorum laboriosam dolorum quasi. Impedit quis dolore eos quas fuga quisquam perspiciatis.	2023-05-20 11:07:45.528	PUBLISHED	0	0	\N	f79e377d-1880-4d87-8969-ee45c056eca8	1162	597	\N
14	At culpa magnam est. Maiores minus quos temporibus. Modi ratione ab officia repudiandae neque ex.	2023-02-13 23:52:12.819	PUBLISHED	0	0	\N	ca20402d-0be7-4bc9-a46f-727662a5ad90	1163	642	\N
23	Sed dolor doloribus non natus iusto nobis ad rerum. Quia possimus cum. Suscipit adipisci corporis eos dolores. Est et alias nemo. Fugiat ducimus sed ut corrupti animi fuga soluta voluptas. Eius dolores quia veniam numquam iure modi modi inventore odit.	2023-02-20 09:56:15.035	PUBLISHED	0	0	\N	1cfb8c3f-bf8e-40ae-8b69-3de29e8e9869	1164	813	\N
19	Inventore in distinctio odio. Autem quaerat architecto vel at. Tempore omnis unde repudiandae.	2023-03-30 05:17:26.444	PUBLISHED	0	0	\N	b8c9b539-4575-46d8-a9fd-df0b863f8c1b	1165	629	\N
19	Ullam quod ducimus unde molestias et error molestiae minus. Consectetur deserunt harum ipsa modi repellendus. Sint sunt quasi inventore. Voluptas vel amet tenetur tempore quam ullam ex iure ab.	2023-05-18 23:03:03.076	PUBLISHED	0	0	\N	86af0d6d-71cf-4ce1-94b2-27995bc5f293	1166	1142	\N
15	Recusandae asperiores placeat dignissimos molestiae voluptate. Ea nemo laudantium culpa tempore ipsam molestias accusamus cumque. Ullam fugit molestias facilis beatae consectetur. Enim praesentium dolorem earum modi rem totam.	2023-08-23 06:35:51.743	PUBLISHED	0	0	\N	67ec46b1-da16-4c25-ae7c-896fa6e2cb1d	1167	570	\N
23	Dignissimos modi veritatis pariatur omnis officiis similique eius soluta. Atque veritatis ab molestiae quidem tempora laboriosam odio eum tenetur.	2023-06-13 15:09:01.69	PUBLISHED	0	0	\N	fbf8f91f-c15c-4e6c-aa75-894159705611	1168	559	\N
20	Animi ipsa ad. Vero minima earum quibusdam facere. Ullam pariatur aut aperiam veritatis praesentium consequuntur molestiae. Asperiores repellat dignissimos repellat incidunt.	2022-11-30 10:45:11.249	PUBLISHED	0	0	\N	17adc907-87c9-45a4-9e56-fab64714b125	1169	1097	\N
21	Ratione quia quaerat vel non soluta deserunt. Nesciunt fugit nobis nisi repellendus asperiores.	2022-12-09 19:30:36.538	PUBLISHED	0	0	\N	9afce1c9-f990-4b27-b9ab-6825c7835dbb	1170	1089	\N
22	Accusamus reiciendis nihil non at quo fuga similique eaque cumque. Quasi in dolorem explicabo ratione tenetur autem accusantium distinctio deleniti. Fugiat quos ipsum ipsum doloremque numquam autem possimus.	2023-10-06 02:19:05.043	PUBLISHED	0	0	\N	ffe31785-e5b0-4625-8b58-5dad4e66b983	1171	358	\N
21	Ex pariatur voluptates illum fugiat. Atque ullam doloremque harum provident corrupti fugit. Beatae iste eum. Voluptatem aspernatur ut odit deleniti. Blanditiis voluptatibus officia incidunt nostrum ad harum facilis voluptatibus.	2023-05-26 16:53:33.696	PUBLISHED	0	0	\N	48f492f3-04a3-4bd4-bf01-ea3415e6fd72	1172	411	\N
20	Quisquam perferendis distinctio adipisci possimus ut cum. Assumenda sequi aspernatur qui quo.	2023-05-20 01:21:42.293	PUBLISHED	0	0	\N	9a512f6f-eda2-4b26-9514-09aecc23e74c	1174	401	\N
15	Saepe dicta aut hic accusantium ab nesciunt voluptatibus aliquam blanditiis. Ratione ab dolorum reiciendis impedit molestiae. Provident atque repellendus porro laudantium. Eum nemo debitis nihil. Eaque eum officiis ad amet.	2023-09-26 05:16:58.937	PUBLISHED	1215782.643044444	1	\N	084977fa-57e5-459c-9428-c5bbf033ee09	1175	902	\N
16	Quidem odio ut quas tempora vitae. Sit ut iste dolorum aperiam magni cumque sequi sint dolorem.	2023-05-11 06:03:57.15	PUBLISHED	0	0	\N	d156251d-3299-4bc1-95b4-95d4759ecbe4	1176	409	\N
23	Veritatis ipsam sit ipsam veniam asperiores alias. Tenetur explicabo magnam natus temporibus. Provident eius similique facilis nesciunt possimus adipisci. Sit consequuntur atque omnis odit. Fuga dignissimos atque sint ipsum minus nostrum. Delectus ipsum doloribus impedit sit ullam quis laboriosam.	2023-03-20 16:21:38.616	PUBLISHED	0	0	\N	caae385e-3fdf-4855-9300-078f18c5462d	1177	1002	\N
23	Accusamus necessitatibus tempore expedita esse minima molestiae. Iste maiores ab odit quidem doloremque. Quae veniam commodi assumenda vero quod. Sunt accusantium eius non voluptate.	2023-10-14 05:00:27.083	PUBLISHED	-1250320.601844444	-1	\N	40b8f3fc-bdcc-470f-a223-41ab8f7762dd	1178	410	\N
14	Nobis porro saepe. Doloremque similique inventore consequatur. Nemo quis perspiciatis consequatur ab rerum. Quod dolore sequi officia fugit numquam. Nihil nam enim nihil quae voluptas inventore. Inventore vel laudantium nihil laborum.	2023-11-12 14:16:20.041	PUBLISHED	0	0	\N	acdd7b6a-e885-4558-9609-d68c27a5441e	1179	734	\N
23	Provident quaerat itaque vel a. Ipsam minus magni. Animi quod impedit. Natus accusamus autem consectetur blanditiis repudiandae.	2023-04-19 08:00:17.604	PUBLISHED	0	0	\N	d4664886-e913-4956-af01-6ca4625a1ce6	1180	917	\N
19	Enim reprehenderit perspiciatis accusamus unde. Ea culpa iure maiores. Possimus optio reiciendis quam et minima qui magnam. Placeat non necessitatibus cum amet ea vitae enim cupiditate. Inventore pariatur mollitia voluptatum aperiam quae.	2023-03-11 09:25:02.175	PUBLISHED	0	0	\N	8eeff1da-edeb-45f5-9924-4a3e1d6fb4db	1181	977	\N
22	Accusantium illum voluptatibus molestiae assumenda cumque. Ullam quo animi. Eius nobis commodi minus quos.	2023-11-14 12:03:04.187	PUBLISHED	0	0	\N	cc8ef1d1-2b71-4549-9ac9-8d6db6552a18	1212	465	\N
23	Error deserunt et deleniti nesciunt autem unde. Et ut ullam deleniti laudantium nemo ad neque.	2023-11-14 14:26:28.995	PUBLISHED	0	0	\N	50244358-c934-4c5b-88c1-4978e4c24c4c	1183	875	\N
19	Animi quibusdam dignissimos optio aspernatur ea error delectus. Voluptates assumenda eum. Minima ut explicabo provident ex illo laudantium animi et quo. Nesciunt in corrupti assumenda id consectetur nesciunt sint eligendi provident.	2023-10-21 07:33:40.079	PUBLISHED	0	0	\N	f9a4d7c8-47d9-451f-be3b-ed27743b5535	1184	826	\N
22	Veniam autem quisquam eum blanditiis reiciendis voluptate sit. Repellendus architecto ab sed.	2023-01-07 12:36:10.698	PUBLISHED	0	0	\N	2e471d29-5263-4772-af02-6545faf53ae6	1185	706	\N
19	Similique similique voluptate rerum fuga. Blanditiis odit corporis. Eos dolorem earum nemo rerum ipsum impedit necessitatibus sunt illum. Optio tempore quas eligendi expedita atque minima nihil vitae. Laboriosam ratione laboriosam.	2023-02-06 13:55:31.545	PUBLISHED	0	0	\N	7e49e19a-c675-4820-bbeb-2ef8c743739a	1187	653	\N
20	Veniam quam maiores atque commodi non. Fugit vero enim reprehenderit minima aperiam nihil. Iusto eius error distinctio. Voluptatum vero eum delectus odio velit dicta. Odit pariatur dolorum numquam ex ad sit ea hic voluptatem. Porro minima suscipit reprehenderit laudantium dignissimos impedit.	2023-09-12 11:45:43.218	PUBLISHED	0	0	\N	533900be-6893-4c39-bd92-d1bb0ee0a7cc	1188	631	\N
21	Voluptas a dolor corporis deleniti. Alias excepturi totam molestias non illo ab.	2023-10-02 23:13:21.856	PUBLISHED	0	0	\N	932a7a4e-0cbd-4c84-9f9f-4f97536b9fcd	1189	982	\N
15	Molestiae id soluta pariatur voluptate quam excepturi corporis odit tenetur. Laborum quis nemo.	2023-11-23 15:39:59.071	PUBLISHED	1327973.312688889	1	\N	17f15bf8-e0de-4a66-b15f-05b04ea4f8ca	1190	873	\N
21	Occaecati distinctio ratione animi facere. Architecto sint laborum. Qui nesciunt nam vero. Atque aspernatur unde deleniti est enim laudantium quos fuga. Quaerat exercitationem quasi ipsam fugit sequi illum voluptas dolore. Adipisci enim laboriosam tempora dignissimos repellat facilis deserunt.	2023-02-09 11:27:56.608	PUBLISHED	0	0	\N	6f13f018-fcc7-40ed-b956-67e9111581c3	1191	959	\N
14	Totam eaque aliquam totam porro. Pariatur explicabo expedita minima. Assumenda earum amet similique odit. Iste porro eaque nesciunt consequatur quas doloribus asperiores provident quam.	2023-07-17 00:50:42.224	PUBLISHED	0	0	\N	a1109869-6a73-4c8e-870e-776449c73efa	1192	579	\N
16	Vero nostrum reiciendis quaerat ab maiores. Suscipit omnis a eos voluptates provident molestiae impedit veniam. Debitis quos architecto harum facilis porro assumenda.	2023-06-01 21:31:48.97	PUBLISHED	0	0	\N	c42fa99d-1354-42b1-bf88-04b2ea995bfd	1193	394	\N
16	Aliquid ut iure. Non praesentium mollitia inventore quis aspernatur pariatur veniam. Quaerat nostrum ipsam voluptatem vel est fugiat autem quae. Accusamus tempora nemo culpa voluptatibus vero temporibus dicta. Ad nulla eaque fuga.	2023-10-29 22:12:21.881	PUBLISHED	0	0	\N	4b55f6cf-9486-4548-a7b6-edc58aa54e8f	1194	674	\N
23	Tempora minima voluptatum perferendis dolor sed nisi. Sapiente iusto mollitia voluptatibus debitis veniam. Hic fugiat odit veritatis iusto molestiae sapiente sunt totam dicta.	2022-12-14 19:25:42.901	PUBLISHED	0	0	\N	b5eedddc-2f6e-42f2-9083-2faeab34414a	1195	938	\N
20	Deserunt nemo ab odit occaecati aut aut alias. Dolor numquam nulla quod et assumenda nobis quisquam.	2023-04-27 17:24:43.12	PUBLISHED	0	0	\N	d71f800d-4eab-4efa-86ea-13ad1b24a714	1196	905	\N
22	Dolores provident nostrum saepe dolore consectetur incidunt quae impedit cumque. Iusto tempore distinctio delectus impedit neque quia est.	2023-04-18 18:20:27.487	PUBLISHED	0	0	\N	fc444111-6d76-444d-a570-0692bf9128c5	1197	470	\N
19	Ducimus quod neque quae. Neque aut provident commodi quisquam nemo odio debitis illum suscipit.	2023-07-16 07:57:35.883	PUBLISHED	0	0	\N	99cda85e-a73f-4c07-88e9-f6a9eb93d16d	1198	561	\N
14	Quibusdam eum aut asperiores dolorem. Facere ipsa inventore repellat. Quidem magnam fugiat fugiat alias dolore sequi. Atque molestiae fugit voluptatem.	2023-01-25 18:26:39.913	PUBLISHED	0	0	\N	4650160a-f3ec-4640-a099-993c868f81f6	1199	939	\N
15	Harum iure iure in. Eaque quia temporibus commodi placeat delectus.	2023-02-24 19:54:21.446	PUBLISHED	0	0	\N	cc41e18e-5210-4a06-ba6f-7d71e5631312	1200	963	\N
23	Magnam exercitationem odio quasi perferendis corporis consequuntur voluptate. Est hic sapiente. Doloremque eius enim voluptatem rem ipsam. Blanditiis dignissimos deleniti perferendis mollitia nam cum veniam necessitatibus.	2023-07-24 16:16:29.144	PUBLISHED	0	0	\N	7b172f9a-aba3-4542-921e-314164c73a9c	1201	778	\N
22	Libero sapiente ipsum distinctio ratione. Consequatur quis quo iusto modi esse itaque aspernatur minima est. Unde voluptatum distinctio.	2023-09-23 20:49:59.961	PUBLISHED	0	0	\N	10a7ab6c-562b-4fae-a6b0-e494c7d096cd	1202	384	\N
14	Non iusto vitae suscipit non velit dolor. Dignissimos recusandae deleniti distinctio voluptas repellendus. Consectetur sint quidem culpa eveniet. Sequi maiores temporibus autem occaecati animi esse nulla repellendus nihil.	2022-12-12 12:00:08.102	PUBLISHED	0	0	\N	a8b13707-f522-430c-9508-94a5318dde6c	1203	1011	\N
23	Corrupti sunt nihil voluptas ipsa. Fugiat reiciendis corrupti repellat consequuntur.	2023-01-21 16:19:35.071	PUBLISHED	0	0	\N	adfcf93d-3a06-44e6-921f-15bc4f1885b9	1204	570	\N
23	Officia dolor impedit numquam. Minus nulla repudiandae in voluptates fugiat libero expedita quasi perferendis. Amet ea ipsa qui esse minima eaque ex beatae eligendi. Beatae tempore et quis ab reiciendis est at. Animi unde nihil. Error omnis sed.	2023-04-30 04:32:01.804	PUBLISHED	0	0	\N	55f8848e-d64b-4b56-ba57-10918c74ad6f	1205	487	\N
14	Ab tenetur eaque illo quia dolore laborum nihil soluta. Praesentium dolore perferendis. Quis eligendi libero dolores eos aliquam ea non quia. Quisquam enim perspiciatis unde earum porro vitae assumenda commodi occaecati. Nam deleniti ut doloribus doloremque aperiam ducimus. Odit aliquid fuga.	2023-09-14 01:18:32.584	PUBLISHED	0	0	\N	04e6275e-bc10-40d9-8be7-07a35071798b	1206	453	\N
20	Earum ipsum voluptate earum quidem veniam repellendus voluptas fugiat. Fuga voluptas laborum velit cupiditate. Ipsum numquam veniam. Incidunt veniam explicabo assumenda harum deserunt similique saepe. Distinctio dolorum numquam doloribus nisi eos pariatur. Voluptatum neque nesciunt est.	2023-08-07 10:09:29.601	PUBLISHED	0	0	\N	dc72c6fe-d0d3-4cf9-95b4-2a4e6f674ea7	1207	684	\N
14	Autem accusantium quis earum esse ipsa adipisci quod. Ullam amet quis. Ad ex ex cum impedit ullam nulla impedit laboriosam in. Veritatis nam itaque quae unde consequatur.	2023-04-07 19:12:11.937	PUBLISHED	0	0	\N	2b1c0f17-6c28-40d4-af9b-0ea54e03ace7	1208	359	\N
18	Atque vero accusamus dolor. Quos quas incidunt sequi maiores veniam fugiat nostrum mollitia consectetur.	2023-02-10 00:42:28.523	PUBLISHED	0	0	\N	e889594c-3f20-4dad-bd5c-0831fd251b44	1209	979	\N
20	Eius porro quaerat. Et officia ab id.	2023-01-20 22:06:49.924	PUBLISHED	0	0	\N	1720f54a-1ae5-4b23-a86f-16e80e2e27ff	1210	1138	\N
15	Laudantium amet atque labore asperiores. Eveniet molestiae quaerat ipsa voluptatum itaque velit perspiciatis.	2023-03-27 23:09:16.701	PUBLISHED	0	0	\N	e77afacc-c94f-4297-822b-32668fed6696	1214	897	\N
20	Non repellat itaque nemo. Numquam voluptatibus cum occaecati quis alias. Magni fugit ut dicta nisi sint officia molestiae.	2023-08-15 05:15:55.669	PUBLISHED	0	0	\N	20547045-60ed-4a2b-981d-8aed08b42b86	1215	459	\N
20	At molestiae nobis ex culpa quaerat veniam. Tenetur hic nesciunt rem veniam cum dolor quis.	2023-10-25 08:08:14.951	PUBLISHED	0	0	\N	e4bfb0ff-b686-4c56-82f6-415bf45e3070	1216	475	\N
14	Non perferendis molestiae consectetur ipsa porro eaque. Inventore vitae corporis. Voluptatum autem minima quibusdam officiis cumque consectetur repudiandae expedita.	2023-08-03 02:24:58.595	PUBLISHED	1111873.302111111	1	\N	9f06fd78-df99-4338-b825-d684370ed13c	1217	649	\N
23	Ipsa fugit at voluptatem error. Laboriosam quasi eum consectetur sed.	2022-12-02 20:20:41.948	PUBLISHED	0	0	\N	688aee33-b875-4722-8cac-651ac8625c66	1218	791	\N
14	Earum temporibus rem ad perspiciatis. Id minus excepturi at sint nulla.	2023-09-07 11:42:26.09	PUBLISHED	0	0	\N	7fa8b828-310f-4d4b-8e65-36f7a345766a	1220	446	\N
22	Similique quam odio ullam ducimus incidunt mollitia dicta error cum. Eius aperiam quod. Voluptates officia ratione quod. Harum nesciunt fugiat fuga maiores sapiente veniam.	2022-12-21 15:04:21.983	PUBLISHED	0	0	\N	e22af686-4099-4f62-a52f-5cdf57032b98	1221	701	\N
19	Temporibus aut nam dolorum cumque quae assumenda numquam reprehenderit pariatur. Possimus minus optio laudantium velit officiis quod eius culpa deleniti. Possimus qui distinctio autem. Labore modi eaque reprehenderit iusto quaerat nostrum vero itaque.	2022-12-13 08:21:21.336	PUBLISHED	0	0	\N	7b856395-92c5-4177-af3b-8b7e7f40fb96	1222	1086	\N
20	Vel veniam quod ea nam eius maiores ducimus libero. Praesentium quam dicta cum expedita dolor beatae voluptatibus. Facilis eos temporibus quasi consequatur error incidunt officia ut. Eos quo atque eaque debitis eligendi.	2023-08-14 00:04:50.314	PUBLISHED	0	0	\N	18a8a90f-ddd8-4f82-a526-4759afd0ead6	1223	775	\N
23	Soluta recusandae pariatur labore deleniti fugit in consequatur autem. A laudantium assumenda vel soluta dolorum perferendis inventore.	2022-11-28 06:41:40.947	PUBLISHED	0	0	\N	38313a98-50ee-4ffa-8130-6afaeaf7d37d	1224	672	\N
14	A necessitatibus neque soluta necessitatibus. Aperiam unde hic ea optio adipisci quam quidem odio. Beatae vitae placeat eaque quae. Ipsam culpa deserunt vitae voluptatibus asperiores autem eum.	2023-11-02 02:08:46.009	PUBLISHED	0	0	\N	ca28f920-09a0-4e7b-9856-5b453ade4612	1225	538	\N
21	Corrupti quas magni aliquam placeat non quae asperiores. Explicabo facilis nisi. Facere fugiat ad quas nesciunt nam id itaque dolore fugiat. Ipsa iste perferendis ab minus placeat labore cupiditate.	2023-01-27 05:51:37.478	PUBLISHED	0	0	\N	caae7120-5714-45ae-8ba5-ea432b143095	1226	478	\N
15	Rem quasi deserunt ipsa impedit quo modi culpa. Deleniti eligendi perspiciatis aspernatur ipsum.	2023-05-15 21:59:59.227	PUBLISHED	0	0	\N	238247a1-153c-46cb-8129-77121bc1df76	1227	1025	\N
17	Fuga tenetur consequatur accusamus quam dolorum quae. Eaque hic possimus placeat eaque est. Odio unde dolore magni porro possimus qui at commodi iusto.	2023-08-20 05:41:21.816	PUBLISHED	0	0	\N	d6f10a1a-1397-43dc-ba4b-eef67790e284	1228	821	\N
18	Vero quae ipsam laboriosam dolores fuga dolor perspiciatis quos. Perspiciatis architecto illo. Blanditiis repudiandae in delectus distinctio. Incidunt quaerat esse quae ullam placeat reprehenderit.	2023-07-19 14:36:32.964	PUBLISHED	0	0	\N	1f677788-07eb-4f9a-921d-512b50006fe2	1229	556	\N
23	Laudantium numquam aut porro esse. Est sequi esse facere odit fugit eaque.	2023-05-03 07:22:56.668	PUBLISHED	0	0	\N	f47b46b5-4cee-42ef-a28e-bdf8d24aa07c	1230	609	\N
15	Suscipit esse culpa eum ipsam voluptatem. Perspiciatis itaque numquam aliquam. Labore quidem possimus ducimus unde quibusdam voluptatibus magnam quasi sed. Quam harum eum neque error earum.	2023-08-20 07:52:11.417	PUBLISHED	0	0	\N	068cf9ef-7e26-4909-90bf-09926d4815a8	1231	611	\N
15	Quam debitis vel magni quam perferendis impedit. Neque rem magni ad.	2023-03-02 14:30:53.618	PUBLISHED	817161.1915111111	1	\N	3bbc14ae-0c74-406d-800d-8a91f710fdb1	1232	1167	\N
16	Ab mollitia maiores sapiente consequatur quis minima doloribus alias. Exercitationem et repudiandae repudiandae cum occaecati. Vel nam rem. Qui cupiditate voluptatum vitae voluptatem. Nesciunt incidunt ullam exercitationem aliquam fugiat. Officiis nemo sed.	2023-07-10 22:55:35.438	PUBLISHED	0	0	\N	ad7f9dea-f92e-4aa6-9b81-df4fb3e8f97b	1233	1071	\N
17	Id optio impedit. Officiis similique numquam. Vitae maiores quibusdam mollitia adipisci provident rem animi. Harum amet saepe perspiciatis. Ipsum culpa reiciendis ut illum.	2023-06-18 11:52:11.489	PUBLISHED	0	0	\N	deba65c9-3a63-4c0f-8cca-4b948f204bf7	1234	1093	\N
16	Laboriosam dolor repudiandae tenetur in iure possimus dolor eum odit. Quasi corporis corrupti maiores aut cupiditate aliquid voluptatibus dolorem. Fugit quae explicabo iure consectetur officiis similique hic itaque.	2023-06-25 07:56:26.717	PUBLISHED	0	0	\N	1e62df15-9f6c-4ca4-b030-4d4a0a1240c3	1235	989	\N
19	Consectetur atque in commodi eaque deserunt vitae in tenetur. Sequi explicabo commodi temporibus reprehenderit exercitationem eos ipsam voluptatibus. Aliquam molestiae facere consequuntur laborum vero eveniet. Nemo sint voluptas corrupti tempora provident commodi provident voluptatum molestias. Perspiciatis animi doloribus a modi nam nisi a dolorum.	2023-02-16 21:26:09.775	PUBLISHED	790834.8838888889	1	\N	dc4fe9a5-5d07-422d-88dd-536a147d4529	1236	742	\N
17	Fuga a est itaque voluptatibus quod amet sit rerum distinctio. Autem culpa quis sapiente accusamus. Eum aliquam repellendus. Tempore fugiat aut reiciendis debitis. Perferendis possimus non. Ducimus laborum deserunt iste numquam voluptatem quae in cumque ea.	2023-05-20 21:28:12.238	PUBLISHED	0	0	\N	ce385c75-fa38-4dd1-8fdb-c65a96d33c2b	1237	838	\N
17	Assumenda accusantium minima animi sunt dicta. Vitae enim rem ipsam. Aut soluta unde enim perferendis corporis doloribus aliquam ab. Totam officiis ea facilis minima sequi recusandae alias laborum. Asperiores harum accusantium necessitatibus veniam aut qui suscipit.	2023-08-15 14:42:24.977	PUBLISHED	0	0	\N	c112c8e0-c57a-4389-be0d-be7efec40f2e	1238	808	\N
23	Animi commodi id id. Illum optio nobis officia cumque sit voluptates. Odio laudantium praesentium.	2023-09-01 06:54:21.873	PUBLISHED	0	0	\N	33e110ce-82b5-4449-b066-56ed931929b4	1239	887	\N
16	Earum error omnis. Odit modi veritatis minima tempora consequatur ab. Tempora sequi nesciunt nisi. Natus blanditiis vero dolorem suscipit rem. Nihil facere voluptatibus quibusdam itaque nulla voluptatem eos reiciendis.	2023-03-05 15:57:43.304	PUBLISHED	0	0	\N	16a27c5c-cd58-4b3d-99d6-41f30758de5e	1240	618	\N
15	Ullam alias numquam animi ratione alias. Soluta dignissimos ratione laudantium voluptate veritatis incidunt. Repudiandae facere dolore neque aperiam alias culpa quos. Debitis porro nisi beatae recusandae aut. Similique vel molestias labore sed nulla laborum nulla. Nisi consectetur veritatis nobis illum quibusdam.	2023-11-10 19:17:31.893	PUBLISHED	1303303.3754	1	\N	cbf226a6-4006-48a4-ab94-6bbc1a8537c1	1241	925	\N
19	Aperiam officiis veritatis corporis suscipit aut explicabo blanditiis. Ab sequi distinctio eaque impedit nam doloribus qui voluptate eveniet. Praesentium cum minus maxime. Blanditiis delectus perferendis molestiae consectetur adipisci ducimus. Nulla aliquid nam corrupti ex quasi.	2023-09-24 22:56:41.806	PUBLISHED	0	0	\N	f27cf087-1b81-471c-adcc-b5d8789d65d8	1244	450	\N
14	Delectus quia voluptatem officiis dignissimos placeat nostrum nemo. Explicabo repellendus sequi dolores a itaque. Itaque esse eius magni repellat eveniet consequatur placeat repellat. Maxime deleniti nulla cumque voluptatibus magni facere similique. Dolore repellat inventore omnis.	2023-04-21 04:11:26.005	PUBLISHED	0	0	\N	8168218b-c43f-4094-881b-01bfc22dbdfd	1245	550	\N
16	Neque sapiente magni nisi suscipit voluptatibus. Quaerat repellendus ut neque accusamus. Ipsum mollitia nisi doloribus minus cupiditate eos. Natus nisi minima nobis doloremque amet quas. Molestiae ipsa reiciendis saepe.	2023-02-05 13:04:28.06	PUBLISHED	0	0	\N	bcae22f1-af3c-436f-8814-3208e5ba6a0a	1246	872	\N
20	Perferendis vel mollitia vero iure quo. Placeat dolorum tenetur voluptates quae corporis. Aliquid accusamus dolores odio expedita. Porro omnis quis. Accusantium accusantium aut nobis illo sapiente nulla. Dolorum corrupti cumque nostrum fugit eveniet autem iure perferendis.	2023-10-01 02:34:13.627	PUBLISHED	0	0	\N	3ed80457-7404-42aa-b704-0c6c19e527e7	1247	1004	\N
23	Eaque expedita commodi rem voluptatibus laborum deleniti dolorem iure. Vel sit quo culpa ullam. Eveniet quo expedita quos eaque inventore ipsum sit. Minima temporibus ad. Vero repellendus fugiat non id repellendus quo ratione maiores. Quasi quae amet nemo.	2023-10-14 18:06:00.04	PUBLISHED	0	0	\N	3bee44c4-3ff9-4ca5-8669-8dc9b75722dc	1248	1127	\N
20	Qui doloremque sunt odit soluta. Natus porro laudantium.	2022-12-22 05:50:03.396	PUBLISHED	0	0	\N	e66aac36-40de-4b98-aabc-0c551d0e6f99	1249	1146	\N
16	Dignissimos necessitatibus eveniet quaerat aut earum similique eos. Ea facere laudantium culpa nulla ab. Ut quibusdam tempora numquam iusto est. Adipisci provident at eos doloribus perferendis impedit totam officia.	2023-05-13 13:38:05.361	PUBLISHED	0	0	\N	99ce9227-054d-49dc-9f71-94fcb8c9ceee	1250	520	\N
19	Fugit consectetur dolores voluptatum deleniti ex. Suscipit quidem explicabo beatae quasi quisquam. Illum eaque aliquid odit ullam veritatis. Repudiandae unde provident mollitia dolores dolor. Facere explicabo nemo.	2023-08-07 00:58:29.96	PUBLISHED	0	0	\N	96a8b013-9159-436f-8a5e-a9a67c8d947b	1251	562	\N
22	Doloribus ullam quisquam non tempore aperiam nemo assumenda labore. A neque deserunt illo quia occaecati repellendus qui impedit saepe.	2023-10-14 00:53:29.279	PUBLISHED	0	0	\N	0fce5eb1-9dd7-4582-a2db-82702c3971c6	1252	913	\N
23	Harum voluptatum corporis ea modi molestiae ea quae debitis neque. Cumque fuga animi aut aspernatur veritatis delectus repudiandae necessitatibus. Repellendus beatae numquam enim aspernatur laudantium doloribus quasi. Ex iste ratione quisquam.	2023-11-07 13:35:18.843	PUBLISHED	0	0	\N	64e7c253-88e8-4923-bacf-45d7b4b81675	1253	762	\N
14	Architecto ea necessitatibus nisi nostrum unde cupiditate. Optio repellat aspernatur ipsum. Aperiam aliquid atque aperiam quod.	2023-06-15 10:01:38.743	PUBLISHED	0	0	\N	eb0c5117-034a-40e8-a599-eaaf1ae6a53d	1254	613	\N
20	Sunt expedita incidunt cupiditate dicta. Debitis quaerat possimus illum placeat doloribus expedita id totam.	2023-03-02 03:17:10.295	PUBLISHED	0	0	\N	8d6781b1-1fc6-4306-bd21-6a117c91d9cf	1256	637	\N
15	Doloremque eligendi enim labore doloribus adipisci quo voluptates. Autem iste doloremque tenetur quia fugiat expedita eius maxime tempore. Reiciendis amet repudiandae. Esse expedita vitae a ipsam architecto assumenda velit. Eveniet recusandae voluptates aperiam est rem numquam dolorem aspernatur velit.	2023-11-21 12:17:43.061	PUBLISHED	0	0	\N	9f72df18-7f7e-43b7-adcf-fa293443dfc0	1257	672	\N
15	Eveniet dolores vitae consequuntur natus necessitatibus ad aut dolor. Quo commodi rem natus aliquid eum veritatis. Suscipit excepturi explicabo quaerat quam sapiente. Quis iste aut optio facilis corrupti ullam cupiditate.	2023-02-19 11:38:21.809	PUBLISHED	0	0	\N	1dbf06ce-eee2-41c0-95fd-1b0afb99f27a	1258	604	\N
17	Voluptas accusantium officiis odio. Nihil alias debitis soluta corrupti a. Eaque expedita at. Aliquam iure dolores suscipit libero quidem hic quod dolores. Non occaecati suscipit nesciunt earum itaque aliquid. Soluta minima nemo error maiores impedit eveniet quisquam reprehenderit reiciendis.	2023-09-27 09:53:31.889	PUBLISHED	0	0	\N	42ab650c-c87a-4b03-948b-c5370e137741	1259	716	\N
22	Dolorem dicta necessitatibus est. Totam dolorem ex qui nihil quos. Eligendi odit fugit ipsam libero ducimus qui ea dignissimos repellat. Repellat accusamus repudiandae id. Minus nulla tempora quaerat temporibus consequatur laborum laborum nemo quibusdam. Modi repellat minus iusto in illum corrupti inventore.	2023-01-03 23:53:31.083	PUBLISHED	0	0	\N	e76ddf55-d291-46a7-a426-d589d2a3b5ed	1260	442	\N
17	Dolorum dolores quis. Recusandae fugiat quos nam adipisci id qui magni praesentium.	2023-04-22 13:56:40.342	PUBLISHED	0	0	\N	6c894392-22a1-4ac4-a098-9c5addd25072	1261	422	\N
15	Consequuntur occaecati eligendi. Officia consectetur odit iste. Quas laudantium non beatae rerum architecto laborum. Vitae qui itaque.	2023-01-26 19:19:33.714	PUBLISHED	0	0	\N	dac108cb-fa1c-420f-8e6b-2a7fcb72b73f	1262	828	\N
14	Voluptates porro voluptates facilis vitae. Occaecati sequi alias voluptatibus eum perspiciatis ipsa. Ratione quasi ex quam. Doloremque possimus eius adipisci molestiae repudiandae. Porro sequi modi velit sequi recusandae praesentium perferendis cumque sint. Harum architecto asperiores est dolorum.	2023-01-24 20:09:12.934	PUBLISHED	0	0	\N	f02b53b6-3eda-40ba-b5e0-ab789949c1b4	1263	450	\N
17	Minus maxime modi harum est accusantium voluptate. Unde saepe voluptatibus esse vitae fugiat praesentium occaecati maiores. Animi ipsa beatae a pariatur.	2023-06-06 04:38:03.341	PUBLISHED	0	0	\N	b0edc6d0-7bf3-418e-a20c-e9b064f9dcc2	1264	1144	\N
21	Et fugiat voluptatem odio. Maiores similique aliquid recusandae. Eos ducimus cum distinctio.	2023-02-14 08:13:34.265	PUBLISHED	0	0	\N	8ae91ec4-de48-4e7a-ad4f-ca20631e7d27	1265	469	\N
16	Illum architecto deserunt tempore. Aliquam animi nisi ipsum assumenda cupiditate consectetur nulla dignissimos porro. Error vitae omnis voluptas in velit natus. Quaerat blanditiis quisquam libero ad voluptatibus deserunt maiores. Et eos ipsam deleniti ea natus quia deleniti laboriosam repudiandae. Repellendus dolore beatae earum est impedit soluta rem illo.	2023-02-06 04:25:35.51	PUBLISHED	0	0	\N	6033c82f-6153-4ec9-af40-9386be4c940a	1266	547	\N
14	Voluptate tempora nisi natus illo consequuntur. Repellat quaerat tempore laborum voluptate unde magni ullam asperiores. Quis hic minus expedita tempore natus saepe autem itaque rerum. Eveniet laborum magni nulla ab.	2023-01-01 21:25:53.36	PUBLISHED	0	0	\N	e916c1e7-594e-43f6-a180-5985fee8a2f7	1267	857	\N
23	Commodi sit quaerat. Repellendus illo deleniti labore voluptatibus eum cumque. Omnis culpa quo fugiat numquam numquam porro praesentium explicabo.	2023-07-22 10:29:34.55	PUBLISHED	0	0	\N	5473bdc6-371b-4ab1-85d5-8e76deb25193	1269	884	\N
23	Inventore exercitationem ea. Repellendus exercitationem deserunt consequatur dolorum. Libero sit officiis ipsum facilis dolorem exercitationem odio corporis. Quam odio quis assumenda praesentium non repudiandae.	2023-08-11 04:26:22.578	PUBLISHED	0	0	\N	eeeb2adb-2fea-4f25-8ed5-f4211a3dc6c7	1271	1193	\N
22	Eveniet vero numquam voluptates alias voluptates recusandae quas. Dolorum hic quis in ipsum explicabo neque molestiae. A nihil fugiat voluptate commodi corrupti. Cupiditate animi provident voluptatum voluptatem illum. Officia ut aliquam hic veniam inventore qui porro. Reprehenderit error voluptate ab placeat distinctio.	2023-10-19 06:06:10.543	PUBLISHED	0	0	\N	242aff3f-34e3-4468-9877-bec1bb58fc1f	1272	491	\N
15	Mollitia laudantium maiores quos id inventore tempora aut. Odio et velit ipsa magnam ex voluptate rem.	2023-08-27 06:35:12.529	PUBLISHED	0	0	\N	07c7e8d9-d034-4e00-bf82-1aa80bb4b298	1273	1241	\N
21	Quae dolorum iste recusandae consequatur natus atque atque eaque. Ipsam cum quibusdam veniam. Aspernatur eveniet odit distinctio nemo at perspiciatis hic eos recusandae. Exercitationem expedita quam autem mollitia minus error quia similique voluptates. Culpa maxime accusantium vel dolor veniam amet aperiam.	2023-07-15 21:05:07.831	PUBLISHED	1076886.840688889	1	\N	d86e7a68-6444-47e7-9336-7238b545b95c	1274	780	\N
20	Nobis repellendus nihil. Sit rem facilis tempore.	2023-07-11 01:24:04.848	PUBLISHED	0	0	\N	20f41230-d615-46f4-81a8-b9b903af83ab	1275	1088	\N
19	Mollitia ratione optio ut atque laboriosam nisi totam unde voluptatem. Laudantium itaque dignissimos doloribus nemo recusandae sunt. Harum exercitationem vel reprehenderit provident architecto consectetur repellendus.	2023-03-16 18:05:00.775	PUBLISHED	0	0	\N	6426ea3e-cbbc-4f32-9364-90d366f7b3d5	1276	435	\N
21	Distinctio aut a impedit id non. Ipsam sit impedit nostrum alias vitae. Explicabo ipsum necessitatibus nemo reprehenderit magni. Similique harum neque omnis dolorum aliquid dicta molestias assumenda numquam. Culpa vitae architecto ipsam vitae.	2023-01-14 00:07:34.297	PUBLISHED	0	0	\N	90928314-2931-41a4-9e66-3783d0a3a6c1	1277	710	\N
23	Ea natus explicabo praesentium expedita odit placeat maiores consequuntur enim. Ut sint ad aut soluta doloremque officiis. Ipsam fuga placeat consequuntur sapiente iste nostrum. Ipsa maxime accusantium. Molestiae dignissimos reiciendis tempora occaecati laboriosam libero eum voluptas voluptatibus.	2023-02-04 23:16:36.654	PUBLISHED	0	0	\N	b0233870-5a2f-420f-9c95-a829ffb811da	1278	843	\N
22	Ipsam commodi quaerat iusto possimus. Molestias voluptatem voluptates. Corporis vero repellat nemo. Sit animi nulla occaecati consequatur. Animi optio dolor nobis modi.	2022-12-16 01:51:50.458	PUBLISHED	0	0	\N	ef15261c-c4d2-46ee-a640-f38efec3ae11	1279	711	\N
14	Sed molestias vitae. Numquam quos at maxime ratione cum dolores. Earum eius voluptate porro aspernatur laborum necessitatibus illo. Provident ab fugit repellendus in.	2023-04-26 10:30:54.705	PUBLISHED	0	0	\N	427e2fc0-39d1-4f3d-a913-cd6666d81e3f	1280	401	\N
21	Quidem nesciunt deserunt laborum dolores eius sunt. Magni tenetur unde explicabo. Occaecati quisquam corporis ipsa impedit debitis perferendis adipisci porro. Aut dolorem accusantium. Deleniti dolorem voluptatibus enim quasi ut. Consequatur recusandae sint.	2023-07-26 09:56:15.977	PUBLISHED	0	0	\N	f0d3b792-1826-4fee-b8ac-66080ef651ed	1281	686	\N
21	Quidem eos quasi minus sapiente nostrum praesentium. Et perferendis iste cupiditate error blanditiis suscipit harum. Quam sed quo minima quis incidunt. Iste quis eos cumque provident facere nemo excepturi.	2023-02-12 22:24:07.163	PUBLISHED	783232.1591777778	1	\N	8ca603bc-f504-46a2-9cb4-919f11e92bad	1282	979	\N
19	Nisi quia fuga nesciunt eius deleniti commodi. Sequi quia quisquam. Labore quos labore blanditiis repellat. Cum itaque sequi consectetur ducimus. Qui eos libero placeat illum soluta.	2023-03-06 15:11:15.648	PUBLISHED	0	0	\N	ab7ab535-baf8-4156-af02-9fe27fdef5d3	1283	368	\N
17	Quas aut esse illum quos aperiam sit necessitatibus. Et quibusdam expedita mollitia numquam. Aspernatur nesciunt velit tempora ipsum quos molestias accusantium. Delectus doloribus occaecati voluptate numquam perspiciatis fugiat repellat eos. Nostrum aliquid neque consequuntur laborum similique. Reiciendis libero qui nulla perspiciatis ex odio nihil corporis.	2023-08-16 22:14:56.116	PUBLISHED	1138419.913688889	1	\N	908aabc7-ad6c-4c4c-8085-85947e14b1c2	1284	491	\N
22	In corporis voluptatibus quae error saepe est adipisci. Corporis natus doloribus quam harum nihil officia.	2023-01-27 00:46:13.307	PUBLISHED	0	0	\N	a5ea918a-777c-41cb-b29e-890a1e1c9e13	1285	1150	\N
16	Facere eos repellendus. Dignissimos officiis alias iusto dignissimos cupiditate. Totam hic consequuntur eveniet atque mollitia ipsa dolore esse possimus. Eligendi distinctio sapiente reiciendis pariatur soluta aliquam. Consequatur ab commodi facilis quidem voluptas. Illo quam eum error omnis at dolor dolores.	2022-11-28 14:23:18.001	PUBLISHED	0	0	\N	99918a8d-ea25-4fd0-810c-592d65f57e14	1286	1130	\N
16	Nulla veniam illum culpa officiis dolorum. Non saepe iure saepe omnis facilis vero maiores. Ut consequuntur exercitationem repellendus.	2022-12-26 04:38:40.507	PUBLISHED	0	0	\N	83fc50e0-8259-40eb-827c-b72cd39dbf2f	1287	585	\N
19	Nisi a facere aperiam. Vel corporis possimus eveniet suscipit magni tempore illo. Deserunt error dicta veritatis dignissimos eum iusto ipsum nihil. Alias culpa ipsam. Modi veritatis quis quam suscipit autem inventore laboriosam optio eius.	2023-03-26 07:49:47.736	PUBLISHED	0	0	\N	130d160d-17ba-4d11-bf1f-187a1f3dd07b	1288	543	\N
21	Officia natus temporibus sapiente ab unde excepturi neque. Molestiae aliquid odit exercitationem sit.	2023-09-26 02:25:51.481	PUBLISHED	0	0	\N	e850e50f-f702-4ea5-bfde-4519b2c8cc03	1289	744	\N
21	Sed tempore beatae consequatur ratione. Eligendi delectus possimus odio aliquam eius enim in. Aperiam asperiores quidem praesentium rerum alias ipsam. Ad aut temporibus atque laborum earum ipsa.	2022-12-26 21:45:57.333	PUBLISHED	0	0	\N	2d4760a8-d666-4768-ba73-e6469fdbe40b	1290	931	\N
16	Molestias voluptas porro ipsum cum unde illum ipsam. Tempora itaque veniam beatae explicabo facilis similique dolores cumque maxime.	2023-08-15 05:24:47.349	PUBLISHED	0	0	\N	691966cd-3360-48e6-af3e-9a19752d426e	1291	1282	\N
15	Dolorum quaerat exercitationem commodi et reiciendis magni. Tempore nemo ullam voluptas aut dolorum sequi veritatis. Quam placeat vero in error illum nam ullam aut.	2023-04-14 21:06:03.795	PUBLISHED	0	0	\N	c536830a-0a0c-4adf-a745-bac7deb170ff	1292	515	\N
14	Nam deleniti repellendus perspiciatis sequi. Iste neque consequuntur doloribus iusto placeat laboriosam sunt quas.	2023-08-04 09:18:42.872	PUBLISHED	0	0	\N	9f1d6171-9e41-45f9-9ca5-ff2cb2630d40	1293	967	\N
17	Non similique animi impedit eaque. Occaecati aut corporis suscipit enim provident. Autem molestias suscipit vero quos. Voluptatum incidunt sit aliquid sunt dolore. Sunt reprehenderit quas.	2022-12-19 06:10:01.348	PUBLISHED	0	0	\N	0f6fc2d2-1753-4e04-a296-d56ab8dffc6d	1294	586	\N
17	Alias maxime blanditiis vel laboriosam praesentium reiciendis eos. Debitis consequatur tempora saepe aperiam architecto.	2023-09-01 07:56:53.478	PUBLISHED	0	0	\N	f739e87a-e7ec-4c0d-8f0e-ec887c66c43e	1297	707	\N
22	Minus aliquam voluptas vitae repellendus omnis vitae soluta cum. Et numquam harum eius dolorum illo. Eveniet fugiat optio similique dolore amet qui officia fugiat. Incidunt asperiores quas.	2023-10-06 21:17:26.622	PUBLISHED	0	0	\N	ff70b494-990f-495b-9193-c5324eda4372	1298	672	\N
20	Explicabo minima velit a ex pariatur perspiciatis cumque expedita. Ipsam tempore accusantium ducimus beatae repellat velit quaerat. Ullam magnam illo voluptatum quidem alias neque nihil ratione. Alias eos voluptas officiis ipsam quisquam officiis provident excepturi.	2023-03-12 16:49:04.063	PUBLISHED	0	0	\N	97628f8b-a7c3-4709-8743-a1766727cecb	1299	936	\N
19	Amet id facilis eaque labore animi cumque officiis esse nemo. Voluptatem corporis expedita velit quod odit excepturi vitae non. Saepe beatae nemo quas. Qui necessitatibus aliquid in illum exercitationem sint placeat. Quod minus labore.	2023-01-22 22:42:23.877	PUBLISHED	0	0	\N	820dde98-8654-4253-85d5-ceabe130911e	1300	402	\N
16	Numquam voluptas laborum quaerat. Alias est rem suscipit hic ratione illo. Saepe commodi architecto id provident. Non inventore impedit asperiores deserunt. Ut eligendi quidem est voluptates tempore repudiandae nobis illo nostrum. Cum cumque consectetur placeat blanditiis ipsum molestias exercitationem.	2023-08-03 03:20:04.944	PUBLISHED	0	0	\N	5ae76ce6-a1ca-40df-9cb8-a4163b6eda68	1301	1165	\N
22	Facilis eius dolorem accusamus repellendus animi repellat eos nisi. Dignissimos alias minima commodi nobis consequuntur impedit non maiores dicta. Nemo molestiae hic. Commodi sed delectus eius. Ratione repudiandae accusamus ipsa ab unde laborum exercitationem totam.	2023-03-09 03:59:21.992	PUBLISHED	829759.1553777778	1	\N	6c79375d-9883-4d5c-b575-573cb37eebda	1302	755	\N
17	Doloremque unde non itaque fugit odio fuga. Debitis possimus enim a recusandae ipsa dicta placeat quaerat dolore.	2023-07-06 11:50:23.677	PUBLISHED	0	0	\N	b6217a4c-1656-42aa-84ec-4a91b260b979	1303	925	\N
22	Rerum quisquam rem fuga vero minima iure laudantium debitis nostrum. Facere dolorum animi unde rerum. Accusamus provident doloremque et perspiciatis tenetur modi explicabo.	2023-09-17 20:52:59.42	PUBLISHED	0	0	\N	f45a1843-7224-427d-a6c6-7b6a690087c6	1304	884	\N
18	Totam reprehenderit incidunt recusandae suscipit praesentium impedit. Magni libero maiores nihil nesciunt autem non. Quae accusantium aperiam dolorem veritatis.	2023-08-12 16:04:47.161	PUBLISHED	0	0	\N	6e83f9e3-525b-4764-a97d-2fcb39706130	1305	757	\N
20	Exercitationem rem illum. Repellendus voluptatum dolores quaerat et eius vitae assumenda beatae.	2023-03-09 21:29:17.934	PUBLISHED	0	0	\N	fa97f6fb-f4fc-40f3-8f5f-04cda28e253f	1306	770	\N
18	Ratione repellendus dolor veritatis repellendus possimus qui ullam rem. Rerum voluptatum ipsum occaecati facere quibusdam similique occaecati atque reiciendis. Dolore error et itaque deserunt eos.	2023-03-25 16:47:32.494	PUBLISHED	861503.3887555555	1	\N	c67a06b0-68ba-497d-8f13-26daa5833eb7	1307	1301	\N
21	Delectus cum vel autem natus nihil occaecati aut. Veritatis tenetur suscipit molestias commodi facere voluptates. Qui laudantium dolore. In unde magni repellendus officia quibusdam maiores eum accusantium facere. Nemo recusandae provident.	2023-08-27 03:58:59.675	PUBLISHED	0	0	\N	aa9792fa-6cb7-405c-9c9b-28268628752b	1308	1054	\N
23	Sequi ipsa vitae voluptas dolore quam laborum minus molestiae dolore. Temporibus repellendus nesciunt aut ex inventore consequuntur fugiat dolores.	2022-12-02 17:39:16.404	PUBLISHED	0	0	\N	75a084ca-1a47-4261-87da-bdee0b229d3e	1309	524	\N
16	Ullam quod delectus facere atque dolores. Nisi mollitia voluptatibus. Fugit quibusdam voluptatum distinctio dolores molestiae corporis labore aliquid magnam. Voluptas vero minima nobis quos voluptas aperiam dicta corporis. Debitis in nulla pariatur vitae pariatur.	2023-10-13 06:17:07.514	PUBLISHED	0	0	\N	8a5fbb91-c3f1-47fe-91b9-86842413d89f	1310	1199	\N
14	Commodi deleniti pariatur rem nobis saepe. Aperiam minus animi alias. Quae voluptas voluptas quae. Tempora laboriosam magni officiis at doloribus. Aspernatur doloribus maiores autem quas voluptate labore deleniti.	2023-09-19 10:50:09.264	PUBLISHED	0	0	\N	45ac13e0-cbb2-4570-b76a-d612a66c22fb	1311	1132	\N
22	Distinctio fuga qui ipsum atque laborum reprehenderit corporis laborum quae. Delectus sed illum nam expedita fugit numquam aperiam temporibus sint.	2022-12-02 01:14:30.754	PUBLISHED	0	0	\N	2de80577-8555-4d94-a9b1-3ccabd7c0375	1312	362	\N
14	Adipisci eos aliquid. Neque tenetur quis voluptas veniam. Ad odio ipsam debitis soluta nostrum qui maiores porro. Tempore totam voluptas ducimus distinctio et magni quas saepe quae.	2023-04-14 01:06:33.991	PUBLISHED	0	0	\N	baf4f3ab-82db-44c1-a3d2-43b78b24ee1e	1313	371	\N
21	Cum laudantium soluta voluptates vel error. Voluptates at possimus assumenda eum asperiores. Eos similique modi maxime quibusdam dolores. Fugit accusantium perferendis tenetur.	2023-06-13 05:14:50.395	PUBLISHED	0	0	\N	5bc4c687-9598-4da1-b261-29547ddec95e	1314	863	\N
14	A provident dolorum libero assumenda hic distinctio assumenda eos. Fuga earum earum asperiores laboriosam veniam repellat. Voluptatibus illo eligendi ipsam sed est minus laborum aliquam facere.	2023-10-29 07:18:08.144	PUBLISHED	0	0	\N	c65fc972-db2a-436d-b075-1895787643e6	1315	583	\N
16	Enim quae nam repudiandae praesentium maiores esse. Nostrum tempore numquam totam possimus. Totam molestiae odit est iusto nulla eveniet quisquam.	2023-05-16 14:33:58.142	PUBLISHED	0	0	\N	bd62196d-8845-4a1d-b86a-d3b592526b89	1316	509	\N
23	Occaecati perferendis ipsam saepe quia quibusdam cum assumenda. Beatae quos labore expedita cupiditate dolores nam vero. Ipsa voluptatibus iure velit minus expedita. Ipsa ratione accusamus ullam eius atque nostrum modi. Cum soluta magnam velit aliquam eius tempore. Dignissimos vel aut similique ratione magni alias cupiditate vitae fugit.	2023-07-28 21:16:59.236	PUBLISHED	0	0	\N	b7be240b-3a9d-4aa8-8a04-cab512275dcf	1317	495	\N
16	Fugiat molestias blanditiis impedit ratione magnam natus recusandae illo. Molestiae molestias iusto veniam suscipit. Placeat quam excepturi impedit vel fugit quasi.	2023-01-07 22:35:50.014	PUBLISHED	0	0	\N	7f36a62e-1810-4c6c-8d78-31d94f72c2d1	1318	787	\N
19	Est voluptas quidem. Debitis inventore maiores incidunt eligendi. Nobis tempora facilis officia sed. Impedit praesentium aperiam eos ea commodi nisi. Explicabo ea neque possimus quis fugiat voluptates sunt quae.	2023-11-21 03:13:29.969	PUBLISHED	0	0	\N	e84e800c-6343-4df4-8aa9-4da97f59ff73	1319	920	\N
18	Ab mollitia minima eveniet tenetur soluta totam inventore. Deserunt hic enim harum dolor vitae nobis eos.	2023-06-17 06:15:04.061	PUBLISHED	1021940.090244444	1	\N	e9420f88-ad5e-4bb0-832a-9cb6ad0d3ed8	1320	854	\N
22	Reprehenderit consequatur quas porro amet ipsam. Quisquam laudantium perspiciatis nulla fugiat quae. Numquam in pariatur cupiditate sapiente deleniti veritatis ad.	2023-04-17 07:06:39.826	PUBLISHED	0	0	\N	5ff81caf-f2ed-4e4a-a325-6f8ef59387bd	1321	1175	\N
18	Consectetur explicabo nemo. Laborum odio voluptate.	2023-10-20 02:59:12.924	PUBLISHED	0	0	\N	432ef3d4-0249-4b9c-93d9-bad95e3d8a20	1322	466	\N
20	Assumenda vel vitae ex laudantium ad minus. Accusantium consequatur magni delectus deserunt esse reprehenderit.	2023-08-23 21:01:32.067	PUBLISHED	0	0	\N	ffe294df-7d06-41ae-b6e3-abcc7b86479f	1325	365	\N
23	Laudantium nesciunt delectus officia temporibus perspiciatis. Architecto accusantium accusamus harum vitae fugiat beatae. Mollitia corrupti nam sed voluptates sit.	2023-08-08 05:55:10.522	PUBLISHED	0	0	\N	ea53a3ee-da21-4977-aa5f-7b36fb2a68ff	1326	350	\N
22	Eum blanditiis eveniet. Minima blanditiis mollitia quas. Et at molestias debitis architecto perferendis.	2023-10-21 09:42:08.045	PUBLISHED	0	0	\N	206bb20a-b6d8-48a4-8a0d-1470579bf6a7	1327	552	\N
17	Aliquam mollitia quos accusantium in fugiat. Doloribus repellendus consectetur et ratione voluptates possimus dolores neque.	2023-02-12 07:05:52.277	PUBLISHED	0	0	\N	acf88c60-6996-41d3-8420-3e5e92aaaeca	1328	1095	\N
17	Asperiores magnam aliquam. Rerum ipsa veniam. Eos ab modi earum.	2023-08-29 10:08:06.455	PUBLISHED	0	0	\N	860c83bf-288f-45ed-a724-8f9caa3c4ceb	1329	652	\N
17	Neque nostrum magni sapiente quibusdam possimus. Temporibus odio perferendis odit esse adipisci sed rerum. Quas voluptatum exercitationem. Quae voluptatibus esse magnam. Illo dolore sapiente non beatae voluptate culpa soluta corrupti. Deserunt eius placeat quibusdam repellendus deleniti hic amet esse.	2023-01-05 22:55:59.73	PUBLISHED	0	0	\N	8162ca52-8a85-4756-ab6c-a791096e175e	1330	879	\N
14	Similique cum incidunt quidem ullam similique natus vero modi velit. Eaque possimus deserunt ut occaecati similique error ex esse laborum. Sunt omnis neque tempore nostrum accusantium voluptate. Reprehenderit reprehenderit quaerat ullam sapiente tenetur consequuntur dolore. Dolorum nulla cumque cumque nisi a ducimus necessitatibus amet illo.	2023-01-07 02:07:53.616	PUBLISHED	0	0	\N	2a7557e2-79de-4a04-a019-774e2a1b5aec	1331	870	\N
20	Nam amet quam unde molestias impedit accusamus consequuntur voluptatem facilis. Esse officiis necessitatibus modi repellendus veritatis placeat excepturi quasi. Fugit consequatur dolorem in eveniet sed ratione sint maxime. Iste eaque consequuntur vitae.	2023-03-11 07:31:16.653	PUBLISHED	0	0	\N	ec0192ad-6e1e-4552-8ec9-930734273050	1332	1088	\N
19	Fugiat dolore impedit doloribus possimus iure reiciendis. Sit consectetur ea quibusdam porro omnis qui unde consequatur nostrum.	2023-05-03 08:59:28.449	PUBLISHED	0	0	\N	3a1fe3c2-4297-4bcb-9b1a-432d56408311	1333	851	\N
15	Velit amet nulla quisquam quis quia provident temporibus. Ipsum fuga pariatur ducimus porro neque sit.	2023-08-23 08:09:13.573	PUBLISHED	0	0	\N	9d7afb5f-04cb-403a-b63a-0e1669886c2a	1334	690	\N
21	Sapiente corporis et rem ratione neque animi voluptas. Quos error maiores iure. Ad praesentium exercitationem architecto consectetur adipisci. Perferendis distinctio tenetur. Necessitatibus ipsum laudantium. Ut odio beatae excepturi cum reprehenderit ex accusamus voluptatibus.	2023-01-31 06:44:17.086	PUBLISHED	0	0	\N	07f81092-7325-42f5-b359-7a07580c5b28	1335	732	\N
23	Eveniet reiciendis velit eaque dolorum voluptatem. Accusantium eligendi ab quia ipsa neque est dicta. Perferendis necessitatibus eos labore ipsam.	2023-09-04 05:25:25.543	PUBLISHED	0	0	\N	73413b22-cfee-4262-95ba-1491674f4c80	1336	550	\N
23	Expedita dicta quae molestias perspiciatis quasi minus consectetur perferendis. Quibusdam error praesentium nihil quod illo est. Fugiat occaecati architecto debitis repellendus fugit libero quos.	2023-08-23 00:09:22.241	PUBLISHED	0	0	\N	2a861541-3ac1-4565-a630-fe5fba5545f0	1337	1027	\N
18	Numquam impedit eos dicta est rerum voluptates cupiditate. Ab laudantium sint ex architecto perferendis placeat maxime. Voluptate doloribus numquam.	2023-06-06 07:11:08.175	PUBLISHED	0	0	\N	578454a8-b39b-48c4-9378-79ecb8b5408c	1338	1216	\N
23	Ipsa sit porro minus accusantium a animi libero nulla. Consectetur officiis doloremque deleniti quos dolorum provident. Non molestiae exercitationem iste earum iusto culpa aliquid. Eveniet dolor mollitia. Reprehenderit reprehenderit nam maiores totam. Nulla et temporibus eligendi.	2023-05-25 16:14:36.618	PUBLISHED	0	0	\N	427ed936-1a96-4582-8fe5-f1ebbf078cfa	1339	628	\N
19	Esse ut animi eum nemo. Minus consectetur deleniti velit excepturi. Non quibusdam tenetur aliquid veniam sequi.	2023-02-11 23:46:35.863	PUBLISHED	0	0	\N	4d493ef8-9f38-4c2c-bcec-29fbc15dee69	1340	936	\N
16	Magnam ducimus porro rerum numquam ex neque voluptates. Voluptates sint iste temporibus ex.	2023-03-17 06:56:34.315	PUBLISHED	0	0	\N	c6a8465b-8e19-4e23-a162-bfd8a8d9c070	1341	1122	\N
16	Eum doloribus ipsa dignissimos repellat fugiat. Id itaque ab atque qui quod voluptatibus beatae animi. Optio repellat aut labore aliquam eos repellendus.	2023-03-12 04:20:10.772	PUBLISHED	0	0	\N	2240ddf9-8b33-4df5-9512-0ed4f4417737	1342	939	\N
18	Aperiam recusandae dicta facilis quaerat dolorem sed doloribus. In ipsa voluptatibus repudiandae aperiam.	2023-04-13 12:26:16.34	PUBLISHED	0	0	\N	057fc6c9-f87f-4b60-bf61-f5442cdb7a16	1343	1088	\N
20	Est deserunt libero non fugiat cum praesentium impedit. Fugit soluta at odit voluptatum nam ad. Iure modi qui laudantium mollitia quaerat. Sit vel itaque provident cumque vero quod deserunt architecto. Molestias in cum accusamus officiis. Hic rerum blanditiis expedita quas sint vel molestiae incidunt culpa.	2023-02-28 23:58:20.623	PUBLISHED	0	0	\N	7a89c8a7-fe4e-4d67-9704-d3ae1aaac94e	1344	806	\N
21	Sit dignissimos ipsa beatae. Voluptate placeat labore perferendis. Doloribus possimus molestiae consectetur illum libero consectetur quo quibusdam incidunt. Possimus laboriosam velit ratione dolorum commodi iure magni accusamus. Tempore nulla at provident quod. Non id facere.	2023-09-10 16:23:57.237	PUBLISHED	0	0	\N	a7b0eb8d-efa7-462c-890a-8787a5c5e7a1	1345	379	\N
19	Unde necessitatibus nobis inventore doloribus fuga. Accusamus sed tenetur rem consequuntur. Nostrum consequatur quae eius quod in eos et magnam. Quidem hic asperiores facere magni id qui saepe. Quo perspiciatis eligendi doloribus.	2023-05-25 12:17:45.581	PUBLISHED	0	0	\N	e87b48cb-d29f-4a4b-8a7e-294c504f6940	1346	1218	\N
19	Cupiditate praesentium aperiam dignissimos magnam inventore odit saepe. Doloribus ducimus labore. Atque iure quasi asperiores eaque. Repellendus maxime excepturi cumque corrupti eaque commodi.	2023-11-14 16:18:56.829	PUBLISHED	0	0	\N	48946703-20d1-4c5c-a868-859cf09df516	1347	1098	\N
21	Ipsa adipisci ratione accusamus esse dolor esse ad dicta dicta. Iusto quis eum voluptas atque. Fuga quas eaque praesentium.	2023-11-15 04:03:12.86	PUBLISHED	0	0	\N	6dc18dee-0a28-4438-99f4-70df53507626	1348	514	\N
21	Vel reiciendis animi expedita laborum optio eligendi porro porro. Autem cupiditate corporis possimus. Dolores aspernatur aperiam. Laborum dolorem libero consectetur.	2022-12-04 02:20:36.928	PUBLISHED	0	0	\N	fa48a46f-971f-4962-8042-8c70fb1b7e2c	1349	1236	\N
14	Quos omnis aspernatur. Optio saepe deserunt culpa est repudiandae eius. Saepe ullam quod rerum. Nemo ab ipsum consectetur inventore consequatur possimus animi. Doloremque aperiam maxime. Non laborum voluptates est harum dolore.	2023-06-04 08:02:18.122	PUBLISHED	0	0	\N	b16458ff-094b-4791-9ea4-ce3fefb1cec1	1350	1208	\N
20	Officiis atque corporis numquam perspiciatis ipsam. Nisi repellat pariatur debitis quisquam.	2023-01-14 19:29:22.799	PUBLISHED	727319.1733111112	1	\N	06ca870f-e975-4ddf-9570-f111f5b10fcf	1513	357	\N
23	Magnam molestias perspiciatis ipsa maiores inventore tenetur quod facilis facilis. Sit libero tempore maiores. Voluptatibus ad mollitia unde consequuntur nam labore. Veniam ipsum nostrum debitis similique molestias deserunt quisquam exercitationem. Sapiente odio cum sequi nam soluta animi. Officiis molestiae adipisci nam vero corporis temporibus dignissimos.	2023-08-02 00:33:51.315	PUBLISHED	0	0	\N	6ff9fa30-62ad-438e-b600-4d9a419027f3	1352	1246	\N
23	Eum fugiat amet ratione officia dignissimos iusto possimus. Voluptatem vitae id sit delectus tempore quaerat illum voluptate.	2023-10-17 01:36:21.292	PUBLISHED	0	0	\N	fc67c342-5963-4919-a94c-c5dabc5dcf7c	1353	863	\N
18	Expedita repudiandae nemo quo recusandae dolorem vitae. Ab pariatur consectetur cupiditate tenetur ullam. Consequuntur facilis ratione id vero.	2023-07-02 00:46:56.252	PUBLISHED	0	0	\N	a444f1bd-dda4-4c79-b857-55578248976c	1354	598	\N
20	Nemo illum illo earum quae ab perspiciatis esse. Repellat ea veniam excepturi harum excepturi.	2023-08-03 14:46:34.748	PUBLISHED	0	0	\N	35938919-6e86-4c26-bb6b-b9f7bf11d587	1355	1106	\N
19	Odio vitae ullam nobis recusandae labore iusto. Ipsum sed voluptatum eius consequatur.	2023-07-08 21:44:32.717	PUBLISHED	0	0	\N	81f2d141-c58c-46c6-ba2b-8185ac9d3efc	1356	1031	\N
23	Doloremque in ipsa dolore. Amet illo facere voluptatem ea libero.	2023-04-23 15:51:10.282	PUBLISHED	0	0	\N	4e07886f-fd4c-454c-9e46-090fa113db75	1357	556	\N
14	Possimus atque in eos delectus inventore maiores commodi soluta. Voluptates tenetur necessitatibus unde odit ut reprehenderit vel beatae.	2023-01-23 11:09:38.163	PUBLISHED	0	0	\N	1e4d426b-92a4-4b13-b2b5-613dd2ddd0d9	1358	961	\N
16	Quas in exercitationem ea. Dicta a doloribus omnis sit.	2023-08-03 16:21:51.391	PUBLISHED	0	0	\N	75a98d7f-77b3-4dfe-ae3a-429986678ff6	1359	1306	\N
17	Voluptate id dolor. Sunt quibusdam voluptas sequi quod accusantium aperiam aut. Maiores ipsum voluptates. Debitis libero veritatis esse. Ipsa voluptas tempore repellendus impedit fuga nulla labore. Libero earum iure cumque eligendi temporibus aspernatur.	2023-04-01 08:17:19.596	PUBLISHED	0	0	\N	22eec5e9-6526-4912-a67e-c90f17f5c3a1	1360	1095	\N
20	Incidunt autem quaerat at. Nesciunt adipisci totam commodi quis praesentium perspiciatis nesciunt facilis.	2023-06-02 21:09:16.724	PUBLISHED	0	0	\N	b2480f3c-85cf-4402-b1a8-5aa079910dff	1361	1106	\N
22	In unde aliquam harum doloremque. Velit aliquam tenetur similique veritatis aspernatur doloribus. Deleniti itaque suscipit. Hic at praesentium saepe aliquid commodi quasi debitis. Debitis velit beatae. Praesentium exercitationem aliquam ad.	2023-11-23 06:18:55.119	PUBLISHED	0	0	\N	45b3f021-385a-4707-b202-514502508012	1362	445	\N
20	Quis ea eveniet totam beatae. Tempore quae tempore assumenda blanditiis cum. Ad perspiciatis adipisci labore voluptates ipsam id optio itaque officia. Neque nulla pariatur molestias eligendi enim ab dolore.	2023-05-23 01:32:06.211	PUBLISHED	0	0	\N	b9f01932-8f9d-4aef-ac09-2ffcbc93d043	1363	640	\N
21	Odio corporis cum tempore ad unde perferendis porro repellendus. Aliquid fugiat ex eos numquam quia. Officiis ducimus nisi eum ullam voluptas vel. Laboriosam ea consectetur excepturi sed ipsa vero commodi doloribus.	2023-07-13 20:13:50.604	PUBLISHED	0	0	\N	a11461cb-9c9c-4be9-85c7-acf78d4474bf	1364	939	\N
23	Soluta enim cupiditate eligendi eveniet magnam molestiae sapiente accusamus velit. Laboriosam laborum ducimus qui dolores ipsam. Expedita aliquam doloribus incidunt molestiae explicabo nobis impedit nisi recusandae.	2023-01-22 00:17:59.6	PUBLISHED	0	0	\N	f12d54e4-990e-4073-9385-de520ead7f3c	1365	517	\N
15	Quae laboriosam iste culpa quisquam amet officia fuga in. Ducimus eveniet ex eaque. Vero quibusdam itaque sed. Cum delectus dignissimos. Quia iste soluta necessitatibus aliquid.	2023-03-21 09:33:16.913	PUBLISHED	0	0	\N	f6116f38-8658-456a-bcd3-8f6c9edfed1e	1366	1251	\N
19	Cum fugiat vitae culpa quas aperiam ut veniam tempore reprehenderit. Est corrupti corporis tempore recusandae aliquid molestias quisquam.	2023-06-25 14:55:21.891	PUBLISHED	0	0	\N	185f446a-2b4e-487e-90a1-e73778641eef	1367	1217	\N
15	Error itaque deserunt nostrum. Inventore doloribus fugit ipsum magnam.	2023-07-02 03:44:46.568	PUBLISHED	0	0	\N	b928cf0b-84ba-436e-af63-c944b286bfc7	1368	350	\N
16	Corrupti repellendus iusto incidunt. Praesentium aut facilis nostrum. Reprehenderit fugiat occaecati facilis rerum. Facere neque ullam ipsam hic. Dolores dolor vitae omnis amet officiis eum. Consectetur sit et modi fugit est.	2022-12-08 12:59:11.609	PUBLISHED	0	0	\N	93e05c05-9248-44c9-a696-312f3a12f284	1369	777	\N
15	Facere tenetur molestiae tenetur aperiam atque maiores iusto nemo. Amet repellat quos architecto quae possimus veniam repudiandae.	2023-10-09 16:50:40.285	PUBLISHED	0	0	\N	dbd1e38e-a6d2-41fa-b7fd-fed5dc0a8bcf	1370	1183	\N
15	Asperiores ex ullam voluptatum tenetur. Recusandae veritatis provident necessitatibus reprehenderit nulla dolorum molestias. Quos ducimus nemo sequi expedita.	2023-07-15 22:22:48.636	PUBLISHED	0	0	\N	a8bed462-0810-43aa-a3fd-ac8580603c8f	1371	1314	\N
16	Eligendi provident pariatur dolorum. Expedita beatae aut expedita minus vel ea dignissimos. Quos ullam placeat. Ducimus quisquam est.	2023-08-04 03:45:18.069	PUBLISHED	0	0	\N	a927de0f-15a4-4005-95ef-11c7adc9b623	1372	768	\N
20	Perferendis perspiciatis praesentium dolorem debitis iure similique et animi consequatur. Ipsa porro quos inventore eligendi libero magnam doloremque aliquam cupiditate. Veniam ipsa eos quidem consequuntur animi in voluptatibus omnis qui. Aut reiciendis veniam dicta facilis delectus.	2023-03-14 23:45:43.659	PUBLISHED	0	0	\N	1b4dc8ba-69b0-4f7e-87ec-10acb1fcbd33	1373	1075	\N
15	Officia nihil ex assumenda iure vero occaecati eligendi inventore. Quaerat maxime blanditiis. Ipsa eius nesciunt corrupti in eaque. At placeat beatae qui eligendi nam rerum ex necessitatibus. Magni tenetur sapiente error corporis. Aperiam blanditiis doloribus libero placeat totam.	2023-04-10 14:03:12.451	PUBLISHED	0	0	\N	3b916766-3cb1-43a7-821f-207fe4594d83	1374	802	\N
23	Pariatur sapiente magnam veniam quo impedit. Quasi officiis iusto. Sunt voluptatum quas. Nostrum eaque modi dignissimos dicta voluptate expedita. Labore explicabo dignissimos sequi veniam aperiam excepturi. Laboriosam commodi perspiciatis dolore asperiores sequi repellendus ipsum aliquid officiis.	2023-05-07 12:46:16.902	PUBLISHED	0	0	\N	72861d02-730d-4129-86f8-b4cf8cae18c1	1375	431	\N
19	Quis rerum totam sed ipsum reiciendis incidunt. Illum repudiandae totam amet quisquam esse omnis modi. Natus voluptatum neque.	2023-03-04 07:34:05.669	PUBLISHED	0	0	\N	8e2ff182-c277-4667-a231-e8e3c6a63cd9	1376	823	\N
19	Repellat vitae pariatur corrupti sequi numquam. Similique maxime hic beatae. Consequatur quia dolore aut laudantium blanditiis et cumque. Optio ut neque illum odio eius temporibus amet.	2023-07-04 13:38:49.226	PUBLISHED	0	0	\N	67520306-5797-4691-a04a-3366f35faf0e	1377	955	\N
23	Quod ullam dolore optio accusantium. Optio dignissimos maxime. Temporibus error atque tempora veniam quos itaque optio. Quaerat iste nihil aliquid asperiores quidem autem commodi. Necessitatibus incidunt fugiat illum neque maxime labore. Perspiciatis aut explicabo excepturi vel facilis.	2023-07-10 22:50:28.907	PUBLISHED	0	0	\N	aa42ef15-1a98-4327-bab1-fb54544ca86a	1378	1074	\N
21	Optio maiores reiciendis nulla. Maxime dignissimos sint est.	2023-07-27 08:28:13.127	PUBLISHED	0	0	\N	411d4825-c126-4c52-9875-5b336d582191	1380	775	\N
14	Quasi quam quo culpa temporibus consequuntur quis quis. Quaerat asperiores corrupti ipsam nostrum. Blanditiis placeat est hic assumenda aliquid optio magnam exercitationem.	2023-09-04 11:51:30.235	PUBLISHED	0	0	\N	e211d599-9876-4e5f-b657-7ff3ddcce3e0	1381	772	\N
18	Harum tenetur error amet magni consequatur cumque. Nihil deserunt culpa ratione eveniet assumenda labore voluptatum placeat similique. Ipsum deleniti ab facere eum impedit ipsa ex id. Eaque reiciendis impedit.	2023-11-12 07:08:37.923	PUBLISHED	0	0	\N	ba0fcc6e-336c-499d-bdd5-4b3fbd670516	1382	853	\N
21	Soluta provident quis minima ratione expedita eaque distinctio. Repellendus dolorum consequuntur. Esse eaque quia voluptate molestias exercitationem. Voluptate voluptatibus maiores aliquam consequuntur. Necessitatibus alias possimus expedita necessitatibus voluptatibus non.	2023-03-04 08:13:33.472	PUBLISHED	0	0	\N	484b507e-208c-48b0-898d-9fe39f51981b	1383	1055	\N
22	Quos dolore impedit minima neque. Harum voluptates vel consectetur. Dolorum nisi molestiae doloremque nesciunt non excepturi molestiae recusandae nihil.	2023-02-18 00:42:33.67	PUBLISHED	0	0	\N	b0d9aa86-7d08-4968-8c62-13f6cbcfe37e	1384	1197	\N
19	Consectetur facere placeat maxime mollitia voluptate repellat ducimus autem odit. Repudiandae laboriosam soluta tenetur maxime assumenda placeat tempore. Ex numquam sed similique. Vero ab accusantium accusantium. Tenetur maxime laboriosam quidem ea.	2023-02-20 21:23:48.912	PUBLISHED	0	0	\N	c463f4ca-199a-43f4-be10-d84e855e7184	1385	458	\N
16	Necessitatibus quibusdam qui optio. Quis aspernatur debitis modi esse nostrum corporis blanditiis.	2023-08-29 22:18:31.183	PUBLISHED	0	0	\N	b1493401-6212-4de3-9129-b665f0333df1	1386	1306	\N
22	Exercitationem ullam quas non ipsam libero accusamus doloremque fugit. Iure adipisci non illo veniam. Veritatis laboriosam iste repellendus dolor voluptates dolore.	2023-05-23 22:39:24.55	PUBLISHED	0	0	\N	29b93b20-2480-47bc-bf68-a7b016dd6170	1387	524	\N
21	At eaque nemo iste. Totam repellendus reprehenderit molestias tenetur. Amet molestiae corporis aperiam illum debitis dicta explicabo. Totam labore corporis cupiditate optio consectetur repudiandae.	2023-01-18 20:03:02.117	PUBLISHED	0	0	\N	8daa22a4-d2a1-431b-8911-e95827d1f4df	1388	891	\N
15	Vel molestias temporibus ad similique. Corrupti magni placeat maiores quisquam. Rerum cumque animi libero autem nulla necessitatibus. Deserunt provident aliquam nihil. Sapiente excepturi quisquam ut ducimus alias est ullam. Nesciunt id doloribus itaque alias quas.	2023-01-27 02:41:24.757	PUBLISHED	0	0	\N	cf0663ed-0bdd-4d9d-a4ac-320d1be52b7e	1389	1165	\N
18	Aspernatur esse sed. Aspernatur dolorum tenetur laudantium enim quidem provident perferendis. Quasi enim temporibus excepturi. Labore laborum magnam aspernatur laborum officia numquam maxime natus corporis. Quos dicta magnam accusantium iste voluptatem.	2023-11-26 10:44:55.564	PUBLISHED	0	0	\N	cb1d45f9-a35a-491f-9b2d-b7a5cc032142	1390	989	\N
15	Necessitatibus dolor laborum quis adipisci modi velit. Odio perspiciatis voluptas necessitatibus sint quia aut recusandae. Error vero sequi fugit reiciendis suscipit alias odit alias cum.	2023-10-30 10:14:14.833	PUBLISHED	0	0	\N	ed494c41-a9c9-4966-ab57-f9bceb945320	1392	822	\N
16	Laboriosam accusamus cupiditate nulla deleniti consequatur dolorem eveniet. Nisi temporibus aperiam maxime quo laboriosam corporis tempora natus. Dolorum esse ex porro ducimus.	2023-05-02 10:05:15.355	PUBLISHED	0	0	\N	9ff3a649-cea8-40fa-a1d2-f9c974f56cd7	1393	816	\N
20	Dolores animi nam adipisci at illum. Corrupti sunt animi maxime dignissimos voluptas quis qui minus. Nostrum omnis odit incidunt occaecati voluptates cumque perferendis. Quod voluptas soluta sunt ratione asperiores quibusdam ullam. Facilis repudiandae id eius unde eius praesentium at omnis similique.	2023-01-05 13:21:36.717	PUBLISHED	0	0	\N	876c15de-02d1-4922-abb4-c9b37a2276ff	1394	406	\N
14	Excepturi iste sit perspiciatis temporibus est velit rerum a. Incidunt molestiae corporis voluptatum sapiente. Eos reiciendis deleniti voluptate tempora unde praesentium consectetur veritatis.	2022-11-30 17:39:06.005	PUBLISHED	0	0	\N	0435345f-112b-4886-aa79-7129c1f14f0a	1395	1108	\N
22	Eaque cumque ratione maiores quas debitis reprehenderit atque harum possimus. Vitae sint illum nihil velit. Eligendi est accusantium repellendus. Assumenda soluta similique dolore sed quaerat repudiandae. Quis minima debitis tempora architecto delectus minima possimus aliquid. Quibusdam blanditiis labore occaecati odio voluptas error.	2023-06-25 04:12:17.179	PUBLISHED	0	0	\N	e1de907b-9b1c-42a0-a8d9-6f481fbb7a54	1396	884	\N
17	Excepturi consectetur ut consectetur blanditiis. Explicabo doloribus ipsam. Quasi magni inventore numquam qui tempore. Nostrum illo fuga consequuntur quas unde sequi fugit nulla alias. Accusantium veritatis sed repellendus.	2023-07-26 09:32:30.276	PUBLISHED	0	0	\N	25b05876-aa83-4979-a9ce-c2863cad8ec4	1397	354	\N
15	Necessitatibus nobis odio laboriosam suscipit porro sint. Fugit dignissimos asperiores dicta. Vero deleniti cumque debitis minima id accusantium quae. Nisi temporibus corrupti officia. Explicabo repudiandae exercitationem cupiditate recusandae.	2023-03-01 12:59:24.109	PUBLISHED	0	0	\N	018ea445-d7fc-41c1-b083-67b4af11d352	1398	1225	\N
18	Atque minus exercitationem eaque earum temporibus numquam facere a. Animi fugit at modi placeat sapiente voluptatibus. Aspernatur odio ducimus nulla repellat repudiandae magni. Iste modi numquam hic repellendus sed quaerat veniam iste ea. Voluptates cumque mollitia optio esse iure quos. Voluptas consequatur asperiores expedita beatae quia.	2023-03-09 16:55:06.066	PUBLISHED	0	0	\N	ffe8a631-0753-4115-9c3c-d2d241fae509	1399	413	\N
15	Eum expedita laudantium dolorem perferendis iusto. Deleniti qui voluptatem quae saepe perferendis nam sed dolores esse. Repellendus tempore blanditiis praesentium labore. Quidem aspernatur a. Autem est tempora facere reiciendis iste dolores vero id.	2023-02-22 01:54:15.89	PUBLISHED	0	0	\N	936e3f99-6efc-4f3a-9b84-ad208558928a	1400	704	\N
16	Autem soluta similique dolor sequi similique eius repellat labore. Fuga explicabo magni exercitationem doloremque maxime ipsam reiciendis rem cum. Nobis sed minima aspernatur tempore repudiandae. Fugiat facilis doloribus libero et assumenda numquam adipisci accusamus corrupti. Sed atque maxime eos laudantium vel nulla.	2023-09-18 05:48:24.001	PUBLISHED	0	0	\N	baf3e9ae-f05f-4c69-997a-4dfcff4c58bb	1401	587	\N
20	Quibusdam iure harum. Eius amet nemo nisi laudantium quisquam corporis.	2023-10-29 20:57:29.872	PUBLISHED	0	0	\N	7e9a5115-59af-499c-aa87-394aaf9aff36	1402	1088	\N
23	Culpa et ut cum atque ratione eum exercitationem ab. Voluptas explicabo quos pariatur iusto sed fugiat. Molestiae voluptatem maiores. Ducimus cumque maxime dolor debitis. Dolor reiciendis reprehenderit debitis occaecati exercitationem. Iusto optio reiciendis ipsam iusto.	2023-08-22 15:44:21.413	PUBLISHED	1149419.142511111	1	\N	601dfd25-87b7-4526-a37d-1d9a800e0a11	1403	497	\N
17	Provident esse placeat sint nisi eveniet et cum harum repellat. Maiores quaerat numquam inventore maiores voluptas eos odio.	2023-04-07 15:41:34.482	PUBLISHED	886375.4329333333	1	\N	ad1ea880-962f-422e-bae7-0223a072f570	1406	1031	\N
15	Eius error ut quibusdam. Deleniti ducimus dolorum minima modi ea ullam architecto numquam placeat. Deserunt deleniti commodi atque.	2023-06-21 14:45:28.958	PUBLISHED	0	0	\N	0651916b-3dfd-4ed5-942f-88d3e0df235c	1407	1043	\N
16	Repellat ut enim accusantium. Aliquam nisi molestias magnam atque quidem quidem iste reprehenderit commodi. Cum in occaecati maxime qui reprehenderit quaerat dolorum omnis a. Consequuntur modi quam facilis voluptate magnam.	2023-09-05 13:11:49.146	PUBLISHED	0	0	\N	7f233c8a-e907-4046-b4c3-22bb715d2f5a	1408	799	\N
15	Sunt tempore laudantium eveniet repellat dolorum similique. Eum consectetur esse assumenda tenetur. Deserunt nobis eos minus impedit quod consectetur id minus.	2023-04-07 21:49:34.107	PUBLISHED	0	0	\N	cd59e75e-bf9b-4324-bedd-acfd982eb2bf	1409	824	\N
18	Iusto necessitatibus alias maxime quo necessitatibus nobis totam possimus ipsum. Eius molestias perferendis illum quas minima veniam sit eius.	2023-01-13 06:33:05.32	PUBLISHED	0	0	\N	8b68f132-9e86-4128-9b0f-8443d41ad291	1410	1056	\N
14	Nulla fugiat unde odit. Maxime minima saepe cum dolorem perferendis hic pariatur ullam dolore. Nemo tenetur consectetur est dignissimos modi iusto quas consequuntur voluptates. Blanditiis consectetur ratione sequi inventore tempora. Officia nisi ducimus non maxime voluptatibus repellendus. Iure facilis numquam adipisci.	2023-01-23 14:34:55.509	PUBLISHED	0	0	\N	831b1882-1fe2-4729-b0e0-dece58ac2544	1411	368	\N
17	Soluta possimus ipsa officia ea incidunt. Nobis qui non debitis perferendis illum corporis quisquam eum. Sit et doloremque vel sint. Incidunt nesciunt commodi aliquid laboriosam a molestiae explicabo. Ullam at minima similique natus. Tempora corrupti repellat reprehenderit ad inventore neque neque.	2023-08-07 03:39:10.122	PUBLISHED	0	0	\N	a43df179-2e52-4a17-a751-48a7eefc1dbb	1412	367	\N
19	Tempore reprehenderit odit ipsa fuga reiciendis. Mollitia ex accusantium ullam. Recusandae sapiente nihil labore neque architecto quis eius nulla. Earum accusantium ab temporibus quidem exercitationem hic.	2023-08-09 01:51:48.771	PUBLISHED	0	0	\N	c19a700e-4482-4bd0-b26c-04f5a6aed8d0	1413	562	\N
15	Culpa dolorum odit tempore. Repudiandae repellendus labore debitis excepturi. Consequatur corporis quisquam.	2023-01-06 13:25:43.46	PUBLISHED	0	0	\N	49654237-39b9-4a32-ba6b-8abdb9a6304d	1414	735	\N
15	Esse assumenda commodi debitis numquam ipsam magnam iste. Quae eius possimus fugiat consectetur officia qui cupiditate necessitatibus doloribus. Officia odit mollitia iste eum. Maiores ullam ex perspiciatis delectus officiis delectus magnam temporibus. Accusamus pariatur necessitatibus libero voluptatibus perspiciatis quibusdam. Quibusdam accusamus fugiat.	2023-07-09 21:42:39.848	PUBLISHED	0	0	\N	21dd5b24-c63f-4cef-b644-0ec1b8437997	1415	1052	\N
18	Sed quae voluptas et odit occaecati. Eligendi iusto quisquam.	2023-04-22 19:12:22.922	PUBLISHED	0	0	\N	13e77148-8cce-491d-8630-e02e1b2391fc	1416	467	\N
16	Culpa delectus amet sequi labore. Qui maxime fuga dolore omnis delectus maiores.	2023-06-26 13:26:10.911	PUBLISHED	0	0	\N	a960bd70-fa41-4308-bb5d-1052297245b2	1417	687	\N
17	Tenetur quo incidunt maiores dolorem reiciendis. Itaque iure officia adipisci numquam quam fugiat voluptates. Aspernatur tempore facere. Ipsum cum iste aliquid sequi reiciendis eligendi. Laboriosam doloremque magnam numquam. Corporis amet quisquam eius architecto.	2023-01-18 05:43:14.01	PUBLISHED	0	0	\N	290b8f72-abed-4961-acfe-16247b57ac66	1418	429	\N
20	Vitae ipsum deserunt. Consectetur quam non et vero ab dignissimos. Nihil qui in in deleniti. Exercitationem iure nisi beatae debitis necessitatibus maxime fuga recusandae.	2023-05-21 10:34:52.672	PUBLISHED	0	0	\N	bdcf82d8-74a6-4aab-9776-dbe9b39ea293	1419	1085	\N
16	Alias corrupti nam eveniet debitis voluptates dignissimos dolore veniam. Molestiae occaecati at velit. Eveniet architecto rerum incidunt veniam ratione soluta. Officiis error cum consequatur enim quas sapiente doloremque eligendi. Iste nobis sunt ipsum optio occaecati error perspiciatis neque. Deleniti consequatur similique ipsum eius facere alias et dolore.	2023-06-30 21:27:27.117	PUBLISHED	0	0	\N	1fa1cf5f-6efa-42fb-a27e-3e313cc2d0b6	1420	421	\N
14	A a aliquam voluptatibus quibusdam molestias consequatur totam ut dolor. Id quidem recusandae ipsam dolorum sapiente.	2022-12-07 08:26:37.591	PUBLISHED	0	0	\N	e1c89899-7f7f-45e2-9637-eca7955b2c4a	1421	1131	\N
21	Excepturi vel maiores similique impedit beatae ipsam. Ipsum omnis quis optio nobis.	2023-01-15 06:54:36.509	PUBLISHED	0	0	\N	935fff94-88ae-48b1-954e-97b784c29fcc	1422	1054	\N
17	Eveniet distinctio alias esse. Ea maxime quos illo magnam accusantium veritatis reiciendis. Eaque ipsa accusamus dolores. Excepturi necessitatibus occaecati. Rem neque fuga. Molestiae expedita vel maxime.	2023-02-23 17:41:32.78	PUBLISHED	0	0	\N	bb84c00c-9163-4d97-b60e-66220e9f854f	1423	1390	\N
18	Odit dolorem cumque hic doloribus commodi similique ullam incidunt eius. Delectus fugiat necessitatibus quae natus non magnam. Nulla alias animi sed possimus dolore voluptas perferendis ut. Placeat explicabo praesentium repudiandae.	2023-09-17 00:38:35.944	PUBLISHED	0	0	\N	77ace9e3-5e83-4a61-8f0c-b4c52470217d	1424	1423	\N
17	Reiciendis dolorem qui tempora doloremque assumenda assumenda doloremque. Explicabo doloribus ipsa quia labore sunt soluta ad.	2023-04-20 03:26:40.45	PUBLISHED	910355.5655555555	1	\N	122d5caf-a638-4b48-9825-27bba0872cd3	1425	1411	\N
18	Odio natus illum voluptate dicta necessitatibus tenetur quo earum dolorem. Praesentium quaerat nesciunt inventore. Optio magnam a veniam modi impedit dicta sed. Nisi labore dolore aut natus dolorum autem nihil quo.	2023-05-13 20:34:58.344	PUBLISHED	0	0	\N	4a676d77-03ad-4dad-8eee-457e001eaf2f	1426	1069	\N
19	Blanditiis consectetur deserunt sint harum harum ad. Vel quibusdam aspernatur harum consequuntur rerum iusto autem modi. Maiores facilis at minus hic. Occaecati odio natus consequatur.	2023-05-06 20:02:03.85	PUBLISHED	0	0	\N	88d6ff0a-2b8a-470b-8919-9db352f6ced2	1427	819	\N
14	Accusantium ab veniam error corporis corporis. Non quia accusamus totam ipsam voluptatum dolorem id dolores blanditiis.	2023-01-20 23:32:50.482	PUBLISHED	0	0	\N	e5027efd-fc1c-4c14-b9db-76c28800f6c4	1428	738	\N
21	Nesciunt sunt impedit nesciunt nihil veritatis et magnam sunt. Possimus omnis unde quod corporis nihil deserunt. Molestiae delectus harum id deleniti iure alias velit quibusdam totam. Eum voluptatibus deserunt maiores vero qui quis eos delectus. Quis porro beatae velit.	2023-02-03 18:39:06.764	PUBLISHED	0	0	\N	9232b7c4-6333-470e-969b-1730baef8fbc	1429	568	\N
18	Placeat reprehenderit ut. Nisi soluta nulla vitae commodi totam ad. Porro amet nostrum. Beatae aperiam consequuntur totam labore tempore ipsum. Est fugit in maxime error. Corrupti eveniet sunt cum architecto culpa libero architecto.	2023-05-13 11:28:45.276	PUBLISHED	0	0	\N	c8109607-e59e-4ce7-8f9d-a3d19ef75725	1430	686	\N
19	Nam ratione nisi officiis. Magni perferendis eos ipsam nostrum placeat.	2023-11-18 18:54:19.547	PUBLISHED	0	0	\N	ff75dd74-5efc-4329-ae27-a71efb669afa	1431	1218	\N
21	Sit dolor animi neque sapiente et fuga. Eveniet eum rem voluptate deserunt tempora quas.	2023-09-30 15:50:21.699	PUBLISHED	0	0	\N	682ff34f-a406-475e-83f7-925a36c811f1	1433	1128	\N
17	Molestiae facere officia laborum quo perspiciatis nulla soluta. Eius ducimus facilis harum nemo cumque nulla. Ex earum voluptatibus ut.	2023-08-06 02:09:42.833	PUBLISHED	0	0	\N	4f9e5f33-ed8e-4e07-a73b-6811b3775f93	1434	1195	\N
23	Modi eveniet dolorum adipisci. Labore omnis voluptates. Fugiat accusantium itaque consequatur. Pariatur explicabo ex autem voluptatum minima. Natus vel reiciendis nam deserunt hic blanditiis fugiat dolores fugiat.	2023-05-19 03:32:30.999	PUBLISHED	0	0	\N	f5ab2007-a7b7-4744-9c68-a443c05a8217	1435	1199	\N
22	Ad rem explicabo tempora placeat est alias voluptates. Qui iure molestias possimus. Exercitationem voluptatem voluptate perspiciatis explicabo quia atque. Fuga autem voluptatem provident et labore vel. Eaque rem consectetur officia ipsam maiores quo quam fugit. Atque quos totam itaque.	2023-11-24 17:00:45.041	PUBLISHED	0	0	\N	55669aa2-b0b9-4e5b-9d86-5b98ddc38886	1437	1409	\N
20	Aspernatur harum maxime natus ipsum quaerat veritatis porro. Hic reprehenderit odit reprehenderit eius ipsum. Numquam quisquam occaecati.	2023-11-07 01:55:40.991	PUBLISHED	0	0	\N	f35bed79-09f8-4272-80a2-ef0e5301373b	1438	1409	\N
15	Quidem nobis ipsum hic magni fugit consectetur. Impedit voluptas exercitationem est optio aspernatur dolor enim quod sunt. Nulla ex ex reprehenderit inventore earum. Optio eaque repellendus eius perferendis nesciunt. Magnam nihil repellat.	2023-11-23 12:29:17.64	PUBLISHED	0	0	\N	6bb8f743-177b-43d6-8a2f-ea226e88bc9e	1439	376	\N
23	Animi labore odio aliquam odit ut. Hic deserunt harum fuga magni vitae suscipit fugiat.	2023-05-11 04:41:27.062	PUBLISHED	950775.2680444445	1	\N	4d1df034-5f4c-4f5b-9f4d-528744d4e86d	1440	1255	\N
23	At aliquid nemo optio sequi nam. Assumenda ea porro enim iste error asperiores commodi porro. Quaerat labore est accusantium. Voluptate iusto ad quibusdam facere.	2023-08-08 11:50:52.947	PUBLISHED	0	0	\N	a84beae1-2de4-4f31-97cb-00f5a1fbabf4	1441	1080	\N
22	Veritatis omnis qui veritatis amet odit dolore provident ipsum libero. Laboriosam id voluptates dolorem voluptatibus. Asperiores hic voluptatum cumque ad. Distinctio pariatur distinctio omnis voluptatibus ut quos. Esse omnis illum laudantium dignissimos suscipit doloremque consectetur.	2023-03-05 03:15:59.487	PUBLISHED	0	0	\N	dc37ffdb-4534-47a5-a1cc-fe90fa64baf7	1442	1436	\N
14	Eius quasi culpa. Repellendus totam magnam. Nam voluptas perspiciatis temporibus animi accusamus. Mollitia ex vitae quis nihil esse. Rem placeat laborum impedit adipisci fuga.	2023-03-15 04:37:57.713	PUBLISHED	0	0	\N	b899efda-dec3-46b3-a518-7fad7dbceee3	1443	717	\N
21	Magni pariatur dignissimos magnam. Ad quis at labore quis incidunt in. Saepe cumque eaque eius fuga. Corrupti quam facere laudantium in exercitationem velit harum cupiditate. Molestias odit ratione provident repellendus totam sequi eius molestiae dolor.	2023-10-23 05:53:17.116	PUBLISHED	0	0	\N	1a31f0dc-d965-4d75-a551-089e3d8eaead	1444	519	\N
22	Voluptatum velit earum placeat. Reprehenderit provident delectus ipsa et quasi aspernatur eligendi quia quaerat. Voluptatum recusandae nulla aut. In placeat nulla sit molestiae voluptates porro tempore fugiat quidem.	2023-04-30 07:07:04.795	PUBLISHED	0	0	\N	3f621a1d-0c74-405e-8bfc-4488c13574c1	1445	1058	\N
19	Deleniti eaque reiciendis modi ex nemo. Nisi nisi necessitatibus iusto aperiam eius quam debitis. Quaerat quod accusamus quia amet.	2023-02-24 00:47:32.511	PUBLISHED	0	0	\N	0dcadaff-cb18-460c-9be7-1527eaa4a719	1446	1241	\N
14	Dolore reiciendis vitae incidunt. Deserunt repellendus saepe voluptatem laudantium molestias provident dignissimos numquam autem. Aperiam voluptatum velit voluptates voluptatem. Eius beatae doloribus maiores. Ipsa porro exercitationem dolore eveniet a ullam ratione eaque quam. Consequuntur nisi ipsam non totam amet.	2023-10-04 01:41:26.623	PUBLISHED	0	0	\N	d3e551fe-f042-4c45-9bb3-325eee136ddb	1447	1008	\N
20	Officiis cupiditate occaecati hic ipsa amet amet quisquam veritatis. Repellat aut quisquam ex beatae distinctio eveniet voluptatibus perferendis. Officia earum eaque incidunt voluptates quaerat error cumque repudiandae. Modi exercitationem tempora qui.	2023-10-27 19:09:37.137	PUBLISHED	0	0	\N	1419b843-c635-479b-ab5d-b536b0f6131e	1448	427	\N
23	Sed illo odio ipsum at. Suscipit exercitationem nam aperiam illo deserunt inventore nam sint. Inventore voluptate eveniet vero non tempore beatae debitis id dolorum.	2023-02-11 17:59:40.092	PUBLISHED	780959.5576	1	\N	1d7b0b80-96a4-4285-af6c-a4eb8abe94ee	1449	1209	\N
17	Ducimus vel facere vel enim ex tenetur. Assumenda quidem modi dignissimos explicabo officia.	2022-12-23 01:40:36.657	PUBLISHED	0	0	\N	c0493ae4-745c-47a4-8015-7b555b174b40	1450	1197	\N
16	Veniam possimus laboriosam maiores eveniet pariatur voluptatibus placeat tempora earum. Veniam doloribus inventore officiis ea quis magnam asperiores id. Debitis debitis error sit. Aliquid fugiat iusto doloribus fuga nihil. Inventore possimus exercitationem in assumenda adipisci.	2023-02-07 02:06:25.916	PUBLISHED	0	0	\N	f5ae5bc8-4410-4063-a9c2-faa993309647	1451	765	\N
19	Sint autem alias tempore dolorum pariatur minima repudiandae sint fugit. Harum fugiat nobis temporibus fugiat ut. Ipsum deserunt ab libero accusantium voluptatem tempora minus. Tempore delectus itaque ducimus facere a nobis fugiat modi iusto. Repellendus minima hic.	2023-10-29 22:38:36.173	PUBLISHED	-1280531.470511111	-1	\N	9e218fe9-7ef0-493a-8245-e1d5b2c3c128	1452	1382	\N
18	Aliquam alias hic ratione repellendus sapiente id adipisci rerum. Tempora quas ut hic soluta eius necessitatibus ipsum in minus. Tenetur ducimus perferendis sequi. Similique sint mollitia animi dolor veniam iste impedit ad quibusdam. Amet velit aspernatur sapiente doloremque in blanditiis officia rem dolorem. Unde expedita dolorem repellendus consequatur quasi.	2023-07-27 19:10:48.029	PUBLISHED	0	0	\N	474bdda0-221d-4a5f-8298-9c9af87bc8bd	1453	652	\N
22	Optio voluptas tempore veritatis ducimus. Praesentium expedita animi tempore doloribus non ratione pariatur. Accusantium similique mollitia. Dolore quaerat facilis cupiditate facere. Numquam dignissimos nam ex voluptatum molestiae modi porro illo.	2023-02-11 07:03:13.234	PUBLISHED	0	0	\N	e5843365-366e-4244-88d1-08d75846a8cc	1454	585	\N
18	Labore magnam ut occaecati. Praesentium perferendis sapiente porro. Beatae repellendus laboriosam optio. Nostrum amet mollitia magnam illo. Nobis voluptatum assumenda numquam est inventore cum sapiente omnis. Vero nobis qui.	2023-02-28 07:41:29.639	PUBLISHED	0	0	\N	24342ec6-cd41-4d5d-b85c-483c12c6d3d2	1455	675	\N
17	Incidunt delectus libero maiores consectetur corrupti blanditiis rem. Occaecati laboriosam earum consectetur veniam. Hic commodi saepe consequuntur ducimus consequatur ullam ad. Illo accusamus voluptates distinctio neque dolorem non atque. In quibusdam amet fugit reiciendis quos. Eum non quaerat accusantium rerum quam itaque accusamus.	2022-12-27 14:47:16.894	PUBLISHED	0	0	\N	8808035b-6e5e-4dcd-af3a-3e2089529411	1456	645	\N
17	Sunt repellat ratione vitae. Quis impedit fuga quas rem.	2023-06-04 11:48:34.629	PUBLISHED	0	0	\N	1c957488-3f08-41be-8a6b-b6ca91ea90ca	1457	545	\N
14	Mollitia cupiditate a minima dicta ipsam expedita perferendis. Quibusdam quos nesciunt aspernatur modi porro.	2023-05-12 17:06:12.019	PUBLISHED	0	0	\N	a1f2f951-ce29-4c39-b94b-93d521100333	1459	710	\N
23	Ea eos harum maxime alias. Eveniet odio vero iste.	2023-07-10 13:30:27.709	PUBLISHED	0	0	\N	69aaf5c7-5c08-4f4b-9ddd-e9e2c541a2c6	1460	933	\N
23	Quisquam laboriosam accusantium error modi asperiores nesciunt doloremque voluptatem. Aperiam minima similique cumque perferendis totam.	2023-04-29 22:39:42.167	PUBLISHED	0	0	\N	4871aa80-f8ed-4e89-bb94-566b6638ce92	1462	1246	\N
20	Possimus exercitationem amet provident itaque cupiditate dolores quaerat. Illum quidem facere est minima ad eum excepturi. Possimus dicta reiciendis corrupti nesciunt sunt modi consectetur.	2023-06-13 18:55:40.978	PUBLISHED	0	0	\N	b7cd5c7d-da71-41a6-84cc-34fe8017057e	1463	380	\N
21	Nulla ipsam dolores nobis distinctio. Assumenda occaecati ipsum sequi veniam. Modi dolorem impedit inventore necessitatibus excepturi eligendi ipsum. Et consectetur aliquam incidunt facilis tempore laboriosam assumenda ratione illo. Quos omnis excepturi adipisci.	2023-11-06 03:48:17.964	PUBLISHED	0	0	\N	359f0499-3a5d-47a6-93f9-9d3939b94214	1464	505	\N
16	Aliquid velit enim reiciendis impedit ut ullam ut. Accusantium perferendis et nulla doloremque adipisci tenetur ratione tenetur nobis.	2023-02-05 06:20:27.921	PUBLISHED	0	0	\N	aab5afa2-62a4-4883-acaa-77ea916162c8	1465	710	\N
16	Illum minima aliquid velit occaecati eligendi magnam consequuntur. Consequuntur odit mollitia odio. Nostrum iste quam ut natus consequatur velit debitis maiores. Excepturi dicta deserunt. Porro quaerat quo repellat distinctio incidunt facilis nulla debitis.	2023-09-30 14:50:07.425	PUBLISHED	0	0	\N	0b181ed9-bc0a-4e0b-b406-20b7fb651eda	1466	1384	\N
20	Fuga tenetur quae officia. Quod nihil fugiat fugit illo aliquam. Dignissimos maiores aliquam quas facilis itaque cupiditate. Culpa delectus tempore ullam neque repudiandae facere. Quod architecto esse omnis. Velit velit nemo.	2022-12-28 11:22:08.753	PUBLISHED	0	0	\N	d9275939-e88a-4f00-afca-54502f0c8b0d	1467	571	\N
22	Eum eos dolorem nisi possimus similique. Totam error veniam inventore.	2023-01-09 05:23:21.342	PUBLISHED	0	0	\N	52b40d1d-de6e-4a23-99c7-b9201b2f22b7	1468	367	\N
14	Repudiandae ipsa sint et blanditiis. Sint eum odit optio iste iste harum.	2023-04-17 04:43:18.848	PUBLISHED	0	0	\N	8dc0336e-674b-4ab3-bc51-fddbffcde8ac	1469	505	\N
21	Amet facilis explicabo nulla amet ab earum temporibus magni. Consectetur cum debitis eius explicabo eius sed quos suscipit. Sed molestias architecto beatae quasi illo tempore et numquam. Officia sit error laudantium cumque reiciendis.	2023-06-05 23:29:23.529	PUBLISHED	0	0	\N	c01c5e91-53f6-4143-841a-571c016a762f	1470	1273	\N
20	Architecto hic impedit nihil. Ea neque ducimus vel illo alias. Impedit dignissimos error modi optio laudantium repellendus. Necessitatibus tempore consequatur sint vel vitae maiores odio quia. Reiciendis expedita cupiditate.	2023-02-15 19:33:46.337	PUBLISHED	788765.0297111111	1	\N	d7961858-c692-48ce-90f0-d5ebf190f710	1471	1373	\N
14	Cumque cum veniam tempore ut eveniet rem fugit ea saepe. Sed architecto accusamus possimus. Amet dicta accusantium est. Inventore beatae inventore non veritatis expedita. Voluptatum perspiciatis repudiandae similique. Iure doloremque amet impedit nostrum accusamus repellat dignissimos doloribus perspiciatis.	2023-10-24 13:11:56.012	PUBLISHED	0	0	\N	292c1996-eea1-4d95-a637-3034c807b421	1472	638	\N
21	Maiores maiores aliquam hic aut ratione dignissimos nulla error cum. Et laudantium quibusdam libero. Officia unde natus iusto eveniet. Provident placeat modi rem dignissimos optio error. Iure praesentium alias amet molestias reprehenderit dolorem ducimus. Animi officiis rem.	2023-11-09 22:19:41.77	PUBLISHED	1301626.261555556	1	\N	56bd6410-8fe0-41fb-a353-d7be95799f50	1473	897	\N
19	Assumenda hic sed aspernatur ex quibusdam assumenda est. Quo placeat velit quos perferendis ducimus nisi. Libero nemo at doloremque fugiat porro accusamus. Consequuntur asperiores officia sint eaque quisquam cum rerum ducimus.	2022-12-26 05:18:59.251	PUBLISHED	0	0	\N	6632969a-035a-4d0d-926d-d0c92997527c	1474	1283	\N
16	Vitae harum laborum provident dolorum. Consectetur perferendis ea explicabo assumenda occaecati illo ipsa. Eaque rerum illum nostrum nobis non vel voluptas error. Voluptatibus quos tempora eligendi. Molestias unde molestias rerum recusandae eveniet fuga aperiam deleniti. Dolorum voluptas impedit debitis.	2023-03-15 09:57:21.898	PUBLISHED	841756.4866222222	1	\N	76a06c30-f8ce-4990-b4ee-6e6a795dfef8	1475	1147	\N
19	Inventore suscipit porro mollitia modi vero voluptatibus ducimus dolore fugit. Dolorem reprehenderit quod cupiditate eius deleniti ullam accusantium laborum neque. Unde unde recusandae optio doloremque distinctio placeat quas harum. Totam beatae rerum sed. Ut aspernatur voluptas quo tempore excepturi esse. Fugit illo voluptates cumque quisquam incidunt eligendi molestiae porro.	2023-05-14 13:38:37.153	PUBLISHED	0	0	\N	08f19219-aa6b-4efd-b022-6f3e3659e669	1476	870	\N
20	Accusamus velit vero aperiam explicabo reiciendis quae. Ut dolor unde eveniet reiciendis officia suscipit voluptate. Beatae ipsum ad magnam consequatur accusamus quidem excepturi. Nostrum aut quibusdam dignissimos ipsam provident.	2023-07-15 08:18:00.3	PUBLISHED	0	0	\N	35f2ae65-20f3-44df-a4da-47e2b98d5b37	1477	515	\N
20	Adipisci nesciunt voluptatem voluptates distinctio deserunt voluptates hic iure. Excepturi nobis vitae laborum. Hic veniam voluptatibus. Ullam possimus veniam debitis nesciunt ex itaque ab. Fuga beatae impedit voluptate.	2023-09-17 06:19:20.397	PUBLISHED	0	0	\N	45be9a43-0d05-4575-80db-43a250834ab7	1478	845	\N
16	Porro molestiae expedita excepturi fuga magnam laudantium illum debitis. Ipsam facere nisi eos neque reiciendis laudantium nobis.	2023-02-18 16:07:26.086	PUBLISHED	0	0	\N	13090aa6-ce8c-42f4-be51-ade0dc5910d9	1479	738	\N
18	Quam exercitationem quo illum eligendi cum ab minus alias delectus. Illum id similique harum voluptates soluta. Culpa voluptates quibusdam accusantium nulla dignissimos ipsam eligendi voluptatibus fugiat.	2023-09-24 18:09:09.556	PUBLISHED	0	0	\N	b651ccbc-dd82-4d96-9fe5-b0f14bdf97f7	1480	363	\N
21	At soluta iusto voluptate quibusdam necessitatibus dolor ducimus. Maxime nisi cumque possimus at autem earum rerum illum. Omnis voluptatum distinctio asperiores laborum ipsa laborum commodi.	2023-06-20 16:21:39.863	PUBLISHED	0	0	\N	2bb2f15a-ccff-47e8-8ce4-26107ad190fe	1481	924	\N
19	Nobis autem possimus officiis harum repellat sed expedita. Consectetur temporibus vitae consequatur aliquam distinctio fugiat maxime.	2023-02-15 07:52:02.288	PUBLISHED	0	0	\N	e30fe217-a9dd-4b50-94b6-8aaf2df6c281	1482	1264	\N
19	Laborum sapiente eaque dignissimos vel. Quam autem labore beatae placeat molestiae. Cumque praesentium minus blanditiis accusamus quibusdam esse. Inventore qui corrupti iure consectetur ducimus incidunt aliquid architecto. Earum explicabo optio veritatis modi nobis error. Quos atque dolores nobis.	2023-02-25 11:13:05.341	PUBLISHED	0	0	\N	6e01a9e5-b166-4d49-ac0f-7f12f73649ea	1483	1270	\N
17	Natus nulla reprehenderit beatae sunt earum saepe eos libero. Commodi maxime asperiores tenetur.	2023-03-27 21:43:10.549	PUBLISHED	0	0	\N	9794d4d5-5ab2-454c-b57c-f4b0e3dfe5bc	1485	446	\N
20	Eos maiores quos. Quidem expedita deserunt neque. Aperiam natus nemo possimus quibusdam voluptatem quisquam recusandae perspiciatis. Aperiam facilis aliquid excepturi voluptas. Esse in cumque hic ab tempore quas.	2023-03-15 07:50:22.145	PUBLISHED	0	0	\N	4cea2077-134a-4eaf-82f0-f63d40d04675	1486	1174	\N
18	Quasi aut praesentium dolorum dolor saepe. Aliquid nihil debitis unde vero ducimus. Impedit numquam expedita voluptatem.	2023-05-17 01:56:44.111	PUBLISHED	0	0	\N	1cc0a15d-9a20-48e8-967e-1e6e3aac26b9	1487	1180	\N
23	Reprehenderit sunt officia officiis quaerat. Voluptates culpa sequi voluptate.	2023-08-06 06:16:48.679	PUBLISHED	1117942.415088889	1	\N	385fdf10-ba20-418d-992b-69717d16eb4b	1488	1398	\N
21	Maxime ea quidem voluptas. Saepe voluptas sapiente sunt vero quae quis quibusdam eum. Temporibus eligendi doloribus laboriosam occaecati provident. Cum rerum blanditiis. Nisi a minus.	2023-04-04 20:32:03.947	PUBLISHED	0	0	\N	7a64ddf0-dc65-47b0-8c27-c931b7e2f973	1489	1465	\N
16	Quasi ad numquam asperiores ducimus id. Quo porro aliquam aspernatur vero cum.	2023-10-19 19:46:39.006	PUBLISHED	0	0	\N	83787468-1b5e-433a-a8d9-d28c29f79427	1490	712	\N
16	Temporibus similique dolor laborum. Cum suscipit iste voluptas soluta.	2023-02-05 05:32:23.061	PUBLISHED	0	0	\N	ee700ded-98cd-4609-8011-eb0b5636ddfa	1491	1049	\N
14	Est magnam dignissimos rerum minima vero. Voluptatum fugit maiores error quas molestias illum molestiae. Totam adipisci nulla voluptas neque dolores vitae. Molestiae occaecati numquam iure totam neque atque. Quasi a dolorum ad ea qui. Quidem deserunt ipsa recusandae dolores.	2023-04-28 11:15:46.45	PUBLISHED	0	0	\N	2cd1b66c-0bc0-4167-bef5-71cd8a72bd42	1492	1166	\N
14	Modi cupiditate inventore dicta fuga hic animi vel. Inventore explicabo reprehenderit. Porro blanditiis voluptatum saepe consequuntur.	2023-06-21 13:15:16.337	PUBLISHED	0	0	\N	41185989-ca3c-46c5-9fbf-06c176747260	1493	1347	\N
18	Dolor libero omnis fugiat quia. Iste dolorem modi ex. Excepturi fugit provident dignissimos. Iste dignissimos perspiciatis consectetur repudiandae ex odit. Quia ipsam deserunt quibusdam expedita suscipit dolor minima. Provident iure beatae eos quibusdam ipsam.	2023-08-11 19:15:19.617	PUBLISHED	0	0	\N	b397da59-43e2-4e9b-a09d-cb1c9e66b83d	1494	1315	\N
22	Est quae nisi nobis nisi deleniti inventore inventore laboriosam alias. Magnam corporis magnam. Similique voluptatem alias debitis eligendi voluptatem.	2023-04-11 12:59:09.102	PUBLISHED	893838.8689333333	1	\N	d2a5641f-a204-4f1c-8d29-49682817be92	1495	1187	\N
23	Impedit magni laborum. Labore cumque reiciendis porro repudiandae doloribus voluptatibus. Ullam dolor maiores reprehenderit dolore culpa libero id nostrum harum. Eius soluta autem nobis iste. Officiis sapiente quam. Ipsa veritatis alias.	2023-04-01 06:35:20.744	PUBLISHED	0	0	\N	d6438374-8d8f-4046-ab64-00d6983ab601	1496	785	\N
18	Animi doloremque odit delectus. Delectus dolorum architecto fugiat illo suscipit similique saepe assumenda asperiores. Blanditiis officiis neque suscipit error.	2023-05-22 13:37:42.651	PUBLISHED	0	0	\N	60fcc0ac-363a-46b9-8823-16b757a9d216	1497	1020	\N
17	Modi velit facilis. Laudantium laudantium reprehenderit error quam.	2022-12-04 17:01:50.521	PUBLISHED	648402.4560222222	1	\N	888e2210-2d46-40b2-82e5-7c3da3e15f88	1498	975	\N
22	Explicabo est sit quibusdam. Assumenda ratione in expedita asperiores expedita nulla porro. Natus dolorum velit. Atque deserunt laudantium.	2023-02-18 00:59:57.321	PUBLISHED	0	0	\N	c1d708a8-75ce-4123-b354-3974e757f833	1499	1154	\N
20	Quae nemo cupiditate ratione tenetur consequuntur corrupti. Quos earum amet quis soluta necessitatibus nihil mollitia quibusdam. Labore vitae deleniti sapiente.	2022-12-31 15:16:45.562	PUBLISHED	0	0	\N	ec405305-7e74-416b-b640-90b202d88c32	1500	360	\N
14	Quos soluta quas beatae sequi vero quasi. Libero officiis nobis incidunt. Quas omnis harum officiis eos delectus. Amet illum libero qui saepe repellendus nulla omnis deserunt quaerat.	2023-04-29 23:33:18.329	PUBLISHED	0	0	\N	45e56c98-d56b-4ff2-89f3-dc7522fac6e0	1501	522	\N
23	Quia voluptatibus unde quia tempore consequatur aperiam consequuntur. Ratione velit necessitatibus quidem mollitia consequuntur voluptatem. Quo esse cupiditate minima quibusdam.	2023-09-29 15:15:06.211	PUBLISHED	0	0	\N	1269d98c-7a65-4e03-bb17-6a740b1cf96b	1502	916	\N
19	Hic aspernatur culpa. Accusamus molestias illo veritatis voluptate.	2023-11-19 08:29:14.295	PUBLISHED	0	0	\N	4280f465-7091-4ef4-a6bd-d1825b1ca246	1503	463	\N
16	Impedit assumenda atque ullam repellat ratione assumenda error. Nobis repellat iste consequuntur unde impedit laudantium soluta possimus explicabo. Saepe quam quibusdam doloremque tenetur. Eligendi earum esse. Est laboriosam iusto consectetur id adipisci reprehenderit ullam officiis voluptatum. Inventore eum provident eius non tempore aspernatur odio consectetur.	2023-11-11 17:13:27.02	PUBLISHED	0	0	\N	975d3a48-4fab-44cf-b786-9e35e3e0162b	1505	1208	\N
17	Itaque animi neque. Ipsam exercitationem ad eius praesentium laboriosam voluptas dolores. Dolorum reiciendis saepe consequatur reprehenderit esse. Dicta explicabo in sed excepturi ullam officiis porro rem.	2023-05-28 12:50:34.923	PUBLISHED	0	0	\N	b6b5c176-2e20-46f0-beea-67463d7d7289	1506	1217	\N
16	Dolorem ea corrupti quos unde vel beatae quo mollitia porro. Vel similique incidunt. Officiis deserunt dignissimos ullam nemo tempora.	2023-06-26 15:13:26.763	PUBLISHED	0	0	\N	0ae25db1-e371-499d-8d0d-6247a516e992	1507	1102	\N
20	Repellendus deserunt iusto doloremque maiores nesciunt. Id veniam unde ut soluta ipsa quas illo. Recusandae aspernatur voluptate animi architecto. Soluta eligendi accusamus consectetur.	2022-12-30 00:53:55.321	PUBLISHED	0	0	\N	4b81e912-424f-43d0-9df9-ef7649f16e08	1508	1173	\N
19	Debitis tempore repellendus libero vel maxime hic cumque in. Deleniti consequatur sequi veniam veniam. Laborum eos omnis nemo repudiandae minus mollitia debitis. Pariatur voluptate officia eos eius omnis mollitia vel quibusdam quod. Nulla natus officiis dignissimos illum tenetur. Libero aliquam assumenda sunt distinctio.	2023-07-24 01:26:23.252	PUBLISHED	0	0	\N	51321b0d-76c4-4c3e-ae7d-164b2e52b10a	1509	360	\N
14	Assumenda explicabo sit ipsum veritatis illo. Adipisci recusandae a architecto reprehenderit quia distinctio. Eligendi amet atque voluptatum.	2023-06-16 05:22:56.282	PUBLISHED	0	0	\N	d9ae5275-4be9-4c12-b2fc-d2dbd5ae7fe3	1510	1023	\N
20	In eum ipsam corrupti sapiente. Officiis quisquam quas et unde quas. Iusto nulla non deserunt sapiente iusto magnam suscipit voluptatibus odit. Odio saepe iste quos nulla dignissimos facilis consectetur est.	2023-05-05 06:03:24.784	PUBLISHED	0	0	\N	7ac40af0-eb0d-43c9-b4f0-388d45089639	1511	1464	\N
17	Consectetur dolor placeat ipsum ea vero eveniet. Voluptas sed inventore. Error quo consequatur distinctio dolores perferendis. Autem explicabo labore ab veniam ipsam ipsa. Optio suscipit ad. Tempore explicabo ad non sint iure quis.	2023-02-23 00:01:45.138	PUBLISHED	0	0	\N	aa0908c6-23c1-4313-837d-a625cff96a98	1512	630	\N
16	Deleniti libero alias voluptates sapiente labore veritatis amet non. Quasi dolorem blanditiis explicabo. Exercitationem inventore incidunt quis. Error facere earum inventore perspiciatis nisi.	2023-03-24 22:44:08.863	PUBLISHED	860058.8636222222	1	\N	bfdb70f9-6a6f-43e4-89bf-119a703437dd	338	\N	\N
22	Magnam veniam consectetur voluptatum occaecati. Officiis id perferendis fugiat tempore sint voluptatum ipsum. Doloribus eligendi in quae facilis asperiores ab alias quod. Sequi earum officiis eligendi rem dignissimos veritatis odio assumenda. Voluptates perferendis reprehenderit laboriosam odit laudantium et.	2023-04-16 22:11:54.87	PUBLISHED	0	0	\N	169f4c18-d6fb-48e0-b7ee-e8a8aabe806a	339	\N	\N
21	Laudantium dignissimos facilis illum sed deserunt amet eveniet ducimus ratione. Ullam debitis cupiditate minus nulla illo earum velit. Sapiente ea ratione aut amet adipisci officia.	2022-12-12 09:29:47.987	PUBLISHED	0	0	\N	3729113e-d941-4372-9950-d04eb63f478b	358	\N	\N
15	Nesciunt voluptatum recusandae cumque iusto nulla praesentium minima ratione nemo. Ad officiis totam ipsa amet esse.	2022-12-11 10:45:29.558	PUBLISHED	0	0	\N	c46b7ab3-e67b-4da7-9b4d-930fbb311763	1515	989	\N
19	Odit expedita error dolorum eligendi doloremque. Eum nobis odio dolores neque eligendi. Illo ex minima voluptatum quam suscipit delectus ipsam iusto voluptas. Illo doloremque saepe culpa sint aliquam doloribus et.	2023-05-13 06:40:21.02	PUBLISHED	0	0	\N	a63c8a1c-6362-4878-90f3-07a97fa5a2dd	1516	593	\N
14	Excepturi possimus aliquam distinctio fugiat iste nemo. Enim fuga necessitatibus consequatur voluptatum adipisci. Possimus maxime ducimus distinctio animi omnis laudantium.	2023-09-27 19:14:44.833	PUBLISHED	0	0	\N	09ea5cab-f965-4966-bd46-20b485c981b3	1517	1136	\N
20	Praesentium rerum laudantium vitae odio quaerat fugit. Tenetur beatae error accusantium impedit. Vitae laboriosam temporibus laboriosam delectus delectus amet quisquam laudantium. Explicabo voluptatum quisquam totam eveniet. Perspiciatis veniam excepturi facilis consequatur hic eligendi eum.	2023-08-21 07:37:57.68	PUBLISHED	0	0	\N	29c23520-66c7-47bd-849f-97824a3f96e4	1518	1184	\N
23	In eaque hic. Provident officiis ea tenetur esse nostrum assumenda. Suscipit reiciendis expedita similique quos porro.	2023-06-12 02:28:09.491	PUBLISHED	0	0	\N	de87ff4f-8fc4-4ffa-90d7-0c6285a9509f	1519	534	\N
14	Sint ipsum rerum recusandae facilis quia. Explicabo voluptas autem. Expedita enim ad sed. Nesciunt magnam dignissimos vero harum minima facilis quasi optio.	2023-09-19 07:23:10.288	PUBLISHED	0	0	\N	3fc94cfe-35ae-4f1c-95a3-fb521f6a9981	1520	792	\N
18	Fugiat ex pariatur aperiam veniam. Commodi eius iste saepe perspiciatis deleniti exercitationem atque. Ratione pariatur et repellat recusandae rem quisquam laboriosam. In possimus praesentium sed cupiditate totam unde maxime. Nemo recusandae doloremque harum ab ex dolorem numquam possimus sint.	2022-12-17 11:44:52.045	PUBLISHED	672939.8232222223	1	\N	e5cde576-2538-4276-b848-738c4e098597	1521	721	\N
19	Nesciunt praesentium placeat. Tempore expedita quas facere pariatur harum voluptatum porro blanditiis.	2023-08-15 05:25:23.362	PUBLISHED	0	0	\N	60e17e0e-36bd-4132-a13f-60f17b83bb54	1522	888	\N
16	Fugit aspernatur ipsum. Ipsam provident error iste eum. Hic deserunt hic. Harum voluptate accusantium cupiditate.	2023-03-14 11:22:18.896	PUBLISHED	0	0	\N	58b5e20e-b10d-467c-959e-5ff235abe29d	1523	488	\N
17	Eligendi officia quam et unde quidem possimus. Exercitationem error culpa reiciendis quas voluptas recusandae error reprehenderit dicta. Culpa assumenda fugiat est cum nemo dignissimos quos ipsa dolores. Omnis ducimus quibusdam incidunt similique rem quaerat.	2023-02-08 05:31:05.37	PUBLISHED	0	0	\N	3dedacba-5a6e-42c8-9587-d94ef2bf2276	1524	823	\N
23	Corrupti aliquam dolor excepturi reiciendis deleniti velit placeat sed. Aperiam similique aperiam quia repellendus. Facilis laudantium quod.	2023-05-09 22:24:08.264	PUBLISHED	0	0	\N	def47b9d-eb5b-4fdc-86a3-adad56dd6236	1525	732	\N
14	Nihil voluptatibus nisi animi excepturi molestiae illum. Suscipit occaecati velit. Architecto tempore saepe quasi numquam labore laborum quidem ex. Minima ullam corrupti corporis dignissimos eveniet tenetur maiores repellendus. Dolor qui reprehenderit dolore at.	2023-11-09 01:53:24.542	PUBLISHED	1299991.212044444	1	\N	4e6e3829-07cb-4b8a-8b30-54e331527eac	1526	1031	\N
21	Eos error unde beatae totam soluta quidem. Eum minima minus minus non rerum. Numquam assumenda fugit. Doloremque harum provident cupiditate. Debitis corporis beatae eaque. Beatae aut voluptatum vitae repudiandae itaque commodi corrupti.	2023-08-04 22:35:09.741	PUBLISHED	0	0	\N	b8308750-3ac4-4644-b1d1-6d38aad48846	1527	995	\N
20	Atque voluptates iure labore consectetur fugit sapiente expedita. Repellendus repellat debitis quasi. Deleniti nam ut.	2023-08-12 23:21:33.981	PUBLISHED	0	0	\N	53ff16db-6d72-4b32-b76d-805711a7a24c	1528	1346	\N
15	Cum ipsa aut dignissimos. Eius libero illum accusamus quisquam tempora quibusdam. Qui similique aut corrupti quo laborum aut cum corrupti explicabo. Aspernatur iure perspiciatis in quae recusandae. Delectus aperiam amet cumque voluptatibus tempora similique cum quaerat.	2023-02-04 05:34:47.859	PUBLISHED	0	0	\N	0210d5b7-d0e4-43c4-bc58-b47a3c2d8a85	1529	1177	\N
20	Facilis sed quae mollitia praesentium libero qui error maiores. Eius eaque quibusdam dolorum. Maiores id illo minus nemo magni. Adipisci architecto aut maxime ab esse aperiam ratione repellat. Natus doloremque non minus adipisci.	2023-05-02 12:48:08.876	PUBLISHED	0	0	\N	3b417375-f532-4974-95b7-efdbdb433748	1530	1106	\N
20	Accusantium aliquid minima sint. Nobis ut labore optio ullam asperiores sequi corporis reprehenderit fugiat.	2023-02-17 19:58:46.107	PUBLISHED	0	0	\N	5cfc4d0f-cead-4b73-80f2-056ae78d64e3	1531	1299	\N
22	Veritatis dolorem soluta tenetur iste explicabo nam. Atque libero velit. Facere optio delectus quis. Reiciendis harum aperiam quae excepturi nam illo ullam ea harum. Mollitia perspiciatis excepturi nobis quidem incidunt sapiente aspernatur ipsam perferendis. Error consequatur odio veniam id reiciendis.	2023-03-16 09:14:07.961	PUBLISHED	0	0	\N	248c5a07-0d01-4b47-91a2-ddef45b78abf	1532	1246	\N
14	Quia rerum omnis iusto quibusdam ratione eveniet natus reiciendis. Modi doloribus ipsum fuga necessitatibus. Doloribus corrupti iste repellat.	2022-12-08 05:21:39.224	PUBLISHED	0	0	\N	dcc717b6-9a97-494f-a753-f43b2897feca	1533	758	\N
16	Quis a culpa possimus impedit ducimus dolor cupiditate fugiat nulla. Repudiandae vel culpa temporibus.	2023-09-17 15:32:44.873	PUBLISHED	0	0	\N	ef46f509-d674-4503-981c-28ef14b18852	1534	678	\N
19	Quos excepturi rerum dolore odit assumenda ipsam. Aliquid voluptatibus cupiditate dignissimos recusandae distinctio delectus iusto. Delectus exercitationem ipsam fuga et.	2023-04-04 19:13:53.826	PUBLISHED	0	0	\N	e41e06a7-1632-490d-96e8-c6d01f6c5ae3	1535	786	\N
23	Debitis asperiores nemo. Voluptas ea consequatur. Culpa amet quos deserunt. Ipsam praesentium aut ex atque excepturi numquam deserunt laboriosam adipisci. Similique possimus nostrum dolores vel ea. Nobis fuga excepturi illum sapiente nisi.	2023-05-23 07:57:12.04	PUBLISHED	0	0	\N	4d660db3-4d57-4616-81c9-174daee26360	1536	935	\N
16	In quidem quisquam nesciunt quod quia necessitatibus mollitia ullam. Laboriosam nemo vel inventore esse occaecati. Nobis voluptate libero. Minus incidunt illum optio.	2022-12-26 00:32:52.891	PUBLISHED	0	0	\N	93bcd2d6-0ad1-4c2b-a2df-487a9a56b779	1537	1270	\N
21	Repellendus sunt recusandae perferendis veritatis inventore fuga quam cupiditate molestiae. Necessitatibus neque dolor quo delectus. Numquam perferendis quas tenetur consequatur et. Aut nobis vel illum soluta sed. Architecto libero repellat similique sequi nam sunt ullam quis voluptatem.	2023-05-25 07:13:40.185	PUBLISHED	0	0	\N	e0261957-7d21-4d6e-8f0a-2658e0193812	361	\N	\N
14	Officiis quaerat saepe sequi natus inventore assumenda corrupti delectus odio. Earum aperiam nihil commodi ullam assumenda ex. Fugiat neque nemo. At placeat nam sunt ratione magnam laborum. Voluptas eius incidunt architecto praesentium pariatur. Repellendus quia ducimus fuga soluta beatae iure vitae iure ullam.	2023-05-27 21:13:55.425	PUBLISHED	0	0	\N	1cbdccb2-feee-49cd-b501-2bda12df8bbf	384	\N	\N
14	Magnam exercitationem recusandae temporibus porro. Quas ducimus quaerat. Sapiente impedit necessitatibus voluptate nihil fugiat ut. Aliquam cupiditate rerum praesentium dolorum maxime dolorum doloremque exercitationem qui. Dolore consequuntur ipsam vel temporibus expedita inventore voluptates quos repudiandae.	2023-10-04 11:20:34.073	PUBLISHED	1231628.116991625	2	\N	8acadacd-5734-44da-811e-86e7191342b3	397	\N	\N
17	Laborum molestias labore. Dolorem hic ea praesentium voluptatem deserunt. Explicabo praesentium earum facere tempora sit. Optio recusandae repellat sed soluta recusandae in nulla rem dicta. In minus harum laborum doloribus nostrum et ipsam doloremque.	2023-03-22 11:37:58.269	PUBLISHED	0	0	\N	0d0491dd-d5d4-4e4b-b216-77434f7479e5	411	\N	\N
18	Ullam in ea sed. Adipisci laudantium ab facilis. Eveniet sequi dolore dolore ipsa inventore rerum maxime ipsam dicta. Numquam dolorem sequi ipsam temporibus aliquid quis eveniet dicta. Id eligendi tempore aliquid sed quod explicabo asperiores earum ipsam. Soluta iste quidem fugiat accusantium temporibus minima dolor corporis impedit.	2023-10-23 11:23:58.448	PUBLISHED	0	0	\N	41021340-0f6e-4932-bbfc-49594da8e25d	423	\N	\N
23	Ullam ex vel dolore excepturi doloribus vitae. Autem illum fugiat delectus quisquam quam at. Dolorum deleniti soluta iste quis. Laudantium aliquid modi.	2023-05-21 21:20:49.626	PUBLISHED	0	0	16	3e422acb-3e17-4c21-8f45-4fe6e4dec25c	438	\N	\N
22	Voluptas vitae doloremque laborum enim. Nemo provident magnam quam consequatur reiciendis beatae quibusdam fuga sapiente. Illum odio consequatur omnis quibusdam amet unde quos est nobis. Voluptates quas nisi vel placeat praesentium mollitia. Quidem id itaque animi eos autem voluptatem. Nulla quisquam distinctio.	2022-12-28 07:02:21.943	PUBLISHED	0	0	17	cb5863c2-0ca6-45f0-b87c-82046f317e6f	447	\N	\N
14	Quisquam doloremque suscipit iste quod voluptatum et minima in. Dolorem laboriosam voluptates quisquam dignissimos nemo ab accusamus natus sed. Voluptatum illo dolore dolorem vero quae. Cum beatae dolores nisi nobis. Ipsa distinctio optio labore. Pariatur atque eligendi adipisci exercitationem veritatis itaque suscipit saepe minus.	2023-11-17 21:42:26.501	PUBLISHED	0	0	25	d6bd3956-298c-482e-b484-879d3ff88bb4	463	\N	\N
14	Iusto iste repellat veritatis minima temporibus. Blanditiis dicta molestiae maiores possimus placeat veniam laboriosam. A voluptatibus commodi veniam consequatur aspernatur accusamus. Magni nam nesciunt corrupti exercitationem sit molestias iusto. Iusto dicta quasi pariatur debitis ipsa nobis id. Eaque sunt iste magni hic cum nobis.	2022-12-14 17:45:12.973	PUBLISHED	0	0	21	4e974c94-331e-4ab7-aac0-2d3b47390e23	486	\N	\N
21	Dolor rem provident consectetur beatae. Aliquid non soluta occaecati quo fugiat delectus asperiores sint id. Dolore aut necessitatibus illo itaque voluptate aperiam. Veniam alias voluptates fuga optio consequuntur blanditiis enim eum ab. Alias reprehenderit soluta debitis eos accusantium quo nihil recusandae. Voluptates inventore exercitationem numquam exercitationem tempore.	2023-10-04 16:51:35.321	PUBLISHED	0	0	20	86e1f3df-9881-4a64-807a-d9e2eeb45128	499	\N	\N
15	Eum eum doloribus autem soluta corporis. Accusamus facere rerum consequatur blanditiis natus quas distinctio temporibus. Iusto quas laudantium voluptatem neque deleniti culpa expedita consectetur. Tempore minus natus nihil assumenda. Unde esse repellat non eum enim voluptatem optio autem. Totam perferendis praesentium reiciendis repudiandae.	2023-11-11 16:30:10.977	PUBLISHED	0	0	18	73a2249b-d7b2-4158-8589-49963b4386f6	510	\N	\N
20	Perferendis magni quibusdam dolore quisquam totam blanditiis similique ducimus. Tempore accusantium neque quaerat. Autem maxime eligendi quasi pariatur consequatur nostrum consequatur tenetur iste. Totam ad qui incidunt incidunt. Quo ipsam ex dolor ducimus. Ea atque recusandae eos similique quibusdam fugiat laudantium numquam.	2023-02-23 05:54:43.415	PUBLISHED	0	0	21	3c8be68b-6578-466c-b4aa-8faaed4c257a	535	\N	\N
21	Aliquid ipsam soluta dolorum incidunt labore expedita ratione commodi ut. Explicabo quos non maiores dignissimos doloribus harum molestiae voluptatum. Assumenda qui molestiae ad ratione vero nulla aliquam maiores amet. Vero minima quae delectus provident labore. Earum aspernatur illum nobis voluptas sunt incidunt voluptates est reiciendis.	2023-10-10 15:46:15.807	PUBLISHED	0	0	\N	e29bdbbe-39bb-48f2-89f1-ec3bd278eeb7	547	418	\N
22	Distinctio eum harum consequatur nobis ipsam vitae hic ratione facere. Molestiae dolor hic id harum delectus neque vero. Vitae illum veniam vero reiciendis ducimus iste. Accusantium non nam sit commodi. Optio assumenda at quam doloremque facilis odio labore nulla. Recusandae iste accusantium nisi iure dolores incidunt facere expedita.	2022-12-14 00:15:13.85	PUBLISHED	0	0	\N	91e1dcde-549b-4c66-94d4-42adeab05641	560	425	\N
15	Officia adipisci corrupti culpa at nisi. Odio vitae amet temporibus quod porro tenetur veritatis. Facere praesentium ratione quia magni ducimus. Dolor incidunt quasi possimus quibusdam ut excepturi repellendus voluptas. In voluptates odio perferendis ullam iste qui voluptates reprehenderit non. Distinctio neque autem id iusto sequi placeat.	2023-03-07 10:20:41.378	PUBLISHED	0	0	\N	5735d8c9-28be-44b8-987e-5005cec9a38d	568	462	\N
23	Dolorem dicta qui culpa labore tempora temporibus sint quod. Deleniti dolore non. Amet sunt dolor sequi nihil quos a. Voluptatibus iusto incidunt sequi ea molestiae veniam commodi minus. Esse pariatur cum. Fuga fugit neque harum id minus vero cumque reprehenderit recusandae.	2023-05-07 07:28:29.85	PUBLISHED	0	0	\N	9441f962-8509-47c9-868f-a3fded4566e3	585	350	\N
22	Aspernatur quos nobis repellendus blanditiis asperiores aperiam beatae labore. Labore hic nam aspernatur magni officiis. Voluptatibus voluptates hic. Saepe est consequatur quaerat tempore reprehenderit reiciendis molestiae id eaque. Quo tenetur sequi nam dolorem. Assumenda optio velit fugit inventore perspiciatis corporis repellendus ut.	2023-04-29 14:48:48.301	PUBLISHED	0	0	\N	9047af9f-442d-4360-b753-bbce9a3e56d9	604	346	\N
15	Provident nobis odio alias vero omnis reprehenderit. Voluptatum omnis eos voluptatum molestiae. Illo cumque nesciunt nesciunt sapiente ad quae rem molestias officiis. Ea doloremque dignissimos est reiciendis officia.	2023-11-07 03:44:52.509	PUBLISHED	0	0	\N	4e4463f8-50c4-4e51-9042-b2ce99377053	614	425	\N
17	Tempora harum similique fuga occaecati nobis porro. Quas iure temporibus quaerat aspernatur. Doloribus consequatur officiis. Recusandae laborum aliquam odio nihil dicta. Magni at cumque quam possimus quisquam accusantium dolorem doloremque nihil.	2023-10-28 23:36:32.551	PUBLISHED	0	0	\N	1584a685-51ea-4c65-b3cf-4a78a862fc00	616	442	\N
19	Officiis harum debitis voluptas ratione quo numquam ratione perspiciatis ex. Adipisci voluptatem magni deserunt quos libero.	2023-11-08 02:34:48.14	PUBLISHED	0	0	\N	5fc659d2-e9ff-4edc-9b0b-8d316ccbaf96	643	518	\N
19	Culpa excepturi rem reprehenderit officia illo quas laborum odit. Illum sed iste praesentium. Eveniet eos suscipit quidem nostrum repudiandae asperiores facilis animi expedita.	2023-03-13 13:38:51.111	PUBLISHED	0	0	\N	744bd603-5b2f-4c5c-beaf-b73a18d055f1	644	401	\N
17	Laudantium quisquam impedit numquam placeat iusto debitis vel. Mollitia architecto officia nisi assumenda repudiandae expedita.	2023-09-05 08:03:12.331	PUBLISHED	0	0	\N	a18494b8-2426-46a0-854d-7b58ed8c9745	670	418	\N
22	Error facilis alias totam praesentium magnam mollitia eaque. Laboriosam assumenda autem distinctio aliquam iste ipsam ad provident. Accusamus consequatur ducimus laboriosam eveniet. Eligendi labore enim animi pariatur vitae aliquid impedit velit quos. Sunt esse nisi. Minus amet laboriosam repellendus commodi ipsa.	2023-06-26 16:58:39.969	PUBLISHED	0	0	\N	72854fb1-3987-4d8d-811e-ddc7bc2c9100	676	557	\N
22	Maiores nulla voluptas consequatur dolor quos impedit eos nulla. Accusamus nesciunt architecto delectus minus assumenda voluptatibus quas esse. Nisi repellendus cum. Aliquam modi quibusdam aliquam nisi aut vel. Tempore repellat consectetur assumenda voluptates dolorem sapiente laboriosam quibusdam.	2023-08-20 12:37:20.536	PUBLISHED	0	0	\N	16001732-d812-4ac9-a853-d84c36e13e92	696	357	\N
23	Nobis blanditiis neque cupiditate et occaecati aut labore fugiat. Delectus magnam debitis. Dicta eveniet blanditiis quos debitis eaque dolore minima incidunt error. Cum commodi consequatur labore ratione ratione earum ipsum omnis. Accusantium ipsa numquam quasi voluptatibus ab placeat quae. Esse laboriosam amet est distinctio voluptate culpa in nulla.	2023-01-06 03:27:43.383	PUBLISHED	0	0	\N	cc4b6f55-e61a-4820-a8f8-a100d20d8aca	705	438	\N
22	Dolorum vitae quisquam labore. Voluptatibus ullam est excepturi itaque placeat. Nulla illum consequuntur. Ratione reiciendis expedita at nesciunt at molestias perspiciatis minus nemo. Aut vel sit minima libero exercitationem ipsa.	2023-10-20 23:32:31.999	PUBLISHED	0	0	\N	80ab6c6a-21a9-433c-aab9-6a1fe2f350c1	721	701	\N
23	Ab quo quia esse eaque officiis cum ipsum. Adipisci at blanditiis earum illo. Distinctio eius ut commodi adipisci fuga facere. Illum nihil reprehenderit iure ad. Magnam officia quod error repellendus vero iusto a ex.	2023-04-02 05:04:41.124	PUBLISHED	0	0	\N	be4f8cb4-b8e7-4e96-873f-35d4fb79f411	750	427	\N
20	Occaecati ad dolores explicabo nobis laborum labore. Ducimus incidunt placeat delectus architecto est beatae numquam. Tempora inventore dignissimos blanditiis facilis ad. Hic iste adipisci praesentium corporis. Reprehenderit a odit adipisci quos.	2023-07-14 16:19:34.758	PUBLISHED	0	0	\N	4b941a54-af62-4cdb-acc3-e5be6f0a5e26	751	553	\N
14	Explicabo dolorem optio minima reprehenderit nam possimus nulla impedit consequatur. Quo magnam voluptates adipisci excepturi. A quaerat est itaque ipsam at. Nisi cum cupiditate fugiat aspernatur reiciendis eaque nostrum dolor. Ut nostrum quia repudiandae voluptatem.	2022-12-29 08:05:02.26	PUBLISHED	0	0	\N	47119c0e-57b6-4e1f-bd6b-c4ba7b64b503	778	391	\N
20	Tenetur dolore voluptatem nemo asperiores praesentium excepturi suscipit repudiandae enim. Voluptatibus ut tempora saepe corporis occaecati non illo eius iure. Aliquam laborum expedita laboriosam laboriosam aspernatur ullam. Corporis ex quos deleniti quos. Minus possimus fugiat molestias eos quod pariatur. Est placeat est consequatur facilis natus non totam a maiores.	2023-04-05 15:45:04.139	PUBLISHED	0	0	\N	2ea3f08e-00e7-4c9e-a4e2-3e9e70716f25	786	345	\N
18	Molestiae a perferendis recusandae impedit. Animi temporibus debitis. Odit reprehenderit ratione accusantium dignissimos necessitatibus consequatur sit magnam. Quibusdam blanditiis rerum earum architecto dolore. Quae sequi quia. Fugiat magnam aliquid.	2023-10-13 23:07:52.186	PUBLISHED	0	0	\N	9b9ea4f8-c907-4da3-9d21-f695cb2e9856	805	436	\N
16	Atque earum cumque eius libero iste eos ut illo. Nostrum perspiciatis natus quisquam modi. At neque quod accusantium minima a necessitatibus hic vero molestias. Eius suscipit tenetur laudantium omnis nostrum voluptatem quae quo. Saepe vero nulla consectetur ratione facilis vitae reiciendis omnis. Nobis mollitia ab ipsa.	2023-10-05 08:26:15.311	PUBLISHED	0	0	\N	f747f5b5-fbd9-42de-8dda-b082f3a4ddaf	811	477	\N
20	Autem provident maiores. Qui quos a voluptas ad. Molestiae sapiente amet perspiciatis alias incidunt sed reiciendis.	2023-10-01 00:49:51.037	PUBLISHED	0	0	\N	aa4fa98c-9f8e-45b4-bf36-08b63d647ee2	832	506	\N
23	Aperiam totam at. Molestias similique in atque dicta quod in sit consectetur nihil. Sed impedit consequatur voluptatum nihil nisi. Quod delectus soluta assumenda distinctio nobis reprehenderit voluptas autem. Asperiores autem laboriosam aperiam sapiente in architecto sequi.	2023-04-15 23:23:31.959	PUBLISHED	0	0	\N	776b98d6-bd43-466c-9723-55a83c92295c	835	809	\N
18	Error eveniet eligendi cupiditate in. Nostrum voluptas ex incidunt odit unde quas. A doloremque maiores saepe facere reiciendis vitae mollitia quaerat cumque. Nobis saepe eos omnis inventore ex rem reiciendis ut. Maxime magnam voluptate. Deserunt sit recusandae reiciendis eveniet.	2023-03-21 04:23:09.32	PUBLISHED	0	0	\N	2493ce94-1cc6-4c55-a3b4-e737d8f789ec	858	650	\N
16	Et dolorem sint laudantium possimus totam numquam. Illo eligendi ut quas nihil iste. Vitae accusamus assumenda asperiores consectetur eveniet. Inventore nostrum voluptate perspiciatis enim labore placeat mollitia tempore temporibus. Iusto officiis aspernatur.	2023-03-18 22:48:55.994	PUBLISHED	848545.2443111112	1	\N	c08e48dd-8117-45ec-bf5c-4389cc9f4507	875	522	\N
23	Delectus et ratione possimus ab autem quos hic sequi porro. Corrupti perferendis voluptate quas omnis distinctio inventore animi illum. Quas tenetur laboriosam sapiente id tempora rerum dolores mollitia maiores. Quos nisi minus voluptatem nostrum eos.	2023-03-07 22:26:47.429	PUBLISHED	0	0	\N	4373cd18-7cd9-477a-a944-3a533f3c20b1	887	720	\N
16	Fugit beatae beatae dolorum. Eaque pariatur corporis delectus molestias illum impedit ducimus. Autem aut voluptates illo voluptates aspernatur id adipisci nam harum. Dignissimos corporis numquam reiciendis sapiente odio. Tempora maiores nobis eos cumque earum accusantium. Voluptates reiciendis quia architecto veniam veritatis voluptate nulla.	2023-03-06 20:16:04.761	PUBLISHED	0	0	\N	d9997a2c-0215-4b36-a036-430bcfa4c18f	898	541	\N
15	Ipsum animi labore molestias dolor ex reprehenderit alias non. Iure ullam repellendus modi tempore. Incidunt suscipit praesentium error commodi quia eaque beatae similique quisquam. Eum ex et ab voluptatum natus unde.	2023-09-04 19:54:02.637	PUBLISHED	0	0	\N	d444ca03-5830-4633-9fee-4bd84f78115d	914	793	\N
16	Sunt ad optio rem molestias totam ratione et eum ex. Vero accusantium saepe nam consequatur totam. Exercitationem eligendi tempore eum fugit hic aliquid dicta laborum. Rem perferendis recusandae. Reprehenderit soluta est beatae cum nesciunt aut delectus ratione explicabo. Inventore aliquam enim enim dolores ea aut.	2023-03-01 10:10:21.372	PUBLISHED	0	0	\N	4b002e44-fee4-4dd2-9e3c-b3c68bd69e5d	939	415	\N
19	Tenetur voluptatibus ad ullam. A aut voluptatibus dignissimos. Laboriosam architecto in.	2023-06-13 00:27:45.099	PUBLISHED	0	0	\N	4c179231-9b23-4948-a994-d8f247d3a801	943	578	\N
16	Unde ipsum quibusdam. Adipisci fugit corrupti eos. Id explicabo omnis pariatur velit ipsa. Ad in minima quod soluta dolorem. Repellat quam sit praesentium tenetur quis maxime voluptatum aperiam totam.	2023-07-13 13:01:16.344	PUBLISHED	0	0	\N	a7fed783-4598-4bbd-b6eb-da63590ff59a	944	816	\N
20	Ad numquam eum. Quod maiores voluptates nobis quae aliquid ab nisi nisi. Commodi id repellat expedita saepe eveniet dolorum nisi rerum minus.	2023-11-10 09:02:24.638	PUBLISHED	0	0	\N	15c87c27-20b3-4c66-9653-495c1a90d857	970	471	\N
22	Rerum natus laborum velit voluptatibus amet laboriosam veritatis. Voluptate sunt eum modi illum. Numquam aut laboriosam rem iure culpa. Quod tempora iusto doloremque qui unde odio numquam. Ipsam cumque reprehenderit quae dolorem quibusdam velit sunt nobis repudiandae.	2023-05-22 19:42:01.981	PUBLISHED	0	0	\N	3fdb9a97-64aa-4a3f-bf3d-e379e5d08620	972	856	\N
14	Incidunt repudiandae aperiam error sequi laborum reprehenderit officiis debitis. Aliquam ullam error delectus officiis. Tempore repellendus ex vero repellendus nesciunt esse. Iure veritatis nam dignissimos. Asperiores itaque iste cum occaecati.	2023-02-10 01:32:21.95	PUBLISHED	777723.1544444445	1	\N	573e45b1-254a-4be2-abae-6daadf8efbb7	995	892	\N
22	Et corporis possimus occaecati quis velit porro adipisci occaecati. Odio velit quo dignissimos accusantium quaerat. Sed voluptatem accusantium eveniet sed maiores nisi eaque laborum. Pariatur praesentium dignissimos molestiae. Nihil amet esse. Mollitia porro praesentium.	2023-08-30 22:00:13.007	PUBLISHED	0	0	\N	0cfbcf42-77e7-45d9-9268-53e6b91492e3	1017	828	\N
23	Aspernatur doloremque cum pariatur dolorum dicta totam quidem. Sapiente velit at sint eveniet porro nihil. Excepturi fugiat amet quia ipsum ipsa beatae. Cum dolores placeat minus fugit aut tempore. At voluptas labore sunt mollitia porro explicabo.	2023-06-19 17:40:09.308	PUBLISHED	0	0	\N	ebd9268e-0d7a-4771-a83b-dd61f19ea507	1023	782	\N
23	Facere consequatur recusandae molestiae labore tempora laudantium aliquid. Id aliquid facilis debitis culpa. Non harum vel fugiat. Vitae animi ex dignissimos ab numquam earum. Pariatur quam at culpa fuga sit molestiae perspiciatis pariatur veritatis. Molestiae impedit exercitationem aliquam voluptatem molestiae porro dicta iure.	2023-09-12 23:32:33.336	PUBLISHED	0	0	\N	d6d313a8-804d-48c7-a174-7ff27e9f7aa9	1025	734	\N
17	Magnam quidem nihil sunt asperiores velit. Tempora suscipit assumenda. Rem at labore voluptates. Voluptatem temporibus animi.	2023-10-28 11:14:24.521	PUBLISHED	0	0	\N	f1a1945c-1f8c-4240-855b-4efa0e998893	1051	696	\N
22	Quia similique dolorem. Unde voluptatem quam dolores tempora in animi officiis ipsam. Labore porro consequatur commodi quasi quis occaecati quos voluptatibus quas. Omnis ad minus. Delectus nisi repellendus voluptatibus provident dolorem aliquam laudantium saepe inventore. Tempora blanditiis rem voluptatum culpa mollitia culpa doloribus.	2023-04-02 20:04:30.863	PUBLISHED	0	0	\N	e62b3092-4a95-46a9-baa4-6cea2296290d	1052	705	\N
18	Sint quasi quis sequi eum voluptatibus. Maiores dicta adipisci esse tempore totam repellat.	2023-08-01 22:22:45.552	PUBLISHED	0	0	\N	a6fc5957-996a-4969-ae1c-d6eddcd9c766	1078	922	\N
19	Maiores temporibus quae excepturi quo facere veritatis voluptatum. Aliquid esse quisquam nesciunt fugit minima laudantium autem. Quasi qui aliquam accusantium. Illum omnis soluta totam unde odit. Et quos ipsum aspernatur repellat fuga hic temporibus fugiat. Aut accusamus temporibus quas cum architecto aspernatur.	2023-09-27 10:14:43.166	PUBLISHED	1218099.625911111	1	\N	a26dd6ce-4fec-47c0-8daf-c2ed49517cad	1082	424	\N
16	Rem perferendis facilis laboriosam iste enim. Deserunt quae animi quis harum fugit. Molestias quo a unde fugit odio adipisci. Blanditiis dicta quibusdam impedit sed praesentium asperiores totam. Nisi tempore mollitia laudantium repellendus magnam voluptates. Nulla nesciunt velit expedita eos alias itaque esse.	2023-03-18 08:22:52.868	PUBLISHED	0	0	\N	7085d52c-30f7-4bd6-b779-942540bb6a67	1106	662	\N
14	Error ducimus veritatis. Est quo debitis debitis ipsam ea perferendis. Dolorum perferendis commodi tenetur blanditiis eos inventore. Ipsum perferendis voluptatum ullam odit architecto nulla. Eos deleniti nostrum a. Id magnam voluptatem voluptas facilis nesciunt inventore accusantium illo.	2023-07-16 11:00:15.907	PUBLISHED	0	0	\N	c3fc4b2c-441d-4409-8ba4-d9bde55a30ba	1112	903	\N
16	Inventore perspiciatis eaque quo odio praesentium iusto. Maiores aperiam nostrum. Explicabo ea ipsum repudiandae. Voluptatum deleniti quo pariatur recusandae pariatur nam officia cumque. Suscipit soluta laudantium corrupti quam distinctio modi. Soluta repellat eligendi itaque aliquam earum aliquam nemo.	2023-04-15 20:27:13.679	PUBLISHED	0	0	\N	7c0ac388-3b21-4902-b43f-99255183e220	1131	942	\N
16	Corrupti consectetur facere animi asperiores voluptatibus. Earum cum inventore dolor placeat voluptatum consequatur dolores. Quis perspiciatis odio ratione ipsa vel sit eligendi doloremque id. Ea perspiciatis suscipit necessitatibus voluptatum dolore eos eligendi. Itaque excepturi asperiores excepturi minus ratione corporis pariatur perspiciatis. Aut ratione rerum maiores hic.	2023-09-25 18:36:59.953	PUBLISHED	0	0	\N	97d268fd-6165-4f47-8216-b052af742552	1144	966	\N
22	Ab veniam voluptatem distinctio qui ab officia eaque eius. A facere similique enim magni doloribus. Possimus eligendi quidem officia in ad est a quasi perferendis. Beatae tenetur maiores. Dolore quod assumenda quam. Aspernatur fugit optio corporis quidem vero animi sint eos ipsa.	2023-01-25 05:55:02.552	PUBLISHED	0	0	\N	ce1979c0-aa2c-45dc-815f-0a8a2eb0cf05	1155	845	\N
14	Deleniti alias corrupti vero dicta. Ex libero deserunt consequuntur impedit doloremque ipsam iste ex. Maiores dignissimos distinctio aspernatur dignissimos excepturi facilis beatae culpa officia. Inventore temporibus ad est cum modi voluptas labore officiis. Sunt quas totam labore perspiciatis beatae possimus. Eaque fugiat molestiae ipsum quia.	2023-04-24 00:52:42.464	PUBLISHED	0	0	\N	2b95ac51-0fb4-4342-845f-531668ca2911	1173	717	\N
14	Officia praesentium veniam impedit hic repudiandae odio facere deleniti. Molestias quisquam molestias fuga natus commodi aliquam. Nam adipisci minima eum ipsa aperiam voluptatum. Voluptatum suscipit iste iure nihil quae consequuntur ipsa consequatur.	2023-01-24 15:12:58.681	PUBLISHED	0	0	\N	a6bbcb5f-15a1-4bd7-8b1d-aae9666a224d	1182	563	\N
16	Quo officia commodi asperiores corporis dolore natus corporis accusantium. Aperiam sapiente corrupti. Asperiores eius dicta deleniti magnam nostrum facere culpa libero impedit. Quia dolor laborum dolorem sequi est culpa. Doloribus corrupti laudantium sit libero animi doloremque. Expedita accusamus deleniti quia voluptatibus adipisci expedita nihil laboriosam consectetur.	2023-02-04 20:52:30.486	PUBLISHED	0	0	\N	8077ac13-97f7-40fd-bd7e-977f8b4fc53a	1186	1026	\N
18	Quod quidem alias aliquam. Doloribus labore explicabo sed eligendi. Nisi placeat laborum totam accusamus asperiores tempore excepturi in praesentium.	2023-05-14 19:48:31.149	PUBLISHED	957744.6922	1	\N	3a0e1fad-e11e-48f0-84cb-b35ff4afa76a	1213	588	\N
21	Culpa doloribus nam. Esse sint ipsum ab qui necessitatibus possimus. Hic error tempore. Nostrum facere provident culpa provident fuga. Laudantium at consectetur tenetur accusantium nesciunt quo inventore aperiam veritatis. Dolores fuga in nobis iure error quis possimus reprehenderit.	2023-04-10 20:51:52.002	PUBLISHED	0	0	\N	7e6e3b2d-d103-4209-82cd-e00ed0b185cf	1219	818	\N
16	Ut rem id magni accusamus eaque reiciendis odit repellat. Eligendi quis voluptatem. Ea neque voluptates aut labore. Asperiores adipisci officia. Officiis non soluta accusamus nostrum incidunt dolorem tempore iusto accusamus. Eum incidunt adipisci ipsam ducimus.	2023-01-24 12:48:18.078	PUBLISHED	0	0	\N	78c57d52-d87a-4488-9b3f-08d07f492a30	1243	841	\N
18	Quidem amet quaerat vitae error saepe magni ratione temporibus doloribus. Hic expedita sequi debitis saepe quibusdam impedit. Quaerat necessitatibus soluta cum quae at voluptas nisi. Quidem mollitia deserunt error aut repudiandae molestias officia. Praesentium accusantium mollitia pariatur. Officiis debitis laboriosam maxime aut deleniti eaque omnis.	2023-06-22 10:26:15.166	PUBLISHED	0	0	\N	1bae2da6-08a1-49f8-b8d8-895bbaabe0c0	1255	805	\N
16	Reprehenderit magni vero natus id corrupti. Laborum necessitatibus expedita.	2023-09-05 01:46:36.82	PUBLISHED	0	0	\N	659fc76f-6398-4a35-8f60-67543279eee8	1268	415	\N
22	Voluptatem harum unde eaque. Quam laboriosam illo. Aperiam odio necessitatibus amet quidem dignissimos nihil quia. Saepe debitis quis. At qui similique atque animi enim et eligendi consequuntur. Impedit eos alias architecto itaque quas commodi et atque.	2023-09-28 08:40:51.638	PUBLISHED	0	0	\N	65ac9b69-af9b-4555-85a9-265e8fa80ebb	1270	532	\N
22	Perferendis vero doloremque fugiat accusamus dolorum at. Facilis nam sed mollitia. Tempore possimus quos dolore quia pariatur. Voluptates atque voluptatem iure reprehenderit dolor.	2023-04-16 03:55:40.617	PUBLISHED	0	0	\N	be36df96-3147-4969-8b22-418d92d6b798	1295	1287	\N
22	Voluptate amet veritatis est unde veniam aliquid dolorem laboriosam. Autem pariatur natus ratione iste nemo similique reiciendis fugit. Fugiat magnam hic accusamus mollitia molestiae quod sit. Nulla consequuntur occaecati tempora nam eligendi nesciunt.	2023-05-20 15:16:18.058	PUBLISHED	0	0	\N	c43c00e4-82a5-42e1-8cdf-94e3f874f5b7	1296	879	\N
18	Id reprehenderit maxime repellendus. Enim soluta assumenda maiores. Adipisci itaque aperiam temporibus praesentium ab eius ut.	2023-07-06 16:57:01.746	PUBLISHED	0	0	\N	c4f6f410-6080-4ef6-a5ae-4be36c3abdd8	1323	1277	\N
20	Deserunt eos minus quae eius labore commodi minima nisi. Quae natus distinctio modi dignissimos soluta vero. Accusantium officia ad ratione. Voluptatum alias neque sapiente. Qui reprehenderit in. Reiciendis eveniet magni non laudantium.	2023-01-17 11:25:30.483	PUBLISHED	0	0	\N	63a9ea3d-2847-4031-b359-3179bd7cddbd	1324	782	\N
18	Mollitia minima architecto veniam voluptatibus et veritatis recusandae deserunt voluptas. Sunt iusto eius ea illum. Nulla sit eaque. Quidem animi similique eos hic distinctio commodi vero nostrum a. Nostrum impedit blanditiis beatae. Expedita itaque pariatur aut quas libero nihil quas autem.	2023-01-05 14:09:29.261	PUBLISHED	0	0	\N	f55f80ae-ae3b-4058-80ef-1b2960080f99	1351	410	\N
19	Dolores minus sint sit vero sequi aspernatur. Eius quam officiis et quaerat fuga vero velit earum. Placeat atque labore repudiandae ratione quia maiores laudantium. Occaecati quibusdam illum atque. Provident dolorum delectus accusamus cumque deleniti libero. A velit voluptatem modi vero beatae.	2023-01-07 04:28:59.812	PUBLISHED	0	0	\N	d36d37bb-bd31-4b00-b842-b0afd8e925b1	1379	1147	\N
19	Quisquam nihil ratione aspernatur veritatis voluptatem. Aperiam unde doloribus quidem quam sapiente. Tempore atque et corrupti ab. Tempore harum aspernatur omnis saepe cumque maiores. Ex vitae debitis corrupti perferendis quas exercitationem soluta consequatur reprehenderit.	2023-05-14 10:51:34.463	PUBLISHED	957028.7658444444	1	\N	3fd2d3fe-57bf-4f3d-9cbb-4570c50a6b9a	1391	1322	\N
22	Sit natus eveniet placeat. Ipsam officia illo. Corrupti qui aliquid earum. Molestias asperiores a fugit tenetur minima fuga iste esse.	2023-10-28 20:55:54.827	PUBLISHED	0	0	\N	dca44338-1569-427b-89e5-04356cfa10c5	1404	458	\N
17	A soluta sapiente. Officiis dignissimos blanditiis facilis excepturi. Vel sed sapiente. Maiores occaecati molestias atque voluptatum alias ex dolorem expedita impedit. Optio deserunt sapiente dicta voluptate exercitationem. Unde enim optio quos placeat porro quisquam.	2023-03-21 08:57:36.175	PUBLISHED	0	0	\N	ccc08300-641e-4db5-8f46-4e5ff153dd0b	1405	667	\N
20	Quae quia non sequi est saepe earum distinctio fugit aperiam. Sunt nam fuga incidunt eos vitae. Tenetur animi ducimus eius provident. At numquam eius cumque. Quasi repudiandae earum dolorum similique illo totam.	2023-09-23 01:52:40.739	PUBLISHED	0	0	\N	865f9010-d9c5-40c4-8629-17cd7e54b412	1432	356	\N
14	Temporibus repellat tempora consequatur veniam consequuntur. Ipsum magni consequuntur dolor molestiae soluta voluptate nesciunt alias dolores. Modi aspernatur similique amet. Eaque reiciendis sunt nulla consequuntur deleniti id. Et odio laboriosam.	2023-05-24 17:04:48.871	PUBLISHED	0	0	\N	ed87db38-7783-4e58-ac37-052f9b21d2b3	1436	925	\N
20	Ea quos quam maiores reiciendis doloremque id vero deleniti optio. Autem eveniet est neque aliquid excepturi officiis.	2023-03-29 04:53:18.021	PUBLISHED	0	0	\N	443a0eba-1b06-4ac1-87f8-eedbe7838c5e	1458	982	\N
21	Voluptas fugit modi beatae modi occaecati quod. Laudantium saepe aspernatur impedit culpa amet vel eaque. Alias placeat facere ipsum aliquid deleniti incidunt est enim fugit. Libero eum possimus consequatur sit incidunt cum. Ab quaerat consectetur eligendi similique recusandae quo perferendis animi. Numquam a ea labore eius.	2023-03-16 04:13:49.938	PUBLISHED	0	0	\N	9b1722d7-7f64-415d-9a8e-52bc7020a76f	1461	1316	\N
23	Deleniti corrupti aliquam voluptas perspiciatis fugit esse sed molestiae et. Aspernatur laboriosam dolorem dolore laborum impedit dolores quas laudantium asperiores.	2023-01-15 16:47:52.293	PUBLISHED	729023.8287333334	1	\N	5fa6e087-3558-4156-94d9-3ad1b3827593	1484	635	\N
20	Fuga tempore assumenda labore ad doloremque error illo. Commodi soluta eaque sapiente placeat ratione ad atque quo corrupti. Sint voluptatum quam occaecati magnam dolorem ullam amet at. Aspernatur repellendus illo similique inventore ducimus facere vitae.	2023-07-30 05:27:03.879	PUBLISHED	0	0	\N	e347c38d-ce0d-46df-8568-7918c3d36e2e	1504	686	\N
22	Quam ipsum veniam esse rem ad pariatur. Fugiat expedita illum soluta numquam animi nam sint facilis. Ad unde porro minus error animi. Fugit tempora iure dolores ea officiis veritatis magnam ad perferendis.	2023-11-14 15:31:52.031	PUBLISHED	0	0	\N	930c059c-302c-4b88-af6b-ff2d38538cbd	1514	1314	\N
\.


--
-- Data for Name: PostAward; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostAward" (id, "userId", "coinId", private, "createdAt", "postId") FROM stdin;
1	6	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	f	2023-11-27 21:15:25.465	13
2	6	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	f	2023-11-27 21:15:25.465	13
3	6	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	f	2023-11-27 21:15:25.465	13
4	6	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	f	2023-11-27 21:15:25.465	13
5	6	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	f	2023-11-27 21:15:25.465	13
6	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2023-11-27 21:15:25.465	13
7	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2023-11-27 21:15:25.465	13
8	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2023-11-27 21:15:25.465	13
9	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2023-11-27 21:15:25.465	13
10	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2023-11-27 21:15:25.465	13
11	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2023-11-27 21:15:25.465	13
12	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2023-11-27 21:15:25.465	13
13	6	price_1MarsIDS6lFTllE6SnBpfVkO	f	2023-11-27 21:15:25.465	13
14	6	price_1MarsIDS6lFTllE6SnBpfVkO	f	2023-11-27 21:15:25.465	13
15	6	price_1MLvQ8DS6lFTllE6BCNkQkSh	f	2023-11-27 21:15:25.465	13
\.


--
-- Data for Name: PostEditHistory; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostEditHistory" (id, content, "createdAt", "postId") FROM stdin;
\.


--
-- Data for Name: PostFactiii; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostFactiii" (id, "createdAt", anonymous, status, data, "factiiiId", "userId", "postId") FROM stdin;
1	2023-11-27 21:15:25.017	f	APPROVED	https://en.wikipedia.org/wiki/History	19	2	1
2	2023-11-27 21:15:25.322	f	APPROVED	\N	20	2	2
3	2023-11-27 21:15:25.322	f	APPROVED	\N	4	2	2
4	2023-11-27 21:15:25.327	f	APPROVED	\N	20	2	3
5	2023-11-27 21:15:25.327	f	APPROVED	\N	19	2	3
6	2023-11-27 21:15:25.334	f	APPROVED	\N	20	2	4
7	2023-11-27 21:15:25.334	f	APPROVED	\N	21	2	4
8	2023-11-27 21:15:25.34	f	APPROVED	\N	20	2	5
9	2023-11-27 21:15:25.34	f	APPROVED	\N	33	2	5
10	2023-11-27 21:15:25.345	f	APPROVED	\N	34	2	6
11	2023-11-27 21:15:25.35	f	APPROVED	\N	3	2	7
12	2023-11-27 21:15:25.43	f	APPROVED	\N	39	6	11
13	2023-11-27 21:15:25.43	f	APPROVED	\N	40	6	11
14	2023-11-27 21:15:25.436	f	APPROVED	\N	39	6	12
15	2023-11-27 21:15:25.436	f	APPROVED	\N	40	6	12
16	2023-11-27 21:15:25.515	f	APPROVED	\N	6	6	18
\.


--
-- Data for Name: PostOpenAILanguageSetting; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostOpenAILanguageSetting" (id, "chosenMaxTokens", temperature, n, "modelId", "postId") FROM stdin;
\.


--
-- Data for Name: PostUpload; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostUpload" (id, "uploadId", "sharedAt", "postId") FROM stdin;
1	70dbac73-d2fd-40c5-8c39-869a02f7e65c	2023-11-27 21:15:25.465	13
2	ad36c2ed-192d-44b4-b296-f1828c61b608	2023-11-27 21:15:25.465	13
3	aa507be9-76c5-4720-9e40-71c6a06ef1fe	2023-11-27 21:15:25.465	13
4	f9581c3c-07ca-4e25-8ffe-08ab296e6048	2023-11-27 21:15:25.465	13
5	c48c6b89-fdf3-4039-95eb-2e3050fda4f1	2023-11-27 21:15:25.465	13
6	0d748291-5723-4e54-aaed-a2ce0a743b91	2023-11-27 21:15:25.465	13
7	70dbac73-d2fd-40c5-8c39-869a02f7e65c	2023-11-27 21:15:25.496	14
8	ad36c2ed-192d-44b4-b296-f1828c61b608	2023-11-27 21:15:25.501	15
9	aa507be9-76c5-4720-9e40-71c6a06ef1fe	2023-11-27 21:15:25.506	16
10	d3530984-b326-4110-9997-52506e254f5d	2023-11-27 21:15:25.511	17
11	8192d70a-aedd-43d2-9da7-287b22e6f83d	2023-11-27 21:15:25.515	18
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Product" (id, active, "createdAt", "updatedAt", "saleTitle", price, type, "appStoreProductId", "playStoreProductId", "spaceId", "originalDisplayPrice") FROM stdin;
price_1MeotEDS6lFTllE61URh48EH	t	2023-11-27 21:15:25.162	2023-11-27 21:15:25.162	1 Month Premium + 200 Coins 20% off	800	MONTHLY_SUBSCRIPTION	\N	\N	4	\N
price_1MGu0TDS6lFTllE6BqybwcsE	t	2023-11-27 21:15:25.182	2023-11-27 21:15:25.182	Premium for Life %50 off + 2,000 Coins	10000	LIFETIME_PREMIUM	\N	\N	4	\N
price_1MMEzsDS6lFTllE6GjjrtD9W	f	2023-11-27 21:15:25.187	2023-11-27 21:15:25.187	Premium for Life %25 off + 3,000 Coins	15000	LIFETIME_PREMIUM	\N	\N	4	\N
price_1MMF3RDS6lFTllE6cgK0xec7	f	2023-11-27 21:15:25.193	2023-11-27 21:15:25.193	Premium for Life + 4,000 Coins	20000	LIFETIME_PREMIUM	\N	\N	4	\N
eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	t	2023-11-27 21:15:25.199	2023-11-27 21:15:25.199	10 Coins = 1 Bronze token	10	COIN	\N	\N	1	\N
price_1MGu3qDS6lFTllE6h6YgMmQl	t	2023-11-27 21:15:25.206	2023-11-27 21:15:25.206	Silver Package gets 200 Coins and 7 days of premium	200	COIN	\N	\N	1	\N
price_1MartCDS6lFTllE6fFgyZvxI	t	2023-11-27 21:15:25.214	2023-11-27 21:15:25.214	Gold Package gets 1,000 Coins and 31 days of premium for 5% off	950	COIN	\N	\N	1	\N
price_1MarsIDS6lFTllE6SnBpfVkO	t	2023-11-27 21:15:25.221	2023-11-27 21:15:25.221	Platinum package gets 5,000 Coins and 183 days of premium for 10% off	4500	COIN	\N	\N	1	\N
price_1MLvQ8DS6lFTllE6BCNkQkSh	t	2023-11-27 21:15:25.226	2023-11-27 21:15:25.226	Diamond Package gets 25,000 Coins and 2 years of premium for 15% off	21250	COIN	\N	\N	1	\N
donation	t	2023-11-27 21:15:25.538	2023-11-27 21:15:25.538	Donation to Factiii	0	DONATION	\N	\N	1	\N
\.


--
-- Data for Name: ReadMessage; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."ReadMessage" (id, "createdAt", "messageId", "conversationId", "userId") FROM stdin;
\.


--
-- Data for Name: Report; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Report" (id, type, "ruleId", comment, status, "reportedUploadId", "reportedBio", "conversationId", public, "createdAt", "updatedAt", "userId", "actionTakenById", "reportedPostId") FROM stdin;
3bd14ac0-35f0-467a-9260-c780887ed22e	POST	1	this post is garbage	CONTENT_REMOVED	\N	\N	\N	f	2023-11-27 21:15:25.386	2023-11-27 21:15:25.386	2	\N	8
805dd383-eff4-4eaf-8e35-540b3ca7f36e	POST	25	\N	PENDING	\N	\N	\N	f	2022-12-31 16:12:25.398	2023-11-27 21:19:55.385	17	\N	594
010da7a0-0d88-4691-b7a2-54800ccbb955	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-21 12:43:30.514	2023-11-27 21:19:55.389	20	\N	931
3f2e4a15-a95b-4090-b1d6-bf77b6fe640c	POST	8	\N	PENDING	\N	\N	\N	f	2023-10-23 21:42:43.1	2023-11-27 21:19:55.391	18	\N	1362
a6f46442-5105-4c3e-bc41-4068ac31ed57	POST	33	\N	PENDING	\N	\N	\N	f	2023-08-10 11:42:19.3	2023-11-27 21:19:55.393	21	\N	1081
0fad1bdb-0909-475b-a1cc-4fc6cbac1e88	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-09 16:43:16.183	2023-11-27 21:19:55.395	21	\N	1038
8609727f-a2b7-4044-bf7f-45cc897164d4	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-16 18:39:47.632	2023-11-27 21:19:55.396	19	\N	1313
5dc47a6e-9174-45d7-ba3b-99958ba0fda2	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-05-09 21:29:18.241	2023-11-27 21:19:55.398	15	\N	420
31dea339-131f-4740-b788-d82cfefbe9db	POST	10	\N	PENDING	\N	\N	\N	f	2023-03-08 04:29:52.387	2023-11-27 21:19:55.4	23	\N	865
b108153f-9b26-4fce-9b7d-7b51c95f3d55	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-06-05 22:08:36.415	2023-11-27 21:19:55.401	14	\N	692
463a3669-5bc6-4fd8-abd6-07101cc3d091	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-28 09:59:13.479	2023-11-27 21:19:55.403	17	\N	871
f33201cf-5752-4b0b-bdb1-38498801338c	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-04 03:47:44.707	2023-11-27 21:19:55.405	23	\N	1272
a0ecf750-51ce-4abc-b128-6ec7370c4843	POST	38	\N	PENDING	\N	\N	\N	f	2023-08-16 22:42:02.034	2023-11-27 21:19:55.406	20	\N	1407
1cb5f700-e218-4fa3-800f-e080c4dee117	POST	45	\N	PENDING	\N	\N	\N	f	2022-11-29 12:19:21.166	2023-11-27 21:19:55.408	23	\N	772
ad9ded48-b228-4842-8f1b-0beabce4e2f5	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-09-26 10:01:22.289	2023-11-27 21:19:55.41	18	\N	1212
41f8913c-410c-41a4-88c5-c7c93578cb61	POST	43	\N	PENDING	\N	\N	\N	f	2023-03-09 16:11:17.916	2023-11-27 21:19:55.411	19	\N	838
dea6f059-566e-46fc-892d-bcad5c9b2548	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-06-17 15:30:15.228	2023-11-27 21:19:55.413	23	\N	1237
00110047-ee52-43d2-b042-fc1871ffdaa3	POST	59	\N	DISCARDED	\N	\N	\N	f	2022-12-20 17:48:28.65	2023-11-27 21:19:55.415	21	\N	489
8fa8d012-bdfa-46e2-af19-7fbfc5e6a94f	POST	11	\N	PENDING	\N	\N	\N	f	2023-10-22 23:53:26.273	2023-11-27 21:19:55.416	14	\N	1435
3606a47d-b656-4d73-8786-32dad34f029a	POST	48	\N	PENDING	\N	\N	\N	f	2022-12-01 03:26:41.946	2023-11-27 21:19:55.418	14	\N	448
2d2ce40f-03b0-4612-acfc-6d63f205d3c1	POST	46	\N	PENDING	\N	\N	\N	f	2023-04-20 19:36:12.817	2023-11-27 21:19:55.42	14	\N	1435
4e945e32-da22-42cc-92b7-3c787b08c8c0	POST	47	\N	PENDING	\N	\N	\N	f	2023-05-27 04:37:08.329	2023-11-27 21:19:55.421	20	\N	800
38e7c2a7-a3ba-4402-8da8-6c215e7bf85d	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-21 02:44:19.847	2023-11-27 21:19:55.423	20	\N	748
2d52f19e-cda3-4494-8cc6-d4fe256ab0e3	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-02-21 00:22:25.655	2023-11-27 21:19:55.424	21	\N	1324
7f8f7e1d-4de0-4b06-9a84-227c42aef4c2	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-03-14 03:04:45.5	2023-11-27 21:19:55.426	18	\N	1471
568db273-9d80-42a1-8050-473169037068	POST	28	\N	PENDING	\N	\N	\N	f	2023-08-23 15:03:34.14	2023-11-27 21:19:55.428	22	\N	1004
c5d80089-1807-4803-ab4b-4e9eb233be17	POST	2	\N	DISCARDED	\N	\N	\N	f	2023-04-19 17:27:07.579	2023-11-27 21:19:55.43	15	\N	1218
9b60103a-89bb-4b58-a40f-c9a82876c824	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-21 20:24:31.777	2023-11-27 21:19:55.432	22	\N	1007
34ae7d61-c704-4a38-b0df-8c73c2239789	POST	59	\N	PENDING	\N	\N	\N	f	2023-03-14 10:40:01.985	2023-11-27 21:19:55.434	16	\N	1092
29b92021-dcee-4cae-96a7-b37012d187c6	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-30 14:59:04.677	2023-11-27 21:19:55.436	15	\N	1473
08e675ec-9197-4d24-ab11-049ec1dd8838	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-11-19 19:58:48.41	2023-11-27 21:19:55.438	14	\N	347
7cb51dad-11e5-4caa-a4e3-314947c194a7	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-09-11 13:24:22.247	2023-11-27 21:19:55.44	17	\N	1088
6dd1e20b-d44e-4587-8e91-1de87476159c	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-19 20:01:10.976	2023-11-27 21:19:55.442	23	\N	1413
2d4dc300-debd-409c-b449-34ffb7ef2e90	POST	51	\N	PENDING	\N	\N	\N	f	2023-11-11 15:26:25.716	2023-11-27 21:19:55.443	16	\N	1396
bb89dd7e-d0cf-45fd-9c1a-edc610a6739f	POST	1	\N	DISCARDED	\N	\N	\N	f	2022-11-29 23:30:14.712	2023-11-27 21:19:55.445	17	\N	1045
8c593ea4-c85e-465c-ab5c-7c8157ac4c42	POST	59	\N	DISCARDED	\N	\N	\N	f	2023-09-22 01:46:38.775	2023-11-27 21:19:55.447	21	\N	1135
baaa7381-2eb8-4cc7-abce-b1c6508625f5	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-05 07:13:12.298	2023-11-27 21:19:55.448	23	\N	508
babffc8e-6bbc-4622-bd39-3dc381c7b605	POST	14	\N	PENDING	\N	\N	\N	f	2023-04-12 04:30:05.064	2023-11-27 21:19:55.45	19	\N	1172
d32809bb-e0d8-44b5-a9ca-4069e1840c97	POST	2	\N	PENDING	\N	\N	\N	f	2023-05-26 10:15:16.147	2023-11-27 21:19:55.451	16	\N	1463
c637f5ec-5b9e-46a6-bc9e-c1169206fdf1	POST	33	\N	PENDING	\N	\N	\N	f	2023-10-21 16:34:04.378	2023-11-27 21:19:55.453	18	\N	564
1774304c-bcee-4063-af1c-e6eedc4da4ab	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-05-09 22:56:28.554	2023-11-27 21:19:55.454	14	\N	1027
f5a925d0-6c54-4358-a6ac-4ef8ee83685e	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-04-23 09:39:08.551	2023-11-27 21:19:55.456	23	\N	939
7ff035e0-ef05-4270-a52d-f698aac9f0e6	POST	2	\N	DISCARDED	\N	\N	\N	f	2023-01-22 08:29:44.238	2023-11-27 21:19:55.458	14	\N	720
88c3401f-5746-4532-9dcf-761d16fc4701	POST	11	\N	PENDING	\N	\N	\N	f	2023-01-06 14:07:46.234	2023-11-27 21:19:55.459	15	\N	596
f81972ef-ac95-4be4-a4be-328ca0693d02	POST	34	\N	DISCARDED	\N	\N	\N	f	2022-12-23 07:32:32.341	2023-11-27 21:19:55.461	19	\N	841
b495a743-31f8-4b06-9281-3d5b03890201	POST	9	\N	PENDING	\N	\N	\N	f	2023-04-27 03:44:25.244	2023-11-27 21:19:55.464	15	\N	1105
de190950-0355-4d27-ab05-b558a9057b38	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-11-26 18:17:52.081	2023-11-27 21:19:55.466	23	\N	1074
702342f5-a7a4-4b2e-9dcb-ef9e939c9bf4	POST	43	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-24 02:19:08.818	2023-11-27 21:19:55.467	20	\N	1122
6fc86493-1b67-4137-986c-5447b3f30cf0	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-21 00:27:24.919	2023-11-27 21:19:55.469	20	\N	893
015f2943-65b6-4fec-917e-3a4c1ecc4807	POST	52	\N	PENDING	\N	\N	\N	f	2023-08-12 00:40:19.59	2023-11-27 21:19:55.471	16	\N	570
50d3b2ef-d49a-44cb-b172-4d50c7e31451	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-06 11:12:56.406	2023-11-27 21:19:55.472	21	\N	1270
03bcc922-efd4-4617-8192-e3974c2fd183	POST	50	\N	PENDING	\N	\N	\N	f	2022-12-30 06:09:20.725	2023-11-27 21:19:55.474	16	\N	377
856840eb-29c6-408f-892f-68ea6b276d0d	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-04 23:24:20.826	2023-11-27 21:19:55.475	16	\N	1117
c3eb81ba-d9bc-4f75-a466-4e6bc24d11d8	POST	30	\N	PENDING	\N	\N	\N	f	2023-05-05 15:29:57.181	2023-11-27 21:19:55.477	20	\N	1420
882666fe-470c-4cd5-a04f-f9128d32e2ac	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-15 14:45:24.621	2023-11-27 21:19:55.478	23	\N	1359
c30f52cc-0423-471a-b039-f8c6905f62a0	POST	47	\N	PENDING	\N	\N	\N	f	2023-03-21 07:59:28.959	2023-11-27 21:19:55.48	20	\N	1142
6e9488ec-17d7-43c9-9dc2-867493830926	POST	42	\N	PENDING	\N	\N	\N	f	2023-02-03 19:37:42.998	2023-11-27 21:19:55.481	22	\N	999
73442c7f-3ce6-4cb9-b4ba-c237249ba987	POST	21	\N	PENDING	\N	\N	\N	f	2023-10-05 01:27:05.519	2023-11-27 21:19:55.483	14	\N	357
7080da3d-c8ae-4bda-b403-4425c9841c28	POST	3	\N	PENDING	\N	\N	\N	f	2023-02-13 16:53:05.773	2023-11-27 21:19:55.484	18	\N	790
469b33c9-740b-4a97-9606-5980a653f4dd	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-10-21 14:36:49.173	2023-11-27 21:19:55.486	23	\N	908
c0f72ecb-902b-4838-98a7-d5950b488211	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-07-10 13:53:24.51	2023-11-27 21:19:55.487	22	\N	1054
26a689d0-6f49-47c9-85a4-4e78746d286c	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-08-11 00:55:20.239	2023-11-27 21:19:55.489	19	\N	732
ddca6068-01ec-40e3-974b-f2c3a0ec6436	POST	56	\N	PENDING	\N	\N	\N	f	2023-07-26 13:59:18.629	2023-11-27 21:19:55.49	20	\N	1141
9af96d73-45f7-44f7-97cb-946ef58f3dfd	POST	17	\N	PENDING	\N	\N	\N	f	2023-08-26 21:04:39.078	2023-11-27 21:19:55.492	16	\N	1211
38f7e24a-6c0f-4d31-a512-178e7ab5fe6b	POST	58	\N	PENDING	\N	\N	\N	f	2023-01-25 20:18:29.749	2023-11-27 21:19:55.494	14	\N	953
097a9dbf-98d7-4bcc-bc3a-794c40600d62	POST	30	\N	DISCARDED	\N	\N	\N	f	2023-08-15 07:18:53.129	2023-11-27 21:19:55.495	15	\N	1078
d2165579-a895-450d-adf2-abce5d43f2bb	POST	40	\N	PENDING	\N	\N	\N	f	2023-09-20 16:58:26.748	2023-11-27 21:19:55.497	14	\N	1286
da5ff2eb-70a5-4499-b353-c69118812168	POST	27	\N	DISCARDED	\N	\N	\N	f	2023-02-01 08:57:54.264	2023-11-27 21:19:55.498	18	\N	1160
0a5e8fe8-c72b-4b39-9f2f-2def04a754bf	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-01-12 17:00:10.407	2023-11-27 21:19:55.5	20	\N	648
7e141a1a-4224-4bbe-8c01-48c59858c1d1	POST	54	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-18 21:28:03.064	2023-11-27 21:19:55.501	22	\N	823
1cac8055-8c02-424f-ad0a-9f3dd1c4bb9d	POST	46	\N	DISCARDED	\N	\N	\N	f	2023-04-13 22:14:58.706	2023-11-27 21:19:55.503	14	\N	1499
0b987803-9d3b-4e98-9df3-8b3ab77251cc	POST	57	\N	DISCARDED	\N	\N	\N	f	2023-06-07 13:12:00.614	2023-11-27 21:19:55.509	18	\N	1289
b5316509-ecdf-476c-aadc-b803021ec478	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-11 02:50:49.85	2023-11-27 21:19:55.51	19	\N	1269
f26c8f45-726c-41c2-9f5c-bfcf2dca11b6	POST	25	\N	DISCARDED	\N	\N	\N	f	2023-02-13 03:28:23.628	2023-11-27 21:19:55.512	18	\N	769
53373ae0-dbba-4516-811e-4077c2a6d9ce	POST	33	\N	PENDING	\N	\N	\N	f	2023-04-04 07:45:30.467	2023-11-27 21:19:55.514	21	\N	839
72d6af24-c2e6-4234-97bc-786ff3082388	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-03-27 15:27:37.413	2023-11-27 21:19:55.515	19	\N	868
63e624b2-2a53-4762-ba38-20da73d458d2	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-03-26 14:24:40.511	2023-11-27 21:19:55.517	21	\N	1239
0a942808-167b-4f3d-8831-001a2ad43fb1	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-25 02:11:34.707	2023-11-27 21:19:55.518	17	\N	1219
20397260-9ce7-4530-88a7-4ecdf4a19b38	POST	13	\N	DISCARDED	\N	\N	\N	f	2023-05-10 08:56:57.234	2023-11-27 21:19:55.52	19	\N	1114
f4107350-1b49-4721-ad34-0db38d4f5003	POST	35	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-23 20:03:36.982	2023-11-27 21:19:55.521	14	\N	1524
a9a63971-c0b4-4e31-83a9-240d2ee746ed	POST	23	\N	DISCARDED	\N	\N	\N	f	2023-02-01 13:34:50.046	2023-11-27 21:19:55.523	21	\N	535
574e4903-d59c-459e-8a1d-2c18b0d2cbc7	POST	37	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-25 18:38:02.752	2023-11-27 21:19:55.524	23	\N	531
615ee5ce-cf44-4462-97b0-e4698a8681ab	POST	32	\N	DISCARDED	\N	\N	\N	f	2022-12-07 07:27:12.058	2023-11-27 21:19:55.526	20	\N	798
a25da852-7a56-43ae-b818-12431698739e	POST	32	\N	PENDING	\N	\N	\N	f	2023-11-26 22:38:46.233	2023-11-27 21:19:55.528	19	\N	540
7d36438a-b087-46f1-b5f2-dc99e7b7182b	POST	57	\N	DISCARDED	\N	\N	\N	f	2023-02-13 17:06:21.258	2023-11-27 21:19:55.529	21	\N	448
9a902ab5-ecc5-4aba-9457-fc432ef24832	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-17 10:39:53.849	2023-11-27 21:19:55.531	16	\N	950
23849296-5ed1-4c86-8fec-bbced7cf5483	POST	19	\N	PENDING	\N	\N	\N	f	2023-08-07 05:43:41.807	2023-11-27 21:19:55.533	19	\N	1391
b22ecb2b-c7bd-4265-9f57-10baa4681953	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-07 03:59:03.934	2023-11-27 21:19:55.535	14	\N	1133
fab5b86f-a1bf-4ac3-86ca-62fabdb4dcc2	POST	6	\N	PENDING	\N	\N	\N	f	2022-12-30 00:15:12.215	2023-11-27 21:19:55.537	21	\N	1361
6a71aa9d-9f14-4806-97e4-a9b78dcf6a53	POST	36	\N	PENDING	\N	\N	\N	f	2023-11-10 16:03:42.534	2023-11-27 21:19:55.539	17	\N	1321
a791e3b5-228f-424e-bcee-7a14ef6f1d95	POST	31	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-25 06:29:45.422	2023-11-27 21:19:55.541	17	\N	421
442c03d4-9443-4dde-8217-c1a5f1f8cb3a	POST	48	\N	PENDING	\N	\N	\N	f	2023-07-30 05:57:59.158	2023-11-27 21:19:55.542	16	\N	389
efc3cb43-db68-4a3d-96fb-4342e30341c8	POST	18	\N	PENDING	\N	\N	\N	f	2023-09-26 19:28:06.978	2023-11-27 21:19:55.544	19	\N	942
3141b708-07b3-4a80-9dbe-484772577980	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-07 03:01:39.735	2023-11-27 21:19:55.546	18	\N	767
38a85054-9b9b-4935-8dcd-d86e68a70393	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-02-06 02:13:42.664	2023-11-27 21:19:55.548	14	\N	1518
9864429b-9bec-4861-ab6f-79aac41fb263	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-20 11:41:42.99	2023-11-27 21:19:55.55	19	\N	815
1f734afd-7d6f-48ef-b60a-0dba1d295660	POST	9	\N	PENDING	\N	\N	\N	f	2023-02-10 04:48:37.986	2023-11-27 21:19:55.552	19	\N	874
9f9e7b77-8581-4d98-b3ad-58b18009f4cb	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-02 18:38:09.448	2023-11-27 21:19:55.553	16	\N	960
1d02bba9-c337-48b2-b48d-1c3cfac8eb58	POST	37	\N	PENDING	\N	\N	\N	f	2023-05-02 16:04:28.939	2023-11-27 21:19:55.555	18	\N	1334
7486f9a1-7fa6-49f8-9630-00423c4f6f57	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-08-17 13:25:27.576	2023-11-27 21:19:55.557	16	\N	587
b8d3a368-06f5-473b-ae80-caebb52bfc17	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-19 10:16:33.9	2023-11-27 21:19:55.559	15	\N	1384
928f93a0-6fb9-4a11-85e2-d7d5727fdf55	POST	50	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-20 03:18:16.592	2023-11-27 21:19:55.562	18	\N	485
7bc8ce59-85f8-4911-8fa1-19d4750c5176	POST	13	\N	PENDING	\N	\N	\N	f	2023-01-30 13:54:15.234	2023-11-27 21:19:55.564	23	\N	1187
5eb17af0-9fa6-495b-8850-b0fdd57841d2	POST	24	\N	DISCARDED	\N	\N	\N	f	2022-12-13 01:31:11.525	2023-11-27 21:19:55.567	15	\N	501
bd32a147-bb26-4bf0-b98b-85f6c5933175	POST	33	\N	DISCARDED	\N	\N	\N	f	2022-12-14 12:33:58.357	2023-11-27 21:19:55.569	22	\N	1439
6e380f7b-bb29-4d0c-afa0-e20994efe52c	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-20 19:54:36.849	2023-11-27 21:19:55.571	15	\N	744
232ea436-0805-4489-a36d-e62adfa614f6	POST	30	\N	PENDING	\N	\N	\N	f	2023-08-06 09:53:53.684	2023-11-27 21:19:55.572	22	\N	654
16b18a2e-d7da-4d74-921f-13c31ed875d4	POST	23	\N	PENDING	\N	\N	\N	f	2023-01-04 19:47:28.195	2023-11-27 21:19:55.574	19	\N	380
c85e4823-738c-4e23-a92e-232b2dba3320	POST	47	\N	PENDING	\N	\N	\N	f	2023-11-15 00:33:46.079	2023-11-27 21:19:55.576	15	\N	1149
45658524-87b7-4894-a78c-b916a4491735	POST	24	\N	DISCARDED	\N	\N	\N	f	2023-10-10 01:34:17.5	2023-11-27 21:19:55.578	20	\N	1200
69a536c9-afef-41d1-b367-15fb08a38e5d	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-30 20:09:06.876	2023-11-27 21:19:55.58	20	\N	840
44ab4858-35ca-48a0-857a-99134c879254	POST	34	\N	PENDING	\N	\N	\N	f	2023-06-18 23:18:59.633	2023-11-27 21:19:55.581	14	\N	929
b33129b4-e258-4db4-bd6e-6eb60270cc06	POST	23	\N	PENDING	\N	\N	\N	f	2023-03-16 04:58:52.956	2023-11-27 21:19:55.583	23	\N	1277
ac97710a-243c-4f3d-ac12-65930c609431	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-30 09:20:39.74	2023-11-27 21:19:55.585	17	\N	419
19fd3a8e-a80c-402e-b1dd-2750ed450842	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-01-13 19:43:34.285	2023-11-27 21:19:55.587	19	\N	658
f94392db-3492-4dc6-9826-22623b764d9c	POST	41	\N	DISCARDED	\N	\N	\N	f	2022-12-30 06:25:56.035	2023-11-27 21:19:55.589	16	\N	623
ebf3f5f4-d2a9-4123-8c09-9e63247e4f6a	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-10-27 12:46:48.905	2023-11-27 21:19:55.591	22	\N	937
2eea5ca8-03d8-435f-a679-04b855988ea1	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-24 20:25:37.13	2023-11-27 21:19:55.592	18	\N	503
adb6ff9b-4a1a-493d-9078-2f3fe09b9567	POST	27	\N	DISCARDED	\N	\N	\N	f	2022-12-23 23:54:49.982	2023-11-27 21:19:55.594	22	\N	604
a9356232-aa79-469f-a57f-6159dd9f329d	POST	54	\N	PENDING	\N	\N	\N	f	2023-11-19 16:18:09.046	2023-11-27 21:19:55.596	18	\N	414
8249dd1b-a2e3-47eb-897d-24276d569610	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-03-07 05:22:47.481	2023-11-27 21:19:55.598	16	\N	1306
2586af46-6c5c-4b67-b23e-7da36a3dddb2	POST	41	\N	PENDING	\N	\N	\N	f	2023-03-14 13:45:29.208	2023-11-27 21:19:55.6	23	\N	1102
b2a7ddb3-2c47-4e0c-a06e-46008201b9c1	POST	50	\N	PENDING	\N	\N	\N	f	2023-10-21 14:39:58.858	2023-11-27 21:19:55.601	18	\N	519
2256ad2c-5b6d-4f2c-8e58-d2c32fd2ac31	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-05-28 02:33:01.251	2023-11-27 21:19:55.603	16	\N	405
22daf3fc-27db-4ba6-b8de-efbd1ecc7575	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-11-13 17:17:49.407	2023-11-27 21:19:55.605	21	\N	964
89d9b94b-690d-4e66-acb7-29c232f38dcf	POST	43	\N	PENDING	\N	\N	\N	f	2023-05-04 14:58:43.706	2023-11-27 21:19:55.606	21	\N	550
a213ae03-afff-4e50-960c-8bea62771d93	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-10-01 02:40:15.439	2023-11-27 21:19:55.608	18	\N	820
716cc0a6-b3ca-4113-ad17-52ddd55085c6	POST	34	\N	PENDING	\N	\N	\N	f	2023-08-20 16:18:41.847	2023-11-27 21:19:55.61	17	\N	352
e58e79cc-fbb2-4539-9015-7809e8546b90	POST	7	\N	PENDING	\N	\N	\N	f	2022-12-13 00:51:24.493	2023-11-27 21:19:55.611	20	\N	556
d89d98bf-68f9-406c-83df-75a34a286d24	POST	55	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-22 11:42:50.32	2023-11-27 21:19:55.613	21	\N	1450
edf5ec3c-b62a-488c-98bf-b21f56d8ac3a	POST	21	\N	PENDING	\N	\N	\N	f	2023-09-23 20:00:37.892	2023-11-27 21:19:55.615	22	\N	1270
cc78129a-e627-48f4-b72a-70c6ac504e3c	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-09-19 02:54:29.347	2023-11-27 21:19:55.617	23	\N	1292
d3b39f67-245e-4d38-95ef-b1343e552fe7	POST	47	\N	PENDING	\N	\N	\N	f	2023-09-28 00:19:06.204	2023-11-27 21:19:55.619	20	\N	866
c2a09539-7350-4b07-ae07-e560c91f60cf	POST	58	\N	PENDING	\N	\N	\N	f	2023-02-19 03:27:51.94	2023-11-27 21:19:55.62	23	\N	1207
b40d5630-65c2-4422-8cdb-9856e97f5682	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-15 06:56:59.657	2023-11-27 21:19:55.622	19	\N	501
8012ec1a-71f6-4826-ab30-80960619a950	POST	9	\N	PENDING	\N	\N	\N	f	2023-04-24 09:26:24.909	2023-11-27 21:19:55.624	18	\N	461
663844ac-3e5b-4b7b-8576-2ca3bd53332f	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-06-02 21:50:28.137	2023-11-27 21:19:55.625	19	\N	1041
2fb6fc08-015b-4126-ad24-77d217fecbf2	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-05-24 04:26:26.93	2023-11-27 21:19:55.627	22	\N	1159
b8750675-8272-47c6-ba53-2d76a2d917c0	POST	44	\N	PENDING	\N	\N	\N	f	2023-03-02 04:12:41.35	2023-11-27 21:19:55.629	15	\N	422
303c313e-1cce-40e9-9eaf-8f1bdf850fcc	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-05-09 06:37:29.523	2023-11-27 21:19:55.631	22	\N	890
2cbe5efd-fe09-482e-807d-104a991ff680	POST	30	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-20 03:10:36.881	2023-11-27 21:19:55.633	14	\N	1319
c25f0795-147e-465c-8455-e4f9c1213ca7	POST	55	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-02 20:23:29.139	2023-11-27 21:19:55.635	15	\N	580
1ea7065f-7cff-4182-b0fb-092324eaa57e	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-02-07 19:22:59.359	2023-11-27 21:19:55.637	20	\N	576
aca8466a-c9bb-4400-ba6b-64aaf9fd62e1	POST	46	\N	DISCARDED	\N	\N	\N	f	2023-06-23 23:57:01.643	2023-11-27 21:19:55.639	15	\N	511
4a96b908-12aa-44f1-a3c2-51915cb1ddeb	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-01-01 08:32:50.982	2023-11-27 21:19:55.641	18	\N	1046
6927295b-2aa3-43f0-9186-21731dc96ab5	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-08-13 13:46:43.564	2023-11-27 21:19:55.643	18	\N	1214
23f1bc54-2218-4051-aebc-1147c525c18a	POST	21	\N	PENDING	\N	\N	\N	f	2022-12-16 20:29:52.973	2023-11-27 21:19:55.645	22	\N	1182
aa3114c5-77ce-4fdd-81ca-2dad1f7bbc93	POST	23	\N	PENDING	\N	\N	\N	f	2023-01-25 18:36:20.66	2023-11-27 21:19:55.647	19	\N	1111
3e9248af-25cf-48ac-81d5-f51cc3a8c051	POST	14	\N	DISCARDED	\N	\N	\N	f	2022-12-31 16:32:48.819	2023-11-27 21:19:55.648	19	\N	730
407e96dc-cc25-4f51-b3fb-832cac7c6f0f	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-04-17 12:24:56.005	2023-11-27 21:19:55.65	14	\N	740
78daaa9b-97e1-4ca4-bc06-a8fea68c9455	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-02 04:45:18.169	2023-11-27 21:19:55.652	19	\N	1042
ae648bb6-ce62-4a81-8078-8196a9b6d8b3	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-11 04:05:25.529	2023-11-27 21:19:55.653	20	\N	1085
b4e6bcea-6b2b-4727-a0f2-e1b29c28c1ed	POST	19	\N	PENDING	\N	\N	\N	f	2023-09-29 02:39:56.286	2023-11-27 21:19:55.655	15	\N	886
e399493f-b3eb-4751-a0ba-f98fddeb3907	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-20 16:09:36.97	2023-11-27 21:19:55.657	20	\N	1057
474f5aed-795f-43eb-a867-1fe869b92264	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-22 20:27:26.594	2023-11-27 21:19:55.659	17	\N	1354
65401676-e85f-4781-b36b-8eb61c5358c8	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-05-11 04:12:44.787	2023-11-27 21:19:55.66	20	\N	506
7f95f41a-7022-4604-a3bb-5fcc7c8be8d1	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-29 12:47:56.258	2023-11-27 21:19:55.662	18	\N	447
ef9ea3a4-9e53-4c3d-8e0c-5ba5e42e2797	POST	12	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-13 09:33:06.584	2023-11-27 21:19:55.666	22	\N	713
6c9953d7-6142-4f8c-b5b3-0c2946f001de	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-18 18:51:31.83	2023-11-27 21:19:55.668	22	\N	558
10107d3d-545c-469b-8689-e0e0c203db41	POST	34	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-25 01:19:54.95	2023-11-27 21:19:55.669	15	\N	410
bf334f37-bd16-4c4c-bc94-8ee5aab3d2aa	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-09-08 05:56:56.615	2023-11-27 21:19:55.671	17	\N	1025
34ed7840-4b05-45a7-aab4-b3a96bcfa5a7	POST	28	\N	PENDING	\N	\N	\N	f	2023-11-18 18:23:25.702	2023-11-27 21:19:55.673	16	\N	1155
5c491b07-300a-4bfb-8695-4c8e0686a92b	POST	10	\N	PENDING	\N	\N	\N	f	2023-08-22 09:23:58.166	2023-11-27 21:19:55.674	22	\N	1375
1a61f883-ed80-49d4-b82f-eb16e86a2f43	POST	31	\N	PENDING	\N	\N	\N	f	2023-08-17 05:15:05.558	2023-11-27 21:19:55.676	21	\N	954
08d9b4f8-047a-4a9b-af3c-b6543a26fb00	POST	10	\N	PENDING	\N	\N	\N	f	2023-10-12 07:24:41.08	2023-11-27 21:19:55.677	22	\N	1387
4bcb526c-90f8-42af-910c-8f778ce5cb76	POST	13	\N	PENDING	\N	\N	\N	f	2023-11-02 10:16:14.721	2023-11-27 21:19:55.679	23	\N	369
42c852ac-90fc-46a3-8e7b-1a17863a5f72	POST	37	\N	PENDING	\N	\N	\N	f	2023-03-20 00:35:14.928	2023-11-27 21:19:55.68	18	\N	1093
b0121938-69c3-4d7f-8881-77925340c917	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-08-15 14:14:32.306	2023-11-27 21:19:55.682	20	\N	1129
249d8afe-7492-4079-b581-5e56aa9814b7	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-01-07 18:52:38.38	2023-11-27 21:19:55.684	17	\N	360
5caf6390-a713-48b1-9c19-4d1239e41051	POST	53	\N	PENDING	\N	\N	\N	f	2023-06-21 19:11:59.98	2023-11-27 21:19:55.686	15	\N	1450
61c4bb0d-0e85-4878-b6af-635512217e76	POST	14	\N	PENDING	\N	\N	\N	f	2023-02-13 18:23:32.273	2023-11-27 21:19:55.687	15	\N	737
0113edfc-7218-40d5-b7d2-375aee9c6657	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-07 20:41:56.268	2023-11-27 21:19:55.689	20	\N	553
a74f53ba-0de6-4e29-8dc7-bfb813ce85df	POST	24	\N	DISCARDED	\N	\N	\N	f	2022-12-30 16:54:55.491	2023-11-27 21:19:55.69	19	\N	1235
fac8e869-45a8-4098-9a29-7a9e22e39bcd	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-08-29 17:53:51.498	2023-11-27 21:19:55.692	16	\N	378
01d443f3-ca3e-4401-91b6-b17811a0114b	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-11-15 04:04:13.571	2023-11-27 21:19:55.694	22	\N	1492
85fb9b59-c7da-48ec-801a-4d4765ab3e67	POST	57	\N	DISCARDED	\N	\N	\N	f	2022-11-30 17:54:52.639	2023-11-27 21:19:55.696	17	\N	1361
c7aa737c-3a96-4597-bbb9-c3eb392e3bd1	POST	5	\N	DISCARDED	\N	\N	\N	f	2023-03-10 09:15:25.005	2023-11-27 21:19:55.698	21	\N	840
15c7490f-aeaa-44d0-9240-e2adfa94e883	POST	31	\N	DISCARDED	\N	\N	\N	f	2023-02-10 12:37:08.208	2023-11-27 21:19:55.699	15	\N	554
1fa46b26-b59d-4526-b387-7c65e9ae6634	POST	30	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-12 06:50:40.066	2023-11-27 21:19:55.701	22	\N	1326
927fc11c-a758-4580-986b-a4260fcddbcf	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-03-22 10:31:54.478	2023-11-27 21:19:55.703	18	\N	746
e25db00e-dd49-495e-ba8c-06ef9f97fb86	POST	27	\N	PENDING	\N	\N	\N	f	2022-12-01 07:22:29.602	2023-11-27 21:19:55.704	15	\N	388
d5258dc9-14fd-47c0-9ace-f2722131a0ee	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-06-19 14:18:48.522	2023-11-27 21:19:55.706	19	\N	703
730fef8e-ab26-48f2-91e8-0236929eca69	POST	46	\N	PENDING	\N	\N	\N	f	2023-10-31 05:28:50.779	2023-11-27 21:19:55.708	21	\N	1058
641d729a-2422-4b5a-a7d3-7b01c71f5fe1	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-01-18 12:21:52.451	2023-11-27 21:19:55.709	16	\N	1461
17fbf8be-04e0-460e-a777-ce0c8ec8ddc8	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-30 06:13:06.811	2023-11-27 21:19:55.711	20	\N	1091
499f82f5-fd65-4302-a77a-1d0827c09f67	POST	19	\N	PENDING	\N	\N	\N	f	2023-07-29 13:47:07.108	2023-11-27 21:19:55.713	18	\N	475
e73e18c8-f15e-4a22-99c5-065150c53db1	POST	49	\N	PENDING	\N	\N	\N	f	2023-09-03 19:40:18.168	2023-11-27 21:19:55.715	15	\N	1415
426784b3-586c-42e2-9fd3-6c5d1d9ae2a1	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-03-15 18:24:10.653	2023-11-27 21:19:55.716	14	\N	645
c4372f3b-12b2-40db-a69e-6415505da624	POST	12	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-14 18:36:06.071	2023-11-27 21:19:55.718	21	\N	1343
a842c541-7b29-49ac-9554-0f3ec0969c09	POST	38	\N	PENDING	\N	\N	\N	f	2023-11-02 19:31:31.635	2023-11-27 21:19:55.72	16	\N	620
232645f4-6cc3-4ad3-a06a-9f3f506cc7ce	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-28 09:58:20.637	2023-11-27 21:19:55.722	18	\N	974
246480a6-b16a-4955-9ef2-c4456109ccd7	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-07 02:14:03.633	2023-11-27 21:19:55.723	14	\N	894
91537612-137c-4c73-9349-212e132e2b8d	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-13 23:36:42.048	2023-11-27 21:19:55.725	14	\N	707
0f5b1f3e-8ad9-410b-88ce-9ad797c4ef57	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-03-16 16:54:42.821	2023-11-27 21:19:55.727	14	\N	997
6aed7886-664d-4334-97f2-e3a5e0b068da	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-11 06:41:48.079	2023-11-27 21:19:55.729	23	\N	1011
753c1915-f34f-4879-aba4-c859cf241736	POST	11	\N	PENDING	\N	\N	\N	f	2023-02-10 20:25:17.212	2023-11-27 21:19:55.731	14	\N	953
c1e6ffa7-db79-4872-8d1f-f334cbf7039d	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-27 06:58:06.765	2023-11-27 21:19:55.732	20	\N	1513
621028db-f7ba-4485-9863-bc148dc9a588	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-07 10:03:34.762	2023-11-27 21:19:55.734	20	\N	360
d0239043-4115-4b58-ae85-e9e564173d85	POST	22	\N	PENDING	\N	\N	\N	f	2023-11-13 08:18:04.156	2023-11-27 21:19:55.736	20	\N	891
98724eb2-4e16-4cdd-8250-ccc337bd93bb	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-10 23:34:39.197	2023-11-27 21:19:55.738	21	\N	1532
2adb4dcc-ab63-495c-88ea-1a546c384b3f	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-01-26 12:48:38.786	2023-11-27 21:19:55.74	16	\N	1008
a470feea-6578-4315-9c0f-5a74f9bce218	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-05 15:11:43.967	2023-11-27 21:19:55.742	18	\N	1390
d91e2f23-af7f-4526-a9a0-d04bd0bc4100	POST	35	\N	PENDING	\N	\N	\N	f	2023-09-22 10:15:54.604	2023-11-27 21:19:55.743	22	\N	955
f28f53ce-5cf0-474e-9b70-e02111ae319e	POST	43	\N	PENDING	\N	\N	\N	f	2023-11-08 23:40:54.446	2023-11-27 21:19:55.745	22	\N	509
441ec5b7-1ffe-486f-8ff2-8cf237f3a0d2	POST	14	\N	DISCARDED	\N	\N	\N	f	2023-02-21 16:41:15.457	2023-11-27 21:19:55.747	22	\N	1531
191269a4-2a85-406b-b615-7670ebc6a709	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-10-25 11:33:28.337	2023-11-27 21:19:55.748	15	\N	1098
8fce11c0-e113-4e6a-8d6e-f76747b90215	POST	31	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-22 03:38:22.89	2023-11-27 21:19:55.75	19	\N	847
10167a56-2b86-4382-9ab5-e7d47b15ec76	POST	56	\N	DISCARDED	\N	\N	\N	f	2023-08-05 13:40:35.653	2023-11-27 21:19:55.751	22	\N	822
b25e0b14-63c6-4fb2-ab0d-058dfcbe07e7	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-03-03 01:04:31.044	2023-11-27 21:19:55.753	17	\N	1243
4fca80e4-3bca-4970-8aaa-7aa749d88dba	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-04-22 09:46:08.373	2023-11-27 21:19:55.754	17	\N	1093
386b6a85-f9b5-45f7-a1fa-dd1aca87f2bc	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-11-02 09:51:08.341	2023-11-27 21:19:55.756	18	\N	1252
cb021a9c-7d78-4c2c-9fde-f1bfb9326797	POST	4	\N	PENDING	\N	\N	\N	f	2023-09-29 02:31:30.92	2023-11-27 21:19:55.758	16	\N	1303
42c98b78-6c26-489f-b0d6-f4b567ce4508	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-08-30 17:10:39.689	2023-11-27 21:19:55.759	15	\N	1534
00bf9c2f-a51c-4dda-9231-e3fdc14f6494	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-10-22 17:22:09.639	2023-11-27 21:19:55.761	15	\N	413
a733d59b-fd72-4b33-bf7f-8918e1a60ecd	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-05-31 02:51:18.378	2023-11-27 21:19:55.763	17	\N	1380
990a4fd0-2942-4de3-bbbd-82478d2e1317	POST	28	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-07 07:35:51.852	2023-11-27 21:19:55.764	18	\N	386
7d47f61c-33fe-4686-90e3-44f73834a29d	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-06-12 00:20:01.924	2023-11-27 21:19:55.766	23	\N	577
fb938584-6a6a-41c3-8886-85c853746314	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-11 11:06:35.344	2023-11-27 21:19:55.769	14	\N	1373
9ef12f8f-f793-4827-ba4b-e5082534ff2b	POST	17	\N	PENDING	\N	\N	\N	f	2023-08-24 05:08:00.268	2023-11-27 21:19:55.771	23	\N	771
33707f4a-71f5-4fdf-88b8-6c940da414a0	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-30 19:47:55.109	2023-11-27 21:19:55.773	19	\N	1352
cdc94914-963b-4ce6-9596-01471ebe946c	POST	26	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-31 17:31:18.736	2023-11-27 21:19:55.775	16	\N	648
95dc8890-9122-4a99-9d15-0d4f07e2403e	POST	51	\N	DISCARDED	\N	\N	\N	f	2023-10-14 10:17:29.427	2023-11-27 21:19:55.777	18	\N	966
957b1823-860c-4e7a-85b7-305310bf1e5b	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-08-13 07:29:13.447	2023-11-27 21:19:55.779	21	\N	1478
9ddb5571-9181-47b9-b510-6b82991507fa	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-21 23:26:15.257	2023-11-27 21:19:55.78	16	\N	613
cf24de4d-3984-47a2-8ff9-b46b03b3202c	POST	53	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-15 17:22:30.819	2023-11-27 21:19:55.782	15	\N	699
64a09363-be72-46e4-b428-9c8c248cde94	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-01-23 18:21:06.041	2023-11-27 21:19:55.783	18	\N	540
b0d862d3-dbac-4147-a122-b2329028fac0	POST	47	\N	DISCARDED	\N	\N	\N	f	2023-01-29 10:24:28.942	2023-11-27 21:19:55.785	20	\N	1255
634cedbf-d16e-4288-8c05-e23f0b6a9425	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-10-12 21:44:12.397	2023-11-27 21:19:55.787	19	\N	923
9869e7dc-4fa2-4a38-b7b4-db7ca17b2645	POST	37	\N	PENDING	\N	\N	\N	f	2023-06-30 05:20:32.003	2023-11-27 21:19:55.788	14	\N	1002
9888b3d0-ee46-4132-8416-e52381918c8f	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-05 21:14:47.918	2023-11-27 21:19:55.79	23	\N	667
845eb173-3ff9-45eb-b025-baf903ee90ca	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-01-18 02:00:03.378	2023-11-27 21:19:55.792	14	\N	1214
b571cb00-4556-41b0-b9bb-2b64b75cb0be	POST	40	\N	DISCARDED	\N	\N	\N	f	2023-04-11 18:36:19.121	2023-11-27 21:19:55.794	17	\N	1407
ad6dbf95-b8a5-4e15-88fb-a3487fb5c763	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-09-22 02:34:12.049	2023-11-27 21:19:55.795	20	\N	676
3087e5a8-ac15-4ded-a380-25077fc68e78	POST	31	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-24 04:41:55.091	2023-11-27 21:19:55.797	19	\N	745
d617fcbe-2554-4fb4-aa92-738a9fda4201	POST	12	\N	PENDING	\N	\N	\N	f	2023-07-23 08:17:17.577	2023-11-27 21:19:55.799	14	\N	1479
ab43a187-b792-4bb9-9d94-abf6e6d82a63	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-10-29 10:54:14.874	2023-11-27 21:19:55.8	22	\N	1319
5eeff39d-aa92-49dd-8369-2866fc45452f	POST	48	\N	DISCARDED	\N	\N	\N	f	2023-11-11 21:15:44.162	2023-11-27 21:19:55.802	19	\N	646
a512e971-7b31-4c13-a948-2c781a44a9a4	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-28 00:43:49.388	2023-11-27 21:19:55.803	19	\N	1399
2dcc803e-cd0d-484a-a809-0557cab9f919	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-07 16:14:56.887	2023-11-27 21:19:55.805	22	\N	1154
00801eaf-9a5b-4ead-a28d-8713f3e9f39b	POST	15	\N	PENDING	\N	\N	\N	f	2022-12-04 00:16:41.076	2023-11-27 21:19:55.807	19	\N	1421
dd260241-7dd8-4396-9791-19e0651dad17	POST	33	\N	PENDING	\N	\N	\N	f	2023-02-27 09:43:16.658	2023-11-27 21:19:55.808	14	\N	439
a7c7baa1-89e0-494d-a9c8-3c19a935dae1	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-20 18:59:11.859	2023-11-27 21:19:55.81	18	\N	549
1ceac82a-6238-4f8e-9b5f-31cbf3bd7c18	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-01-02 13:12:28.696	2023-11-27 21:19:55.811	23	\N	822
df4134c2-e0fe-4d28-bca0-62d6cff4894b	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-05-05 06:15:02.363	2023-11-27 21:19:55.813	23	\N	1079
603ee7da-cd52-4f89-a173-33d4b6e18277	POST	30	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-17 12:57:50.286	2023-11-27 21:19:55.814	20	\N	1184
b9614a27-a7ec-4cf7-8852-3844a6e8f383	POST	39	\N	PENDING	\N	\N	\N	f	2023-02-16 22:03:15.29	2023-11-27 21:19:55.816	17	\N	1382
05249dff-fb8d-44b2-98da-f125cc666986	POST	15	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-15 00:59:34.154	2023-11-27 21:19:55.818	19	\N	1219
d1b173c1-d14b-4b6c-9e75-ddb0c4f1095b	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-09-22 16:08:25.533	2023-11-27 21:19:55.819	22	\N	1466
20e257ad-7020-4bc0-bd8e-69bcb4b0f7b3	POST	22	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-17 13:06:17.626	2023-11-27 21:19:55.821	17	\N	635
252ab346-82dc-4024-844f-66b1dee091b1	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-02-11 01:32:57.604	2023-11-27 21:19:55.823	16	\N	403
ca7848f4-c607-46f7-adde-4ca031f02969	POST	25	\N	PENDING	\N	\N	\N	f	2022-12-23 17:57:15.467	2023-11-27 21:19:55.824	19	\N	911
643c19f4-6d06-4904-9549-e18d9e594d8a	POST	12	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-09 19:29:17.654	2023-11-27 21:19:55.826	17	\N	858
5be686b7-794c-4573-9473-f921adb03bf5	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-10-01 12:27:12.958	2023-11-27 21:19:55.827	18	\N	509
2d3c0042-3711-4fcb-9d4f-8e7399e501a6	POST	32	\N	PENDING	\N	\N	\N	f	2023-02-05 06:37:01.251	2023-11-27 21:19:55.829	16	\N	1353
b7fce4b8-e43c-4e5e-b6a0-74f86b445f6a	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-04 05:54:22.614	2023-11-27 21:19:55.831	19	\N	831
0743d4f0-3cb5-48d7-a34f-a7eaf3e96bb9	POST	52	\N	PENDING	\N	\N	\N	f	2023-05-06 16:07:39.709	2023-11-27 21:19:55.833	22	\N	934
8141edcd-f084-4260-a5f0-78ac050708d8	POST	40	\N	PENDING	\N	\N	\N	f	2023-04-25 18:51:38.751	2023-11-27 21:19:55.834	19	\N	871
847a8ab0-0f99-4156-8ac4-22808ff14146	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-10 23:56:23.077	2023-11-27 21:19:55.836	21	\N	1227
db8872f7-2a91-4e95-b204-189a8e7bdb5e	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-07-16 13:13:45.418	2023-11-27 21:19:55.838	19	\N	1210
1968ff00-4218-4e8f-acfa-3bf3e326fa4b	POST	8	\N	PENDING	\N	\N	\N	f	2023-05-13 05:57:37.338	2023-11-27 21:19:55.84	21	\N	802
cf21b500-de0d-49b3-b169-870dce8ea3fb	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-04-30 18:40:48.588	2023-11-27 21:19:55.842	23	\N	747
be186f36-0885-4790-aa0b-0b7f3d349e2f	POST	16	\N	DISCARDED	\N	\N	\N	f	2023-04-27 14:00:31.509	2023-11-27 21:19:55.844	18	\N	1412
d3647fba-98d2-4eab-b08d-bf0c19ff4e3e	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-08-05 02:54:28.106	2023-11-27 21:19:55.846	17	\N	1478
01a86aef-420c-4ecc-b965-1aff39487762	POST	49	\N	DISCARDED	\N	\N	\N	f	2023-07-16 13:54:58.345	2023-11-27 21:19:55.848	22	\N	821
a89f66ed-79a3-4a30-9675-b251c8128d9f	POST	52	\N	PENDING	\N	\N	\N	f	2023-07-04 00:29:18.166	2023-11-27 21:19:55.849	21	\N	955
c452ca5e-a759-4ce0-b6e4-7d83ce43d5ee	POST	28	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-29 16:10:48.097	2023-11-27 21:19:55.851	17	\N	852
dc155747-8e1b-4a42-8cd7-7f1d5c9bb71e	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-10-16 18:39:44.284	2023-11-27 21:19:55.852	20	\N	507
b1f7b7f1-7fd1-41e3-b5a0-51d3adb8af4d	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-10-09 22:05:55.416	2023-11-27 21:19:55.854	22	\N	1020
d8140a7e-d346-45ae-92ab-73c37b08a631	POST	46	\N	DISCARDED	\N	\N	\N	f	2023-11-06 05:47:28.709	2023-11-27 21:19:55.856	22	\N	1449
20b3cce3-997d-49d2-918f-dfd805f1fc8d	POST	24	\N	DISCARDED	\N	\N	\N	f	2023-10-17 10:37:22.502	2023-11-27 21:19:55.857	14	\N	1356
ae7afd3a-77b3-45f1-a73f-d985e6fb65cb	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-26 06:21:26.597	2023-11-27 21:19:55.86	21	\N	1435
02c7edcb-01b9-483f-9f10-2329ea078302	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-09-15 14:43:46.099	2023-11-27 21:19:55.861	15	\N	1460
4672397c-e888-4718-80c3-87bb5941d7c7	POST	9	\N	PENDING	\N	\N	\N	f	2023-10-19 08:29:01.548	2023-11-27 21:19:55.863	21	\N	843
b927b926-a45b-4582-81a2-784ae3e3f23a	POST	7	\N	PENDING	\N	\N	\N	f	2023-07-11 00:48:16.155	2023-11-27 21:19:55.865	14	\N	731
8e67c66a-12c8-4e03-b8a4-5d172bb7f3a1	POST	49	\N	PENDING	\N	\N	\N	f	2023-10-20 19:27:43.903	2023-11-27 21:19:55.866	15	\N	1494
6e458ed7-ef76-44a5-972a-78f7d24cf42b	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-22 03:34:53.853	2023-11-27 21:19:55.868	20	\N	864
65e11a61-6745-4699-b622-282d236dda3a	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-10-15 14:38:53.267	2023-11-27 21:19:55.87	18	\N	1517
d2fb5239-bb5e-4ebe-b1ba-db005fd0047d	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-02 00:43:36.504	2023-11-27 21:19:55.872	14	\N	1062
5f367541-9fca-40a2-a45b-302a829ca421	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-13 13:51:59.932	2023-11-27 21:19:55.874	20	\N	922
0f97755d-d0ab-4b1f-ad4a-5dd20ec405cf	POST	45	\N	PENDING	\N	\N	\N	f	2023-02-12 15:48:33.074	2023-11-27 21:19:55.875	19	\N	678
068b892a-b540-434d-87a0-a99d63097cf2	POST	23	\N	DISCARDED	\N	\N	\N	f	2023-11-27 20:50:56.161	2023-11-27 21:19:55.877	22	\N	1234
19b477c7-551f-4fe6-aa7a-d15a00582b06	POST	57	\N	PENDING	\N	\N	\N	f	2023-04-23 09:11:16.217	2023-11-27 21:19:55.879	19	\N	1447
ff44330c-67bc-4059-85da-874532550a71	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-06-08 16:53:04.562	2023-11-27 21:19:55.88	16	\N	703
9f24ea39-bf82-4e8a-b64d-49ff5ba71c7f	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-08 00:08:51.536	2023-11-27 21:19:55.882	17	\N	1005
3a43695a-3dfd-45b1-b01f-7d4560975274	POST	50	\N	PENDING	\N	\N	\N	f	2023-05-18 23:33:05.782	2023-11-27 21:19:55.884	23	\N	1532
0e423b5d-0c9e-494f-9109-30f387790f46	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-04-08 18:47:39.406	2023-11-27 21:19:55.886	19	\N	1507
63213442-285d-475e-9a4d-b1870ff2e1cc	POST	58	\N	PENDING	\N	\N	\N	f	2023-08-30 09:07:15.332	2023-11-27 21:19:55.888	14	\N	1087
84f59b0d-0a3d-4869-9f97-b8ba71875437	POST	39	\N	PENDING	\N	\N	\N	f	2022-12-09 05:57:45.833	2023-11-27 21:19:55.889	14	\N	1464
68754ee3-47a7-4923-94a1-06d41bd4f96d	POST	12	\N	PENDING	\N	\N	\N	f	2023-02-10 22:39:54.541	2023-11-27 21:19:55.891	18	\N	758
3209a585-b2b4-43a7-92e0-c0378ab382d4	POST	14	\N	DISCARDED	\N	\N	\N	f	2023-08-12 11:47:24.867	2023-11-27 21:19:55.893	22	\N	1131
ea2c405b-3c96-495f-a8c0-7f3e11a69667	POST	7	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-15 13:21:42.423	2023-11-27 21:19:55.894	22	\N	684
6e0cf654-9f34-4d72-8307-e917e6be4aa9	POST	55	\N	DISCARDED	\N	\N	\N	f	2022-11-28 09:30:49.961	2023-11-27 21:19:55.896	23	\N	964
8941b0d1-28f6-4a37-8fa2-3a31d9475178	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-03-24 08:18:25.834	2023-11-27 21:19:55.9	16	\N	1457
5b23078a-fc22-4fc1-8275-acbd54a57f26	POST	18	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-09 12:54:22.225	2023-11-27 21:19:55.901	17	\N	1379
fdad452e-2cc5-46b7-8f9b-f98c7521bd7e	POST	25	\N	DISCARDED	\N	\N	\N	f	2023-01-10 18:28:35.626	2023-11-27 21:19:55.903	21	\N	347
b465488b-630c-44c2-9dc4-3dee90dd8423	POST	46	\N	DISCARDED	\N	\N	\N	f	2023-11-19 12:27:08.483	2023-11-27 21:19:55.905	14	\N	782
97bfab02-7a0f-4232-a4a7-f544acdfa7f4	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-08-29 12:38:19.021	2023-11-27 21:19:55.906	20	\N	699
ca8bb728-35b7-41cb-8db9-136d0dc99a4e	POST	14	\N	PENDING	\N	\N	\N	f	2023-05-09 20:33:23.853	2023-11-27 21:19:55.908	16	\N	1518
a02a3008-536b-4d90-93ab-65c441a11009	POST	48	\N	PENDING	\N	\N	\N	f	2023-03-04 13:48:12.938	2023-11-27 21:19:55.91	14	\N	977
b51cd7b9-b3b8-40a7-ac32-21fbbd12b328	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-09-09 08:30:17.08	2023-11-27 21:19:55.911	21	\N	711
c0a6cedc-7311-48f5-a744-7bb50664b5be	POST	46	\N	DISCARDED	\N	\N	\N	f	2023-01-17 15:20:15.372	2023-11-27 21:19:55.913	15	\N	1079
edf39560-bfb6-4d9f-8310-93441639f25b	POST	37	\N	PENDING	\N	\N	\N	f	2023-01-07 11:36:37.997	2023-11-27 21:19:55.915	20	\N	1319
4c1b1588-c72c-40fa-893a-536842c71303	POST	8	\N	DISCARDED	\N	\N	\N	f	2022-12-15 19:36:40.904	2023-11-27 21:19:55.916	20	\N	923
415864e5-76d5-426c-9eef-2bb3186f0cbb	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-03-24 23:14:13.23	2023-11-27 21:19:55.918	22	\N	436
e47cdbba-e4b1-45d3-b08b-6920c5c82dba	POST	1	\N	PENDING	\N	\N	\N	f	2023-04-01 11:15:36.449	2023-11-27 21:19:55.919	23	\N	878
19c1e1f9-1ad2-4c5b-adec-648fe7d01f85	POST	13	\N	PENDING	\N	\N	\N	f	2023-11-15 23:17:41.173	2023-11-27 21:19:55.921	22	\N	1342
ea934548-222e-4469-bb43-35eaf053897f	POST	18	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-05 23:52:57.006	2023-11-27 21:19:55.923	16	\N	578
54727fc8-d7ec-4f2f-bba4-ec7a72f6bf20	POST	13	\N	DISCARDED	\N	\N	\N	f	2023-08-02 07:40:30.015	2023-11-27 21:19:55.924	23	\N	644
08b9d76c-9efa-420e-8f72-a774a5eceab2	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-06-30 08:16:21.796	2023-11-27 21:19:55.927	15	\N	1509
ad3c5ae2-47dc-4ccd-8301-5b10c1601237	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-11-05 14:20:21.882	2023-11-27 21:19:55.929	19	\N	545
9dd2d733-8cee-48b7-9f0e-e9c11b25d0d3	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-24 06:36:03.07	2023-11-27 21:19:55.931	23	\N	1508
c8a173f7-f595-4d9b-a5a7-c1f0bd6e0561	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-07 00:53:04.378	2023-11-27 21:19:55.934	14	\N	674
3f99a79c-75b7-4ec8-ab4e-00446bb07fe6	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-26 18:16:38.356	2023-11-27 21:19:55.937	16	\N	1093
69e1b0a8-b6d6-4f03-a71d-fe207d365925	POST	46	\N	DISCARDED	\N	\N	\N	f	2022-12-17 08:03:21.094	2023-11-27 21:19:55.939	17	\N	1202
07ca30a6-9733-4d9b-8945-f61fabd24463	POST	47	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-02 09:29:15.239	2023-11-27 21:19:55.94	20	\N	888
2b432909-9270-47fb-bc7b-26a696b746bc	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-17 20:32:11.981	2023-11-27 21:19:55.943	23	\N	1447
eff2b485-c570-47ed-bc83-e7ac47f66319	POST	56	\N	DISCARDED	\N	\N	\N	f	2023-07-18 06:10:15.81	2023-11-27 21:19:55.945	21	\N	744
834242de-d42e-4225-97fc-f5db20738b2d	POST	27	\N	PENDING	\N	\N	\N	f	2023-04-07 12:37:22.727	2023-11-27 21:19:55.947	22	\N	839
a681e35d-6454-4aca-a2f5-da2974ab79cc	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-06-26 10:30:53.532	2023-11-27 21:19:55.949	16	\N	685
8461b36c-c963-4197-9a51-59ed210641aa	POST	13	\N	DISCARDED	\N	\N	\N	f	2022-12-08 14:59:48.165	2023-11-27 21:19:55.951	18	\N	519
d1258ffc-36a3-44df-9431-659066521134	POST	10	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-26 20:35:26.478	2023-11-27 21:19:55.952	22	\N	1436
85c8820a-e997-4630-a9f1-5aff21e7b284	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-07-11 20:26:24.81	2023-11-27 21:19:55.954	22	\N	614
bc0060d2-7d26-4017-936c-a001c7b53936	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-08-23 12:03:39.465	2023-11-27 21:19:55.956	18	\N	950
ed066052-3089-43d4-b7fd-f667e1f10a14	POST	35	\N	PENDING	\N	\N	\N	f	2023-06-25 15:46:43.319	2023-11-27 21:19:55.957	19	\N	682
224dd2e4-5749-40db-a44f-4340aff63e5c	POST	15	\N	PENDING	\N	\N	\N	f	2023-03-03 23:09:24.065	2023-11-27 21:19:55.959	17	\N	1094
5d480733-877d-49ad-b413-ea2265f711c7	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-04 17:45:45.268	2023-11-27 21:19:55.961	14	\N	1155
9fc37a14-1bc0-448c-82d7-3b5df15202e9	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-05-09 13:22:06.928	2023-11-27 21:19:55.963	16	\N	795
5086367c-2db0-424e-a2a8-fad8e9de8635	POST	48	\N	DISCARDED	\N	\N	\N	f	2023-08-07 15:10:49.627	2023-11-27 21:19:55.964	18	\N	1039
7bf63916-340d-4c10-ae42-47689e06628e	POST	36	\N	DISCARDED	\N	\N	\N	f	2023-03-27 10:34:46.98	2023-11-27 21:19:55.967	22	\N	1176
28f4a47b-d3bf-42e1-ad47-a92b22bf4007	POST	18	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-11 09:47:39.488	2023-11-27 21:19:55.968	14	\N	601
5e5445fa-e6db-4e25-8408-0cb997b45c6a	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-03-03 19:46:51.903	2023-11-27 21:19:55.97	15	\N	1125
a23e0867-ca4b-4fdc-831d-7636e2ee6aaa	POST	31	\N	PENDING	\N	\N	\N	f	2023-01-14 14:40:27.048	2023-11-27 21:19:55.971	20	\N	374
a915d730-9155-4dea-8827-b9e14983f2f3	POST	2	\N	PENDING	\N	\N	\N	f	2023-08-30 01:04:38.336	2023-11-27 21:19:55.973	20	\N	638
5495d024-77e5-469c-8856-f20bf8a7039f	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-06-02 23:33:23.091	2023-11-27 21:19:55.974	19	\N	881
2973c26d-1b05-4e55-8f51-721f79911271	POST	34	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-10 18:54:17.728	2023-11-27 21:19:55.976	16	\N	1204
124c7e48-ec7c-46a1-a17e-b58e7522ed77	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-10-17 17:57:51.936	2023-11-27 21:19:55.978	22	\N	799
a83b0e97-bc7b-499f-ac42-b405ff8191cd	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-10-14 17:22:50.524	2023-11-27 21:19:55.979	17	\N	1504
fdc4d2cd-4e6f-4381-8da2-b8fdb0b63a96	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-22 04:35:19.925	2023-11-27 21:19:55.981	14	\N	964
2151f242-c9da-46f8-bb60-4203a3493f17	POST	35	\N	PENDING	\N	\N	\N	f	2023-07-23 08:47:29.954	2023-11-27 21:19:55.983	16	\N	1535
c670714e-5352-4eca-b568-d25567e3dd0e	POST	38	\N	DISCARDED	\N	\N	\N	f	2022-12-01 08:25:25.076	2023-11-27 21:19:55.985	20	\N	1269
7bdb38f5-81e1-46ef-b50c-495b14fc542d	POST	14	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-06 22:00:26.727	2023-11-27 21:19:55.987	18	\N	1078
99684287-614a-46ca-a042-950f26819d55	POST	5	\N	PENDING	\N	\N	\N	f	2023-06-12 06:04:18.133	2023-11-27 21:19:55.988	15	\N	738
f7f50084-85c8-4062-aed5-3139855d4eba	POST	31	\N	DISCARDED	\N	\N	\N	f	2022-12-10 14:03:08.7	2023-11-27 21:19:55.99	21	\N	998
e9fcc6c4-b591-48ac-9ec8-47e7fd6f36c1	POST	50	\N	PENDING	\N	\N	\N	f	2023-05-28 11:52:05.808	2023-11-27 21:19:55.991	14	\N	385
8e9852d9-220b-4fae-a1e8-225bafab2e02	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-11 03:13:26.709	2023-11-27 21:19:55.993	21	\N	402
9490bc62-ff33-490d-b153-8c939c4e4ebd	POST	54	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-04 20:51:35.464	2023-11-27 21:19:55.995	15	\N	984
e24ff541-ae55-4bee-b8ff-e7dffac1c259	POST	25	\N	PENDING	\N	\N	\N	f	2023-08-14 14:25:13.728	2023-11-27 21:19:55.996	16	\N	1240
49e1548f-df86-45e8-84ca-2897e4a494d3	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-23 11:41:20.257	2023-11-27 21:19:55.998	23	\N	768
cc2708fa-a15c-41fb-9466-1d8857a72da2	POST	5	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-31 06:27:27.03	2023-11-27 21:19:56	21	\N	870
5dc6fcd9-ea56-487e-aa59-bad09fb8b1c9	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-30 10:31:34.169	2023-11-27 21:19:56.001	15	\N	1508
8a35cc6f-fe5f-4392-9829-cae7590152d1	POST	55	\N	PENDING	\N	\N	\N	f	2023-11-06 01:15:34.554	2023-11-27 21:19:56.002	17	\N	1444
35bae0dc-da87-444a-a346-f94d74ba020f	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-04-25 05:05:57.421	2023-11-27 21:19:56.005	19	\N	1513
a261599f-3181-46f9-b7cc-367ff86faea3	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-04-15 01:15:13.605	2023-11-27 21:19:56.006	23	\N	507
874a0bdb-87ff-4303-a5bd-84e14ee07447	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-18 10:45:41.943	2023-11-27 21:19:56.008	21	\N	1283
7be5372d-c076-41c1-9fb5-7b78f03d72da	POST	9	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-24 05:43:48.42	2023-11-27 21:19:56.01	19	\N	971
87387246-2183-4345-b66f-d83393b2655e	POST	53	\N	PENDING	\N	\N	\N	f	2023-08-29 19:12:18.331	2023-11-27 21:19:56.012	18	\N	1414
7a896fad-b139-4f12-8143-f33a1b5576a7	POST	40	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-18 02:36:32.906	2023-11-27 21:19:56.013	14	\N	1458
46e0d500-be1c-4f9d-bd85-cac054214a49	POST	2	\N	DISCARDED	\N	\N	\N	f	2022-12-25 01:04:41.397	2023-11-27 21:19:56.015	16	\N	872
08e1b454-670b-4035-a279-34c3d5752600	POST	22	\N	PENDING	\N	\N	\N	f	2023-02-23 05:42:04.458	2023-11-27 21:19:56.017	16	\N	682
28885eac-6f78-4b20-b22a-5a1884acc1cb	POST	9	\N	DISCARDED	\N	\N	\N	f	2023-08-18 18:36:12.174	2023-11-27 21:19:56.018	16	\N	1421
c838ab8e-3de3-4c23-9118-71b952bf4fc9	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-22 18:13:09.404	2023-11-27 21:19:56.02	15	\N	506
7b0acfcc-812a-4b5c-8f95-11e550152363	POST	2	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-02 10:50:55.65	2023-11-27 21:19:56.021	14	\N	1428
ce00f22d-8280-41dc-adc9-15de58f9954c	POST	29	\N	PENDING	\N	\N	\N	f	2022-12-23 09:09:09.139	2023-11-27 21:19:56.023	22	\N	897
35563a15-e537-4598-a5ee-22bec806303e	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-08-04 15:09:28.546	2023-11-27 21:19:56.024	18	\N	1113
9da8759b-eca9-4d28-a37f-68a4afbb33af	POST	26	\N	PENDING	\N	\N	\N	f	2023-09-03 19:30:23.829	2023-11-27 21:19:56.026	15	\N	1365
945d6ed9-d205-43d8-9157-6a64cb15422d	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-30 04:48:08.792	2023-11-27 21:19:56.028	23	\N	1294
921e34d7-acad-453f-8312-a49b94f95b3d	POST	57	\N	PENDING	\N	\N	\N	f	2023-01-03 03:39:53.071	2023-11-27 21:19:56.029	14	\N	1072
ecd60bba-b3c6-4ef0-90a0-df597c214de0	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-09-28 13:02:14.681	2023-11-27 21:19:56.031	15	\N	1314
bf0c9b0b-a94f-48dc-94dc-34c90391ff08	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-16 06:53:48.784	2023-11-27 21:19:56.032	14	\N	673
e2b28d7d-554b-4840-a9ef-9983a6d41b70	POST	32	\N	PENDING	\N	\N	\N	f	2023-06-15 12:01:32.989	2023-11-27 21:19:56.034	19	\N	962
1da933a4-8ee0-469d-a038-f6b0fc8eb588	POST	45	\N	PENDING	\N	\N	\N	f	2023-03-24 14:49:18.484	2023-11-27 21:19:56.035	14	\N	379
d65449e4-e800-4ae5-b799-d52909abcd5b	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-21 16:50:50.258	2023-11-27 21:19:56.037	22	\N	1092
55f39969-ad2c-4b7b-9c6c-16fc72a18780	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-27 00:30:59.045	2023-11-27 21:19:56.038	21	\N	1173
f27869b8-5d0e-4bc0-9c6d-730145db1414	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-28 04:26:54.003	2023-11-27 21:19:56.04	17	\N	962
19799337-c018-4c19-a746-12aec8d4696a	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-07-23 04:12:25.002	2023-11-27 21:19:56.041	23	\N	1168
ab7786dc-fe03-4bf3-a72c-0a02726790b3	POST	13	\N	PENDING	\N	\N	\N	f	2023-01-02 08:23:28.843	2023-11-27 21:19:56.043	17	\N	1094
a960754b-1b15-424c-b78d-f84239739b22	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-16 16:05:42.789	2023-11-27 21:19:56.045	17	\N	887
3f42af28-e22e-468b-bfdd-1ed3e76da6a8	POST	29	\N	PENDING	\N	\N	\N	f	2023-06-13 01:34:01.375	2023-11-27 21:19:56.047	16	\N	1406
5e0d2cb8-c401-4ff9-9fae-2bed28fd1769	POST	7	\N	PENDING	\N	\N	\N	f	2023-02-28 22:37:53.399	2023-11-27 21:19:56.048	14	\N	379
0108e2bf-c9eb-49fb-a42f-5bdfc3b31d84	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-10-03 08:07:30.253	2023-11-27 21:19:56.049	14	\N	829
126ce8ee-9b3e-4dd9-a3f4-d46adef6bbe6	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-08-08 23:42:11.75	2023-11-27 21:19:56.051	19	\N	1277
a56495b3-aaae-4ccb-8666-d5eb597a288e	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-03 07:18:02.847	2023-11-27 21:19:56.052	21	\N	769
3eb27f1a-b26f-4b46-a6fa-484332159c31	POST	31	\N	PENDING	\N	\N	\N	f	2023-01-06 15:58:46.093	2023-11-27 21:19:56.054	14	\N	1358
292e80e7-5180-4e01-80fe-37407c4fac13	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-20 13:33:49.743	2023-11-27 21:19:56.055	22	\N	551
9c6f3d31-77c3-4828-a498-efb4276209e8	POST	6	\N	DISCARDED	\N	\N	\N	f	2023-01-16 14:47:16.42	2023-11-27 21:19:56.057	22	\N	745
f7381244-efaa-4c0e-bf84-e731be7e775b	POST	12	\N	DISCARDED	\N	\N	\N	f	2022-12-31 22:02:33.884	2023-11-27 21:19:56.058	19	\N	522
1736fea6-415d-43f1-bf55-47b487d059a0	POST	36	\N	PENDING	\N	\N	\N	f	2023-06-26 03:04:51.602	2023-11-27 21:19:56.06	21	\N	885
b576cf26-b9ce-486b-8f0d-3c815c96e00f	POST	54	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-15 18:21:54.299	2023-11-27 21:19:56.062	19	\N	832
f8706274-9d93-4d11-92a4-afcdfa176285	POST	35	\N	PENDING	\N	\N	\N	f	2023-10-29 09:50:36.785	2023-11-27 21:19:56.064	20	\N	1291
b32fe3cf-5e02-4ca1-b6c8-eea2ed343866	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-05-15 21:17:59.896	2023-11-27 21:19:56.065	22	\N	657
e01a652a-42d8-44a8-9082-44cd21d7b03b	POST	58	\N	PENDING	\N	\N	\N	f	2022-12-06 12:35:33.739	2023-11-27 21:19:56.067	15	\N	937
beabf937-1aae-4240-8ef1-b23c9bc09fba	POST	18	\N	PENDING	\N	\N	\N	f	2023-05-15 16:57:43.351	2023-11-27 21:19:56.068	21	\N	1529
dde02202-b1b8-4349-9e12-5833f518def4	POST	22	\N	DISCARDED	\N	\N	\N	f	2023-08-10 17:12:56.441	2023-11-27 21:19:56.07	19	\N	718
7c990b84-6c8b-420f-af5f-4716fb9d4f07	POST	56	\N	PENDING	\N	\N	\N	f	2023-11-21 20:40:21.543	2023-11-27 21:19:56.071	14	\N	1325
65d77b53-8fbe-42a6-a3fa-0c9ae3c2e9b5	POST	32	\N	PENDING	\N	\N	\N	f	2023-09-24 12:23:22.115	2023-11-27 21:19:56.073	17	\N	1306
5a6a96f4-126c-45d3-a149-4c1a725bfaa6	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-21 17:17:31.016	2023-11-27 21:19:56.074	18	\N	910
52d59769-7a1c-4516-9f88-75ac2e05ba8b	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-03-15 10:45:40.964	2023-11-27 21:19:56.076	14	\N	1208
a4dc82ff-36d8-481e-8630-a86e4e22c2a9	POST	36	\N	DISCARDED	\N	\N	\N	f	2023-10-10 18:26:33.345	2023-11-27 21:19:56.077	14	\N	1063
7dd36862-1d16-4f1b-bc00-f575d18794bf	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-21 00:51:59.908	2023-11-27 21:19:56.079	16	\N	610
9e4a3ada-0856-4477-af8d-dd89f0a8dae8	POST	59	\N	PENDING	\N	\N	\N	f	2023-04-24 09:37:03.067	2023-11-27 21:19:56.081	20	\N	1499
997928dd-c0f4-4db0-8901-de3706e1dd4d	POST	54	\N	PENDING	\N	\N	\N	f	2023-10-14 06:45:09.02	2023-11-27 21:19:56.083	23	\N	883
1e3df78d-9f7b-4020-9633-6fcf299821f8	POST	48	\N	PENDING	\N	\N	\N	f	2023-11-14 14:35:11.848	2023-11-27 21:19:56.085	15	\N	1092
8a87a211-ccaa-4fde-883a-45e860879965	POST	48	\N	PENDING	\N	\N	\N	f	2022-11-28 13:38:04.028	2023-11-27 21:19:56.087	21	\N	1347
6c5e37a9-aa05-44db-b457-6cc650865301	POST	14	\N	DISCARDED	\N	\N	\N	f	2023-02-06 16:28:37.452	2023-11-27 21:19:56.089	15	\N	1039
f3b74850-8f2b-4345-96a8-4db05ddc1a4b	POST	13	\N	DISCARDED	\N	\N	\N	f	2023-05-06 18:53:53.554	2023-11-27 21:19:56.09	18	\N	1018
81269d54-c021-4922-91ca-4b03d5c8a9b9	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-09 09:44:55.971	2023-11-27 21:19:56.092	22	\N	909
a949360c-9144-4bfe-b7ba-cfe0d9981fdf	POST	37	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-28 15:30:54.884	2023-11-27 21:19:56.094	23	\N	1263
240fef17-4f50-454c-a2a9-fb49510c8bc2	POST	28	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-18 13:08:49.599	2023-11-27 21:19:56.096	23	\N	1109
940d2a61-dac5-44f5-8a43-1c84acbc8ddf	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-24 02:03:52.799	2023-11-27 21:19:56.097	15	\N	1265
9695e313-1953-4ae3-a809-c43ee023f748	POST	34	\N	DISCARDED	\N	\N	\N	f	2022-12-13 08:55:03.689	2023-11-27 21:19:56.099	16	\N	1078
644d2567-bf0e-438a-8991-54f3a1c2cffb	POST	18	\N	PENDING	\N	\N	\N	f	2023-08-31 04:36:38.538	2023-11-27 21:19:56.1	15	\N	1180
e6c55241-543e-4c02-aef0-dc43be8c964b	POST	13	\N	PENDING	\N	\N	\N	f	2023-06-27 10:23:33.808	2023-11-27 21:19:56.102	14	\N	751
28cc07b5-846d-455b-a9e9-c6d454d464d0	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-09 21:05:33.539	2023-11-27 21:19:56.103	16	\N	640
762cccf8-1b24-4d32-b637-15336d632ea3	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-08-26 01:02:29.668	2023-11-27 21:19:56.105	23	\N	485
27c4c1bb-0331-4d15-a462-b94708f0e45c	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-30 06:43:38.463	2023-11-27 21:19:56.107	17	\N	1269
58e99857-da17-4cd3-a93d-111ac26b7c98	POST	58	\N	PENDING	\N	\N	\N	f	2023-01-08 22:30:26.46	2023-11-27 21:19:56.108	21	\N	1303
24bd335e-824b-4ad7-bb96-10bc8731455f	POST	42	\N	PENDING	\N	\N	\N	f	2023-03-19 06:22:59.052	2023-11-27 21:19:56.11	15	\N	364
7def2860-268b-4bf7-aad9-c957d7e877d7	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-26 12:46:36.622	2023-11-27 21:19:56.112	14	\N	933
f92796fa-c40e-430f-a2b2-ee13af830299	POST	30	\N	DISCARDED	\N	\N	\N	f	2023-06-17 07:34:30.682	2023-11-27 21:19:56.114	22	\N	1060
de833873-cb00-4e42-a2c5-7985758453ad	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-19 09:24:36.412	2023-11-27 21:19:56.115	20	\N	976
f98227bf-84a7-446b-9325-6141d1bf39e9	POST	53	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-02 21:22:10.471	2023-11-27 21:19:56.117	23	\N	1266
ea052869-3746-4bc1-bf03-0deed297d2dc	POST	47	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-21 01:28:26.1	2023-11-27 21:19:56.119	17	\N	867
318bbcc3-47ea-433b-9fae-631f1c12a9cc	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-07 23:54:25.398	2023-11-27 21:19:56.121	22	\N	413
cbd7131d-54d3-41c5-a83e-125af3b0fb42	POST	53	\N	PENDING	\N	\N	\N	f	2023-10-16 20:54:33.522	2023-11-27 21:19:56.122	19	\N	415
08cfb5c5-af0c-4b47-aef1-fa773a19b7e0	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-03 10:17:51.52	2023-11-27 21:19:56.124	18	\N	1042
bdfbfaba-ab2e-45a0-b821-a83ffca65cfc	POST	29	\N	PENDING	\N	\N	\N	f	2023-10-09 01:54:47.249	2023-11-27 21:19:56.125	16	\N	930
dffd3f8e-9529-40b9-859b-83c9f0c92f29	POST	28	\N	PENDING	\N	\N	\N	f	2023-06-23 21:42:59.567	2023-11-27 21:19:56.127	23	\N	533
6b529bc3-b96a-4270-b7ac-4b1b4063587e	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-19 06:50:56.496	2023-11-27 21:19:56.129	22	\N	1110
da03ea04-da09-4b42-9758-a444b7343b0c	POST	5	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-01 10:11:56.06	2023-11-27 21:19:56.131	21	\N	1168
03749630-8545-4a65-a7e2-59e78b032279	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-14 17:12:14.728	2023-11-27 21:19:56.134	18	\N	1306
c409fb3f-59bb-488f-b889-fef1d7a721c7	POST	25	\N	DISCARDED	\N	\N	\N	f	2023-06-03 16:04:37.053	2023-11-27 21:19:56.135	14	\N	1022
fa759c36-fbe0-4a8b-b0bf-fcdb986c747f	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-10-23 08:59:15.965	2023-11-27 21:19:56.137	20	\N	1090
aa38c8cd-0553-4385-8037-09d118d55b2a	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-07 11:03:36.135	2023-11-27 21:19:56.139	21	\N	671
400244a0-da4e-4def-97fa-c65070c7eeed	POST	40	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-25 06:39:36.81	2023-11-27 21:19:56.141	18	\N	938
dfdded79-4508-42c5-8b7f-608dbc1f57db	POST	53	\N	PENDING	\N	\N	\N	f	2023-04-12 00:28:03.712	2023-11-27 21:19:56.142	17	\N	605
6d80b237-c5e5-4380-9f5a-493fc11d20bc	POST	43	\N	PENDING	\N	\N	\N	f	2022-12-30 18:47:49.511	2023-11-27 21:19:56.144	23	\N	618
ccb04975-863b-4bff-a494-e9da93c5119d	POST	51	\N	DISCARDED	\N	\N	\N	f	2023-06-09 10:08:43.817	2023-11-27 21:19:56.146	14	\N	600
7d5e9699-515a-4e7e-ba61-51d1e4feefbc	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-16 14:34:39.359	2023-11-27 21:19:56.147	15	\N	1364
37867338-3c64-4aa5-931f-f5f83e278693	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-09-03 09:55:30.267	2023-11-27 21:19:56.149	16	\N	816
338ce70f-61d1-4473-8285-770937cd1523	POST	40	\N	DISCARDED	\N	\N	\N	f	2023-09-30 04:17:17.872	2023-11-27 21:19:56.15	23	\N	1398
6873a507-6cac-4e3a-b820-2f238832c860	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-23 21:47:11.85	2023-11-27 21:19:56.152	21	\N	453
b5dfdc16-20a5-4a9e-a6ef-2fabc5976a2e	POST	30	\N	PENDING	\N	\N	\N	f	2023-09-05 09:54:06.044	2023-11-27 21:19:56.154	18	\N	799
4c9e3ecf-369d-4746-87d0-313c17fca8f8	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-26 14:13:15.479	2023-11-27 21:19:56.155	23	\N	1486
2bc0349b-ee66-459a-aad5-0fcd887f19d4	POST	50	\N	PENDING	\N	\N	\N	f	2023-09-07 04:23:40.752	2023-11-27 21:19:56.157	18	\N	751
0734d94c-ffd0-4522-b6e1-17105c90f880	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-26 13:27:24.439	2023-11-27 21:19:56.159	22	\N	1145
fc8e8b44-1b7a-4242-8be7-6323946d1e44	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-07-16 01:08:38.646	2023-11-27 21:19:56.161	17	\N	401
1d33c3c4-718a-4232-a10c-f245bb2c1959	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-03 14:11:48.344	2023-11-27 21:19:56.163	14	\N	510
d5f272b5-19e8-46c4-a32a-617341e51256	POST	59	\N	DISCARDED	\N	\N	\N	f	2023-02-24 18:12:51.865	2023-11-27 21:19:56.165	19	\N	877
cdc49582-b8f5-410c-9174-aadc59a28908	POST	3	\N	DISCARDED	\N	\N	\N	f	2022-12-10 18:26:51.91	2023-11-27 21:19:56.166	17	\N	1266
9e803b7a-9470-4927-a5f6-9709ab139421	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-02-02 18:50:03.977	2023-11-27 21:19:56.168	23	\N	789
322a56eb-c766-4849-880a-56fb08482aa8	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-01-18 02:28:04.7	2023-11-27 21:19:56.17	16	\N	768
8e74b815-45e7-4e61-8f89-2433ad36a0ce	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-08-24 01:01:49.02	2023-11-27 21:19:56.171	15	\N	1496
83dee4a0-0254-42ca-8c37-dd74f2401d14	POST	40	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-31 10:47:00.069	2023-11-27 21:19:56.173	16	\N	1268
cbe584da-0fa8-463c-96a6-3aec480f267f	POST	17	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-28 19:49:33.721	2023-11-27 21:19:56.174	22	\N	536
af2ac590-b94f-4636-9ff7-7e62e7de3a77	POST	31	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-10 22:35:15.448	2023-11-27 21:19:56.176	23	\N	1162
3e98c0c1-7c97-46af-b8a2-ee1fcdd89e45	POST	7	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-17 19:18:17.536	2023-11-27 21:19:56.177	23	\N	1131
407d25be-5f06-4da0-b459-e400f8628a47	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-18 12:26:33.804	2023-11-27 21:19:56.179	19	\N	634
83914451-2293-4034-9f26-09b0428d94e9	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-08-31 06:16:47.707	2023-11-27 21:19:56.18	20	\N	1152
24a257b0-e938-41da-8af2-a002fd679c0b	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-02-03 02:51:17.881	2023-11-27 21:19:56.182	16	\N	493
e596c919-a4dd-4a1a-be95-f38806a25877	POST	36	\N	PENDING	\N	\N	\N	f	2023-01-20 05:09:31.956	2023-11-27 21:19:56.183	14	\N	669
b809f620-4eda-4fb7-8728-ad61f5365c5f	POST	57	\N	PENDING	\N	\N	\N	f	2023-09-18 04:28:09.798	2023-11-27 21:19:56.185	17	\N	407
eb6411b1-a0d5-4a73-9e35-b07c3a582f6b	POST	28	\N	PENDING	\N	\N	\N	f	2023-05-26 21:53:23.586	2023-11-27 21:19:56.187	18	\N	1368
b24d5def-a8f1-4019-aeb6-8d2b38f75b46	POST	20	\N	PENDING	\N	\N	\N	f	2023-09-28 04:08:38.602	2023-11-27 21:19:56.189	20	\N	1364
41306f3e-9e7d-411d-88dd-a8d5d790a7bc	POST	44	\N	PENDING	\N	\N	\N	f	2023-04-16 18:12:51.12	2023-11-27 21:19:56.19	23	\N	970
9c026fc5-c4ac-4225-91ca-56d755f21cbb	POST	22	\N	DISCARDED	\N	\N	\N	f	2023-08-17 03:14:44.863	2023-11-27 21:19:56.192	17	\N	1173
b48129eb-b8b3-45f1-b156-4ec347d9ff88	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-28 05:26:39.573	2023-11-27 21:19:56.194	15	\N	1251
35136471-4d7a-4f4d-9c73-7b8b618a3609	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-20 11:06:55.156	2023-11-27 21:19:56.195	22	\N	711
cacd2929-39b8-4370-8c98-a9d742d8d208	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-22 01:46:54.751	2023-11-27 21:19:56.197	22	\N	1491
8ae945f7-47a1-4c92-9691-ea5d95e172b3	POST	8	\N	DISCARDED	\N	\N	\N	f	2023-02-06 17:11:23.18	2023-11-27 21:19:56.199	18	\N	1369
4f2d5f75-dcad-43fe-9eda-c3305d2d4e98	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-27 09:48:09.475	2023-11-27 21:19:56.2	16	\N	724
3c1af4af-f27a-45cf-88ce-8db3c2f786fd	POST	50	\N	PENDING	\N	\N	\N	f	2023-08-30 05:14:44.352	2023-11-27 21:19:56.202	18	\N	524
e9db8a45-dcb6-4aad-8434-c86098fc537b	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-25 12:52:45.315	2023-11-27 21:19:56.203	19	\N	362
d170bc8e-9d64-46d4-89e3-19a1bd45226a	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-08-05 12:52:07.584	2023-11-27 21:19:56.205	20	\N	1018
8fffa04b-9e65-4c56-b1f0-c0b6a4204702	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-03-04 14:50:22.088	2023-11-27 21:19:56.206	15	\N	1504
254f258e-e517-4416-a496-081bfe32f268	POST	5	\N	PENDING	\N	\N	\N	f	2023-01-28 00:24:44.749	2023-11-27 21:19:56.21	20	\N	1034
1d6adc60-da52-4dce-90dc-b813c02d6a40	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-07-29 01:39:40.299	2023-11-27 21:19:56.213	18	\N	345
376fa7d2-07cc-40a4-9a8e-b8230a4e263b	POST	21	\N	PENDING	\N	\N	\N	f	2022-12-09 15:26:03.911	2023-11-27 21:19:56.215	21	\N	567
ea9445af-0ac1-464f-87dd-750b5b113d60	POST	17	\N	PENDING	\N	\N	\N	f	2023-07-11 11:07:57.843	2023-11-27 21:19:56.216	21	\N	1193
93d73ca3-5901-4ea3-937d-473849f77496	POST	55	\N	PENDING	\N	\N	\N	f	2023-04-12 00:51:17.69	2023-11-27 21:19:56.218	21	\N	993
10d1391d-5918-4475-841c-92442a58fcf6	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-04-22 01:50:55.416	2023-11-27 21:19:56.22	14	\N	1181
109b2747-57a4-40c0-aeec-3f7e56c5f423	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-30 10:56:27.873	2023-11-27 21:19:56.221	23	\N	903
431987ce-21b7-449a-bcae-2f14fafbc0d0	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-29 07:21:11.224	2023-11-27 21:19:56.223	15	\N	1463
1ee93e00-f0bb-49b5-a108-e0908d75b5ab	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-05 21:57:04.297	2023-11-27 21:19:56.224	14	\N	360
681507d3-f7e4-427c-9b77-251597b4b1a9	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-08-16 07:34:42.429	2023-11-27 21:19:56.226	15	\N	599
df3db307-0d96-45a8-8596-00e155295ab6	POST	26	\N	PENDING	\N	\N	\N	f	2023-03-17 16:47:23.922	2023-11-27 21:19:56.228	18	\N	378
419e4a6e-c884-4a11-8d18-0b8be318681d	POST	10	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-19 19:31:49.977	2023-11-27 21:19:56.229	18	\N	1137
b7d42235-9be8-4f9c-a2ce-9f0758a53ec6	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-11-09 06:56:59.291	2023-11-27 21:19:56.231	23	\N	1074
56d8eb97-67de-4808-9815-717a2a1c19fc	POST	28	\N	PENDING	\N	\N	\N	f	2023-03-22 19:46:11.847	2023-11-27 21:19:56.233	22	\N	674
b3914e67-16ca-4a8b-9bdf-4db593bb4b4f	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-01-19 11:25:40.36	2023-11-27 21:19:56.234	18	\N	870
052979e2-1ccf-4198-9aba-2fa3cf92ae0a	POST	52	\N	PENDING	\N	\N	\N	f	2022-12-31 00:12:31.355	2023-11-27 21:19:56.236	19	\N	1320
ad554b88-2961-4acd-8745-b6eeb1d3083d	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-03-31 21:23:19.54	2023-11-27 21:19:56.237	16	\N	837
66a36874-a522-40a0-b4fe-4b8989885b1c	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-16 16:54:58.287	2023-11-27 21:19:56.239	16	\N	1387
f4bf39ab-c951-4c9d-982b-39057237f716	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-05-24 09:47:10.259	2023-11-27 21:19:56.241	22	\N	1242
2dcfc8d0-311e-4693-97e0-25ef103ddbaf	POST	17	\N	PENDING	\N	\N	\N	f	2023-03-21 17:48:59.107	2023-11-27 21:19:56.243	14	\N	966
dc6ecbed-1f65-48e6-a6a2-8c0f01379051	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-13 16:33:28.567	2023-11-27 21:19:56.244	19	\N	628
6c2bde05-17a8-49ee-b5a6-8c97e2b150b4	POST	24	\N	PENDING	\N	\N	\N	f	2023-02-04 23:03:22.972	2023-11-27 21:19:56.246	23	\N	1363
e65643ad-e7c3-424e-9f78-e29c4321b73f	POST	57	\N	PENDING	\N	\N	\N	f	2023-09-06 07:20:43.363	2023-11-27 21:19:56.248	23	\N	1068
cd8afa08-faad-4193-b187-d79278fcaf2d	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-20 02:55:30.178	2023-11-27 21:19:56.25	18	\N	880
667a4c9d-82cd-4faf-9cdf-acf2e6cf9226	POST	32	\N	PENDING	\N	\N	\N	f	2023-09-13 02:37:57.844	2023-11-27 21:19:56.251	15	\N	360
aa150e30-c543-4b3d-af4d-ad7878a88e45	POST	24	\N	DISCARDED	\N	\N	\N	f	2023-09-27 20:04:40.501	2023-11-27 21:19:56.253	16	\N	502
9333e753-d214-467f-84f4-cace012f5b2c	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-31 21:07:37.429	2023-11-27 21:19:56.254	20	\N	621
7de7dc07-2bec-4a3e-915e-f3b8d9ad85ed	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-04-18 19:04:39.858	2023-11-27 21:19:56.257	23	\N	1484
3cb194d7-f596-4276-851a-491f164fb400	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-08-27 06:51:22.615	2023-11-27 21:19:56.259	21	\N	1061
4d8a75b7-cb79-44f2-a349-54e3c16e70e8	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-03 03:55:06.53	2023-11-27 21:19:56.261	22	\N	1169
1433b65f-bac7-4ce4-92c9-c723364fa416	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-10-23 21:29:48.225	2023-11-27 21:19:56.263	14	\N	455
a372bb35-d5c1-4fb6-89f2-c44c553a683e	POST	16	\N	PENDING	\N	\N	\N	f	2023-02-01 00:34:17.638	2023-11-27 21:19:56.265	18	\N	906
0e5c19a2-2680-4ca7-a2fe-89ac924a8de8	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-20 15:53:36.535	2023-11-27 21:19:56.267	22	\N	912
8f9bd148-01b3-41c7-9639-de772a350098	POST	11	\N	PENDING	\N	\N	\N	f	2023-08-21 10:26:12.556	2023-11-27 21:19:56.268	18	\N	1194
479ebc0e-b0e6-402a-921b-663e4b74753c	POST	5	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-24 05:04:01.681	2023-11-27 21:19:56.27	23	\N	888
636f779b-32bc-4c50-8926-2955d8839627	POST	48	\N	PENDING	\N	\N	\N	f	2023-07-10 04:05:49.506	2023-11-27 21:19:56.273	14	\N	566
c5e95455-99ab-4ba9-953a-dc1d58902328	POST	8	\N	PENDING	\N	\N	\N	f	2023-09-26 12:01:50.344	2023-11-27 21:19:56.275	19	\N	558
da9cc5cc-7346-4038-967e-c148e16cbaca	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-07 01:46:59.322	2023-11-27 21:19:56.277	16	\N	1314
3f1aafd4-2883-49a3-90dc-9be707bc9f06	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-10-04 18:32:27.401	2023-11-27 21:19:56.279	16	\N	995
8f094556-1cfa-483d-be7e-8f16e129f38a	POST	41	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-29 18:04:20.92	2023-11-27 21:19:56.281	15	\N	588
4dd94faa-a623-4a84-aa86-139ba835050e	POST	23	\N	DISCARDED	\N	\N	\N	f	2023-03-30 08:39:51.571	2023-11-27 21:19:56.283	19	\N	1426
e2b64fe7-ccae-4026-a4bd-a22ce24b789d	POST	41	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-03 22:03:10.534	2023-11-27 21:19:56.284	21	\N	351
80c78829-bec8-45fd-9887-51e430eaa9e0	POST	27	\N	DISCARDED	\N	\N	\N	f	2022-12-16 22:11:26.409	2023-11-27 21:19:56.286	15	\N	1107
cb8784b0-df62-44e9-9ba5-9b14a27ae331	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-10 18:25:59.206	2023-11-27 21:19:56.288	20	\N	582
c87e605e-d8c5-43e2-ab18-8b7bd5eed172	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-04-12 08:28:15.662	2023-11-27 21:19:56.29	14	\N	1185
0fe16ace-651c-4233-9dc1-7dff64d71441	POST	36	\N	PENDING	\N	\N	\N	f	2023-01-12 11:38:27.211	2023-11-27 21:19:56.292	21	\N	697
df52b919-2220-435d-9384-394a8ab6f178	POST	2	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-10 09:14:58.026	2023-11-27 21:19:56.294	14	\N	431
9d8801ae-a2d6-4a8f-b0fc-41d1845ce4cb	POST	14	\N	PENDING	\N	\N	\N	f	2023-11-01 15:04:42.03	2023-11-27 21:19:56.296	19	\N	1397
c38dc748-638c-4808-8c71-8082e29d1391	POST	38	\N	DISCARDED	\N	\N	\N	f	2023-04-10 23:25:02.515	2023-11-27 21:19:56.298	20	\N	1354
6bb91fd2-4e1a-42a3-8218-e6c790f76a45	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-29 02:06:57.042	2023-11-27 21:19:56.3	14	\N	342
0cbcd5b7-9d0d-4c36-baed-012b29f123aa	POST	41	\N	PENDING	\N	\N	\N	f	2023-08-03 21:57:51.153	2023-11-27 21:19:56.302	23	\N	736
60fd2f3d-eda5-44d4-ba20-68736a9c7419	POST	42	\N	PENDING	\N	\N	\N	f	2023-03-08 13:25:24.21	2023-11-27 21:19:56.305	21	\N	686
ddbc7bc3-7ab1-418e-ada1-e5287fe1956d	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-02-20 03:24:19.113	2023-11-27 21:19:56.307	23	\N	558
058e4673-7531-48a7-8a6c-171a81bb1447	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-21 22:14:24.798	2023-11-27 21:19:56.309	21	\N	932
035ebb90-78cd-46da-8222-146a48a66b0c	POST	51	\N	DISCARDED	\N	\N	\N	f	2023-01-11 02:53:03.562	2023-11-27 21:19:56.311	22	\N	1137
60241aa3-45ab-455f-8429-c591d3a27846	POST	42	\N	DISCARDED	\N	\N	\N	f	2023-01-08 12:12:18.329	2023-11-27 21:19:56.313	15	\N	1359
9346201e-856c-40b4-8ebd-d4674a044e4e	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-04-08 17:37:26.976	2023-11-27 21:19:56.315	17	\N	1221
95d0a64e-bc23-45cc-9a8e-c8d4bf368ea3	POST	49	\N	PENDING	\N	\N	\N	f	2023-10-12 16:22:12.124	2023-11-27 21:19:56.317	16	\N	1468
4aa4edaf-a749-4dd9-8e9a-adde6df3daab	POST	52	\N	DISCARDED	\N	\N	\N	f	2023-10-07 22:37:11.043	2023-11-27 21:19:56.319	22	\N	862
ca042de9-200e-4cbd-a8bd-610fdce5cdca	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-07-18 11:28:55.481	2023-11-27 21:19:56.321	17	\N	1180
ef9be185-483e-4e42-9729-062ff48ab44d	POST	6	\N	PENDING	\N	\N	\N	f	2023-04-20 02:28:26.656	2023-11-27 21:19:56.323	23	\N	932
349581c4-fd42-4439-92c9-d0c92cd77698	POST	58	\N	PENDING	\N	\N	\N	f	2023-01-31 03:41:14.591	2023-11-27 21:19:56.325	23	\N	1121
0ac961e3-c215-43c3-aaab-508659904fa1	POST	24	\N	PENDING	\N	\N	\N	f	2023-03-14 01:44:01.832	2023-11-27 21:19:56.326	22	\N	440
77d13e33-dd16-4a4e-b370-13017f9fdaa5	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-27 00:33:27.6	2023-11-27 21:19:56.328	22	\N	354
61419e73-b67f-4f24-89f0-734dd921c811	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-05 02:07:10.509	2023-11-27 21:19:56.33	18	\N	1095
1811a4f0-3d17-4d98-9132-d286acb14323	POST	8	\N	DISCARDED	\N	\N	\N	f	2022-12-28 09:45:26.474	2023-11-27 21:19:56.332	19	\N	1357
2da5e177-4936-4091-8378-083f8f906df0	POST	59	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-20 10:30:59.652	2023-11-27 21:19:56.334	15	\N	542
7e2af29f-de27-4ccb-bf12-538da24758d2	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-10-10 04:26:48.532	2023-11-27 21:19:56.336	23	\N	810
877d8ad5-7990-40f7-81ad-57d4f6b852eb	POST	2	\N	PENDING	\N	\N	\N	f	2023-07-11 05:23:04.104	2023-11-27 21:19:56.338	17	\N	772
4b0bb160-26e5-4273-b285-8f62d455629a	POST	43	\N	PENDING	\N	\N	\N	f	2023-08-14 15:20:20.052	2023-11-27 21:19:56.339	22	\N	1240
e777f621-0e89-49c9-b0f3-9cc4673dabf2	POST	27	\N	DISCARDED	\N	\N	\N	f	2023-11-15 01:12:54.139	2023-11-27 21:19:56.342	23	\N	585
22899927-e466-4a58-8120-71301f9051a6	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-02-18 04:10:06.9	2023-11-27 21:19:56.344	17	\N	339
41ee9ff5-1ff7-4d9f-8ed8-48bc56d456c8	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-04-17 19:29:21.034	2023-11-27 21:19:56.346	14	\N	1525
ca5a531d-7ca9-44c4-811a-7c1ff4666042	POST	42	\N	PENDING	\N	\N	\N	f	2023-01-28 03:43:34.513	2023-11-27 21:19:56.347	18	\N	932
ca71baa0-19be-4547-b79f-994161c3c2d4	POST	22	\N	DISCARDED	\N	\N	\N	f	2023-06-06 10:35:39.963	2023-11-27 21:19:56.349	17	\N	1094
1f02fdc2-deb7-49b0-bee8-ec7bf7f0ab21	POST	35	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-02 15:34:58.398	2023-11-27 21:19:56.351	18	\N	1288
a03ac8da-689d-43cb-b13b-e86283d60d8a	POST	16	\N	PENDING	\N	\N	\N	f	2023-09-13 05:22:45.104	2023-11-27 21:19:56.353	14	\N	1438
67bb12e7-6332-4e64-b8e0-53a8d0ff64c6	POST	48	\N	DISCARDED	\N	\N	\N	f	2023-10-20 07:49:39.208	2023-11-27 21:19:56.355	22	\N	1104
1fc66dbd-d0bc-420d-8381-e7da68395602	POST	25	\N	PENDING	\N	\N	\N	f	2023-06-18 01:42:14.186	2023-11-27 21:19:56.357	16	\N	1260
c03c4b6f-28b8-42f3-8d65-5eab5180d6e2	POST	30	\N	PENDING	\N	\N	\N	f	2023-07-24 14:30:37.598	2023-11-27 21:19:56.359	19	\N	865
de913fb9-dca2-4c73-b741-7759ec1fa02a	POST	58	\N	PENDING	\N	\N	\N	f	2023-01-13 04:23:36.376	2023-11-27 21:19:56.361	21	\N	1352
be0c8957-f333-4e76-baf6-aec82aa35b28	POST	29	\N	PENDING	\N	\N	\N	f	2023-09-14 12:53:23.749	2023-11-27 21:19:56.363	15	\N	1403
a7730227-7782-4dda-9ce4-d140968ab597	POST	46	\N	PENDING	\N	\N	\N	f	2023-05-18 20:04:11.243	2023-11-27 21:19:56.365	23	\N	803
3c55baaf-17b1-4b5f-be69-cccacf7953c9	POST	56	\N	PENDING	\N	\N	\N	f	2023-03-09 21:22:42.328	2023-11-27 21:19:56.367	18	\N	613
353dc797-ba1a-4029-99a0-e0634afa0f4d	POST	15	\N	PENDING	\N	\N	\N	f	2023-08-16 09:09:32.546	2023-11-27 21:19:56.369	15	\N	796
7530632a-4425-4752-b3c8-cf20b84a2726	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-01-22 05:38:39.596	2023-11-27 21:19:56.371	19	\N	1425
edd4e102-4e7f-4baf-8806-076305069cd5	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-10-02 19:42:49.152	2023-11-27 21:19:56.373	20	\N	1461
57ed870c-82b1-444e-810a-4308cb9dca9f	POST	21	\N	PENDING	\N	\N	\N	f	2023-07-22 16:42:22.887	2023-11-27 21:19:56.375	23	\N	1344
ee375aee-e425-4c16-9801-087c52d77366	POST	17	\N	PENDING	\N	\N	\N	f	2023-07-28 09:16:32.094	2023-11-27 21:19:56.377	21	\N	1114
f0da35d4-cff9-4b48-9a18-3f2ca6943ad5	POST	2	\N	PENDING	\N	\N	\N	f	2023-10-11 08:52:05.345	2023-11-27 21:19:56.379	19	\N	1400
7fe73651-de8f-4a3b-812e-98232da9f360	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-11-07 00:23:45.694	2023-11-27 21:19:56.382	23	\N	1143
6f8a397a-07c8-430a-987a-f09812656553	POST	7	\N	PENDING	\N	\N	\N	f	2023-10-06 16:20:36.615	2023-11-27 21:19:56.384	19	\N	942
0b6bb548-0388-4032-b60c-34c2734869fc	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-04-20 15:33:15.354	2023-11-27 21:19:56.386	18	\N	415
4289fe14-ab39-4092-b7d4-c38c66b51494	POST	40	\N	DISCARDED	\N	\N	\N	f	2022-12-17 12:49:08.02	2023-11-27 21:19:56.388	15	\N	560
a4208dc3-1530-41d8-af6f-ef11627fac0f	POST	26	\N	PENDING	\N	\N	\N	f	2023-02-08 00:51:03.256	2023-11-27 21:19:56.39	18	\N	868
3036ad11-ddcb-4900-8a07-31739fe20a65	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-27 08:28:54.347	2023-11-27 21:19:56.392	16	\N	1424
3fd1c1a3-d7be-43b1-98d9-5a13685e8609	POST	36	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-25 18:19:23.792	2023-11-27 21:19:56.395	14	\N	456
1f02ee31-f44f-438c-940b-3e2b7a8b334e	POST	2	\N	PENDING	\N	\N	\N	f	2023-10-13 07:48:07.244	2023-11-27 21:19:56.397	21	\N	443
b54ec33a-01d3-4e49-89b4-83275e3432f5	POST	39	\N	PENDING	\N	\N	\N	f	2023-09-12 08:38:04.744	2023-11-27 21:19:56.399	21	\N	1503
50fa640d-3d0f-4eff-8aa3-86925c01f8e7	POST	42	\N	DISCARDED	\N	\N	\N	f	2022-12-23 15:09:26.475	2023-11-27 21:19:56.401	17	\N	450
7d0ec4e4-4c71-4487-ab52-b83b7bfe9e2c	POST	43	\N	PENDING	\N	\N	\N	f	2023-04-01 00:56:13.968	2023-11-27 21:19:56.403	18	\N	1010
e3ee3022-bd68-4755-9e9a-bb01a3e75c58	POST	5	\N	DISCARDED	\N	\N	\N	f	2023-03-16 07:02:10.579	2023-11-27 21:19:56.405	15	\N	663
2da67441-21a6-4679-8958-1ed56658cd4a	POST	10	\N	PENDING	\N	\N	\N	f	2023-10-13 07:22:46.48	2023-11-27 21:19:56.408	23	\N	549
d48787fe-bc86-439b-883d-374eecc22bc2	POST	58	\N	DISCARDED	\N	\N	\N	f	2023-02-01 11:36:05.675	2023-11-27 21:19:56.41	19	\N	650
145990fb-2f09-47a4-9130-18e020d9b065	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-01 01:48:19.727	2023-11-27 21:19:56.412	16	\N	341
3de3d9a2-2ed1-42f4-b22f-af69508e4aed	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-19 18:52:44.556	2023-11-27 21:19:56.415	17	\N	482
aa9625fb-7f0f-45b8-ba8e-7e09f38f8b45	POST	48	\N	DISCARDED	\N	\N	\N	f	2023-06-19 12:32:04.842	2023-11-27 21:19:56.417	14	\N	1047
af4a5fad-2256-4a66-ae6c-456d121f274a	POST	19	\N	PENDING	\N	\N	\N	f	2023-10-15 15:02:14.084	2023-11-27 21:19:56.419	18	\N	1209
9e08a022-e0a8-4223-8e6b-0ba6c4c7c169	POST	49	\N	DISCARDED	\N	\N	\N	f	2023-04-16 15:52:10.792	2023-11-27 21:19:56.421	20	\N	859
5aa83c2a-a413-48d7-8347-d8d394f777d6	POST	9	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-23 18:21:05.392	2023-11-27 21:19:56.423	20	\N	629
412cff4b-15a2-4692-9185-59864518760e	POST	35	\N	PENDING	\N	\N	\N	f	2023-01-17 04:27:21.274	2023-11-27 21:19:56.425	23	\N	763
ebd51af8-1dc6-4e47-b41f-13ec0e683376	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-05-14 18:12:58.73	2023-11-27 21:19:56.427	21	\N	751
f6afc590-d95f-4b5d-a515-525465c2e167	POST	45	\N	DISCARDED	\N	\N	\N	f	2023-10-12 01:23:34.409	2023-11-27 21:19:56.429	19	\N	1132
f610e0ea-197d-413d-b8bb-80c2b5da4444	POST	24	\N	DISCARDED	\N	\N	\N	f	2023-05-31 09:47:19.499	2023-11-27 21:19:56.431	23	\N	1511
357d965e-6b19-4b8f-b7a6-f26bc6a1a27e	POST	37	\N	PENDING	\N	\N	\N	f	2022-12-29 13:47:50.016	2023-11-27 21:19:56.433	20	\N	720
6fa5855c-e1ca-416d-9a27-b5ecfc6a80c9	POST	50	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-27 00:03:21.041	2023-11-27 21:19:56.436	18	\N	772
68b20db3-75f4-47fd-83fe-b555c7ed6143	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-30 04:31:49.18	2023-11-27 21:19:56.438	22	\N	533
8a2a1193-5c06-41b7-8cfa-caa133c8b2b7	POST	8	\N	PENDING	\N	\N	\N	f	2023-07-31 02:18:21.02	2023-11-27 21:19:56.44	21	\N	575
2b6df180-9f93-435c-a77c-12975b96e173	POST	22	\N	DISCARDED	\N	\N	\N	f	2023-03-14 16:07:39.403	2023-11-27 21:19:56.442	22	\N	465
d11be0e7-d267-4b22-8148-61e90fa5684c	POST	31	\N	PENDING	\N	\N	\N	f	2023-04-01 23:13:27.151	2023-11-27 21:19:56.445	20	\N	759
79e1de2e-966c-49b3-8f40-e43dfa50e7e6	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-19 18:07:50.192	2023-11-27 21:19:56.456	15	\N	584
8ede93d2-5d6a-4a54-8249-dc2c0d4d8ae0	POST	46	\N	PENDING	\N	\N	\N	f	2023-10-21 07:40:16.61	2023-11-27 21:19:56.462	14	\N	773
a029eef0-25ed-4a52-8ade-da1d7099a331	POST	33	\N	PENDING	\N	\N	\N	f	2023-11-27 03:27:29.45	2023-11-27 21:19:56.464	23	\N	577
67526ec0-4bed-480b-b001-e3306d6f3d27	POST	32	\N	PENDING	\N	\N	\N	f	2022-12-19 16:08:13.189	2023-11-27 21:19:56.466	16	\N	685
c1a0ae25-0393-4ed2-9da7-d55d726a0794	POST	3	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-26 17:16:03.085	2023-11-27 21:19:56.468	14	\N	759
29b504f1-e6e1-48f5-a2a3-4e321b9a557e	POST	35	\N	PENDING	\N	\N	\N	f	2023-05-16 13:28:04.222	2023-11-27 21:19:56.47	22	\N	909
39ea8773-5c13-4ee7-86b6-c064686a3070	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-09-05 04:50:14.319	2023-11-27 21:19:56.472	14	\N	680
bab182ed-a6f7-4871-920f-bc28ba634973	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-21 09:02:02.641	2023-11-27 21:19:56.475	22	\N	1316
c4ac3fa1-ccb3-4d23-8faa-e58557d52995	POST	39	\N	PENDING	\N	\N	\N	f	2023-04-13 22:08:38.281	2023-11-27 21:19:56.481	17	\N	997
72dc5d1b-bba8-40aa-adeb-4b3fe9f545b8	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-07-29 22:47:40.201	2023-11-27 21:19:56.483	15	\N	515
f294011a-6648-4cc6-9269-da35862aa6f0	POST	53	\N	PENDING	\N	\N	\N	f	2023-10-21 11:55:37.203	2023-11-27 21:19:56.486	20	\N	1313
7eb86c3c-012d-48d1-b313-dd8dbbb72cce	POST	49	\N	PENDING	\N	\N	\N	f	2023-03-18 02:37:19.861	2023-11-27 21:19:56.488	19	\N	1044
bd0f18e2-3156-4eb2-ac89-5903de03bbaf	POST	5	\N	PENDING	\N	\N	\N	f	2023-02-27 21:59:58.187	2023-11-27 21:19:56.49	21	\N	886
a842840c-2218-449f-9003-76ebce80b8a7	POST	52	\N	PENDING	\N	\N	\N	f	2023-09-08 04:44:54.196	2023-11-27 21:19:56.492	18	\N	1084
1edc648f-21b5-4f44-bd42-6ce44ecd2a44	POST	14	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-07 07:23:52.838	2023-11-27 21:19:56.503	21	\N	934
4a7a6c0b-471f-4c00-a33a-cb13f363ddb6	POST	15	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-29 05:21:07.492	2023-11-27 21:19:56.506	14	\N	1174
99c99ee8-ab97-4af2-849a-d92b3b79dcc6	POST	3	\N	PENDING	\N	\N	\N	f	2023-02-17 19:46:06.226	2023-11-27 21:19:56.507	16	\N	705
3c9c33de-b2d3-42af-843b-941e5b70e8ac	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-24 00:31:30.262	2023-11-27 21:19:56.509	18	\N	1289
71670a3a-f68d-4871-8420-912c59259a8c	POST	13	\N	DISCARDED	\N	\N	\N	f	2023-07-07 02:04:39.515	2023-11-27 21:19:56.511	20	\N	448
25a75173-44b2-4368-8201-e52bd5ba1044	POST	22	\N	PENDING	\N	\N	\N	f	2023-01-12 00:05:01.631	2023-11-27 21:19:56.513	22	\N	796
74880542-d41e-485a-99bd-eabb71597a17	POST	51	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-09 08:11:04.703	2023-11-27 21:19:56.515	17	\N	1153
74615e1b-710a-4908-b1b1-e5216be8d9ff	POST	8	\N	PENDING	\N	\N	\N	f	2023-06-02 09:27:20.246	2023-11-27 21:19:56.517	15	\N	451
f1b3d3fe-dfe0-47b3-87a5-318acbec1749	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-07 15:52:11.316	2023-11-27 21:19:56.519	17	\N	1497
c7aee5bf-e8f0-486b-80ba-4b5d1c65776f	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-05-06 00:46:04.425	2023-11-27 21:19:56.521	19	\N	742
e7ff6d37-9fe0-4751-9f78-c23b8682f332	POST	25	\N	PENDING	\N	\N	\N	f	2023-06-11 10:27:56.696	2023-11-27 21:19:56.525	17	\N	1166
d37e63d8-5348-453f-b1a9-ea70fb082f00	POST	14	\N	PENDING	\N	\N	\N	f	2022-11-27 21:20:12.462	2023-11-27 21:19:56.538	21	\N	1207
4596edf5-11ea-48db-bcd6-b4d2748e637e	POST	41	\N	PENDING	\N	\N	\N	f	2023-10-31 14:55:59.692	2023-11-27 21:19:56.542	21	\N	1087
3bba7292-e374-47ea-a490-ed47b0b82b2b	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-08-14 20:56:19.351	2023-11-27 21:19:56.543	14	\N	810
e03133c9-5bfd-423e-be7d-6aacb1f426ef	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-09 21:11:23.35	2023-11-27 21:19:56.545	21	\N	1109
2f9b0c26-ce0f-4593-a3fb-7f38d5659114	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-14 10:56:36.093	2023-11-27 21:19:56.547	21	\N	1117
fdea1748-f7cd-4499-bddb-cfad1ec81581	POST	31	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-04 02:36:03.857	2023-11-27 21:19:56.549	22	\N	1259
5f3438c3-f35f-46f5-a7a7-e873a6d30bdc	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-04-28 15:28:19.185	2023-11-27 21:19:56.55	22	\N	1047
62481ff2-9cd0-4d57-b815-a790dced62d4	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-16 02:00:33.664	2023-11-27 21:19:56.552	20	\N	536
52228b96-6afd-4243-97ce-b382531fe4c5	POST	28	\N	PENDING	\N	\N	\N	f	2023-05-19 06:13:47.941	2023-11-27 21:19:56.554	16	\N	1171
7c396264-1dfc-4b75-b52b-83619fa9bec9	POST	22	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-22 13:54:29.757	2023-11-27 21:19:56.556	14	\N	363
2e92de44-edf3-4adf-95ef-164b7f6d552c	POST	49	\N	PENDING	\N	\N	\N	f	2023-05-13 20:25:28.887	2023-11-27 21:19:56.558	22	\N	773
0eb8cf27-9ed0-46c1-b5ec-41b73706acbc	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-18 04:27:13.912	2023-11-27 21:19:56.561	18	\N	497
df86ed44-d87d-4153-b007-507f335ba454	POST	28	\N	PENDING	\N	\N	\N	f	2023-09-29 22:36:16.178	2023-11-27 21:19:56.563	18	\N	978
12e51ff1-4710-4ca6-9ad1-13e6df83d363	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-11 07:20:48.411	2023-11-27 21:19:56.565	15	\N	983
7947badb-298e-4aa8-8358-7f7976738342	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-04-28 12:43:47.477	2023-11-27 21:19:56.567	22	\N	1063
5c4f0dc2-716a-4750-8fe7-282f8d3cd244	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-16 11:40:03.547	2023-11-27 21:19:56.569	19	\N	543
56b6c0b3-658d-48fd-bfd8-c36a5704bea3	POST	42	\N	PENDING	\N	\N	\N	f	2023-08-17 09:56:20.639	2023-11-27 21:19:56.571	22	\N	1487
9898ecd6-9ade-4448-820c-8d07704dc914	POST	48	\N	PENDING	\N	\N	\N	f	2023-08-18 01:54:42.337	2023-11-27 21:19:56.573	20	\N	1083
8ab5f38a-c1bb-49a3-ab8b-95871e3a24eb	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-06-13 17:09:14.073	2023-11-27 21:19:56.574	22	\N	1424
30543489-88e2-4611-b653-dfc787e959f1	POST	2	\N	DISCARDED	\N	\N	\N	f	2023-04-09 16:38:06.094	2023-11-27 21:19:56.576	17	\N	823
b4ea776b-d6d7-483b-9dcd-3274268ab840	POST	18	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-23 12:44:20.885	2023-11-27 21:19:56.578	16	\N	915
a17e749f-65a9-4940-8d67-bfa0dcf551fc	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-27 07:39:52.796	2023-11-27 21:19:56.579	23	\N	801
163ac539-a1e1-4494-b653-5d283d2d91f9	POST	12	\N	DISCARDED	\N	\N	\N	f	2023-07-21 06:15:03.568	2023-11-27 21:19:56.581	17	\N	690
02d47389-ac27-4475-8a73-1cf4a3d688ca	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-18 19:39:22.753	2023-11-27 21:19:56.583	19	\N	674
fc69f685-43f5-472e-8c9d-f6f2d38206ae	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-09-22 01:42:33.439	2023-11-27 21:19:56.585	14	\N	1132
8752f644-a339-4041-810f-b3218484bb53	POST	46	\N	PENDING	\N	\N	\N	f	2023-07-01 18:55:57.666	2023-11-27 21:19:56.586	22	\N	1201
2df90b61-952a-48f2-9d48-e7c2ab7e6c3d	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-08 22:57:43.441	2023-11-27 21:19:56.589	16	\N	1041
6353dc31-a5a1-4701-b73a-d838c479c33c	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-06-16 09:25:58.033	2023-11-27 21:19:56.591	19	\N	556
c366c1e2-7a04-4f57-a768-e62fe5857239	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-10 05:33:02.292	2023-11-27 21:19:56.593	17	\N	1448
fd9a35de-83d9-484a-8429-d9c579259116	POST	7	\N	PENDING	\N	\N	\N	f	2023-09-16 10:42:14.252	2023-11-27 21:19:56.594	17	\N	980
11ffccfb-2e08-41ae-9450-05b4b31a734d	POST	46	\N	PENDING	\N	\N	\N	f	2023-08-20 12:37:52.07	2023-11-27 21:19:56.596	16	\N	1009
721351d0-e633-447f-b414-cb1a4031cfc6	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-26 19:30:03.267	2023-11-27 21:19:56.598	21	\N	532
cecc4b41-4144-459c-9c7b-e42518971184	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-05 23:00:36.18	2023-11-27 21:19:56.601	16	\N	968
5b3282c6-3b4a-46fd-b317-df01b3981355	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-20 03:13:57.005	2023-11-27 21:19:56.603	19	\N	990
02de48bf-65a0-4359-808c-93b423ab2166	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-03 03:42:23.805	2023-11-27 21:19:56.604	21	\N	504
48a5b84c-54a9-47a3-9faa-247351048c07	POST	37	\N	DISCARDED	\N	\N	\N	f	2023-07-06 10:48:43.194	2023-11-27 21:19:56.606	15	\N	851
c319b3ee-5560-44af-af2f-04653bfd1219	POST	49	\N	PENDING	\N	\N	\N	f	2023-05-09 13:52:23.752	2023-11-27 21:19:56.608	20	\N	1102
c47f0536-ea0a-44d9-8aa6-b7c1c5f59f8d	POST	47	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-21 21:18:27.944	2023-11-27 21:19:56.609	18	\N	527
7b07dde2-b3d6-48d9-9259-7b8911cf01c3	POST	27	\N	PENDING	\N	\N	\N	f	2023-03-21 13:18:26.396	2023-11-27 21:19:56.611	14	\N	1029
a8b30658-4099-4b0f-9e64-35db7a5785ff	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-02-17 15:48:24.564	2023-11-27 21:19:56.612	16	\N	953
acfe1a43-e0c4-49f6-b27a-e65ff02b278b	POST	48	\N	PENDING	\N	\N	\N	f	2023-03-07 06:55:39.03	2023-11-27 21:19:56.614	20	\N	1523
50163b2d-ce34-437b-ab23-03b53abcf722	POST	12	\N	DISCARDED	\N	\N	\N	f	2022-12-24 07:36:13.213	2023-11-27 21:19:56.616	19	\N	644
c442c548-a761-47e2-9bfd-b2a23ec07f0d	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-14 00:31:16.371	2023-11-27 21:19:56.617	18	\N	815
79196515-384d-4458-b6a5-da4bb82f3090	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-10 02:20:46.302	2023-11-27 21:19:56.619	18	\N	971
711d0051-425c-4d5e-8130-859933332c5e	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-24 04:08:14.403	2023-11-27 21:19:56.62	17	\N	887
227f116c-28ae-4d78-9a60-fa987f3b0452	POST	5	\N	DISCARDED	\N	\N	\N	f	2023-06-28 10:46:10.562	2023-11-27 21:19:56.622	19	\N	1013
11785364-ee50-434d-9d94-c16eaa1db6c2	POST	6	\N	PENDING	\N	\N	\N	f	2023-10-27 17:57:41.27	2023-11-27 21:19:56.624	15	\N	1370
b0aee04b-a08c-45c5-b2f1-112d890de67c	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-10-29 17:22:01.704	2023-11-27 21:19:56.625	23	\N	1500
c073a4d9-c0d6-489e-923b-23d6978d0422	POST	47	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-16 13:11:40.309	2023-11-27 21:19:56.627	17	\N	523
78925fb4-4aa2-47e2-8334-58b852910ad2	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-11-05 11:22:56.337	2023-11-27 21:19:56.629	16	\N	411
7e9a8e97-3f5e-444c-ab07-180a1da192ea	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-02-19 12:20:48.378	2023-11-27 21:19:56.631	22	\N	966
c07168f9-aad0-4e6c-8c4c-abd52b11b8d8	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-19 14:00:41.006	2023-11-27 21:19:56.633	18	\N	1181
d7785eff-57be-4ed7-a4c6-bdbef72abaa5	POST	34	\N	DISCARDED	\N	\N	\N	f	2022-12-12 06:59:18.829	2023-11-27 21:19:56.635	18	\N	880
952efcdf-d3a8-46ef-893c-1609151125df	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-27 05:45:58.069	2023-11-27 21:19:56.637	19	\N	1105
a0d6ee6e-7dd1-455b-80c8-c41af30913ea	POST	5	\N	PENDING	\N	\N	\N	f	2023-08-18 06:04:33.086	2023-11-27 21:19:56.638	23	\N	893
ecc436be-577e-4648-9c80-327fc12037bd	POST	42	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-15 10:39:04.978	2023-11-27 21:19:56.64	14	\N	1115
4cf5d22f-12a8-4629-8a14-3cf8d4c8d326	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-06-16 05:37:19.76	2023-11-27 21:19:56.642	18	\N	1389
0bf6a2d2-ffe7-4d70-a25f-8b75f9f6b144	POST	48	\N	PENDING	\N	\N	\N	f	2023-09-20 23:58:10.761	2023-11-27 21:19:56.643	16	\N	1254
39b1a4bc-9561-4420-85fa-162da5c66b1c	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-06-25 10:38:36.574	2023-11-27 21:19:56.645	15	\N	452
d59a87b5-76a9-43ec-a52f-7aeabd862465	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-22 13:21:28.541	2023-11-27 21:19:56.646	21	\N	1352
a31e631f-bb41-4da9-822f-33e4505e5e8f	POST	16	\N	DISCARDED	\N	\N	\N	f	2023-10-04 04:09:00.162	2023-11-27 21:19:56.648	20	\N	392
76ec5b71-13d5-42b4-bfdc-fcf01d5a4544	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-14 12:34:07.444	2023-11-27 21:19:56.65	16	\N	456
f27f56c6-2798-4b1a-ae96-0054e965f87c	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-27 12:54:20.07	2023-11-27 21:19:56.651	21	\N	977
a9e9bb95-2c30-43a3-b5ad-f5ca90378639	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-07-02 13:20:12.347	2023-11-27 21:19:56.653	21	\N	537
c340ff8a-015d-4a27-8ce2-47815adc6312	POST	30	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-29 18:17:26.354	2023-11-27 21:19:56.655	14	\N	653
8cd9329e-69b7-4364-af15-d33f735f20fe	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-26 01:27:10.05	2023-11-27 21:19:56.656	23	\N	1367
417352d1-dbef-4af5-8072-37bd609694f1	POST	5	\N	PENDING	\N	\N	\N	f	2023-03-18 21:11:01.371	2023-11-27 21:19:56.658	19	\N	688
6bd92288-05ed-44b0-8435-a550f2268129	POST	46	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-28 01:32:33.647	2023-11-27 21:19:56.659	22	\N	1123
d3c99fa2-b6dd-45e4-86be-99eee421b50a	POST	55	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-05 23:45:27.604	2023-11-27 21:19:56.661	23	\N	1319
26607542-a1e3-4d26-bcb4-fda85c8a4c43	POST	58	\N	PENDING	\N	\N	\N	f	2023-11-19 13:22:30.568	2023-11-27 21:19:56.663	15	\N	512
45f57148-06ac-4a11-a47e-6fdefa22a8ad	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-08-27 00:31:32.254	2023-11-27 21:19:56.664	20	\N	937
c86d961d-8d4d-4a3f-9e09-b1f8003dec1e	POST	52	\N	PENDING	\N	\N	\N	f	2023-09-03 16:22:00.522	2023-11-27 21:19:56.666	22	\N	1303
0d1bcc68-8033-4788-a217-38799981bf5a	POST	25	\N	DISCARDED	\N	\N	\N	f	2022-12-12 19:42:03.627	2023-11-27 21:19:56.667	16	\N	381
56620b2a-09ab-4fab-b590-8c7db204a72b	POST	32	\N	PENDING	\N	\N	\N	f	2023-04-20 23:30:30.896	2023-11-27 21:19:56.669	20	\N	1347
7d60fa1d-8975-4895-aa8b-ae499db03d15	POST	17	\N	PENDING	\N	\N	\N	f	2023-07-26 22:57:15.024	2023-11-27 21:19:56.671	17	\N	1073
8f67b9ea-b4e0-4fe7-86bb-0994c6991dac	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-02 05:08:05.701	2023-11-27 21:19:56.672	19	\N	832
b92160ea-77a3-41a9-94e6-0e36fa78ea25	POST	1	\N	PENDING	\N	\N	\N	f	2023-06-27 05:03:05.46	2023-11-27 21:19:56.674	16	\N	1229
41c2e7ca-d608-4b99-9150-5a6a04d2abd6	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-11 01:07:15.751	2023-11-27 21:19:56.675	17	\N	1014
bccfdfe5-2475-4e50-8e8e-1cc2d7e8ed13	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-11-01 14:01:07.04	2023-11-27 21:19:56.677	18	\N	1476
c3e3d895-5337-4695-805c-025bbca7fe83	POST	13	\N	PENDING	\N	\N	\N	f	2023-01-14 07:24:41.849	2023-11-27 21:19:56.679	19	\N	414
6f205309-6a9f-4a7d-b7d9-812de399d7c5	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-08-28 13:25:14.215	2023-11-27 21:19:56.68	16	\N	1210
ceef4c96-2b1f-4e59-9e50-4580f609908e	POST	2	\N	PENDING	\N	\N	\N	f	2023-07-13 22:18:35.971	2023-11-27 21:19:56.682	20	\N	969
67eb9ed1-4429-416c-a432-ed856edc83e2	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-02-28 00:49:53.97	2023-11-27 21:19:56.684	20	\N	1049
730546e7-53c7-44d7-8a6f-8a6672fd3347	POST	8	\N	DISCARDED	\N	\N	\N	f	2023-01-23 04:07:32.841	2023-11-27 21:19:56.686	23	\N	510
311804c9-d6b0-405e-9718-3ce1e3b3ba5b	POST	31	\N	DISCARDED	\N	\N	\N	f	2023-09-15 00:04:58.612	2023-11-27 21:19:56.688	14	\N	1287
e5f5c29f-3abe-4f2c-ad4d-c9c114915d25	POST	9	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-20 17:43:39.149	2023-11-27 21:19:56.689	17	\N	644
60f69605-dc1d-4b32-b88f-434efb7a4a84	POST	27	\N	DISCARDED	\N	\N	\N	f	2023-03-24 02:35:34.241	2023-11-27 21:19:56.691	23	\N	1506
1b110d30-e311-41e2-9dc9-ffedc9b5c20f	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-08-16 07:58:05.345	2023-11-27 21:19:56.694	16	\N	736
b500d044-00fe-4aa1-8193-2aa82b167455	POST	36	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-07 11:21:59.843	2023-11-27 21:19:56.697	17	\N	1302
e224a0e9-a342-4717-a336-b9b5cbee73f4	POST	15	\N	PENDING	\N	\N	\N	f	2023-05-16 22:11:25.441	2023-11-27 21:19:56.699	23	\N	1030
aa883c7b-472a-464c-8d06-7c6d7acd91d0	POST	55	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-27 22:40:21.397	2023-11-27 21:19:56.701	21	\N	542
2f53176e-5e2f-42ca-ba4b-e9f25f95901a	POST	40	\N	DISCARDED	\N	\N	\N	f	2023-07-16 05:27:02.8	2023-11-27 21:19:56.703	17	\N	393
79c6b6cc-1393-48df-92c8-cda638e495f6	POST	3	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-31 13:17:11.647	2023-11-27 21:19:56.705	22	\N	1498
106eb3e5-eb48-4b0a-972f-580d025d7e4d	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-08-02 04:04:30.197	2023-11-27 21:19:56.707	15	\N	559
53e07ee9-5813-48e1-8959-a2c32aa3ed64	POST	41	\N	PENDING	\N	\N	\N	f	2023-10-28 14:36:45.415	2023-11-27 21:19:56.709	16	\N	750
fbc396b7-a235-45d7-83fb-5889a43f334f	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-27 23:27:43.791	2023-11-27 21:19:56.712	16	\N	1250
69560a74-5db3-4e76-bd2e-05fed017f369	POST	49	\N	PENDING	\N	\N	\N	f	2023-02-06 14:13:58.948	2023-11-27 21:19:56.714	17	\N	1397
fa15d7eb-c13c-427a-94a3-563addc07656	POST	2	\N	PENDING	\N	\N	\N	f	2023-03-22 18:55:08.777	2023-11-27 21:19:56.716	19	\N	1416
2769f9d7-785c-4174-b8c0-e755afe551a9	POST	7	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-21 16:36:04.898	2023-11-27 21:19:56.718	17	\N	884
2b990295-79d7-495b-bc2e-fad811cbc95c	POST	55	\N	PENDING	\N	\N	\N	f	2023-04-17 23:16:31.709	2023-11-27 21:19:56.72	16	\N	842
75e4e0d2-3a38-47e3-8814-a66a123c4dca	POST	6	\N	DISCARDED	\N	\N	\N	f	2023-02-12 15:18:22.403	2023-11-27 21:19:56.722	19	\N	549
e47cb43c-4edf-4ceb-aee7-da17bfbc55c1	POST	53	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-23 00:02:27.146	2023-11-27 21:19:56.724	20	\N	1230
bb354fc7-9660-45d4-82ba-407c85c99f0d	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-22 10:37:30.352	2023-11-27 21:19:56.726	19	\N	1501
33b40723-9f7d-4b04-9c3f-75612f5779aa	POST	40	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-15 01:47:55.517	2023-11-27 21:19:56.729	21	\N	850
0cfa41e4-0f69-42ae-a7c3-6a1e12a76ec2	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-03-03 15:04:59.71	2023-11-27 21:19:56.731	22	\N	1013
3a03247e-9d74-4575-a76d-1a004d2babd0	POST	16	\N	PENDING	\N	\N	\N	f	2023-07-04 10:55:05.245	2023-11-27 21:19:56.733	17	\N	1044
11f29139-98cf-4c7d-9bba-899a5dbe8ca2	POST	19	\N	PENDING	\N	\N	\N	f	2023-07-12 21:27:49.662	2023-11-27 21:19:56.736	17	\N	593
acfb28ba-0a9b-415f-95b1-cf111be2b292	POST	48	\N	PENDING	\N	\N	\N	f	2023-10-20 17:59:13.242	2023-11-27 21:19:56.738	17	\N	1166
8e695e77-54ce-4b26-8998-8c2e4192cb23	POST	22	\N	PENDING	\N	\N	\N	f	2023-02-17 00:09:16.745	2023-11-27 21:19:56.74	20	\N	1229
535084ac-2651-4858-a5ec-30f80d083430	POST	6	\N	PENDING	\N	\N	\N	f	2023-06-21 11:30:21.52	2023-11-27 21:19:56.741	19	\N	390
e37dffc3-2da2-4dcb-b3e8-613a6da6a919	POST	3	\N	PENDING	\N	\N	\N	f	2023-05-21 03:29:17.756	2023-11-27 21:19:56.743	17	\N	1415
a9d7b135-b957-437d-a28b-47e0384cb154	POST	8	\N	PENDING	\N	\N	\N	f	2023-04-19 12:58:50.199	2023-11-27 21:19:56.745	21	\N	1165
fa5dbb3e-cde9-4530-999a-72ee574ea49f	POST	20	\N	PENDING	\N	\N	\N	f	2022-12-08 05:15:58.47	2023-11-27 21:19:56.748	21	\N	1367
ac46fae6-f0e5-413f-8967-47fdfdb1b406	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-08-16 14:54:06.528	2023-11-27 21:19:56.75	22	\N	509
07bb4706-78c0-4ece-9068-742296f75b03	POST	3	\N	PENDING	\N	\N	\N	f	2023-07-08 07:16:49.307	2023-11-27 21:19:56.752	14	\N	873
ecee541f-875a-4d01-9b01-610dddc99f7f	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-07-22 13:49:03.752	2023-11-27 21:19:56.754	15	\N	1107
538df74f-aedc-4397-b70a-ba3df359d97d	POST	7	\N	PENDING	\N	\N	\N	f	2023-02-02 16:40:47.164	2023-11-27 21:19:56.756	22	\N	1376
7ffa901f-1ff6-46af-b928-1d55f4d1e2de	POST	16	\N	PENDING	\N	\N	\N	f	2023-08-17 07:21:52.529	2023-11-27 21:19:56.758	20	\N	799
defb48c8-33c6-4e2b-8227-4836171945f5	POST	47	\N	PENDING	\N	\N	\N	f	2023-08-16 08:51:08.646	2023-11-27 21:19:56.76	16	\N	743
f9d3fcdd-f1a3-4e84-857c-1474d4409fb0	POST	2	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-19 13:45:20.266	2023-11-27 21:19:56.762	17	\N	921
9d37b059-e189-4085-8195-787c7f095b7c	POST	45	\N	DISCARDED	\N	\N	\N	f	2023-09-30 12:33:16.044	2023-11-27 21:19:56.764	14	\N	594
f75a007d-6de3-4a7a-9a27-b3da7c81b7b8	POST	24	\N	DISCARDED	\N	\N	\N	f	2023-07-09 13:31:45.879	2023-11-27 21:19:56.766	21	\N	1062
8d8f99cd-701e-41e8-887c-9bae47965cee	POST	46	\N	PENDING	\N	\N	\N	f	2023-11-08 16:43:15.254	2023-11-27 21:19:56.768	16	\N	1118
49ac2cd5-10c8-4c0a-8b22-1b2053a1d04c	POST	26	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-01 02:39:02.552	2023-11-27 21:19:56.77	23	\N	568
01b7d402-e6b2-4ac5-8ba4-502e72fdc77b	POST	59	\N	PENDING	\N	\N	\N	f	2023-02-16 04:17:25.9	2023-11-27 21:19:56.772	21	\N	1414
bfdaa287-62d7-4da3-8000-88f1a27ad981	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-03-22 18:52:43.586	2023-11-27 21:19:56.774	18	\N	1278
e56b6937-1dd3-4dbc-9afd-e96710d05dd5	POST	31	\N	PENDING	\N	\N	\N	f	2023-07-01 02:11:44.593	2023-11-27 21:19:56.777	20	\N	1380
317512c9-7688-40e6-9ceb-e2bd64c48238	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-09-16 12:15:29.097	2023-11-27 21:19:56.779	15	\N	901
2210bf49-d3b4-42c2-a4cc-012119a0d4f8	POST	29	\N	DISCARDED	\N	\N	\N	f	2023-09-12 19:33:51.595	2023-11-27 21:19:56.781	14	\N	408
73e6acf8-8805-443d-9d9f-5e649f583c76	POST	21	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-03 06:38:51.508	2023-11-27 21:19:56.783	18	\N	1188
8d371436-ccc7-4343-8bad-5311d4b83ada	POST	35	\N	PENDING	\N	\N	\N	f	2023-11-27 08:49:07.357	2023-11-27 21:19:56.786	19	\N	1044
6da9362a-af39-4192-974e-c4de86793d4e	POST	58	\N	PENDING	\N	\N	\N	f	2023-02-20 15:46:06.897	2023-11-27 21:19:56.788	22	\N	1074
381b3e5e-7dc8-4f5e-bbfd-581570431aa6	POST	20	\N	PENDING	\N	\N	\N	f	2023-02-13 19:22:34.341	2023-11-27 21:19:56.791	19	\N	1394
7708ce31-e4ff-4cec-995a-0fa539c7afa9	POST	17	\N	PENDING	\N	\N	\N	f	2023-09-30 10:59:10.718	2023-11-27 21:19:56.793	16	\N	968
2b5fc6ea-d1a6-4157-bd5a-d5e379a88230	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-06-19 03:07:00.211	2023-11-27 21:19:56.795	17	\N	1119
71321e53-5b10-4f69-a1c1-f118ca08b286	POST	27	\N	PENDING	\N	\N	\N	f	2023-08-11 14:38:01.276	2023-11-27 21:19:56.797	17	\N	610
abc6947c-9527-4c22-a42b-6bec77521f99	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-03-18 17:27:50.837	2023-11-27 21:19:56.799	16	\N	547
98b052c3-8a53-464e-bae0-a34391ed86c9	POST	7	\N	PENDING	\N	\N	\N	f	2023-09-06 12:31:50.852	2023-11-27 21:19:56.801	23	\N	1408
2b26ec85-45f3-4ae2-8a77-b43247e1cdee	POST	14	\N	PENDING	\N	\N	\N	f	2023-09-16 00:14:47.732	2023-11-27 21:19:56.803	21	\N	1421
af021a79-1baf-4fe9-9f82-c80f362663e0	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-05-13 04:20:14.215	2023-11-27 21:19:56.805	17	\N	1515
6a24ed1b-e92c-4bb9-9205-587cf0c69032	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-05 09:58:23.114	2023-11-27 21:19:56.808	17	\N	1365
9a477114-dec9-4037-b202-8174299cf088	POST	7	\N	PENDING	\N	\N	\N	f	2023-08-24 00:55:53.907	2023-11-27 21:19:56.811	21	\N	761
32abf3fc-3576-4006-a452-cb91f5638622	POST	5	\N	PENDING	\N	\N	\N	f	2023-01-30 09:53:39.009	2023-11-27 21:19:56.813	22	\N	643
06311818-1d8c-4024-bc3e-8d48ed02c434	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-17 10:51:32.301	2023-11-27 21:19:56.815	17	\N	1362
7dab8a9b-4c11-48ab-a4aa-b1d49207aff9	POST	42	\N	DISCARDED	\N	\N	\N	f	2023-08-19 04:34:55.98	2023-11-27 21:19:56.818	20	\N	725
c0725a70-fd88-4d3f-8423-03c9706b33d8	POST	9	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-26 22:29:38.21	2023-11-27 21:19:56.819	22	\N	687
811eedc2-0d93-4728-9ee3-234c4fc57cd3	POST	47	\N	DISCARDED	\N	\N	\N	f	2023-01-13 08:12:08.352	2023-11-27 21:19:56.821	15	\N	705
e856565b-9911-4ffa-b9ae-5a2387d202e0	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-06-22 09:12:08.107	2023-11-27 21:19:56.823	22	\N	833
4921763f-3031-4c51-80f0-fa173cd0c1ac	POST	11	\N	PENDING	\N	\N	\N	f	2022-12-17 14:32:15.567	2023-11-27 21:19:56.825	18	\N	1296
a227135b-930e-4228-b6fe-ee1252fd621e	POST	56	\N	PENDING	\N	\N	\N	f	2023-02-27 22:14:13.953	2023-11-27 21:19:56.827	18	\N	1490
84cefcaa-9128-4cc2-aee6-1e0c27ae2cba	POST	10	\N	DISCARDED	\N	\N	\N	f	2023-01-26 07:22:00.855	2023-11-27 21:19:56.829	21	\N	462
3df6951e-4c7e-413c-88f9-ecd69f8336c4	POST	43	\N	PENDING	\N	\N	\N	f	2023-07-02 23:51:02.215	2023-11-27 21:19:56.831	16	\N	349
802c86d2-055b-47f6-8c57-8770db7b0ff9	POST	47	\N	PENDING	\N	\N	\N	f	2023-10-19 04:45:00.391	2023-11-27 21:19:56.832	15	\N	1183
d3c9aaeb-3816-4cf9-99a2-0c1ee55b50d8	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-01 05:55:55.368	2023-11-27 21:19:56.834	19	\N	729
9c0f5f0e-ea0a-4924-a449-e5133451140c	POST	12	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-11 08:39:14.921	2023-11-27 21:19:56.835	14	\N	1361
1fbb16ce-7e54-4f23-bde5-b1a32abe6bf4	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-01 13:03:19.309	2023-11-27 21:19:56.837	22	\N	432
4d7820b5-7154-44bc-9a52-70903109f1fe	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-05-03 20:34:13.665	2023-11-27 21:19:56.838	23	\N	996
6ac8d897-b662-4e2f-854a-32ad2307338d	POST	12	\N	PENDING	\N	\N	\N	f	2023-08-04 01:28:16.217	2023-11-27 21:19:56.84	15	\N	1085
dc891298-bdc2-408e-8d6f-2551405ebf6f	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-06-20 05:13:36.855	2023-11-27 21:19:56.842	20	\N	1426
ef6287db-efba-4fdd-80ce-6d0ea97fb948	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-22 20:41:14.469	2023-11-27 21:19:56.843	22	\N	691
ce281731-2aea-485e-8b0b-ced72e08900a	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-15 03:09:24.595	2023-11-27 21:19:56.845	15	\N	1329
22de133d-43bd-4946-9466-613628cd72f7	POST	53	\N	PENDING	\N	\N	\N	f	2023-08-24 07:50:46.615	2023-11-27 21:19:56.846	20	\N	1453
cc37904b-4455-49dc-b93c-fb9092b97e63	POST	28	\N	PENDING	\N	\N	\N	f	2023-03-11 02:53:41.586	2023-11-27 21:19:56.848	20	\N	959
15d08e0d-c92e-4126-a918-7a10cb255351	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-01-19 03:49:56.582	2023-11-27 21:19:56.849	14	\N	907
de2638c9-cd0a-464b-82f9-7d6e389ce82c	POST	50	\N	PENDING	\N	\N	\N	f	2022-12-24 01:23:41.899	2023-11-27 21:19:56.851	19	\N	1110
5b4c129a-3603-4c7a-84b3-aa072e433deb	POST	35	\N	PENDING	\N	\N	\N	f	2023-03-27 16:06:43.182	2023-11-27 21:19:56.853	16	\N	1000
79eb63ba-b049-4efb-90bd-f4cac7d3ec4b	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-07 01:32:45.098	2023-11-27 21:19:56.855	23	\N	944
9f4b3932-738b-4469-bab3-0f49b0a16a1a	POST	54	\N	DISCARDED	\N	\N	\N	f	2023-01-04 02:02:52.36	2023-11-27 21:19:56.857	15	\N	910
be713f0d-2c44-41be-9e0d-8497b6bb3d14	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-07-19 14:35:52.392	2023-11-27 21:19:56.86	23	\N	632
0b59c0d7-f0fc-4494-a8e5-f8b32e3e91e3	POST	47	\N	PENDING	\N	\N	\N	f	2023-07-17 10:34:16.973	2023-11-27 21:19:56.862	23	\N	401
c95fc97e-fd67-4689-a24c-2d0b72112f55	POST	16	\N	PENDING	\N	\N	\N	f	2023-04-18 17:07:29.066	2023-11-27 21:19:56.864	18	\N	1140
a588a5c1-d144-42c7-af96-c922b7613e07	POST	26	\N	DISCARDED	\N	\N	\N	f	2023-06-15 07:39:46.864	2023-11-27 21:19:56.866	17	\N	1403
d8ea6805-c09a-4322-9267-9a3333f5ea5f	POST	58	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-22 10:21:10.982	2023-11-27 21:19:56.868	20	\N	1249
62f2b50f-32f8-4931-8af3-a4a3b163d0c9	POST	1	\N	PENDING	\N	\N	\N	f	2023-01-25 00:24:55.704	2023-11-27 21:19:56.869	21	\N	1400
8c61206d-f5ec-465c-b3ab-0437a8a71186	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-12 23:57:29.164	2023-11-27 21:19:56.871	17	\N	770
30cb27bb-108e-49ea-9ba4-a3d59ac32817	POST	48	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-01 22:42:41.092	2023-11-27 21:19:56.873	21	\N	1343
3e5f0763-48d4-4a8e-b698-ab6a467b024c	POST	1	\N	PENDING	\N	\N	\N	f	2023-08-24 21:13:31.864	2023-11-27 21:19:56.874	17	\N	619
79d4124d-714c-467c-93fc-3aaeec819150	POST	19	\N	PENDING	\N	\N	\N	f	2023-06-15 02:43:27.329	2023-11-27 21:19:56.876	19	\N	941
6c2fc35e-a0f4-4f9d-8b15-d68ba05b8105	POST	54	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-25 02:26:05.892	2023-11-27 21:19:56.877	19	\N	1383
2babfb3a-72b0-4c0d-bdb8-95e2f07275df	POST	51	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-17 23:38:04.46	2023-11-27 21:19:56.879	14	\N	1265
2fe493b1-995c-436c-9701-a7bf3fc76ded	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-21 20:34:04.2	2023-11-27 21:19:56.88	16	\N	930
ca7cf647-f2ee-4497-9ca3-59aa822845c6	POST	9	\N	PENDING	\N	\N	\N	f	2023-03-25 14:20:37.745	2023-11-27 21:19:56.882	21	\N	351
3e988bb8-5ea5-4a3b-a069-3386087e816f	POST	54	\N	PENDING	\N	\N	\N	f	2023-11-15 07:19:58.716	2023-11-27 21:19:56.884	23	\N	951
591f2d0a-660c-4209-9d4f-35395de587d9	POST	17	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-13 05:55:52.126	2023-11-27 21:19:56.885	21	\N	1509
80aed258-88eb-4fce-8cab-92625e2bd219	POST	7	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-29 03:59:07.511	2023-11-27 21:19:56.887	20	\N	973
2bdef824-ea7c-44d6-96c4-e55762ab2e7d	POST	55	\N	PENDING	\N	\N	\N	f	2023-07-01 07:51:58.329	2023-11-27 21:19:56.888	14	\N	1255
7dd90fcb-586b-4704-80b3-eaf014cc0f03	POST	16	\N	DISCARDED	\N	\N	\N	f	2023-09-27 17:59:59.215	2023-11-27 21:19:56.89	19	\N	615
d847859a-4411-4d18-b8d7-f03e583cae33	POST	50	\N	PENDING	\N	\N	\N	f	2022-12-12 21:43:47.211	2023-11-27 21:19:56.892	21	\N	714
dbd232e8-37cf-4fde-9250-4613f9a0b697	POST	4	\N	PENDING	\N	\N	\N	f	2023-02-20 01:31:36.949	2023-11-27 21:19:56.893	23	\N	1231
50781fda-8e61-459f-8e0c-d9fcf8600434	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-19 06:56:28.014	2023-11-27 21:19:56.895	15	\N	895
bc89d550-0541-428e-8fdb-9811c43004f5	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-06-19 21:41:46.648	2023-11-27 21:19:56.897	21	\N	676
7492c39c-6d17-4e5c-8c2e-9a68e3e1afdb	POST	43	\N	PENDING	\N	\N	\N	f	2022-12-25 07:08:57.018	2023-11-27 21:19:56.898	22	\N	441
63076d7d-c735-4756-b039-c86ccd071beb	POST	21	\N	DISCARDED	\N	\N	\N	f	2023-07-06 01:37:11.51	2023-11-27 21:19:56.9	14	\N	1441
8446354a-fbec-46e9-bc48-0bd103fb2771	POST	17	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-23 15:42:42.223	2023-11-27 21:19:56.902	21	\N	350
6e132908-f4e1-4098-8f2f-917bae6a99d4	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-06-28 14:18:06.813	2023-11-27 21:19:56.903	14	\N	829
0745ad90-de26-472b-bef0-47126203fbe1	POST	41	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-12 07:07:19.093	2023-11-27 21:19:56.905	16	\N	800
e0cabe36-46a6-4219-be48-997fb83d0fc5	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-01-07 13:57:02.198	2023-11-27 21:19:56.907	21	\N	361
117648ac-72f2-479b-88a9-03a5f76b9676	POST	56	\N	DISCARDED	\N	\N	\N	f	2023-05-26 02:52:22.584	2023-11-27 21:19:56.909	17	\N	565
a63c59a3-b186-4abe-8cd0-40b6f6149d15	POST	34	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-29 15:17:38.531	2023-11-27 21:19:56.91	15	\N	1514
d6d4204a-33c0-4706-9b57-9bddc9f905d6	POST	15	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-22 03:28:50.38	2023-11-27 21:19:56.912	17	\N	1011
e8b8eaba-6762-429e-af9b-8b874e0a3a52	POST	58	\N	PENDING	\N	\N	\N	f	2023-04-07 20:57:59.38	2023-11-27 21:19:56.913	22	\N	754
4a57255d-707e-4f0b-98a4-28efdf9a66d6	POST	51	\N	PENDING	\N	\N	\N	f	2023-10-23 19:15:27.465	2023-11-27 21:19:56.915	21	\N	1160
4867ae68-d4fc-4508-8263-3f30c24cf979	POST	37	\N	PENDING	\N	\N	\N	f	2023-07-30 05:51:19.614	2023-11-27 21:19:56.916	14	\N	550
abbd87d4-6d67-42e8-9d40-465fa8fa86cb	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-09-08 02:46:52.36	2023-11-27 21:19:56.918	19	\N	805
883dbed4-ec3b-4fcb-95c2-ad26b36d3681	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-09 10:20:32.933	2023-11-27 21:19:56.919	21	\N	647
7ae22fbe-2a23-4c1e-acf9-d3c3d7caa25d	POST	39	\N	DISCARDED	\N	\N	\N	f	2023-05-03 01:14:47.558	2023-11-27 21:19:56.921	15	\N	965
a35f7407-9081-4095-9cfa-c0b1582f062c	POST	40	\N	PENDING	\N	\N	\N	f	2023-01-05 15:48:42.868	2023-11-27 21:19:56.923	23	\N	510
e6f5720e-039b-4345-83ac-9923af988364	POST	10	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-20 04:48:20.693	2023-11-27 21:19:56.924	18	\N	1525
526e7329-2d46-452f-ba7e-682315421bf9	POST	53	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-18 23:19:31.915	2023-11-27 21:19:56.926	14	\N	981
72dd24fa-7e20-4775-9e24-440c3cfb175f	POST	39	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-22 06:57:38.917	2023-11-27 21:19:56.927	22	\N	1202
2cc8deee-2565-4ce1-9292-de1b2a3ec909	POST	48	\N	DISCARDED	\N	\N	\N	f	2022-11-28 16:10:24.902	2023-11-27 21:19:56.929	17	\N	1145
661d4d4e-abbf-41f3-8933-af3ebeecca0a	POST	33	\N	DISCARDED	\N	\N	\N	f	2022-12-18 20:04:21.657	2023-11-27 21:19:56.931	23	\N	1519
d932d5d9-d2c9-4889-8246-96fd12ac76e4	POST	6	\N	PENDING	\N	\N	\N	f	2023-11-06 20:17:30.941	2023-11-27 21:19:56.932	20	\N	861
0e84961f-da38-4f13-ab52-76daa94ba068	POST	55	\N	PENDING	\N	\N	\N	f	2023-04-11 16:54:07.899	2023-11-27 21:19:56.934	21	\N	1177
08b12f33-ddbd-4c74-823f-586b1dabc6b7	POST	56	\N	DISCARDED	\N	\N	\N	f	2023-04-21 12:11:42.252	2023-11-27 21:19:56.935	14	\N	920
343a1237-f8db-473e-b892-36f0fe4d4b2a	POST	59	\N	DISCARDED	\N	\N	\N	f	2023-07-25 18:38:02.169	2023-11-27 21:19:56.937	18	\N	1517
2d09bc2e-0aba-4567-9de8-5ffb11306989	POST	27	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-28 04:31:24.619	2023-11-27 21:19:56.938	18	\N	750
e6f444cc-e8e5-4035-b7a4-c5f322f24869	POST	58	\N	PENDING	\N	\N	\N	f	2022-11-30 22:22:16.57	2023-11-27 21:19:56.94	20	\N	354
71f52dd0-7f1e-41e4-aab2-7394d64f1882	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-06-14 22:29:11.808	2023-11-27 21:19:56.941	22	\N	786
e4d2f977-dc4f-4d7e-adfe-3ad3608202f1	POST	47	\N	PENDING	\N	\N	\N	f	2023-08-19 03:28:50.014	2023-11-27 21:19:56.943	19	\N	1336
01adc2b7-5d31-471b-9471-f0f4c923a7ac	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-09-30 16:09:17.024	2023-11-27 21:19:56.944	16	\N	1355
d24cdf15-165c-43d5-9eac-76e298c78e0c	POST	20	\N	DISCARDED	\N	\N	\N	f	2023-07-25 10:26:26.69	2023-11-27 21:19:56.946	21	\N	1438
8bd077ef-6291-4e90-8705-065764fe4025	POST	13	\N	PENDING	\N	\N	\N	f	2023-04-29 14:14:01.636	2023-11-27 21:19:56.948	21	\N	654
326df31e-d51c-4cb5-85a5-1938e7abfd2b	POST	16	\N	DISCARDED	\N	\N	\N	f	2023-08-29 19:46:08.543	2023-11-27 21:19:56.95	17	\N	1165
c380b22d-f7ef-49e4-9dcb-7d1fa0f3a1fa	POST	47	\N	DISCARDED	\N	\N	\N	f	2023-02-06 18:34:35.279	2023-11-27 21:19:56.951	14	\N	1371
2ceda1f6-191f-4416-b78c-41599d1f3943	POST	59	\N	DISCARDED	\N	\N	\N	f	2023-08-29 07:34:18.691	2023-11-27 21:19:56.953	20	\N	387
9071812b-af43-4dec-a987-3029d506037b	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-16 23:16:56	2023-11-27 21:19:56.954	20	\N	564
5ce1a09f-9639-45d4-b9d3-59cd47588af4	POST	36	\N	DISCARDED	\N	\N	\N	f	2023-11-02 01:28:16.264	2023-11-27 21:19:56.956	17	\N	1494
a4477110-53f1-44f5-8e3a-0e814eeaf6e5	POST	36	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-01 19:30:30.927	2023-11-27 21:19:56.957	19	\N	509
899c1cf7-136f-4b4a-a68d-91c4923c6014	POST	57	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-31 14:32:55.509	2023-11-27 21:19:56.959	20	\N	685
6a828017-fd85-4809-9187-fcf3754c27a5	POST	34	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-23 04:41:07.653	2023-11-27 21:19:56.961	19	\N	573
bce3e2e0-12c7-489f-8c74-27fcb161debe	POST	56	\N	DISCARDED	\N	\N	\N	f	2023-01-24 16:19:32.811	2023-11-27 21:19:56.963	22	\N	731
09406255-7806-4744-9da0-a1e9bbf8a1fe	POST	27	\N	DISCARDED	\N	\N	\N	f	2023-11-10 11:06:37.227	2023-11-27 21:19:56.966	14	\N	406
26e7279f-7af8-4943-85ad-120943f5f80c	POST	47	\N	DISCARDED	\N	\N	\N	f	2023-09-09 22:05:48.18	2023-11-27 21:19:56.968	15	\N	1150
638bb5fe-b84f-413a-9f25-8315fb2e6be5	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-10-08 21:25:07.829	2023-11-27 21:19:56.97	16	\N	1057
393a02cc-3a9c-44ee-9cc9-fcec9b8c9544	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-11-28 13:40:21.639	2023-11-27 21:19:56.972	15	\N	1512
d1f4e2af-765a-4a50-8e9e-1d65bf20adff	POST	23	\N	DISCARDED	\N	\N	\N	f	2023-04-19 16:30:47.513	2023-11-27 21:19:56.974	14	\N	1311
6755598f-8bf3-4c7a-8d74-5cdf0568b5e2	POST	8	\N	DISCARDED	\N	\N	\N	f	2023-02-23 09:03:37.646	2023-11-27 21:19:56.976	23	\N	466
783693d9-9ae7-48e0-8da4-215010597794	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-04 12:50:47.365	2023-11-27 21:19:56.978	15	\N	816
54fa80e4-6ea4-4874-8404-fa489b435a55	POST	8	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-02 22:28:04.602	2023-11-27 21:19:56.981	16	\N	1286
a948ba4e-2ade-4436-b818-17fff1558a42	POST	37	\N	DISCARDED	\N	\N	\N	f	2023-09-23 00:39:36.243	2023-11-27 21:19:56.983	19	\N	1055
cece814d-9a72-437c-86d0-558969b9824e	POST	55	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-28 05:29:09.215	2023-11-27 21:19:56.985	15	\N	962
56f1b758-1930-4061-a6e8-7b217d690ac0	POST	55	\N	DISCARDED	\N	\N	\N	f	2023-04-18 21:16:29.04	2023-11-27 21:19:56.987	14	\N	631
e9e30be2-8185-455d-8dd5-31522c8e3008	POST	14	\N	DISCARDED	\N	\N	\N	f	2023-09-17 07:18:09.635	2023-11-27 21:19:56.989	18	\N	1221
5d777d6e-acd8-40a4-a8b7-070515501907	POST	43	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-07 23:44:38.096	2023-11-27 21:19:56.991	20	\N	545
95a51e12-af0b-4742-8e6c-99173be03e2d	POST	33	\N	PENDING	\N	\N	\N	f	2023-02-18 19:18:40.203	2023-11-27 21:19:56.993	15	\N	935
e2b12b18-4676-4d04-9a63-262b62e7c2e7	POST	57	\N	DISCARDED	\N	\N	\N	f	2023-07-31 01:28:26.425	2023-11-27 21:19:56.994	18	\N	499
7124003b-523d-4527-8dc8-5e8292b3fb5e	POST	43	\N	DISCARDED	\N	\N	\N	f	2023-03-03 20:38:59.658	2023-11-27 21:19:56.996	18	\N	1184
3b361522-7d81-4273-807a-214a94a87a82	POST	48	\N	DISCARDED	\N	\N	\N	f	2023-10-07 10:56:36.088	2023-11-27 21:19:56.998	22	\N	1474
9eaecef3-ac80-415d-bb79-2f4d75ae77bf	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-03-16 22:20:06.325	2023-11-27 21:19:56.999	19	\N	1136
8f53d3a4-b03f-4597-84ac-c86d5b779210	POST	57	\N	PENDING	\N	\N	\N	f	2023-08-14 06:56:06.264	2023-11-27 21:19:57.001	23	\N	1026
a6283c76-0dfb-48e5-a660-2a522157004f	POST	57	\N	PENDING	\N	\N	\N	f	2023-03-25 18:58:52.21	2023-11-27 21:19:57.003	21	\N	375
effef737-fbbf-4e0e-855e-37481c345c9e	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-03-20 02:18:41.064	2023-11-27 21:19:57.004	19	\N	549
525cc012-4c55-45f6-8ec2-572820c095bb	POST	49	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-17 21:05:50.458	2023-11-27 21:19:57.006	21	\N	1076
c9ebc933-605d-49d3-bf48-30eb61551541	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-07 09:57:17.73	2023-11-27 21:19:57.007	23	\N	390
3576f131-358d-45d4-85a9-6aecad61c0bc	POST	24	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-10 20:52:10.881	2023-11-27 21:19:57.009	18	\N	889
f9297abc-9280-4c6b-ad05-c28864c9e173	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-04-15 10:11:14.884	2023-11-27 21:19:57.01	15	\N	960
26698e1a-3b30-42e3-b2ec-d7670f17e3a8	POST	37	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-30 07:11:30.42	2023-11-27 21:19:57.012	17	\N	1352
f9a39b94-744b-43cc-a9a7-6b86fa6c3b3e	POST	53	\N	PENDING	\N	\N	\N	f	2023-03-13 03:20:40.62	2023-11-27 21:19:57.013	23	\N	567
69f4beac-5b01-4421-ad3f-4c02bad61f27	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-04-24 11:16:08.146	2023-11-27 21:19:57.015	15	\N	1109
a40ae03b-dc5c-43e6-a0ac-7aa279b210d1	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-24 11:45:31.089	2023-11-27 21:19:57.016	19	\N	830
f078c150-ced7-4cdb-9a63-33b2bbaba7b8	POST	21	\N	PENDING	\N	\N	\N	f	2023-06-30 03:14:59.574	2023-11-27 21:19:57.018	17	\N	933
3f448b8d-6b21-40bb-9b7a-c0dfa0c9fe00	POST	27	\N	PENDING	\N	\N	\N	f	2023-05-06 13:16:09.391	2023-11-27 21:19:57.019	19	\N	688
244b151d-5eb7-4b49-a20d-595a36c24bc8	POST	38	\N	PENDING	\N	\N	\N	f	2023-09-19 11:59:20.578	2023-11-27 21:19:57.021	23	\N	803
de25530b-36d1-4ef8-a18c-078641f3ab3c	POST	13	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-01 03:00:49.095	2023-11-27 21:19:57.023	20	\N	1282
0a61126f-fbf5-4334-979d-896922d8a51b	POST	2	\N	PENDING	\N	\N	\N	f	2023-11-06 13:15:53.44	2023-11-27 21:19:57.024	23	\N	1428
777b5bc8-8242-40a5-a3d7-39868da74b99	POST	26	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-07 17:28:24.268	2023-11-27 21:19:57.026	23	\N	984
b901387f-7810-41f4-9806-4e952f0ed57a	POST	8	\N	PENDING	\N	\N	\N	f	2023-04-22 01:55:25.666	2023-11-27 21:19:57.027	18	\N	1408
2428a4f2-cfe8-43bb-ad8f-5ccc85c88dc3	POST	32	\N	DISCARDED	\N	\N	\N	f	2023-02-28 09:41:20.016	2023-11-27 21:19:57.029	19	\N	1208
bc359133-6176-4ab1-8a18-7e8726ebf975	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-12 02:07:33.261	2023-11-27 21:19:57.031	21	\N	1323
56ff5249-2b5d-444b-a9b7-b5f4aa7e66b4	POST	42	\N	DISCARDED	\N	\N	\N	f	2023-10-13 23:47:43.814	2023-11-27 21:19:57.032	18	\N	687
c1170407-827c-4a1e-9c5b-c32e4d8073c2	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-23 02:06:07.171	2023-11-27 21:19:57.034	22	\N	1232
8538bb00-e3bd-4b76-a9bd-816f8c454eec	POST	29	\N	PENDING	\N	\N	\N	f	2022-11-30 21:04:13.919	2023-11-27 21:19:57.035	19	\N	720
1f5711ef-dd74-4f06-9336-b08dc7d901c6	POST	15	\N	DISCARDED	\N	\N	\N	f	2023-10-13 10:33:00.21	2023-11-27 21:19:57.036	19	\N	1226
13394374-e998-4562-9e17-452244c60a14	POST	57	\N	DISCARDED	\N	\N	\N	f	2023-03-26 09:53:37.043	2023-11-27 21:19:57.038	15	\N	1517
0d6568c5-9145-4117-aa43-df90d6a6064d	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-11 09:00:25.488	2023-11-27 21:19:57.039	23	\N	563
1436b743-fc6a-43a8-af08-d000153dd051	POST	16	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-02 15:39:36.25	2023-11-27 21:19:57.041	21	\N	829
18da3e3f-ff58-48a5-9ef4-1b5881c6586a	POST	45	\N	PENDING	\N	\N	\N	f	2023-04-20 13:14:02.109	2023-11-27 21:19:57.043	23	\N	934
41fabf2e-28b6-413a-bdf0-b519ff1ee87f	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-10-28 22:20:06.828	2023-11-27 21:19:57.044	21	\N	646
29146a2f-b37b-4b28-9622-e024c33e9b7d	POST	45	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-05 02:19:30.011	2023-11-27 21:19:57.046	20	\N	1298
cbe421ed-97a2-4daf-8b4c-9cc240d24dd0	POST	34	\N	PENDING	\N	\N	\N	f	2023-02-12 03:52:21.601	2023-11-27 21:19:57.047	23	\N	1110
d95aaa2c-ce89-49c4-8e67-1023b36dce56	POST	43	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-13 19:27:08.392	2023-11-27 21:19:57.049	16	\N	774
7252c528-820b-438e-ba76-7abe3eae0fcf	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-24 02:07:10.181	2023-11-27 21:19:57.05	23	\N	1427
b5356b56-d042-46cc-aa41-461f1d3ec110	POST	29	\N	PENDING	\N	\N	\N	f	2023-04-19 06:08:00.68	2023-11-27 21:19:57.052	17	\N	1319
e01dc96c-2c89-4c42-9e0a-62352fe701e1	POST	18	\N	DISCARDED	\N	\N	\N	f	2023-05-25 20:53:05.261	2023-11-27 21:19:57.053	23	\N	734
4e4b9a99-e380-4a32-83a7-9278a94320d9	POST	58	\N	DISCARDED	\N	\N	\N	f	2022-12-05 11:14:37.112	2023-11-27 21:19:57.055	14	\N	1021
9b83054b-8484-43e2-afd8-5dc9ff3e25dc	POST	13	\N	DISCARDED	\N	\N	\N	f	2023-02-28 20:34:52.357	2023-11-27 21:19:57.057	20	\N	867
922f754f-58b1-4491-bd30-77fa5d63a52e	POST	18	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-01-02 00:34:59.181	2023-11-27 21:19:57.058	22	\N	712
4b381bdc-d03b-48e4-8d61-215af31e2478	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-09 02:13:37.917	2023-11-27 21:19:57.06	16	\N	700
c8f646af-4179-43ed-b2c7-fae4c8184885	POST	27	\N	DISCARDED	\N	\N	\N	f	2023-01-14 14:16:43.559	2023-11-27 21:19:57.062	16	\N	1466
0fc00ce5-3597-4642-b825-8fa2495a9ded	POST	53	\N	DISCARDED	\N	\N	\N	f	2023-11-11 10:24:47.451	2023-11-27 21:19:57.063	21	\N	742
25a7da5f-5339-46ac-b1e6-d6086505442f	POST	17	\N	DISCARDED	\N	\N	\N	f	2023-05-13 16:44:50.731	2023-11-27 21:19:57.065	21	\N	1385
23674787-4bfb-4b35-9b34-b6d223b76229	POST	50	\N	DISCARDED	\N	\N	\N	f	2023-06-17 12:09:32.123	2023-11-27 21:19:57.067	21	\N	410
282a99f7-da59-46b3-850d-d2c45f90933f	POST	19	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-22 16:36:48.144	2023-11-27 21:19:57.069	23	\N	1400
3a9c0f93-c6e6-4d97-abf0-cef2251054d1	POST	2	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-04 07:44:55.583	2023-11-27 21:19:57.07	15	\N	995
4e4ef760-0dfb-46f5-945b-88116f9c3834	POST	5	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-10-21 03:04:12.735	2023-11-27 21:19:57.071	20	\N	421
14fccebb-daa0-460f-a779-df7807ff175f	POST	57	\N	PENDING	\N	\N	\N	f	2023-06-26 13:19:29.926	2023-11-27 21:19:57.073	21	\N	875
858a8b70-73c5-432e-939f-09196a135c2e	POST	22	\N	PENDING	\N	\N	\N	f	2023-02-22 01:26:29.397	2023-11-27 21:19:57.075	20	\N	608
54e88e6c-dd21-496a-b095-4ef30cc82e34	POST	7	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-03 04:10:48.483	2023-11-27 21:19:57.076	22	\N	723
f10f8ff2-a85f-4dc5-8c7f-94511f6f71e2	POST	35	\N	DISCARDED	\N	\N	\N	f	2023-07-08 11:37:44.179	2023-11-27 21:19:57.078	19	\N	359
42a1ec42-7df4-45d0-a2c7-dc692dde4225	POST	11	\N	DISCARDED	\N	\N	\N	f	2023-11-01 10:33:26.141	2023-11-27 21:19:57.08	23	\N	1018
f7a03a6b-b05a-41f2-9e2f-c24d5c42d4ea	POST	24	\N	PENDING	\N	\N	\N	f	2023-03-31 16:54:10.98	2023-11-27 21:19:57.081	17	\N	883
92ad9a91-62e6-44c6-9faf-314b5ca3f96c	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-08 01:43:27.224	2023-11-27 21:19:57.083	19	\N	976
5c3510f7-34b5-4bf6-9722-c50ecf6ae386	POST	56	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-23 03:37:47.888	2023-11-27 21:19:57.084	22	\N	903
69c2d14e-16ff-4ddb-9b67-6d52ffabd69a	POST	12	\N	DISCARDED	\N	\N	\N	f	2023-09-29 18:52:42.557	2023-11-27 21:19:57.086	23	\N	843
fbb48c57-5c9c-48fb-b98f-3b097c0617e1	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-31 14:08:40.577	2023-11-27 21:19:57.087	15	\N	1047
e46bdff8-e997-4802-84a3-d998f160bdb0	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-04 11:28:43.142	2023-11-27 21:19:57.089	17	\N	1291
fea87d3b-2e0d-4b0f-b03c-72a5f3f972a5	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-11 10:36:11.778	2023-11-27 21:19:57.091	22	\N	640
34fd0ea9-fcf2-40d0-9a69-344fee2cb8c3	POST	1	\N	DISCARDED	\N	\N	\N	f	2023-04-20 23:40:28.819	2023-11-27 21:19:57.093	16	\N	941
55e6995d-795a-4616-87d8-f1cdabf84729	POST	38	\N	PENDING	\N	\N	\N	f	2023-06-01 00:00:54.003	2023-11-27 21:19:57.096	23	\N	981
4cc9331f-6288-4587-a167-bb18277f99c7	POST	13	\N	PENDING	\N	\N	\N	f	2022-12-19 22:53:27.358	2023-11-27 21:19:57.098	23	\N	1453
6a0dba62-b20f-4659-ae6c-3b93728b6a36	POST	20	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-02 13:16:01.227	2023-11-27 21:19:57.1	18	\N	751
5eeb6bb4-d187-4403-b3f1-9e98076873bb	POST	6	\N	DISCARDED	\N	\N	\N	f	2023-05-15 06:07:35.864	2023-11-27 21:19:57.102	22	\N	1407
49602ae4-4a09-4c85-b428-d4375be6bc3b	POST	17	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-06-03 17:24:49.313	2023-11-27 21:19:57.104	17	\N	908
2b100945-4c14-4448-be47-6bffc85d1374	POST	23	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-28 11:03:11.081	2023-11-27 21:19:57.106	19	\N	608
c969c574-b93d-4043-a0f7-72dc529f6707	POST	37	\N	DISCARDED	\N	\N	\N	f	2023-06-20 01:07:56.218	2023-11-27 21:19:57.109	14	\N	919
9afe056b-52eb-43e7-8d1f-bd1be94ff5a2	POST	34	\N	PENDING	\N	\N	\N	f	2023-03-26 01:01:32.354	2023-11-27 21:19:57.111	14	\N	1509
53674244-a457-41b3-8bbd-b0814c09e936	POST	56	\N	PENDING	\N	\N	\N	f	2023-08-17 10:49:08.809	2023-11-27 21:19:57.113	22	\N	1155
36a82628-3bca-4eba-b38b-b287236a8057	POST	8	\N	DISCARDED	\N	\N	\N	f	2023-09-20 15:20:59.303	2023-11-27 21:19:57.116	19	\N	444
942c6be3-79b7-43be-8b45-b0eb430307b1	POST	7	\N	DISCARDED	\N	\N	\N	f	2023-05-28 08:56:11.936	2023-11-27 21:19:57.118	22	\N	466
22bafdb6-3190-43da-bca0-e96fca2f0f32	POST	41	\N	DISCARDED	\N	\N	\N	f	2023-08-17 21:03:30.567	2023-11-27 21:19:57.121	14	\N	982
32742721-cda8-4cd2-a366-5f37ff3ed949	POST	1	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-08-01 01:02:59.127	2023-11-27 21:19:57.123	17	\N	1384
fc04927f-c3b4-4697-ab2e-7eb0d1952c4e	POST	11	\N	DISCARDED	\N	\N	\N	f	2023-02-18 03:45:22.982	2023-11-27 21:19:57.125	22	\N	1049
60a4eb1f-769f-4575-b234-9a7788b143ce	POST	32	\N	PENDING	\N	\N	\N	f	2023-06-06 09:04:27.981	2023-11-27 21:19:57.127	22	\N	365
3e8a50bc-0226-462c-a051-8a73903588dc	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-02-14 12:38:44.671	2023-11-27 21:19:57.13	21	\N	653
cfbc6d21-80f5-46c9-add8-93173f3794db	POST	56	\N	PENDING	\N	\N	\N	f	2023-03-04 04:17:05.979	2023-11-27 21:19:57.132	14	\N	781
04d9d24a-75a3-41c1-8d65-0280cfdafb41	POST	56	\N	DISCARDED	\N	\N	\N	f	2022-12-01 22:54:10.885	2023-11-27 21:19:57.134	18	\N	1410
81dfb557-a8cf-46e7-a1fe-ab3c7038d5b3	POST	54	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-05 07:18:37.79	2023-11-27 21:19:57.137	21	\N	640
cf88aa9e-9b86-4906-b539-358e24615ae5	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-06-20 08:25:40.502	2023-11-27 21:19:57.139	23	\N	926
4f174fec-f592-46e0-b211-1d549f5b4f99	POST	14	\N	PENDING	\N	\N	\N	f	2023-09-20 04:02:18.972	2023-11-27 21:19:57.141	14	\N	441
db320d0d-f9b7-4a46-bb05-8213b0f6b898	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-04 18:39:41.403	2023-11-27 21:19:57.143	19	\N	923
dada0466-c046-4928-8f29-71c2b441b6d1	POST	44	\N	PENDING	\N	\N	\N	f	2023-10-27 01:16:57.549	2023-11-27 21:19:57.145	22	\N	618
41fa9b0a-8353-4581-8684-0a5e5830ec19	POST	4	\N	PENDING	\N	\N	\N	f	2023-02-22 12:08:11.993	2023-11-27 21:19:57.147	16	\N	1387
4d85ec5c-e76d-4ace-a684-5e85dfa2d903	POST	34	\N	PENDING	\N	\N	\N	f	2023-08-27 15:21:22.923	2023-11-27 21:19:57.15	14	\N	1004
b3b4445d-9c6f-48ab-bc4c-e6f45a13e1fd	POST	17	\N	PENDING	\N	\N	\N	f	2023-05-19 11:07:07.654	2023-11-27 21:19:57.151	21	\N	1163
6657e2ff-b240-4000-814c-a8574c78404f	POST	51	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-12 18:17:08.549	2023-11-27 21:19:57.154	14	\N	1520
8d0d25cc-90fb-4186-b844-c461e5103c06	POST	11	\N	DISCARDED	\N	\N	\N	f	2022-12-18 04:38:33.238	2023-11-27 21:19:57.156	20	\N	799
ddf82be0-251d-4491-b21e-f750c1b263df	POST	29	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-04-07 18:10:53.84	2023-11-27 21:19:57.158	17	\N	901
b49afb1e-2483-42c9-81d4-72b7c9f295a1	POST	52	\N	PENDING	\N	\N	\N	f	2023-08-28 23:30:56.822	2023-11-27 21:19:57.16	17	\N	1178
2641f060-fac9-4924-b0e6-00f8fac8243d	POST	3	\N	DISCARDED	\N	\N	\N	f	2023-07-29 02:31:22.594	2023-11-27 21:19:57.162	16	\N	825
4232145e-dcb7-40f5-9810-c79b9aececec	POST	16	\N	PENDING	\N	\N	\N	f	2023-10-13 09:29:14.797	2023-11-27 21:19:57.164	18	\N	1071
a4d5b1de-2ee6-447c-a318-159fd7dcd907	POST	4	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-21 04:50:54.569	2023-11-27 21:19:57.166	14	\N	345
6004d787-44f6-4af5-a7ec-8b22d54c0a8d	POST	49	\N	PENDING	\N	\N	\N	f	2023-05-06 18:07:46.69	2023-11-27 21:19:57.168	17	\N	551
48bddffd-7204-4088-b6ba-7e89a77ea043	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-06-02 13:00:14.999	2023-11-27 21:19:57.171	22	\N	752
0816e1f6-15a3-4421-91b6-b2dcaf93f5af	POST	18	\N	DISCARDED	\N	\N	\N	f	2023-05-10 18:03:58.706	2023-11-27 21:19:57.172	19	\N	1083
3c0772f5-e0ad-4a73-a2ed-3654e6cd4bb5	POST	28	\N	DISCARDED	\N	\N	\N	f	2023-09-15 15:34:29.194	2023-11-27 21:19:57.174	21	\N	1389
4ab8c319-2357-45f1-82c6-f4f3f2561ae7	POST	43	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-07 12:30:09.697	2023-11-27 21:19:57.177	19	\N	584
006a1931-d11a-4f9e-b19b-18ddb39251eb	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-25 12:39:56.336	2023-11-27 21:19:57.178	17	\N	896
342b5fd5-0bcf-4eef-ac78-d3dc47570c6c	POST	33	\N	DISCARDED	\N	\N	\N	f	2023-06-29 03:24:45.136	2023-11-27 21:19:57.181	19	\N	590
18af3fa0-9c39-4d41-bcf1-e16e29ae3a61	POST	8	\N	DISCARDED	\N	\N	\N	f	2023-08-12 19:09:50.478	2023-11-27 21:19:57.183	22	\N	1191
c224ef4f-2a1b-4660-8bd4-28d6a35569ab	POST	48	\N	PENDING	\N	\N	\N	f	2023-09-24 03:08:28.763	2023-11-27 21:19:57.185	20	\N	1423
a6de87f2-61b8-4d05-9e1d-5ae19007dcc3	POST	13	\N	PENDING	\N	\N	\N	f	2022-12-17 07:42:42.399	2023-11-27 21:19:57.187	19	\N	447
4c5cff64-8ddc-4b68-99e7-6373b92dc63c	POST	53	\N	PENDING	\N	\N	\N	f	2023-11-20 03:46:03.909	2023-11-27 21:19:57.189	20	\N	1500
8c4a9284-3be6-4acc-bdff-0a8f84219746	POST	25	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-07-23 11:06:35.445	2023-11-27 21:19:57.191	20	\N	715
b91da4d5-4eb0-4532-a5cc-ddc6f450c9e7	POST	11	\N	DISCARDED	\N	\N	\N	f	2023-09-30 18:55:04.552	2023-11-27 21:19:57.193	17	\N	1083
7c36e4d6-c159-4907-8a62-3de3ee72901c	POST	15	\N	PENDING	\N	\N	\N	f	2023-11-25 14:58:39.029	2023-11-27 21:19:57.195	17	\N	832
3f0988d3-b54f-4089-8004-e1c303e8b199	POST	18	\N	PENDING	\N	\N	\N	f	2023-10-14 03:55:47.411	2023-11-27 21:19:57.198	18	\N	391
8f1181cd-3f28-464b-a71b-5a85fe72017a	POST	32	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-22 13:35:08.146	2023-11-27 21:19:57.201	23	\N	744
a5bff222-642e-440a-a074-4019a236d999	POST	37	\N	PENDING	\N	\N	\N	f	2023-10-22 14:01:00.169	2023-11-27 21:19:57.203	22	\N	544
ffbec6b3-373e-49e1-b3b5-73fab33050f3	POST	23	\N	PENDING	\N	\N	\N	f	2022-12-29 20:34:36.695	2023-11-27 21:19:57.205	22	\N	785
5bec0b96-e49d-456f-9d65-70be5453f326	POST	44	\N	DISCARDED	\N	\N	\N	f	2023-03-03 06:03:10.935	2023-11-27 21:19:57.207	19	\N	617
55fe2161-e17f-45d2-8164-5ddcc9aa9b9f	POST	14	\N	CONTENT_REMOVED	\N	\N	\N	f	2022-12-19 12:24:07.812	2023-11-27 21:19:57.209	22	\N	712
a45310bf-b80a-46e6-ae05-7f86fd715aa9	POST	6	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-02-04 10:41:49.453	2023-11-27 21:19:57.212	20	\N	735
ec53b61c-2a3b-47d6-8056-33d07d1f7229	POST	38	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-04 12:02:57.191	2023-11-27 21:19:57.214	22	\N	381
96846e52-30e8-4ad6-a9be-cd3426664248	POST	58	\N	PENDING	\N	\N	\N	f	2023-02-10 23:10:01.339	2023-11-27 21:19:57.216	21	\N	400
a8c7bd5d-4000-4418-b2f0-d794810e6cd7	POST	47	\N	DISCARDED	\N	\N	\N	f	2023-11-19 05:56:40.492	2023-11-27 21:19:57.217	23	\N	600
7efb8bb7-6f5c-42a9-8908-589db1f7c981	POST	11	\N	PENDING	\N	\N	\N	f	2022-12-16 15:41:19.441	2023-11-27 21:19:57.219	20	\N	1373
4abd696a-1f68-46c7-a883-c5b95d5215fd	POST	6	\N	DISCARDED	\N	\N	\N	f	2023-02-19 04:39:52.03	2023-11-27 21:19:57.22	18	\N	1234
c1565cc3-1c3f-47ee-bbae-a9623d52b9ae	POST	33	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-02 15:06:46.83	2023-11-27 21:19:57.222	16	\N	1000
882aeb69-2868-4dcb-bebf-2f0f6311dd0b	POST	39	\N	PENDING	\N	\N	\N	f	2023-06-06 08:47:37.772	2023-11-27 21:19:57.223	21	\N	1008
8e60335c-bde4-4022-9a97-bd63969dee5a	POST	34	\N	DISCARDED	\N	\N	\N	f	2023-01-01 15:55:45.714	2023-11-27 21:19:57.225	22	\N	1048
cae5ed15-c06d-41e9-9748-57749205480e	POST	11	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-11-07 05:54:43.849	2023-11-27 21:19:57.227	17	\N	1211
f8dfd3d8-d192-4fb5-8868-7496cad886e5	POST	2	\N	DISCARDED	\N	\N	\N	f	2023-06-20 05:04:52.501	2023-11-27 21:19:57.229	14	\N	1527
f30a7421-46eb-48ff-82bb-2f0dc2815a5b	POST	38	\N	PENDING	\N	\N	\N	f	2023-11-04 22:04:45.925	2023-11-27 21:19:57.231	20	\N	747
f7600552-ce98-43db-a32e-f54a21045a4b	POST	11	\N	DISCARDED	\N	\N	\N	f	2023-03-17 22:46:55.743	2023-11-27 21:19:57.232	22	\N	425
79725c7c-5694-45d2-9777-1eb6fbf845d9	POST	44	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-19 14:55:05.019	2023-11-27 21:19:57.234	17	\N	872
4f9f6c15-83d5-41a0-9e37-944d1390861b	POST	19	\N	DISCARDED	\N	\N	\N	f	2023-05-09 08:29:53.054	2023-11-27 21:19:57.235	17	\N	973
4b0a013c-ede0-4d5e-a03b-a354fdb1545c	POST	28	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-09-08 04:08:51.466	2023-11-27 21:19:57.237	19	\N	449
2e6708ec-5a8b-4829-919b-51c60953d73a	POST	2	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-03-09 05:57:36.048	2023-11-27 21:19:57.239	15	\N	715
ed0d3a75-2b2b-4ed9-b32a-7b7ab6f36935	POST	4	\N	DISCARDED	\N	\N	\N	f	2023-07-11 20:23:19.03	2023-11-27 21:19:57.24	19	\N	482
2f81c2ba-9dba-4ea8-bf8e-f9cbe3817070	POST	47	\N	PENDING	\N	\N	\N	f	2023-11-12 09:08:49.985	2023-11-27 21:19:57.242	22	\N	1289
8714e4d7-7fcd-4321-80fe-486609a54167	POST	52	\N	CONTENT_REMOVED	\N	\N	\N	f	2023-05-21 05:17:48.099	2023-11-27 21:19:57.243	18	\N	622
\.


--
-- Data for Name: Rule; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Rule" (id, title, description, "createdAt", "spaceId", edited, "factiiiId") FROM stdin;
1	No Hate	We do not tolerate content that expresses, incites, or promotes hate based on identity.	2023-11-27 21:15:24.922	1	f	\N
2	No Illegal Content	We do not allow content that violates any laws, trademarks, or copyrights.	2023-11-27 21:15:24.922	1	f	\N
3	Respect Others	Please keep your content respectful. We may not agree on everything, but as fellow humans, we should strive to respect each other.	2023-11-27 21:15:24.922	1	f	\N
4	No Deceptive Content	We do not allow content that is intentionally misleading or spreading false information. Parody is allowed, but impersonation is not.	2023-11-27 21:15:24.922	1	f	\N
5	No Harassment or Trolling	We do not tolerate content that is harassing or trolling.	2023-11-27 21:15:24.922	1	f	\N
6	No Name Trolling	We reserve the right to transfer account Space and User names to new owners. This will be done in a transparent and open manner.	2023-11-27 21:15:24.922	1	f	\N
7	No Violence	We do not allow content that encourages violence against others.	2023-11-27 21:15:24.922	1	f	\N
8	No Self-Harm	We do not allow content that promotes, encourages, or depicts acts of self-harm.	2023-11-27 21:15:24.922	1	f	\N
9	Political Content Discouraged	While political content is allowed, it is not encouraged. The default site filter deboosts political content. Please keep political discussion in s/politics.	2023-11-27 21:15:24.922	1	f	\N
10	nsfw	nsfw rule	2023-11-27 21:15:25.053	\N	f	6
11	Politics	Politics rule	2023-11-27 21:15:25.062	\N	f	4
12	No Hate	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:15:25.249	12	f	\N
13	No Harassment	Content that intends to harass, threaten, or bully an individual	2023-11-27 21:15:25.249	12	f	\N
14	No Violence	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:15:25.249	12	f	\N
15	No Self-harm	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2023-11-27 21:15:25.249	12	f	\N
16	No Sexual Material	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:15:25.249	12	f	\N
17	No Political Manipulation	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:15:25.249	12	f	\N
18	No Spam	Unsolicited bulk content	2023-11-27 21:15:25.249	12	f	\N
19	No Deception	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2023-11-27 21:15:25.249	12	f	\N
20	No Malware	Content that attempts to generate ransomware, keyloggers, viruses, or other software intended to impose some level of harm	2023-11-27 21:15:25.249	12	f	\N
21	Illegal or harmful industries	Includes gambling, payday lending, illegal substances, pseudo-pharmaceuticals, multi-level marketing, weapons development, warfare, cybercrime, adult industries, spam, and non-consensual surveillance.	2023-11-27 21:15:25.249	12	f	\N
22	Misuse of personal data	Includes classifying people based on protected characteristics, mining sensitive information without appropriate consent, products that claim to accurately predict behavior based on dubious evidence.	2023-11-27 21:15:25.249	12	f	\N
23	Promoting dishonesty	Includes testimonial generation, product or service review generation, educational dishonesty, contract cheating, astroturfing.	2023-11-27 21:15:25.249	12	f	\N
24	Deceiving or manipulating users	Includes automated phone calls that sound human, a romantic chatbot that emotionally manipulates end-users, automated systems (including conversational AI and chatbots) that donΓÇÖt disclose that they are an AI system, or products that simulate another person without their explicit consent.	2023-11-27 21:15:25.249	12	f	\N
25	Trying to influence politics	Includes generating political fundraising emails, or classifying people in order to deliver targeted political messages.	2023-11-27 21:15:25.249	12	f	\N
26	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:51.973	16	f	\N
27	No Sexual Content	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:19:51.973	16	f	\N
28	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:51.973	16	f	\N
29	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:51.988	17	f	\N
30	No Deceptive Content	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2023-11-27 21:19:51.988	17	f	\N
31	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.004	18	f	\N
32	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:52.004	18	f	\N
33	No Sexual Content	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:19:52.004	18	f	\N
34	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.004	18	f	\N
35	No Self-Harm Content	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2023-11-27 21:19:52.004	18	f	\N
36	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.017	19	f	\N
37	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.017	19	f	\N
38	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.032	20	f	\N
39	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:52.045	21	f	\N
40	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.045	21	f	\N
41	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.045	21	f	\N
42	No Sexual Content	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:19:52.045	21	f	\N
43	No Sexual Content	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:19:52.058	22	f	\N
44	No Deceptive Content	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2023-11-27 21:19:52.058	22	f	\N
45	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.058	22	f	\N
46	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:52.058	22	f	\N
47	No Self-Harm Content	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2023-11-27 21:19:52.058	22	f	\N
48	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:52.076	23	f	\N
49	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.076	23	f	\N
50	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.076	23	f	\N
51	No Sexual Content	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2023-11-27 21:19:52.089	24	f	\N
52	No Self-Harm Content	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2023-11-27 21:19:52.089	24	f	\N
53	No Deceptive Content	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2023-11-27 21:19:52.089	24	f	\N
54	No Hate Content	Content that expresses, incites, or promotes hate based on identity	2023-11-27 21:19:52.089	24	f	\N
55	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.089	24	f	\N
56	No Violence Content	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2023-11-27 21:19:52.089	24	f	\N
57	No Self-Harm Content	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2023-11-27 21:19:52.108	25	f	\N
58	No Political Content	Content attempting to influence the political process or to be used for campaigning purposes	2023-11-27 21:19:52.108	25	f	\N
59	No Deceptive Content	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2023-11-27 21:19:52.108	25	f	\N
\.


--
-- Data for Name: SavedPost; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SavedPost" ("userId", "createdAt", "postId") FROM stdin;
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Session" (id, "refreshToken", "issuedAt", "browserName", "lastUsed", "userId", "revokedAt") FROM stdin;
\.


--
-- Data for Name: SiteSettings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SiteSettings" (id, "createdAt", "coinTronRatio", "coinTransferRatio", "requestRateLimit", "postsPerMinute", "maxSpacesPerUser", "openAiLimitPerHourPerUser", "openAiLimitPremiumUser") FROM stdin;
1	2023-11-27 21:15:24.835	3000	5	50	30	10	30	100
\.


--
-- Data for Name: Space; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Space" (id, slug, name, description, "avatarId", "bannerId", robohash, "createdAt", "updatedAt", status, "paidSpaceMonthlyPrice", "pinnedPostId", types) FROM stdin;
2	wikipedia	Wikipedia	Welcome to the unofficial Wikipedia Page!	\N	\N	278af683-3174-43fe-bfdb-1c4aa8df55d3	2023-11-27 21:15:25.008	2023-11-27 21:15:25.008	ACTIVE	99	\N	{}
3	founders	founders	Welcome to founders! A place for founding members to hang out and share requests. This is only open to those who buy founders tokens	49e07b7f-4cb4-435b-9394-12acf198b35e	f55399c1-cce8-4e0f-989c-1c0038452ee0	322acebb-1579-46ea-b14a-2a1b191fa191	2023-11-27 21:15:25.114	2023-11-27 21:15:25.123	ACTIVE	99	\N	{PREMIUM}
4	premium	premium	Welcome to premium! A place for premium members to hang out and share requests. This is only open to those with active premium subscriptions.	dba8fca1-10e3-4271-8532-9217699bba43	d8abfa7d-cde6-4291-bc99-8aef41b3496d	66ef829e-694f-4967-8c8d-95875bc8c84b	2023-11-27 21:15:25.127	2023-11-27 21:15:25.136	ACTIVE	99	\N	{PREMIUM}
1	factiii	factiii	Welcome to factiii. This is a place to discuss anything you like with an emphasis on factiii and how we can improve. Hope you all enjoy it here!	08469425-cc22-4870-8479-cd35118cfcfb	20cf4766-f99a-45d0-aee8-7ea2a545bee3	dbc20cc8-dc23-47b6-8047-7eb76c35d738	2023-11-27 21:15:24.922	2023-11-27 21:15:25.144	ACTIVE	99	\N	{}
5	about	about	Welcome to our about page. Here you can see our blog as well as learn about our Mission. Feel free to engage with us in s/factiii.	6b95d052-5977-4c45-aa5a-3dcfabbc2dff	3620fdb9-9ef2-4589-8700-a57e5f5b95e1	305d58f0-e2da-4160-9bfb-e23c04efad25	2023-11-27 21:15:25.147	2023-11-27 21:15:25.158	ACTIVE	99	\N	{}
6	science	science	A place to talk about everything science!	\N	\N	eefa5274-4db2-4230-baf2-b3a33edaff6f	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
7	history	history	A place to discuss History!	\N	\N	d69c925e-fb80-4448-a40f-8a856906db93	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
8	pics	pics	A place to post fun pictures!	\N	\N	2b69a8d6-fe31-4f5c-a8f5-dc31279c8026	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
9	videos	videos	A place to post fun videos!	\N	\N	89977820-a082-4d3a-8423-5d5aae6a1b6d	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
10	news	news	A place to post world leading News!	\N	\N	755f6542-c2f8-4ffd-8f68-35475d658ea8	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
11	announcements	announcements	A place factiii uses to share announcements.	\N	\N	26b4655b-2efa-45bf-9cb2-60ba725781fd	2023-11-27 21:15:25.231	2023-11-27 21:15:25.231	ACTIVE	99	\N	{}
12	openai	OpenAI	Get answers to every single question you have, powered by GPT-3. Not the official OpenAI account.	ed135d8c-ba0e-44d6-beb3-6610c12cdb89	182a71fa-b200-46ba-9143-8a960cc0636e	3620fe85-d91b-4d25-9679-f3edc6a619db	2023-11-27 21:15:25.249	2023-11-27 21:15:25.269	ACTIVE	99	\N	{}
13	paid	paid	This is a test private paid space. Janice is not invited so we can do tests to see if she can see it.	57904dff-3534-43c2-802a-ba422f44c2af	ce77eb1c-c306-4923-9a7d-bf7ccaf96c5d	1b1ca7b9-aa56-4105-8e2f-64973f9caf8b	2023-11-27 21:15:25.401	2023-11-27 21:15:25.413	ACTIVE	99	\N	{PRIVATE,PAID}
14	private-test	Private Test	This is a test private space. If you see me then something is broken. Janice loves this secret place.	\N	\N	cce90f31-e2ce-435c-91da-5a2119642b71	2023-11-27 21:15:25.416	2023-11-27 21:15:25.416	ACTIVE	99	\N	{PRIVATE}
15	private-factiii	Private Factiii	This is a test private space. Janice is the owner and it holds private factiiis.	\N	\N	7d5b8a49-2a40-4a74-9986-44f840e8f6b1	2023-11-27 21:15:25.42	2023-11-27 21:15:25.42	ACTIVE	99	\N	{PRIVATE}
16	north-stanfordberg	North Stanfordberg	Eos illo vero earum dignissimos. Nisi eaque qui. Sapiente et accusantium illum quas beatae accusantium quia esse natus. Veniam quos id rem occaecati.	3276b4fc-ff1f-49f3-8f61-e6eaa3b5e4d0	aadad952-e9ca-469d-966b-4f5f5e31e0f5	259c8c6f-061a-49cd-912e-10b69208d521	2023-10-31 17:50:39.647	2023-11-27 21:19:51.969	ACTIVE	99	\N	{}
17	new-frederikhaven	New Frederikhaven	Excepturi earum nostrum illo deserunt aperiam ipsa omnis incidunt voluptas. Quia quibusdam iste est.	5c5203e2-024d-475a-8787-d36547daa6f3	1eed358c-f500-474d-802f-99e5066efccc	61e8b52e-084c-4782-bb64-543fb66c7eda	2023-06-06 14:46:42.279	2023-11-27 21:19:51.986	ACTIVE	99	\N	{}
18	tremblayberg	Tremblayberg	Quos sit voluptatum autem totam sapiente natus. Nisi cum cumque sed fugiat.	1274a834-a812-449b-ab91-2771307c8e44	84f001f3-9219-49df-982b-145cd47952c7	db3351e7-5991-4181-bb7a-43298186e644	2023-09-16 12:46:55.877	2023-11-27 21:19:52.001	ACTIVE	99	\N	{}
19	sanfordfield	Sanfordfield	Aperiam tenetur nisi nostrum. Impedit corporis quidem odio deserunt ratione delectus autem similique quia. Totam facilis incidunt eos totam possimus animi. Assumenda aspernatur distinctio minus officia eligendi odio iste amet.	8d6f637d-88ed-45ee-8d41-1fe906bf837c	ced85294-34d4-48c9-a473-c554da2931f8	41107254-6a25-4e35-83b2-565b98f7adf9	2023-03-22 20:19:10.083	2023-11-27 21:19:52.015	ACTIVE	99	\N	{}
20	baltimore	Baltimore	Dicta deleniti molestias. Possimus aliquid aliquam nihil hic cumque aspernatur harum veniam. Quod amet itaque dolore veniam quod adipisci recusandae veniam velit. Blanditiis repudiandae vero libero recusandae tempore.	5cb79a19-14cf-4feb-a0af-821a8f45c12e	5ee3c904-3b93-4f29-9461-50c5a6b0a04d	8fd31119-b3c8-4e51-8d4f-90ca65db2b98	2023-05-05 17:45:28.482	2023-11-27 21:19:52.028	ACTIVE	99	\N	{}
21	la-mirada	La Mirada	Ipsam distinctio minus laboriosam laudantium incidunt. Velit quasi explicabo consectetur eum nihil. Fuga repudiandae a. Consequuntur cum minus minima tempora facilis suscipit.	31e2399a-c741-4b92-81aa-6a1aa89bfe36	88efcec1-fd59-4aa8-a751-30fd047dea11	bbe3f528-307e-4b7f-bd9a-e8ffc4d01332	2023-11-25 04:21:20.297	2023-11-27 21:19:52.043	ACTIVE	99	\N	{}
22	north-tyreek	North Tyreek	Odit amet consequuntur illum sapiente deserunt neque dolore in aspernatur. Numquam quaerat dignissimos dolores sit ducimus dolorum. Blanditiis necessitatibus harum excepturi debitis ad nemo aspernatur.	1d2e6b38-6f1f-44fa-94d3-e82082208b9d	3293354f-0553-41d0-9be3-f5482fbe08af	54724429-bbe8-4bc0-9570-52f75464435a	2023-03-02 06:24:44.315	2023-11-27 21:19:52.056	ACTIVE	99	\N	{}
23	wardstad	Wardstad	Voluptas non laborum molestias quidem eos. Necessitatibus nobis ratione nesciunt voluptatem modi molestiae reiciendis commodi repudiandae. Expedita nulla adipisci. Hic ut repudiandae fugiat sunt.	e5380b54-267d-417b-b96a-cfbbc99fce3b	d59c345e-7efa-4a43-b891-adbb5e2c006c	c4d1db96-6951-467d-9cd0-a7ef177a4c02	2022-11-28 22:35:28.027	2023-11-27 21:19:52.074	ACTIVE	99	\N	{}
24	genevievechester	Genevievechester	Ratione blanditiis doloribus cum cupiditate quo nulla similique. Eveniet molestiae quasi culpa. Corrupti voluptatem quibusdam ratione. Laudantium consectetur voluptate dolor possimus. Quia vitae fuga quam soluta eos qui. Minus numquam repellat.	57595909-d152-4645-a28a-129563c4a5eb	9312468a-1bb0-4259-b8a0-621f7761be02	3a738904-80a1-435d-ab35-3d3370833c55	2022-12-03 18:53:38.842	2023-11-27 21:19:52.087	ACTIVE	99	\N	{}
25	colechester	Colechester	Perferendis in veniam placeat ad itaque vel doloribus. Cum ducimus repellat quisquam omnis. Consectetur at expedita ex dolorum ex dolorum. Ratione minus ducimus aliquam reprehenderit dicta corporis quis nobis. Veritatis quas accusantium iste provident voluptates eligendi tenetur expedita tempora. Fugiat reiciendis porro amet quia.	f6ee385b-3121-4bd8-92e7-2529a09c8787	05f395fe-e3db-495a-8661-d95f797a3f66	505540f2-8c57-4a8f-9b76-cc2af76e2e42	2023-02-16 04:41:49.85	2023-11-27 21:19:52.101	ACTIVE	99	\N	{}
\.


--
-- Data for Name: SpaceFilter; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceFilter" ("spaceId", "userId", "createdAt") FROM stdin;
1	2	2023-11-27 21:15:24.922
1	3	2023-11-27 21:15:24.922
1	1	2023-11-27 21:15:24.922
1	6	2023-11-27 21:15:25.383
1	14	2023-11-27 21:19:51.769
1	15	2023-11-27 21:19:51.814
1	16	2023-11-27 21:19:51.829
1	17	2023-11-27 21:19:51.844
1	18	2023-11-27 21:19:51.859
1	19	2023-11-27 21:19:51.874
1	20	2023-11-27 21:19:51.889
1	21	2023-11-27 21:19:51.908
1	22	2023-11-27 21:19:51.927
1	23	2023-11-27 21:19:51.941
\.


--
-- Data for Name: SpaceInvite; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceInvite" ("spaceId", "userId", "inviterId", "createdAt", joined) FROM stdin;
\.


--
-- Data for Name: SpaceMember; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceMember" ("createdAt", expires, "userId", "spaceId", "productId", "subscriptionId", roles) FROM stdin;
2023-11-27 21:15:24.922	\N	2	1	\N	\N	{OWNER}
2023-11-27 21:15:24.922	\N	3	1	\N	\N	{OWNER}
2023-11-27 21:15:24.922	\N	1	1	\N	\N	{MODERATOR}
2023-11-27 21:15:25.008	\N	2	2	\N	\N	{OWNER}
2023-11-27 21:15:25.008	\N	4	2	\N	\N	{OWNER}
2023-11-27 21:15:25.114	\N	2	3	\N	\N	{OWNER}
2023-11-27 21:15:25.114	\N	3	3	\N	\N	{OWNER}
2023-11-27 21:15:25.127	\N	2	4	\N	\N	{OWNER}
2023-11-27 21:15:25.127	\N	3	4	\N	\N	{OWNER}
2023-11-27 21:15:25.147	\N	2	5	\N	\N	{OWNER}
2023-11-27 21:15:25.147	\N	3	5	\N	\N	{OWNER}
2023-11-27 21:15:25.147	\N	1	5	\N	\N	{MODERATOR}
2023-11-27 21:15:25.249	\N	5	12	\N	\N	{OWNER}
2023-11-27 21:15:25.249	\N	2	12	\N	\N	{MODERATOR}
2023-11-27 21:15:25.249	\N	3	12	\N	\N	{MODERATOR}
2023-11-27 21:15:25.401	1969-12-31 23:59:57.975	2	13	\N	\N	{OWNER}
2023-11-27 21:15:25.401	1969-12-31 23:59:57.975	3	13	\N	\N	{OWNER}
2023-11-27 21:15:25.416	\N	6	14	\N	\N	{MEMBER}
2023-11-27 21:15:25.42	\N	6	15	\N	\N	{OWNER}
2023-08-15 19:20:29.377	\N	19	16	\N	\N	{OWNER}
2023-03-23 23:34:02.74	\N	23	17	\N	\N	{OWNER}
2022-12-07 18:23:45.894	\N	17	18	\N	\N	{OWNER}
2023-11-21 03:44:27.256	\N	20	19	\N	\N	{OWNER}
2023-08-12 09:50:26.945	\N	18	20	\N	\N	{OWNER}
2022-12-05 09:36:47.496	\N	20	21	\N	\N	{OWNER}
2023-06-22 13:23:12.781	\N	14	22	\N	\N	{OWNER}
2023-05-26 06:18:57.689	\N	21	23	\N	\N	{OWNER}
2023-07-25 10:52:15.458	\N	15	24	\N	\N	{OWNER}
2023-03-10 19:31:13.72	\N	14	25	\N	\N	{OWNER}
2023-07-29 20:28:39.718	\N	14	17	\N	\N	{MEMBER}
2023-01-10 10:55:13.802	\N	14	20	\N	\N	{MEMBER}
2023-03-28 21:43:20.757	\N	14	24	\N	\N	{MEMBER}
2023-02-22 08:56:39.843	\N	14	23	\N	\N	{MEMBER}
2023-07-17 21:17:57.937	\N	14	16	\N	\N	{MEMBER}
2023-08-19 23:28:09.258	\N	14	21	\N	\N	{MEMBER}
2023-01-12 21:39:46.13	\N	14	19	\N	\N	{MEMBER}
2022-12-17 20:51:50.406	\N	15	22	\N	\N	{MEMBER}
2023-01-30 22:53:56.899	\N	15	20	\N	\N	{MEMBER}
2023-06-16 22:15:30.437	\N	15	23	\N	\N	{MEMBER}
2023-01-28 11:40:15.714	\N	15	17	\N	\N	{MEMBER}
2023-07-20 02:44:26.401	\N	15	18	\N	\N	{MEMBER}
2023-02-15 05:08:09.141	\N	15	21	\N	\N	{MEMBER}
2022-12-26 05:07:06.38	\N	16	17	\N	\N	{MEMBER}
2023-07-23 11:29:35.184	\N	16	20	\N	\N	{MEMBER}
2023-11-10 16:37:08.074	\N	16	18	\N	\N	{MEMBER}
2023-07-20 20:20:03.179	\N	16	19	\N	\N	{MEMBER}
2022-12-04 14:07:44.127	\N	16	23	\N	\N	{MEMBER}
2023-08-23 23:21:46.852	\N	16	22	\N	\N	{MEMBER}
2023-02-20 22:59:22.823	\N	17	16	\N	\N	{MEMBER}
2023-10-14 16:41:11.975	\N	17	19	\N	\N	{MEMBER}
2023-09-01 14:40:49.955	\N	17	20	\N	\N	{MEMBER}
2023-04-02 07:19:52.449	\N	17	25	\N	\N	{MEMBER}
2023-02-07 16:33:17.324	\N	17	23	\N	\N	{MEMBER}
2022-12-23 21:53:41.896	\N	17	21	\N	\N	{MEMBER}
2023-10-30 10:27:41.381	\N	17	17	\N	\N	{MEMBER}
2023-06-25 17:10:02.713	\N	18	25	\N	\N	{MEMBER}
2023-09-08 21:20:34.476	\N	18	19	\N	\N	{MEMBER}
2023-06-02 00:17:17.072	\N	18	16	\N	\N	{MEMBER}
2023-09-09 07:50:26.563	\N	18	23	\N	\N	{MEMBER}
2023-06-18 19:10:28.086	\N	18	17	\N	\N	{MEMBER}
2023-06-23 05:52:47.765	\N	18	24	\N	\N	{MEMBER}
2023-01-31 19:40:01.583	\N	18	21	\N	\N	{MEMBER}
2023-03-05 12:02:43.846	\N	18	18	\N	\N	{MEMBER}
2023-04-19 22:12:45.066	\N	18	22	\N	\N	{MEMBER}
2023-06-04 03:21:16.659	\N	19	18	\N	\N	{MEMBER}
2023-04-26 12:44:41.552	\N	19	17	\N	\N	{MEMBER}
2023-01-06 20:22:47.327	\N	19	23	\N	\N	{MEMBER}
2023-07-09 14:26:37.888	\N	19	19	\N	\N	{MEMBER}
2023-04-18 01:28:50.835	\N	19	20	\N	\N	{MEMBER}
2022-12-09 18:27:52.335	\N	19	22	\N	\N	{MEMBER}
2023-06-07 08:41:57.794	\N	19	24	\N	\N	{MEMBER}
2023-07-07 20:30:43.062	\N	19	21	\N	\N	{MEMBER}
2023-11-13 21:57:33.726	\N	20	17	\N	\N	{MEMBER}
2023-09-01 23:14:49.692	\N	20	24	\N	\N	{MEMBER}
2023-04-09 08:49:30.962	\N	20	23	\N	\N	{MEMBER}
2023-06-10 08:03:40.807	\N	20	25	\N	\N	{MEMBER}
2022-12-22 15:46:38.571	\N	20	18	\N	\N	{MEMBER}
2023-05-31 01:46:19.934	\N	20	20	\N	\N	{MEMBER}
2023-10-19 12:57:38.062	\N	20	16	\N	\N	{MEMBER}
2023-05-06 17:26:37.995	\N	20	22	\N	\N	{MEMBER}
2023-05-02 16:25:02.084	\N	21	17	\N	\N	{MEMBER}
2023-03-01 01:52:37.17	\N	21	25	\N	\N	{MEMBER}
2023-01-06 15:51:32.742	\N	21	16	\N	\N	{MEMBER}
2023-01-20 01:29:28.379	\N	21	24	\N	\N	{MEMBER}
2023-02-28 17:11:19.234	\N	21	22	\N	\N	{MEMBER}
2023-07-17 21:48:19.132	\N	21	20	\N	\N	{MEMBER}
2023-11-05 07:22:27.21	\N	21	21	\N	\N	{MEMBER}
2022-12-28 10:06:14.748	\N	21	19	\N	\N	{MEMBER}
2023-01-14 05:26:08.997	\N	21	18	\N	\N	{MEMBER}
2023-09-08 07:29:44.566	\N	22	17	\N	\N	{MEMBER}
2023-03-08 03:37:40.148	\N	22	21	\N	\N	{MEMBER}
2023-07-02 18:01:20.102	\N	22	16	\N	\N	{MEMBER}
2023-04-20 20:24:59.069	\N	22	24	\N	\N	{MEMBER}
2023-03-07 11:05:46.471	\N	22	22	\N	\N	{MEMBER}
2023-07-16 21:27:23.514	\N	22	19	\N	\N	{MEMBER}
2023-07-24 01:41:10.765	\N	22	25	\N	\N	{MEMBER}
2023-11-15 07:52:25.589	\N	22	20	\N	\N	{MEMBER}
2023-08-18 04:21:35.861	\N	22	18	\N	\N	{MEMBER}
2023-07-05 06:47:55.872	\N	22	23	\N	\N	{MEMBER}
2023-07-04 02:52:35.079	\N	23	24	\N	\N	{MEMBER}
2023-09-26 17:58:00.876	\N	23	19	\N	\N	{MEMBER}
2023-02-14 07:37:54.67	\N	23	16	\N	\N	{MEMBER}
2022-12-06 01:25:03.908	\N	23	25	\N	\N	{MEMBER}
2023-09-27 13:51:47.442	\N	23	18	\N	\N	{MEMBER}
2023-07-02 20:02:38.39	\N	23	21	\N	\N	{MEMBER}
2023-10-05 04:26:22.755	\N	23	22	\N	\N	{MEMBER}
2022-12-26 23:58:51.054	\N	23	23	\N	\N	{MEMBER}
2023-11-07 12:52:02.185	\N	23	20	\N	\N	{MEMBER}
\.


--
-- Data for Name: SpaceRuleEditHistory; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceRuleEditHistory" (id, title, description, "ruleId", "createdAt") FROM stdin;
\.


--
-- Data for Name: SpaceTime; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceTime" (id, "createdAt", "updatedAt", "timestamp", latitude, longitude, display, altitude, "postFactiiiId") FROM stdin;
\.


--
-- Data for Name: Subscription; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Subscription" (id, active, "payDayAnchor", "nextPayment", "productId", "userId", identifier) FROM stdin;
\.


--
-- Data for Name: Upload; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Upload" (id, status, "createdAt", "userId", key, type, "productId", name, size) FROM stdin;
1552dc54-d215-4de1-b5e5-ce8db5254ae8	PUBLISHED	2023-11-27 21:15:24.97	2	static/tagFunny.jpg	IMAGE	\N	\N	\N
b779393b-5f8e-4565-bf91-582b19494a8f	PUBLISHED	2023-11-27 21:15:24.977	2	static/tagInformative.jpg	IMAGE	\N	\N	\N
316c1b08-a15b-44b8-9613-5cf77e231821	PUBLISHED	2023-11-27 21:15:24.979	2	static/tagTroll.jpg	IMAGE	\N	\N	\N
10082c05-96a4-4899-aec3-52508e6e2fab	PUBLISHED	2023-11-27 21:15:24.981	2	static/tagPolitics.jpg	IMAGE	\N	\N	\N
8caa1d13-5029-4a24-9c38-a7b63dc51139	PUBLISHED	2023-11-27 21:15:24.983	2	static/tagMisleading.jpg	IMAGE	\N	\N	\N
64834b13-a66c-484c-b2ca-4d3c69533a7c	PUBLISHED	2023-11-27 21:15:24.985	2	static/tagNSFW.jpg	IMAGE	\N	\N	\N
75f4923f-29cf-40f8-80bb-e666f8ec00b5	PUBLISHED	2023-11-27 21:15:25.089	2	static/jonAvatar.jpg	IMAGE	\N	\N	\N
60b0c524-58bf-4b1f-8ce2-5ea41c7e04b0	PUBLISHED	2023-11-27 21:15:25.09	2	static/jonBanner.jpg	IMAGE	\N	\N	\N
b633a965-eaa2-4305-9cfc-a5021bb9bc52	PUBLISHED	2023-11-27 21:15:25.098	3	static/parikAvatar.jpg	IMAGE	\N	\N	\N
42b4a5cc-45be-4d39-a19a-6af2477396c3	PUBLISHED	2023-11-27 21:15:25.1	3	static/parikBanner.jpg	IMAGE	\N	\N	\N
1528fdc2-daf0-4686-bd86-8bd172cae3df	PUBLISHED	2023-11-27 21:15:25.105	1	static/nataliiaAvatar.jpg	IMAGE	\N	\N	\N
25187e4a-0069-4bd7-9f68-29fcdac52ea0	PUBLISHED	2023-11-27 21:15:25.107	1	static/nataliiaBanner.jpg	IMAGE	\N	\N	\N
49e07b7f-4cb4-435b-9394-12acf198b35e	PUBLISHED	2023-11-27 21:15:25.119	2	static/foundersAvatar.jpg	IMAGE	\N	\N	\N
f55399c1-cce8-4e0f-989c-1c0038452ee0	PUBLISHED	2023-11-27 21:15:25.121	2	static/foundersBanner.jpg	IMAGE	\N	\N	\N
dba8fca1-10e3-4271-8532-9217699bba43	PUBLISHED	2023-11-27 21:15:25.131	2	static/premiumAvatar.jpg	IMAGE	\N	\N	\N
d8abfa7d-cde6-4291-bc99-8aef41b3496d	PUBLISHED	2023-11-27 21:15:25.133	2	static/premiumBanner.jpg	IMAGE	\N	\N	\N
08469425-cc22-4870-8479-cd35118cfcfb	PUBLISHED	2023-11-27 21:15:25.138	2	static/factiiiAvatar.jpg	IMAGE	\N	\N	\N
20cf4766-f99a-45d0-aee8-7ea2a545bee3	PUBLISHED	2023-11-27 21:15:25.14	2	static/factiiiBanner.jpg	IMAGE	\N	\N	\N
6b95d052-5977-4c45-aa5a-3dcfabbc2dff	PUBLISHED	2023-11-27 21:15:25.153	2	static/aboutAvatar.jpg	IMAGE	\N	\N	\N
3620fdb9-9ef2-4589-8700-a57e5f5b95e1	PUBLISHED	2023-11-27 21:15:25.156	2	static/aboutBanner.jpg	IMAGE	\N	\N	\N
e2eb5015-9c7b-4aac-9153-ee86402e3c49	PUBLISHED	2023-11-27 21:15:25.162	2	static/premium-icon.svg	IMAGE	price_1MeotEDS6lFTllE61URh48EH	\N	\N
b9080848-4d00-4fe7-954b-bc0cb57c72c1	PUBLISHED	2023-11-27 21:15:25.182	2	static/premium-icon.svg	IMAGE	price_1MGu0TDS6lFTllE6BqybwcsE	\N	\N
1c5b2b26-8d8f-46e7-bed1-022780da5d2a	PUBLISHED	2023-11-27 21:15:25.187	2	static/premium-icon.svg	IMAGE	price_1MMEzsDS6lFTllE6GjjrtD9W	\N	\N
4438664a-4324-466d-b9fa-60a47e4c86bb	PUBLISHED	2023-11-27 21:15:25.193	2	static/premium-icon.svg	IMAGE	price_1MMF3RDS6lFTllE6cgK0xec7	\N	\N
91204557-b2ed-43e5-a6e9-ad47b67fee91	PUBLISHED	2023-11-27 21:15:25.199	2	static/bronze.gif	IMAGE	eb02d0e7-3bcf-4f7c-be61-34078bb55ac6	\N	\N
5ed23c48-4497-4043-84a8-bc3711dee06b	PUBLISHED	2023-11-27 21:15:25.206	2	static/silver.gif	IMAGE	price_1MGu3qDS6lFTllE6h6YgMmQl	\N	\N
fa182cec-19c4-4d32-aded-c93334d4c5b8	PUBLISHED	2023-11-27 21:15:25.214	2	static/gold.gif	IMAGE	price_1MartCDS6lFTllE6fFgyZvxI	\N	\N
ec4a8927-32e3-483e-9a13-291315e7cc97	PUBLISHED	2023-11-27 21:15:25.221	2	static/platinum.gif	IMAGE	price_1MarsIDS6lFTllE6SnBpfVkO	\N	\N
b0448979-b0e3-4893-bed0-c7f682d5feaf	PUBLISHED	2023-11-27 21:15:25.226	2	static/diamond.gif	IMAGE	price_1MLvQ8DS6lFTllE6BCNkQkSh	\N	\N
ed135d8c-ba0e-44d6-beb3-6610c12cdb89	PUBLISHED	2023-11-27 21:15:25.262	5	static/openai-logo.jpg	IMAGE	\N	\N	\N
182a71fa-b200-46ba-9143-8a960cc0636e	PUBLISHED	2023-11-27 21:15:25.264	5	static/openai-banner.png	IMAGE	\N	\N	\N
57904dff-3534-43c2-802a-ba422f44c2af	PUBLISHED	2023-11-27 21:15:25.409	6	static/paidAvatar.svg	IMAGE	\N	\N	\N
ce77eb1c-c306-4923-9a7d-bf7ccaf96c5d	PUBLISHED	2023-11-27 21:15:25.411	6	static/paidBanner.svg	IMAGE	\N	\N	\N
70dbac73-d2fd-40c5-8c39-869a02f7e65c	PUBLISHED	2023-11-27 21:15:25.441	6	static/test1.jpg	IMAGE	\N	\N	\N
ad36c2ed-192d-44b4-b296-f1828c61b608	PUBLISHED	2023-11-27 21:15:25.443	6	static/test2.jpg	IMAGE	\N	\N	\N
aa507be9-76c5-4720-9e40-71c6a06ef1fe	PUBLISHED	2023-11-27 21:15:25.445	6	static/test3.jpg	IMAGE	\N	\N	\N
f9581c3c-07ca-4e25-8ffe-08ab296e6048	PUBLISHED	2023-11-27 21:15:25.448	6	static/test4.gif	IMAGE	\N	\N	\N
c48c6b89-fdf3-4039-95eb-2e3050fda4f1	PUBLISHED	2023-11-27 21:15:25.45	6	static/test5.gif	IMAGE	\N	\N	\N
0d748291-5723-4e54-aaed-a2ce0a743b91	PUBLISHED	2023-11-27 21:15:25.453	6	static/test6.jpg	IMAGE	\N	\N	\N
d3530984-b326-4110-9997-52506e254f5d	PUBLISHED	2023-11-27 21:15:25.457	6	static/test7.mp4	VIDEO	\N	\N	\N
8192d70a-aedd-43d2-9da7-287b22e6f83d	PUBLISHED	2023-11-27 21:15:25.461	6	static/test8.jpg	IMAGE	\N	\N	\N
f692e9d9-86d5-4fa9-b6b7-9aa74151a60b	PUBLISHED	2023-11-27 21:15:25.52	6	static/janiceAvatar.jpg	IMAGE	\N	\N	\N
644f4f1a-76d8-4b70-85e7-492f472ae8c3	PUBLISHED	2023-11-27 21:15:25.523	6	static/janiceBanner.jpg	IMAGE	\N	\N	\N
9dec8743-de1b-4b4d-ad25-59245833c2e1	PUBLISHED	2023-11-27 21:19:51.797	14	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1228.jpg	IMAGE	\N	\N	\N
27eaef2a-be32-4c69-a9e9-d991d9459011	PUBLISHED	2023-11-27 21:19:51.803	14	https://loremflickr.com/1920/1080/sports	IMAGE	\N	\N	\N
c7604f20-0c18-46d7-92fc-8cc8e8cc02a7	PUBLISHED	2023-11-27 21:19:51.82	15	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/711.jpg	IMAGE	\N	\N	\N
6a0fb07a-46d6-4aa7-80a1-6fcb415515a8	PUBLISHED	2023-11-27 21:19:51.823	15	https://loremflickr.com/1920/1080/nightlife	IMAGE	\N	\N	\N
d8f9a143-ef1c-424e-9792-c9016c518248	PUBLISHED	2023-11-27 21:19:51.836	16	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/285.jpg	IMAGE	\N	\N	\N
ad776212-1683-48db-8f7c-2dc90c507338	PUBLISHED	2023-11-27 21:19:51.838	16	https://loremflickr.com/1920/1080/nightlife	IMAGE	\N	\N	\N
eb8a038d-30a0-47f6-bb86-61af2e3a7841	PUBLISHED	2023-11-27 21:19:51.851	17	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1042.jpg	IMAGE	\N	\N	\N
29728cd6-59fe-4c13-9696-6d268a705d77	PUBLISHED	2023-11-27 21:19:51.853	17	https://loremflickr.com/1920/1080/nightlife	IMAGE	\N	\N	\N
cacf35c1-8c94-4899-9544-f81fd2858517	PUBLISHED	2023-11-27 21:19:51.866	18	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/933.jpg	IMAGE	\N	\N	\N
c8dcead6-7595-455f-9710-1a5261195a75	PUBLISHED	2023-11-27 21:19:51.868	18	https://loremflickr.com/1920/1080/business	IMAGE	\N	\N	\N
66bf58c6-9f8a-4082-ba5f-e391e976a40d	PUBLISHED	2023-11-27 21:19:51.88	19	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/831.jpg	IMAGE	\N	\N	\N
47722363-d78d-4bb4-b091-3e5c28d7b2e3	PUBLISHED	2023-11-27 21:19:51.882	19	https://loremflickr.com/1920/1080/business	IMAGE	\N	\N	\N
9718c655-5192-486e-8591-faf5ec6d6aee	PUBLISHED	2023-11-27 21:19:51.895	20	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1237.jpg	IMAGE	\N	\N	\N
f347e766-d7ce-4193-a1ff-ee4cac740bc1	PUBLISHED	2023-11-27 21:19:51.897	20	https://loremflickr.com/1920/1080/people	IMAGE	\N	\N	\N
7ea0d0df-2795-4dde-adfd-8899d511cf48	PUBLISHED	2023-11-27 21:19:51.914	21	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/459.jpg	IMAGE	\N	\N	\N
a1a37b62-89a1-4918-997c-cc2c810a3be4	PUBLISHED	2023-11-27 21:19:51.92	21	https://loremflickr.com/1920/1080/sports	IMAGE	\N	\N	\N
b2684346-cc2e-4e4d-a188-96c3b1349d8d	PUBLISHED	2023-11-27 21:19:51.933	22	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1214.jpg	IMAGE	\N	\N	\N
a0ed1b3d-077b-4563-b9de-4602e9b76915	PUBLISHED	2023-11-27 21:19:51.935	22	https://loremflickr.com/1920/1080/sports	IMAGE	\N	\N	\N
f8c2921f-8b67-4da1-a70f-12e98366fdee	PUBLISHED	2023-11-27 21:19:51.947	23	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/146.jpg	IMAGE	\N	\N	\N
3a10d8fc-c9f0-409c-b314-cb2b4e53573d	PUBLISHED	2023-11-27 21:19:51.949	23	https://loremflickr.com/1920/1080/transport	IMAGE	\N	\N	\N
3276b4fc-ff1f-49f3-8f61-e6eaa3b5e4d0	PUBLISHED	2023-11-27 21:19:51.965	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1180.jpg	IMAGE	\N	\N	\N
aadad952-e9ca-469d-966b-4f5f5e31e0f5	PUBLISHED	2023-11-27 21:19:51.967	1	https://loremflickr.com/1920/1080/food	IMAGE	\N	\N	\N
5c5203e2-024d-475a-8787-d36547daa6f3	PUBLISHED	2023-11-27 21:19:51.982	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/28.jpg	IMAGE	\N	\N	\N
1eed358c-f500-474d-802f-99e5066efccc	PUBLISHED	2023-11-27 21:19:51.984	1	https://loremflickr.com/1920/1080/transport	IMAGE	\N	\N	\N
1274a834-a812-449b-ab91-2771307c8e44	PUBLISHED	2023-11-27 21:19:51.997	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/420.jpg	IMAGE	\N	\N	\N
84f001f3-9219-49df-982b-145cd47952c7	PUBLISHED	2023-11-27 21:19:51.999	1	https://loremflickr.com/1920/1080/sports	IMAGE	\N	\N	\N
8d6f637d-88ed-45ee-8d41-1fe906bf837c	PUBLISHED	2023-11-27 21:19:52.011	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/600.jpg	IMAGE	\N	\N	\N
ced85294-34d4-48c9-a473-c554da2931f8	PUBLISHED	2023-11-27 21:19:52.013	1	https://loremflickr.com/1920/1080/nightlife	IMAGE	\N	\N	\N
5cb79a19-14cf-4feb-a0af-821a8f45c12e	PUBLISHED	2023-11-27 21:19:52.024	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1228.jpg	IMAGE	\N	\N	\N
5ee3c904-3b93-4f29-9461-50c5a6b0a04d	PUBLISHED	2023-11-27 21:19:52.026	1	https://loremflickr.com/1920/1080/nature	IMAGE	\N	\N	\N
31e2399a-c741-4b92-81aa-6a1aa89bfe36	PUBLISHED	2023-11-27 21:19:52.039	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/70.jpg	IMAGE	\N	\N	\N
88efcec1-fd59-4aa8-a751-30fd047dea11	PUBLISHED	2023-11-27 21:19:52.041	1	https://loremflickr.com/1920/1080/food	IMAGE	\N	\N	\N
1d2e6b38-6f1f-44fa-94d3-e82082208b9d	PUBLISHED	2023-11-27 21:19:52.052	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/906.jpg	IMAGE	\N	\N	\N
3293354f-0553-41d0-9be3-f5482fbe08af	PUBLISHED	2023-11-27 21:19:52.054	1	https://loremflickr.com/1920/1080/fashion	IMAGE	\N	\N	\N
e5380b54-267d-417b-b96a-cfbbc99fce3b	PUBLISHED	2023-11-27 21:19:52.07	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/276.jpg	IMAGE	\N	\N	\N
d59c345e-7efa-4a43-b891-adbb5e2c006c	PUBLISHED	2023-11-27 21:19:52.072	1	https://loremflickr.com/1920/1080/city	IMAGE	\N	\N	\N
57595909-d152-4645-a28a-129563c4a5eb	PUBLISHED	2023-11-27 21:19:52.083	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/899.jpg	IMAGE	\N	\N	\N
9312468a-1bb0-4259-b8a0-621f7761be02	PUBLISHED	2023-11-27 21:19:52.085	1	https://loremflickr.com/1920/1080/fashion	IMAGE	\N	\N	\N
f6ee385b-3121-4bd8-92e7-2529a09c8787	PUBLISHED	2023-11-27 21:19:52.097	1	https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/243.jpg	IMAGE	\N	\N	\N
05f395fe-e3db-495a-8661-d95f797a3f66	PUBLISHED	2023-11-27 21:19:52.099	1	https://loremflickr.com/1920/1080/sports	IMAGE	\N	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."User" (id, status, "tronsBalance", "coinsBalance", "createdAt", email, password, username, name, bio, "avatarId", "bannerId", "twoFaSecret", "referredById", robohash, tag, "pinnedPostId", types) FROM stdin;
4	ACTIVE	0	0	2023-11-27 21:15:25.003	parikshith8040@gmail.com	$2b$10$9BonSswdP4/T0YZvbiqHhekYSR66NuFy65nPnlW6XGqNVDNdxGdeS	wikipedia	Wikipedia	Unofficial Wikipedia account	\N	\N	\N	\N	c1999a9c-4730-4ab6-889a-26c132c684ae	BOT	\N	{}
2	ACTIVE	0	0	2023-11-27 21:15:24.903	jsnyder@factiii.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	jon	Jonathan Snyder	Active duty Air Force. Full time parent. Part time programmer and science fanatic.	75f4923f-29cf-40f8-80bb-e666f8ec00b5	60b0c524-58bf-4b1f-8ce2-5ea41c7e04b0	\N	\N	deb1166a-23a4-4355-9a3e-c626b4b62384	NEW	\N	{}
3	ACTIVE	0	0	2023-11-27 21:15:24.916	parik36@icloud.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	parik	Parik	Factiii's #1 developer.	b633a965-eaa2-4305-9cfc-a5021bb9bc52	42b4a5cc-45be-4d39-a19a-6af2477396c3	\N	\N	2f3b5c5e-9e28-4e0e-9cde-6dca7ab9010c	NEW	\N	{}
1	ACTIVE	0	0	2023-11-27 21:15:24.859	nasnyder10@gmail.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	nataliia	Nataliia Snyder	Factiii's #1 user.	1528fdc2-daf0-4686-bd86-8bd172cae3df	25187e4a-0069-4bd7-9f68-29fcdac52ea0	\N	\N	8142b884-abfc-4edd-a334-03ab308dd852	NEW	\N	{}
5	ACTIVE	0	0	2023-11-27 21:15:25.237	openaiBot@factiii.com	AHDJHSJCGHJSFCGSHJFCGH*&#$*&_#HSGFH	openai	OpenAI	Get answers to every single question you have, powered by GPT-3. This space is not managed or endorsed by OpenAI.	ed135d8c-ba0e-44d6-beb3-6610c12cdb89	182a71fa-b200-46ba-9143-8a960cc0636e	\N	\N	50ca8294-c8c9-4d5f-955f-20338ec90f6d	BOT	\N	{}
7	ACTIVE	0	0	2023-11-27 21:15:25.278	banned@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	banned	I am banned from everywhere	I am a test user! I have 1 post in every space and I am banned from every space	\N	\N	\N	\N	87627430-cf2f-49f4-9acc-44293203c1ed	NEW	\N	{}
8	ACTIVE	0	0	2023-11-27 21:15:25.282	muted@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	muted	I am muted by everyone	I am a test user! I have 1 post in every space and I am muted by every one	\N	\N	\N	\N	ece32d61-417b-43cd-b658-8ca09c242a8a	NEW	\N	{}
9	ACTIVE	0	0	2023-11-27 21:15:25.287	blocked@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	blocked	I am blocked by everyone	I am a test user! I have 1 post in every space and I am blocked by every one	\N	\N	\N	\N	e1cac7da-590f-4621-9223-6601aa8f0700	NEW	\N	{}
10	ACTIVE	0	0	2023-11-27 21:15:25.292	blockAll@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	blockAll	I blocked everyone	I am a test user! I have 1 post in every space and I blocked every one	\N	\N	\N	\N	e123f0b5-7abb-4b31-bfaf-ab8a6c558be2	NEW	\N	{}
11	ACTIVE	0	0	2023-11-27 21:15:25.357	private@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	private	Private User	I am a test Private user!	\N	\N	\N	\N	375d89e7-3560-4d57-94c9-da77858c9224	NEW	\N	{}
12	ACTIVE	0	0	2023-11-27 21:15:25.363	privateUserFollowsJonParik@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	privateUserFollowsJonParik	Private User follows Jon and Parik	I am a test Private user that follows Jon and Parik!	\N	\N	\N	\N	f01076dd-cc5e-4b0f-8869-0d38442791df	NEW	\N	{PRIVATE}
13	ACTIVE	0	0	2023-11-27 21:15:25.376	privateUserFollowedByJonParik@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	privateUserFollowedByJonParik	Private User followed by Jon and Parik	I am a test Private user that is followed by Jon and Parik!	\N	\N	\N	\N	bc17d209-f005-4429-84ea-500e328e192e	NEW	\N	{PRIVATE}
6	ACTIVE	0	0	2023-11-27 21:15:25.273	janice123@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	janice78	Janice Bogan PhD	I am a test user!	f692e9d9-86d5-4fa9-b6b7-9aa74151a60b	644f4f1a-76d8-4b70-85e7-492f472ae8c3	\N	\N	24665484-73e3-43c1-a189-98e6eb50d441	NEW	\N	{}
14	ACTIVE	0	0	2023-11-27 21:19:51.769	Lukas_Howell80@hotmail.com	qE4PY0eIZTz7GRy	Earnestine_Skiles	Miss Adam Nikolaus	Minus modi fugit quaerat. Quae illo expedita totam. Fugit praesentium ab quidem asperiores.	9dec8743-de1b-4b4d-ad25-59245833c2e1	27eaef2a-be32-4c69-a9e9-d991d9459011	\N	\N	4dbc4ff0-cc3b-452f-aa34-c2a4f6691805	NEW	\N	{}
15	ACTIVE	0	0	2023-11-27 21:19:51.814	Gayle.Jakubowski@gmail.com	4KXRGD8Cw81YeeZ	Abigail33	Daryl Dietrich	Explicabo officia molestias eaque nesciunt dignissimos. Deleniti id perspiciatis ab placeat expedita magnam. Atque eligendi voluptatibus excepturi placeat itaque delectus. Quisquam libero consectetur autem. Deserunt ab voluptatibus ducimus placeat ex. Aspernatur recusandae magnam soluta placeat animi ratione eos.	c7604f20-0c18-46d7-92fc-8cc8e8cc02a7	6a0fb07a-46d6-4aa7-80a1-6fcb415515a8	\N	\N	dee281db-73ee-435e-889b-a07b50d5fb1c	NEW	\N	{}
16	ACTIVE	0	0	2023-11-27 21:19:51.829	Maud_Hackett@yahoo.com	SbMzbVO77Uq8pS0	Gabe.Frami	Wayne Franecki	Enim aliquid sint id velit esse odio. Architecto suscipit distinctio. Commodi aperiam amet recusandae in quae. Voluptate quam iure totam illum similique.	d8f9a143-ef1c-424e-9792-c9016c518248	ad776212-1683-48db-8f7c-2dc90c507338	\N	\N	415a7788-7670-4193-8d27-eb809313cd46	NEW	\N	{}
17	ACTIVE	0	0	2023-11-27 21:19:51.844	Tevin33@hotmail.com	gHsvNDDMgrLohFx	Alessandra98	Chad Gibson	Tempore maiores explicabo eos fuga. Dolorum tempora illo corporis occaecati enim sunt quidem. Consectetur esse deleniti eaque consequatur voluptatem corporis. Cum assumenda alias omnis reiciendis consectetur similique. Sequi aperiam repudiandae optio. Quaerat nam amet facilis dolor.	eb8a038d-30a0-47f6-bb86-61af2e3a7841	29728cd6-59fe-4c13-9696-6d268a705d77	\N	\N	663ec9fb-5883-4f82-9f90-7cf203e3bd50	NEW	\N	{}
18	ACTIVE	0	0	2023-11-27 21:19:51.859	Evie_Kozey@gmail.com	qh24aWuX_vpWxxe	Marisol_Auer86	Darrin Torphy	Fuga dicta veritatis ullam. Quasi ab doloremque ipsum veniam eum excepturi. Itaque veniam ex occaecati reiciendis consequuntur ea sapiente aliquid.	cacf35c1-8c94-4899-9544-f81fd2858517	c8dcead6-7595-455f-9710-1a5261195a75	\N	\N	1e17622e-b1f9-47f8-8573-8bfa1a0a9502	NEW	\N	{}
19	ACTIVE	0	0	2023-11-27 21:19:51.874	Damian.Schaden@hotmail.com	sx_7J7bKXucDm6B	Edmond89	Jonathan Denesik	Suscipit illum asperiores quod ipsum nesciunt dolor. Natus animi eveniet explicabo tempora saepe dolor porro. A ducimus consequuntur officia dolore magnam nihil inventore. Est debitis animi pariatur pariatur accusantium accusantium ad maiores praesentium. Minima sequi illum iste adipisci similique voluptatem enim explicabo. Impedit a rerum distinctio ullam eligendi.	66bf58c6-9f8a-4082-ba5f-e391e976a40d	47722363-d78d-4bb4-b091-3e5c28d7b2e3	\N	\N	ad3ea149-f4ea-4ef3-8169-a853ffb470e2	NEW	\N	{}
20	ACTIVE	0	0	2023-11-27 21:19:51.889	Joshua52@hotmail.com	yCOEbJGsEkrTs22	Dudley_Weber	Dr. Benny Rowe	Voluptatum facilis doloribus. Quibusdam perspiciatis ipsa tempore cumque impedit. Dolore vero quia hic. Porro labore doloremque amet tenetur ipsam. Totam consequuntur rem quibusdam tenetur cupiditate quod sed quisquam sequi. Perferendis deserunt eaque vel.	9718c655-5192-486e-8591-faf5ec6d6aee	f347e766-d7ce-4193-a1ff-ee4cac740bc1	\N	\N	4154f958-362b-4a6c-a6ad-1bbd77fb5c7d	NEW	\N	{}
21	ACTIVE	0	0	2023-11-27 21:19:51.908	Harrison_Deckow66@gmail.com	bQwXAH7bH8jmJY1	Jailyn.Kub44	Kate Lebsack	Aliquam beatae quasi rem. Facere incidunt eveniet. Hic debitis non sed in vel vel magnam.	7ea0d0df-2795-4dde-adfd-8899d511cf48	a1a37b62-89a1-4918-997c-cc2c810a3be4	\N	\N	f79f1d2e-95b9-4744-adb8-082a9a032443	NEW	\N	{}
22	ACTIVE	0	0	2023-11-27 21:19:51.927	Lowell.Cremin@hotmail.com	9MLCyCJfc5eFY8p	Xavier.Zulauf32	Gladys Quigley	Deserunt sit architecto eligendi vero. Quo eaque nisi ullam magnam nostrum voluptas molestiae ullam perspiciatis. Quisquam illo minima fuga autem aperiam similique. At libero in perferendis cum veniam culpa.	b2684346-cc2e-4e4d-a188-96c3b1349d8d	a0ed1b3d-077b-4563-b9de-4602e9b76915	\N	\N	16378523-dba3-40a2-b703-4328b373dba5	NEW	\N	{}
23	ACTIVE	0	0	2023-11-27 21:19:51.941	Virgie_Douglas14@yahoo.com	ypbXT_Q4VyRzr3P	Imogene42	Elsie Ondricka	Placeat aspernatur officia impedit placeat nam suscipit accusantium quia adipisci. Commodi quas fugit itaque incidunt amet doloremque laudantium. In nemo nobis ab sit eaque doloremque suscipit.	f8c2921f-8b67-4da1-a70f-12e98366fdee	3a10d8fc-c9f0-409c-b314-cb2b4e53573d	\N	\N	5abce79e-6924-4f1b-8107-74fd201bde85	NEW	\N	{}
\.


--
-- Data for Name: UserCoinReward; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."UserCoinReward" (id, "userId", "rewardId", "createdAt") FROM stdin;
\.


--
-- Data for Name: UserCost; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."UserCost" (id, "createdAt", "userId", usd, tokens, "modelId") FROM stdin;
\.


--
-- Data for Name: UserMute; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."UserMute" ("muterId", "mutedUserId", "createdAt") FROM stdin;
4	8	2023-11-27 21:15:25.68
2	8	2023-11-27 21:15:25.71
3	8	2023-11-27 21:15:25.723
1	8	2023-11-27 21:15:25.737
5	8	2023-11-27 21:15:25.75
7	8	2023-11-27 21:15:25.765
9	8	2023-11-27 21:15:25.789
10	8	2023-11-27 21:15:25.797
11	8	2023-11-27 21:15:25.803
12	8	2023-11-27 21:15:25.816
13	8	2023-11-27 21:15:25.829
6	8	2023-11-27 21:15:25.843
\.


--
-- Data for Name: UserPreference; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."UserPreference" ("userId", "awardsVisibilityPrivate", "allowProfanity", "betaAccess", "allowPoliticalContent", "hidePostsOnProfile", "hideProfileHistory") FROM stdin;
1	f	f	f	f	f	f
3	f	f	f	f	f	f
4	f	f	f	f	f	f
5	f	f	f	f	f	f
6	f	f	f	f	f	f
7	f	f	f	f	f	f
8	f	f	f	f	f	f
9	f	f	f	f	f	f
10	f	f	f	f	f	f
11	f	f	f	f	f	f
12	f	f	f	f	f	f
13	f	f	f	f	f	f
14	f	f	f	f	f	f
15	f	f	f	f	f	f
16	f	f	f	f	f	f
17	f	f	f	f	f	f
18	f	f	f	f	f	f
19	f	f	f	f	f	f
20	f	f	f	f	f	f
21	f	f	f	f	f	f
22	f	f	f	f	f	f
23	f	f	f	f	f	f
\.


--
-- Data for Name: Vote; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Vote" ("userId", type, "createdAt", "postId") FROM stdin;
14	UPVOTE	2023-11-27 21:19:55.215	933
14	UPVOTE	2023-11-27 21:19:55.22	528
14	UPVOTE	2023-11-27 21:19:55.222	636
14	UPVOTE	2023-11-27 21:19:55.223	1495
14	UPVOTE	2023-11-27 21:19:55.225	385
14	UPVOTE	2023-11-27 21:19:55.227	1425
14	UPVOTE	2023-11-27 21:19:55.229	1175
14	UPVOTE	2023-11-27 21:19:55.23	1391
14	UPVOTE	2023-11-27 21:19:55.231	517
14	DOWNVOTE	2023-11-27 21:19:55.233	421
14	UPVOTE	2023-11-27 21:19:55.234	926
15	DOWNVOTE	2023-11-27 21:19:55.236	504
15	UPVOTE	2023-11-27 21:19:55.237	492
15	UPVOTE	2023-11-27 21:19:55.239	1053
15	UPVOTE	2023-11-27 21:19:55.24	803
15	UPVOTE	2023-11-27 21:19:55.242	935
15	UPVOTE	2023-11-27 21:19:55.243	995
15	UPVOTE	2023-11-27 21:19:55.245	1403
15	DOWNVOTE	2023-11-27 21:19:55.246	1452
15	UPVOTE	2023-11-27 21:19:55.248	1513
15	DOWNVOTE	2023-11-27 21:19:55.249	1021
16	UPVOTE	2023-11-27 21:19:55.251	779
16	UPVOTE	2023-11-27 21:19:55.252	1232
16	UPVOTE	2023-11-27 21:19:55.254	875
16	UPVOTE	2023-11-27 21:19:55.256	947
16	UPVOTE	2023-11-27 21:19:55.258	338
16	UPVOTE	2023-11-27 21:19:55.26	1211
16	UPVOTE	2023-11-27 21:19:55.263	829
16	UPVOTE	2023-11-27 21:19:55.265	397
16	UPVOTE	2023-11-27 21:19:55.268	1190
17	UPVOTE	2023-11-27 21:19:55.269	611
17	UPVOTE	2023-11-27 21:19:55.271	1159
17	UPVOTE	2023-11-27 21:19:55.273	1040
17	DOWNVOTE	2023-11-27 21:19:55.275	481
17	UPVOTE	2023-11-27 21:19:55.276	373
17	UPVOTE	2023-11-27 21:19:55.278	1484
17	UPVOTE	2023-11-27 21:19:55.279	1449
17	UPVOTE	2023-11-27 21:19:55.281	708
17	UPVOTE	2023-11-27 21:19:55.283	1307
17	UPVOTE	2023-11-27 21:19:55.284	1440
17	UPVOTE	2023-11-27 21:19:55.286	1153
17	UPVOTE	2023-11-27 21:19:55.288	986
18	UPVOTE	2023-11-27 21:19:55.289	456
18	UPVOTE	2023-11-27 21:19:55.291	1241
18	UPVOTE	2023-11-27 21:19:55.292	647
18	UPVOTE	2023-11-27 21:19:55.294	1302
18	UPVOTE	2023-11-27 21:19:55.296	1029
18	UPVOTE	2023-11-27 21:19:55.298	600
18	DOWNVOTE	2023-11-27 21:19:55.3	636
18	UPVOTE	2023-11-27 21:19:55.302	1282
18	DOWNVOTE	2023-11-27 21:19:55.303	493
18	UPVOTE	2023-11-27 21:19:55.305	936
18	UPVOTE	2023-11-27 21:19:55.306	1320
18	UPVOTE	2023-11-27 21:19:55.308	877
18	UPVOTE	2023-11-27 21:19:55.309	350
19	UPVOTE	2023-11-27 21:19:55.311	539
19	UPVOTE	2023-11-27 21:19:55.313	349
19	DOWNVOTE	2023-11-27 21:19:55.314	895
19	UPVOTE	2023-11-27 21:19:55.316	1406
19	UPVOTE	2023-11-27 21:19:55.318	1526
19	UPVOTE	2023-11-27 21:19:55.319	1217
19	UPVOTE	2023-11-27 21:19:55.321	683
19	UPVOTE	2023-11-27 21:19:55.322	469
19	DOWNVOTE	2023-11-27 21:19:55.324	588
19	UPVOTE	2023-11-27 21:19:55.326	1125
19	DOWNVOTE	2023-11-27 21:19:55.327	517
19	UPVOTE	2023-11-27 21:19:55.329	636
19	UPVOTE	2023-11-27 21:19:55.33	1067
19	UPVOTE	2023-11-27 21:19:55.332	1020
19	UPVOTE	2023-11-27 21:19:55.333	1284
19	UPVOTE	2023-11-27 21:19:55.335	877
19	UPVOTE	2023-11-27 21:19:55.337	890
20	DOWNVOTE	2023-11-27 21:19:55.338	456
20	UPVOTE	2023-11-27 21:19:55.339	611
20	UPVOTE	2023-11-27 21:19:55.341	742
20	UPVOTE	2023-11-27 21:19:55.343	754
20	UPVOTE	2023-11-27 21:19:55.345	576
20	UPVOTE	2023-11-27 21:19:55.346	969
20	UPVOTE	2023-11-27 21:19:55.348	1471
20	DOWNVOTE	2023-11-27 21:19:55.35	600
20	UPVOTE	2023-11-27 21:19:55.352	1521
20	UPVOTE	2023-11-27 21:19:55.353	1498
20	UPVOTE	2023-11-27 21:19:55.355	1475
20	UPVOTE	2023-11-27 21:19:55.357	1488
20	UPVOTE	2023-11-27 21:19:55.359	1213
20	UPVOTE	2023-11-27 21:19:55.36	1021
21	UPVOTE	2023-11-27 21:19:55.362	984
21	UPVOTE	2023-11-27 21:19:55.364	793
21	DOWNVOTE	2023-11-27 21:19:55.365	1178
22	UPVOTE	2023-11-27 21:19:55.367	1082
23	UPVOTE	2023-11-27 21:19:55.368	492
23	UPVOTE	2023-11-27 21:19:55.37	397
23	UPVOTE	2023-11-27 21:19:55.372	899
23	UPVOTE	2023-11-27 21:19:55.373	1473
23	UPVOTE	2023-11-27 21:19:55.375	684
23	UPVOTE	2023-11-27 21:19:55.376	613
23	UPVOTE	2023-11-27 21:19:55.378	1236
23	UPVOTE	2023-11-27 21:19:55.379	889
23	UPVOTE	2023-11-27 21:19:55.381	1274
\.


--
-- Data for Name: _BanReasonToPost; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."_BanReasonToPost" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _ExpoPushTokenToUser; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."_ExpoPushTokenToUser" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _ReferencesPostFactiii; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."_ReferencesPostFactiii" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _blockedUsers; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."_blockedUsers" ("A", "B") FROM stdin;
9	4
4	10
9	2
2	10
9	3
3	10
9	1
1	10
9	5
5	10
9	7
7	10
9	8
8	10
9	10
9	11
11	10
9	12
12	10
9	13
13	10
9	6
6	10
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
e2189656-ba86-473a-97f5-ffc97b84afb5	7855d2af09d8fb09a5611b4de117be1d2191c6dbbc00b7007e9c823505bf20da	2023-11-27 21:15:21.663161+00	20230902135036_performance_updates	\N	\N	2023-11-27 21:15:21.233254+00	1
d034720d-d53b-434d-865f-e474a5236eed	a50533daed0e78f00bce5b094916a26b7a0ba975fb2d6878aba6b89e4b91c494	2023-11-27 21:15:20.067206+00	20230408144647_v1	\N	\N	2023-11-27 21:15:18.147982+00	1
6b6d9d9c-6b98-45b8-8b5b-12683eb0187c	7c2f69be1310a9a4665142a1fe39aea2b22380b5825069b7cd4f86dbd40828d3	2023-11-27 21:15:20.5507+00	20230509170749_new_pref	\N	\N	2023-11-27 21:15:20.545773+00	1
138c6185-c059-4ef1-be6c-056e5aa2f947	31737f0a3eaec583cb1a9dad7cc9751b29a3082d3d943e838f572de9b77bf291	2023-11-27 21:15:20.079131+00	20230416051547_iap	\N	\N	2023-11-27 21:15:20.069419+00	1
7167a157-c4db-4c7b-8b2e-ec5c55c251f6	1a9cb73b45094b49cda5c4dfa838c28c4ed405eb9c146f35ee8d97b16e33af3e	2023-11-27 21:15:20.089496+00	20230422071836_preferences	\N	\N	2023-11-27 21:15:20.081872+00	1
218ed8b5-41c9-4c12-81c6-cc88bf78ce0a	95f8e2d170777be69d1a9c443b8dcab710e4d133e3189bbc12aa64f3ee26f14e	2023-11-27 21:15:20.139694+00	20230423073959_deletion_cascading	\N	\N	2023-11-27 21:15:20.091235+00	1
9de558cd-d2ea-4db8-987d-a24e9eee6428	cbbbe8143a72818f8cd4d6d86b83ffa9f6b1302ca830aaa092ea94e14cac0a64	2023-11-27 21:15:20.564473+00	20230511055315_openai_site_settings	\N	\N	2023-11-27 21:15:20.553711+00	1
16ebb166-7f2a-40b4-8b78-a6125eb45aaa	f95b4b1cf1b32d7822f68849eb8944677999ea028d93ed4e6f8dae738b4dc6f0	2023-11-27 21:15:20.146058+00	20230423170539_robohash	\N	\N	2023-11-27 21:15:20.141375+00	1
8cd1e483-087a-4fcf-ba53-a7404e5b7551	3263ad84e3c157fccba3a994fbd2135a638fe830126bc2a045f937016062dc39	2023-11-27 21:15:20.155389+00	20230424030216_moderation_action	\N	\N	2023-11-27 21:15:20.147528+00	1
4bcac85b-9def-48ad-8fca-820fa19cc3f9	f02aedc0499fff864a138ceef33ea1400ebededd919c8593800bfd6f16524feb	2023-11-27 21:15:20.186931+00	20230424052835_otp_login	\N	\N	2023-11-27 21:15:20.1569+00	1
a0ea7ad8-91be-4fb3-a55d-7fab5e8b0b2e	affe1d44fdb0d1c9e6a6e416c8d2ba33c7333e58c3b9453b3e4c41f530c8c17f	2023-11-27 21:15:20.634164+00	20230513024650_feedbacks	\N	\N	2023-11-27 21:15:20.566285+00	1
34fc4ab5-b3cc-46aa-b64f-fbcefc1d5490	59f2fa067d40627017ca36c8a01d147bde84c6fd9164bb00c73f394105ae2c12	2023-11-27 21:15:20.196163+00	20230424171408_otp_update	\N	\N	2023-11-27 21:15:20.188819+00	1
69fde5f8-83df-4047-be3d-294fe0c281d0	6e69101fc3a4fc1eee8d34cbe4ef7e2fbc33f9d8afeb9d0c274cbb02265a6f1b	2023-11-27 21:15:20.205045+00	20230430070337_site_settings	\N	\N	2023-11-27 21:15:20.198195+00	1
359c4bb4-f35b-4d08-8224-8cf1d45448c3	a693b32c3ac473ed1c9fc9e87c3fd445e6fdf39213d0c8eb3db050f40d75b344	2023-11-27 21:15:21.69979+00	20230909195814_public_to_private	\N	\N	2023-11-27 21:15:21.665401+00	1
d5710300-6cbe-4fe4-b12f-562b6b133fb5	d54ed16d2a3457b4b2bc0900be2e3cef93df97eca3f56616831b220f52359768	2023-11-27 21:15:20.212136+00	20230501053207_spaces_robohash	\N	\N	2023-11-27 21:15:20.206859+00	1
1d189b62-04b4-461f-826c-628b8669ea17	e991e20fbbfdfa7575fb0d4002b7d087d074a3ef47e0b272b49c9caf133232c7	2023-11-27 21:15:21.121436+00	20230626170429_factiiis_and_iap	\N	\N	2023-11-27 21:15:20.637765+00	1
5b62471b-eda0-4dc8-85e5-5edc8eabd7cf	8f8399032d8b016db8f182c51b28a1098c199429fba0acf5cec7c207db4edce0	2023-11-27 21:15:20.271638+00	20230501084421_rewards	\N	\N	2023-11-27 21:15:20.213953+00	1
e9198264-ffdd-4ccf-95ae-2d2efb81c328	25f7894c3a6ba18f2f8cca89453a30e54773df71498f4a0141d9f94ccbb24601	2023-11-27 21:15:20.41166+00	20230504163541_spaces	\N	\N	2023-11-27 21:15:20.273761+00	1
97b068f3-eeec-444d-a921-e1e20f29927c	4b9ce076776b258b27451ecccc54ff36bed94f7ec71a07004816c84ecd2b784d	2023-11-27 21:15:20.479194+00	20230504164445_drop_communities	\N	\N	2023-11-27 21:15:20.414554+00	1
8194e992-fbed-4ebb-b1d6-39604f070f4d	ce0f1aed2789484c3b3a3ff46fb7d22fbb3f7f503e029a143c65f36a1931a945	2023-11-27 21:15:21.182538+00	20230712232614_factiii_update_and_subscription	\N	\N	2023-11-27 21:15:21.123873+00	1
3403e29a-e2f9-467a-8e86-55b34d29f5b9	45773aa4469a72217e5d33c355533755bd1b8ffcc8074447039d087f55eece0b	2023-11-27 21:15:20.539792+00	20230505153704_history	\N	\N	2023-11-27 21:15:20.480925+00	1
d773c3d2-9998-41f2-b06a-4a621820b85c	ce61b7b17d6ba731f1cb9760e97e07b2a00318d5b645b0024659337c9d6f99bd	2023-11-27 21:15:21.204058+00	20230719150222_votes_issue	\N	\N	2023-11-27 21:15:21.184436+00	1
b690d47f-5be8-4181-88f0-024cce3d3993	82fcbdcc6abf417061964388b2759a37dde456e40b560784ba585ba3fa702324	2023-11-27 21:15:21.707771+00	20231026213645_new_factiiis_and_ban_update_and_waitlist	\N	\N	2023-11-27 21:15:21.701895+00	1
93f92380-5ed2-4620-9b3d-1f181d5ab11b	4dc5d5017a80d01a6c928dabaf05e99fa937f867feb1c8ac75279d95bd8ff5f0	2023-11-27 21:15:21.216151+00	20230726224249_factiii_rule_update	\N	\N	2023-11-27 21:15:21.20683+00	1
4a1e0d90-ea1e-410c-91bf-de257bce806b	d7eb42a68f930538e91d2d51de1846833b5c73ba84119bacdd4735d44a69af1d	2023-11-27 21:15:21.231123+00	20230730113935_document_uploads	\N	\N	2023-11-27 21:15:21.218948+00	1
9c839d48-9e3a-438e-a8ba-38ef479b9da6	32952ea61b2e0eefe88d078acd47a8d240cd39c193f14bfb0c84767faff5348f	2023-11-27 21:15:21.778616+00	20231126143503_expo_tokens_update	\N	\N	2023-11-27 21:15:21.709586+00	1
\.


--
-- Name: BanReason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."BanReason_id_seq"', 1, false);


--
-- Name: Ban_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Ban_id_seq"', 15, true);


--
-- Name: Error_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Error_id_seq"', 1, false);


--
-- Name: ExpoPushToken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."ExpoPushToken_id_seq"', 1, false);


--
-- Name: Factiii_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Factiii_id_seq"', 40, true);


--
-- Name: Item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Item_id_seq"', 1, false);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Message_id_seq"', 1, false);


--
-- Name: Model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Model_id_seq"', 12, true);


--
-- Name: Notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Notification_id_seq"', 1, false);


--
-- Name: OTPBasedLogin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."OTPBasedLogin_id_seq"', 1, false);


--
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Order_id_seq"', 1, false);


--
-- Name: PostAward_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."PostAward_id_seq"', 15, true);


--
-- Name: PostEditHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."PostEditHistory_id_seq"', 1, false);


--
-- Name: PostFactiii_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."PostFactiii_id_seq"', 16, true);


--
-- Name: PostOpenAILanguageSetting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."PostOpenAILanguageSetting_id_seq"', 1, false);


--
-- Name: PostUpload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."PostUpload_id_seq"', 11, true);


--
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Post_id_seq"', 1537, true);


--
-- Name: ReadMessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."ReadMessage_id_seq"', 1, false);


--
-- Name: Rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Rule_id_seq"', 59, true);


--
-- Name: Session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Session_id_seq"', 1, false);


--
-- Name: SiteSettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."SiteSettings_id_seq"', 1, true);


--
-- Name: SpaceRuleEditHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."SpaceRuleEditHistory_id_seq"', 1, false);


--
-- Name: SpaceTime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."SpaceTime_id_seq"', 1, false);


--
-- Name: Space_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Space_id_seq"', 25, true);


--
-- Name: UserCost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."UserCost_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."User_id_seq"', 23, true);


--
-- Name: BanReason BanReason_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BanReason"
    ADD CONSTRAINT "BanReason_pkey" PRIMARY KEY (id);


--
-- Name: Ban Ban_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ban"
    ADD CONSTRAINT "Ban_pkey" PRIMARY KEY (id);


--
-- Name: BotSetting BotSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BotSetting"
    ADD CONSTRAINT "BotSetting_pkey" PRIMARY KEY ("userId");


--
-- Name: CoinRewardItem CoinRewardItem_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."CoinRewardItem"
    ADD CONSTRAINT "CoinRewardItem_pkey" PRIMARY KEY (id);


--
-- Name: Coin Coin_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Coin"
    ADD CONSTRAINT "Coin_pkey" PRIMARY KEY ("productId");


--
-- Name: ConversationParticipants ConversationParticipants_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ConversationParticipants"
    ADD CONSTRAINT "ConversationParticipants_pkey" PRIMARY KEY ("userId", "conversationId");


--
-- Name: Conversation Conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Conversation"
    ADD CONSTRAINT "Conversation_pkey" PRIMARY KEY (id);


--
-- Name: Error Error_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Error"
    ADD CONSTRAINT "Error_pkey" PRIMARY KEY (id);


--
-- Name: ExpoPushToken ExpoPushToken_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ExpoPushToken"
    ADD CONSTRAINT "ExpoPushToken_pkey" PRIMARY KEY (id);


--
-- Name: FactiiiPreferences FactiiiPreferences_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."FactiiiPreferences"
    ADD CONSTRAINT "FactiiiPreferences_pkey" PRIMARY KEY ("factiiiId", "userId");


--
-- Name: Factiii Factiii_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii"
    ADD CONSTRAINT "Factiii_pkey" PRIMARY KEY (id);


--
-- Name: Feedback Feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "Feedback_pkey" PRIMARY KEY (id);


--
-- Name: Follows Follows_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_pkey" PRIMARY KEY ("followerId", "followingId");


--
-- Name: History History_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_pkey" PRIMARY KEY (id);


--
-- Name: Item Item_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Item"
    ADD CONSTRAINT "Item_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: Model Model_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Model"
    ADD CONSTRAINT "Model_pkey" PRIMARY KEY (id);


--
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- Name: OTPBasedLogin OTPBasedLogin_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."OTPBasedLogin"
    ADD CONSTRAINT "OTPBasedLogin_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: PasswordReset PasswordReset_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PasswordReset"
    ADD CONSTRAINT "PasswordReset_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: PostAward PostAward_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostAward"
    ADD CONSTRAINT "PostAward_pkey" PRIMARY KEY (id);


--
-- Name: PostEditHistory PostEditHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostEditHistory"
    ADD CONSTRAINT "PostEditHistory_pkey" PRIMARY KEY (id);


--
-- Name: PostFactiii PostFactiii_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostFactiii"
    ADD CONSTRAINT "PostFactiii_pkey" PRIMARY KEY (id);


--
-- Name: PostOpenAILanguageSetting PostOpenAILanguageSetting_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostOpenAILanguageSetting"
    ADD CONSTRAINT "PostOpenAILanguageSetting_pkey" PRIMARY KEY (id);


--
-- Name: PostUpload PostUpload_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostUpload"
    ADD CONSTRAINT "PostUpload_pkey" PRIMARY KEY (id);


--
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: ReadMessage ReadMessage_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ReadMessage"
    ADD CONSTRAINT "ReadMessage_pkey" PRIMARY KEY (id);


--
-- Name: Report Report_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_pkey" PRIMARY KEY (id);


--
-- Name: Rule Rule_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Rule"
    ADD CONSTRAINT "Rule_pkey" PRIMARY KEY (id);


--
-- Name: SavedPost SavedPost_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SavedPost"
    ADD CONSTRAINT "SavedPost_pkey" PRIMARY KEY ("userId", "postId");


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: SiteSettings SiteSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SiteSettings"
    ADD CONSTRAINT "SiteSettings_pkey" PRIMARY KEY (id);


--
-- Name: SpaceFilter SpaceFilter_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceFilter"
    ADD CONSTRAINT "SpaceFilter_pkey" PRIMARY KEY ("spaceId", "userId");


--
-- Name: SpaceInvite SpaceInvite_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceInvite"
    ADD CONSTRAINT "SpaceInvite_pkey" PRIMARY KEY ("spaceId", "userId");


--
-- Name: SpaceMember SpaceMember_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceMember"
    ADD CONSTRAINT "SpaceMember_pkey" PRIMARY KEY ("userId", "spaceId");


--
-- Name: SpaceRuleEditHistory SpaceRuleEditHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceRuleEditHistory"
    ADD CONSTRAINT "SpaceRuleEditHistory_pkey" PRIMARY KEY (id);


--
-- Name: SpaceTime SpaceTime_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceTime"
    ADD CONSTRAINT "SpaceTime_pkey" PRIMARY KEY (id);


--
-- Name: Space Space_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Space"
    ADD CONSTRAINT "Space_pkey" PRIMARY KEY (id);


--
-- Name: Subscription Subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_pkey" PRIMARY KEY (id);


--
-- Name: Upload Upload_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Upload"
    ADD CONSTRAINT "Upload_pkey" PRIMARY KEY (id);


--
-- Name: UserCoinReward UserCoinReward_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCoinReward"
    ADD CONSTRAINT "UserCoinReward_pkey" PRIMARY KEY (id);


--
-- Name: UserCost UserCost_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCost"
    ADD CONSTRAINT "UserCost_pkey" PRIMARY KEY (id);


--
-- Name: UserMute UserMute_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserMute"
    ADD CONSTRAINT "UserMute_pkey" PRIMARY KEY ("muterId", "mutedUserId");


--
-- Name: UserPreference UserPreference_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserPreference"
    ADD CONSTRAINT "UserPreference_pkey" PRIMARY KEY ("userId");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Vote Vote_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_pkey" PRIMARY KEY ("postId", "userId");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Ban_conversationId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Ban_conversationId_key" ON public."Ban" USING btree ("conversationId");


--
-- Name: BotSetting_userId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "BotSetting_userId_key" ON public."BotSetting" USING btree ("userId");


--
-- Name: ExpoPushToken_token_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "ExpoPushToken_token_key" ON public."ExpoPushToken" USING btree (token);


--
-- Name: Factiii_spaceId_slug_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Factiii_spaceId_slug_idx" ON public."Factiii" USING btree ("spaceId", slug);


--
-- Name: Factiii_spaceId_slug_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Factiii_spaceId_slug_key" ON public."Factiii" USING btree ("spaceId", slug);


--
-- Name: Factiii_userId_slug_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Factiii_userId_slug_idx" ON public."Factiii" USING btree ("userId", slug);


--
-- Name: Factiii_userId_slug_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Factiii_userId_slug_key" ON public."Factiii" USING btree ("userId", slug);


--
-- Name: History_userId_column_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "History_userId_column_idx" ON public."History" USING btree ("userId", "column");


--
-- Name: PasswordReset_userId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PasswordReset_userId_idx" ON public."PasswordReset" USING btree ("userId");


--
-- Name: Payment_paymentIntent_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Payment_paymentIntent_key" ON public."Payment" USING btree ("paymentIntent");


--
-- Name: PostAward_postId_coinId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PostAward_postId_coinId_idx" ON public."PostAward" USING btree ("postId", "coinId");


--
-- Name: PostAward_postId_userId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PostAward_postId_userId_idx" ON public."PostAward" USING btree ("postId", "userId");


--
-- Name: PostAward_userId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PostAward_userId_idx" ON public."PostAward" USING btree ("userId");


--
-- Name: PostFactiii_factiiiId_userId_status_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PostFactiii_factiiiId_userId_status_idx" ON public."PostFactiii" USING btree ("factiiiId", "userId", status);


--
-- Name: PostFactiii_postId_factiiiId_userId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "PostFactiii_postId_factiiiId_userId_key" ON public."PostFactiii" USING btree ("postId", "factiiiId", "userId");


--
-- Name: PostUpload_postId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "PostUpload_postId_idx" ON public."PostUpload" USING btree ("postId");


--
-- Name: Post_createdAt_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_createdAt_idx" ON public."Post" USING btree ("createdAt");


--
-- Name: Post_parentPostId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_parentPostId_idx" ON public."Post" USING btree ("parentPostId");


--
-- Name: Post_spaceId_status_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_spaceId_status_idx" ON public."Post" USING btree ("spaceId", status);


--
-- Name: Post_trendingRank_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_trendingRank_idx" ON public."Post" USING btree ("trendingRank");


--
-- Name: Post_userId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_userId_idx" ON public."Post" USING btree ("userId");


--
-- Name: Post_uuid_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_uuid_idx" ON public."Post" USING btree (uuid);


--
-- Name: Post_uuid_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Post_uuid_key" ON public."Post" USING btree (uuid);


--
-- Name: Post_voteCount_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Post_voteCount_idx" ON public."Post" USING btree ("voteCount");


--
-- Name: Product_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Product_id_key" ON public."Product" USING btree (id);


--
-- Name: Report_conversationId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Report_conversationId_key" ON public."Report" USING btree ("conversationId");


--
-- Name: Report_reportedPostId_status_ruleId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Report_reportedPostId_status_ruleId_idx" ON public."Report" USING btree ("reportedPostId", status, "ruleId");


--
-- Name: Session_refreshToken_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Session_refreshToken_key" ON public."Session" USING btree ("refreshToken");


--
-- Name: Session_userId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Session_userId_idx" ON public."Session" USING btree ("userId");


--
-- Name: SpaceTime_postFactiiiId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "SpaceTime_postFactiiiId_idx" ON public."SpaceTime" USING btree ("postFactiiiId");


--
-- Name: Space_slug_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Space_slug_idx" ON public."Space" USING btree (slug);


--
-- Name: Space_slug_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Space_slug_key" ON public."Space" USING btree (slug);


--
-- Name: Subscription_id_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Subscription_id_key" ON public."Subscription" USING btree (id);


--
-- Name: Subscription_identifier_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "Subscription_identifier_key" ON public."Subscription" USING btree (identifier);


--
-- Name: UserMute_mutedUserId_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "UserMute_mutedUserId_idx" ON public."UserMute" USING btree ("mutedUserId");


--
-- Name: UserPreference_userId_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "UserPreference_userId_key" ON public."UserPreference" USING btree ("userId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_status_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "User_status_idx" ON public."User" USING btree (status);


--
-- Name: User_username_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "User_username_idx" ON public."User" USING btree (username);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: _BanReasonToPost_AB_unique; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "_BanReasonToPost_AB_unique" ON public."_BanReasonToPost" USING btree ("A", "B");


--
-- Name: _BanReasonToPost_B_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "_BanReasonToPost_B_index" ON public."_BanReasonToPost" USING btree ("B");


--
-- Name: _ExpoPushTokenToUser_AB_unique; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "_ExpoPushTokenToUser_AB_unique" ON public."_ExpoPushTokenToUser" USING btree ("A", "B");


--
-- Name: _ExpoPushTokenToUser_B_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "_ExpoPushTokenToUser_B_index" ON public."_ExpoPushTokenToUser" USING btree ("B");


--
-- Name: _ReferencesPostFactiii_AB_unique; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "_ReferencesPostFactiii_AB_unique" ON public."_ReferencesPostFactiii" USING btree ("A", "B");


--
-- Name: _ReferencesPostFactiii_B_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "_ReferencesPostFactiii_B_index" ON public."_ReferencesPostFactiii" USING btree ("B");


--
-- Name: _blockedUsers_AB_unique; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX "_blockedUsers_AB_unique" ON public."_blockedUsers" USING btree ("A", "B");


--
-- Name: _blockedUsers_B_index; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "_blockedUsers_B_index" ON public."_blockedUsers" USING btree ("B");


--
-- Name: idx_space_member_user_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_space_member_user_id ON public."SpaceMember" USING btree ("userId", "spaceId");


--
-- Name: idx_space_types; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_space_types ON public."Space" USING btree (types);


--
-- Name: BanReason BanReason_banId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BanReason"
    ADD CONSTRAINT "BanReason_banId_fkey" FOREIGN KEY ("banId") REFERENCES public."Ban"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BanReason BanReason_ruleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BanReason"
    ADD CONSTRAINT "BanReason_ruleId_fkey" FOREIGN KEY ("ruleId") REFERENCES public."Rule"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Ban Ban_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ban"
    ADD CONSTRAINT "Ban_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public."Conversation"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Ban Ban_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ban"
    ADD CONSTRAINT "Ban_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Ban Ban_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Ban"
    ADD CONSTRAINT "Ban_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: BotSetting BotSetting_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."BotSetting"
    ADD CONSTRAINT "BotSetting_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Coin Coin_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Coin"
    ADD CONSTRAINT "Coin_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ConversationParticipants ConversationParticipants_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ConversationParticipants"
    ADD CONSTRAINT "ConversationParticipants_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public."Conversation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ConversationParticipants ConversationParticipants_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ConversationParticipants"
    ADD CONSTRAINT "ConversationParticipants_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Conversation Conversation_lastMessageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Conversation"
    ADD CONSTRAINT "Conversation_lastMessageId_fkey" FOREIGN KEY ("lastMessageId") REFERENCES public."Message"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Error Error_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Error"
    ADD CONSTRAINT "Error_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FactiiiPreferences FactiiiPreferences_factiiiId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."FactiiiPreferences"
    ADD CONSTRAINT "FactiiiPreferences_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES public."Factiii"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FactiiiPreferences FactiiiPreferences_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."FactiiiPreferences"
    ADD CONSTRAINT "FactiiiPreferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FactiiiPreferences FactiiiPreferences_userPreferenceUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."FactiiiPreferences"
    ADD CONSTRAINT "FactiiiPreferences_userPreferenceUserId_fkey" FOREIGN KEY ("userPreferenceUserId") REFERENCES public."UserPreference"("userId") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Factiii Factiii_avatarId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii"
    ADD CONSTRAINT "Factiii_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Factiii Factiii_bannerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii"
    ADD CONSTRAINT "Factiii_bannerId_fkey" FOREIGN KEY ("bannerId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Factiii Factiii_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii"
    ADD CONSTRAINT "Factiii_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Factiii Factiii_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Factiii"
    ADD CONSTRAINT "Factiii_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Feedback Feedback_mediaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "Feedback_mediaId_fkey" FOREIGN KEY ("mediaId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Feedback Feedback_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Feedback"
    ADD CONSTRAINT "Feedback_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Follows Follows_followerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Follows Follows_followingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Follows"
    ADD CONSTRAINT "Follows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: History History_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: History History_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Item Item_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Item"
    ADD CONSTRAINT "Item_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Item Item_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Item"
    ADD CONSTRAINT "Item_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public."Conversation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_referencePostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_referencePostId_fkey" FOREIGN KEY ("referencePostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_referenceSpaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_referenceSpaceId_fkey" FOREIGN KEY ("referenceSpaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_referenceUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_referenceUserId_fkey" FOREIGN KEY ("referenceUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_targetUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_targetUserId_fkey" FOREIGN KEY ("targetUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OTPBasedLogin OTPBasedLogin_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."OTPBasedLogin"
    ADD CONSTRAINT "OTPBasedLogin_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order Order_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PasswordReset PasswordReset_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PasswordReset"
    ADD CONSTRAINT "PasswordReset_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Payment Payment_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Payment Payment_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public."Subscription"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Payment Payment_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostAward PostAward_coinId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostAward"
    ADD CONSTRAINT "PostAward_coinId_fkey" FOREIGN KEY ("coinId") REFERENCES public."Coin"("productId") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostAward PostAward_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostAward"
    ADD CONSTRAINT "PostAward_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostAward PostAward_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostAward"
    ADD CONSTRAINT "PostAward_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostEditHistory PostEditHistory_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostEditHistory"
    ADD CONSTRAINT "PostEditHistory_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostFactiii PostFactiii_factiiiId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostFactiii"
    ADD CONSTRAINT "PostFactiii_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES public."Factiii"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostFactiii PostFactiii_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostFactiii"
    ADD CONSTRAINT "PostFactiii_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostFactiii PostFactiii_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostFactiii"
    ADD CONSTRAINT "PostFactiii_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostOpenAILanguageSetting PostOpenAILanguageSetting_modelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostOpenAILanguageSetting"
    ADD CONSTRAINT "PostOpenAILanguageSetting_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostOpenAILanguageSetting PostOpenAILanguageSetting_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostOpenAILanguageSetting"
    ADD CONSTRAINT "PostOpenAILanguageSetting_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PostUpload PostUpload_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostUpload"
    ADD CONSTRAINT "PostUpload_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostUpload PostUpload_uploadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."PostUpload"
    ADD CONSTRAINT "PostUpload_uploadId_fkey" FOREIGN KEY ("uploadId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_parentPostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_parentPostId_fkey" FOREIGN KEY ("parentPostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_referencePostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_referencePostId_fkey" FOREIGN KEY ("referencePostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ReadMessage ReadMessage_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ReadMessage"
    ADD CONSTRAINT "ReadMessage_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public."Conversation"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ReadMessage ReadMessage_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ReadMessage"
    ADD CONSTRAINT "ReadMessage_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public."Message"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ReadMessage ReadMessage_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."ReadMessage"
    ADD CONSTRAINT "ReadMessage_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Report Report_actionTakenById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_actionTakenById_fkey" FOREIGN KEY ("actionTakenById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Report Report_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public."Conversation"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Report Report_reportedPostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_reportedPostId_fkey" FOREIGN KEY ("reportedPostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Report Report_reportedUploadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_reportedUploadId_fkey" FOREIGN KEY ("reportedUploadId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Report Report_ruleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_ruleId_fkey" FOREIGN KEY ("ruleId") REFERENCES public."Rule"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Report Report_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Rule Rule_factiiiId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Rule"
    ADD CONSTRAINT "Rule_factiiiId_fkey" FOREIGN KEY ("factiiiId") REFERENCES public."Factiii"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Rule Rule_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Rule"
    ADD CONSTRAINT "Rule_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SavedPost SavedPost_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SavedPost"
    ADD CONSTRAINT "SavedPost_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SavedPost SavedPost_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SavedPost"
    ADD CONSTRAINT "SavedPost_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Session Session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceFilter SpaceFilter_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceFilter"
    ADD CONSTRAINT "SpaceFilter_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceFilter SpaceFilter_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceFilter"
    ADD CONSTRAINT "SpaceFilter_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceInvite SpaceInvite_inviterId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceInvite"
    ADD CONSTRAINT "SpaceInvite_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceInvite SpaceInvite_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceInvite"
    ADD CONSTRAINT "SpaceInvite_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceInvite SpaceInvite_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceInvite"
    ADD CONSTRAINT "SpaceInvite_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceMember SpaceMember_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceMember"
    ADD CONSTRAINT "SpaceMember_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SpaceMember SpaceMember_spaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceMember"
    ADD CONSTRAINT "SpaceMember_spaceId_fkey" FOREIGN KEY ("spaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceMember SpaceMember_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceMember"
    ADD CONSTRAINT "SpaceMember_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public."Subscription"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: SpaceMember SpaceMember_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceMember"
    ADD CONSTRAINT "SpaceMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceRuleEditHistory SpaceRuleEditHistory_ruleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceRuleEditHistory"
    ADD CONSTRAINT "SpaceRuleEditHistory_ruleId_fkey" FOREIGN KEY ("ruleId") REFERENCES public."Rule"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SpaceTime SpaceTime_postFactiiiId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."SpaceTime"
    ADD CONSTRAINT "SpaceTime_postFactiiiId_fkey" FOREIGN KEY ("postFactiiiId") REFERENCES public."PostFactiii"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Space Space_avatarId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Space"
    ADD CONSTRAINT "Space_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Space Space_bannerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Space"
    ADD CONSTRAINT "Space_bannerId_fkey" FOREIGN KEY ("bannerId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Space Space_pinnedPostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Space"
    ADD CONSTRAINT "Space_pinnedPostId_fkey" FOREIGN KEY ("pinnedPostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Subscription Subscription_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Subscription Subscription_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Subscription"
    ADD CONSTRAINT "Subscription_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Upload Upload_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Upload"
    ADD CONSTRAINT "Upload_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Upload Upload_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Upload"
    ADD CONSTRAINT "Upload_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserCoinReward UserCoinReward_rewardId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCoinReward"
    ADD CONSTRAINT "UserCoinReward_rewardId_fkey" FOREIGN KEY ("rewardId") REFERENCES public."CoinRewardItem"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserCoinReward UserCoinReward_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCoinReward"
    ADD CONSTRAINT "UserCoinReward_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserCost UserCost_modelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCost"
    ADD CONSTRAINT "UserCost_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES public."Model"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserCost UserCost_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserCost"
    ADD CONSTRAINT "UserCost_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserMute UserMute_mutedUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserMute"
    ADD CONSTRAINT "UserMute_mutedUserId_fkey" FOREIGN KEY ("mutedUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserMute UserMute_muterId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserMute"
    ADD CONSTRAINT "UserMute_muterId_fkey" FOREIGN KEY ("muterId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserPreference UserPreference_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."UserPreference"
    ADD CONSTRAINT "UserPreference_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User User_avatarId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_avatarId_fkey" FOREIGN KEY ("avatarId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User User_bannerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_bannerId_fkey" FOREIGN KEY ("bannerId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User User_pinnedPostId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pinnedPostId_fkey" FOREIGN KEY ("pinnedPostId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: User User_referredById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_referredById_fkey" FOREIGN KEY ("referredById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Vote Vote_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Vote Vote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BanReasonToPost _BanReasonToPost_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_BanReasonToPost"
    ADD CONSTRAINT "_BanReasonToPost_A_fkey" FOREIGN KEY ("A") REFERENCES public."BanReason"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BanReasonToPost _BanReasonToPost_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_BanReasonToPost"
    ADD CONSTRAINT "_BanReasonToPost_B_fkey" FOREIGN KEY ("B") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ExpoPushTokenToUser _ExpoPushTokenToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_ExpoPushTokenToUser"
    ADD CONSTRAINT "_ExpoPushTokenToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public."ExpoPushToken"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ExpoPushTokenToUser _ExpoPushTokenToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_ExpoPushTokenToUser"
    ADD CONSTRAINT "_ExpoPushTokenToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ReferencesPostFactiii _ReferencesPostFactiii_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_ReferencesPostFactiii"
    ADD CONSTRAINT "_ReferencesPostFactiii_A_fkey" FOREIGN KEY ("A") REFERENCES public."PostFactiii"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ReferencesPostFactiii _ReferencesPostFactiii_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_ReferencesPostFactiii"
    ADD CONSTRAINT "_ReferencesPostFactiii_B_fkey" FOREIGN KEY ("B") REFERENCES public."PostFactiii"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _blockedUsers _blockedUsers_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_blockedUsers"
    ADD CONSTRAINT "_blockedUsers_A_fkey" FOREIGN KEY ("A") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _blockedUsers _blockedUsers_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."_blockedUsers"
    ADD CONSTRAINT "_blockedUsers_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: root
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

