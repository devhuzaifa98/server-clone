--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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
    'FACTIII',
    'USER',
    'SPACE'
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
    "lastMessageId" integer,
    read boolean DEFAULT false NOT NULL
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
    "conversationId" text NOT NULL,
    read boolean DEFAULT false NOT NULL
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
    "reportedPostId" integer,
    "reportedUserId" integer,
    "reportedSpaceId" integer
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
    types public."UserType"[] DEFAULT ARRAY[]::public."UserType"[],
    read boolean DEFAULT false NOT NULL
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
    "hideProfileHistory" boolean DEFAULT false NOT NULL,
    "allowNSFWContent" boolean DEFAULT false NOT NULL
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
1	2024-01-08 20:42:27.994	\N	f	7	2
2	2024-01-08 20:42:27.998	\N	f	7	3
3	2024-01-08 20:42:28	\N	f	7	4
4	2024-01-08 20:42:28.002	\N	f	7	1
5	2024-01-08 20:42:28.005	\N	f	7	5
6	2024-01-08 20:42:28.006	\N	f	7	6
7	2024-01-08 20:42:28.009	\N	f	7	7
8	2024-01-08 20:42:28.011	\N	f	7	8
9	2024-01-08 20:42:28.012	\N	f	7	9
10	2024-01-08 20:42:28.014	\N	f	7	10
11	2024-01-08 20:42:28.016	\N	f	7	11
12	2024-01-08 20:42:28.018	\N	f	7	12
13	2024-01-08 20:42:28.019	\N	f	7	13
14	2024-01-08 20:42:28.021	\N	f	7	14
15	2024-01-08 20:42:28.022	\N	f	7	15
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
c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	1	Bronze	10
price_1MGu3qDS6lFTllE6h6YgMmQl	7	Silver	200
price_1MartCDS6lFTllE6fFgyZvxI	31	Gold	1000
price_1MarsIDS6lFTllE6SnBpfVkO	183	Platinum	5000
price_1MLvQ8DS6lFTllE6BCNkQkSh	730	Diamond	25000
\.


--
-- Data for Name: CoinRewardItem; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."CoinRewardItem" (id, title, quantity, description, "expiresAt", "createdAt") FROM stdin;
PUBLISH_10TH_POST	Publish your 10th post	5	You will be rewarded 5 coins when you create your 10th post on Factiii. To claim this, you just have to create 10 posts (including replies). This is only rewarded once.	\N	2024-01-08 20:42:27.915
GET_100_UPVOTES	Get 100 upvotes on a post	100	You will be rewarded 100 coins when one of the post you created on Factiii recieves 100 upvotes. To claim this, once your post must have a total vote count of 100 (upvotes - downvotes). This is only rewarded once.	\N	2024-01-08 20:42:27.915
VERIFY_EMAIL_ADDRESS	Verify your email address	5	You will be rewarded 5 coins when you verify your email address. To claim this, you must verify your registered email via an OTP. This is only rewarded once.	\N	2024-01-08 20:42:27.915
VERIFY_PHONE_NUMBER	Verify your phone number	10	You will be rewarded 10 coins when you verify your phone number. To claim this, you must add your phone number to Factiii and verify it via an OTP. This is only rewarded once.	\N	2024-01-08 20:42:27.915
\.


--
-- Data for Name: Conversation; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Conversation" (id, "createdAt", "lastMessageId", read) FROM stdin;
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
1	2024-01-08 20:42:35.986	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
2	2024-01-08 20:42:35.996	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
3	2024-01-08 20:43:04.218	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
4	2024-01-08 20:43:04.23	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
5	2024-01-08 20:55:22.33	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
6	2024-01-08 20:55:22.34	::ffff:127.0.0.1	Invalid request: No authentication token provided	\N
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
2	1	a5d7ae38-f706-4ac6-82d2-4d31b65e18b3	\N	2024-01-08 20:42:27.784	\N	1	{NONE}	funny	Funny	APPROVED	{}	\N
2	1	e9cedbb7-5332-452f-bde7-88e573aa4fec	\N	2024-01-08 20:42:27.784	\N	2	{NONE}	informative	Informative	APPROVED	{}	\N
2	1	d67f9dc0-ea30-4b3e-ac1a-f9ed4d6e31bc	\N	2024-01-08 20:42:27.784	\N	3	{NONE}	troll	Troll	APPROVED	{}	\N
2	1	8e36cb06-41f4-4795-924f-25d177796bcd	\N	2024-01-08 20:42:27.784	\N	4	{NONE}	politics	Politics	APPROVED	{}	\N
2	1	378d4ed9-f63f-4cb3-933d-aa6a3142cb41	\N	2024-01-08 20:42:27.784	\N	5	{NONE}	misleading	Misleading	APPROVED	{}	\N
2	1	ffccd04c-4903-4918-8987-bd9c9bda0a86	\N	2024-01-08 20:42:27.784	\N	6	{NONE}	nsfw	NSFW	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	All posts tagged with this must contain at least 1 picture of items to be sold as well as have the location of the items for sale.	7	{MEDIA_REQUIRED}	for_sale	For Sale	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	All posts tagged with this must contain at least 1 picture of the item being summed. The factiii must contain a summation of the components of the calories found in the food in the picture.	8	{MEDIA_REQUIRED,DATA_REQUIRED}	count_calories	Count Calories	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	All posts tagged with this must contain at least 1 picture or video of a workout.	9	{MEDIA_REQUIRED}	work_out	Work Out	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	All posts tagged with this must contain proof of a run to include distance.	10	{MEDIA_REQUIRED,DATA_REQUIRED}	run	Run	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	\N	11	{LOCATION_REQUIRED,TIME_REQUIRED}	space_time	Space Time	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	\N	12	{LOCATION_REQUIRED}	location	Location	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	\N	13	{TIME_REQUIRED}	date_time	Date Time	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.784	\N	14	{DATA_REQUIRED}	data	Data	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.784	\N	15	{CONTENT_REQUIRED}	content	Content	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.784	\N	16	{WIKI}	wiki	Wiki	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.784	\N	17	{NO_POST_DUPLICATES}	no-duplicates	No Duplicates	APPROVED	{}	\N
2	1	\N	\N	2024-01-08 20:42:27.784	\N	18	{BUDGET}	budget	Budget	APPROVED	{}	\N
2	2	\N	\N	2024-01-08 20:42:27.795	This is where you can view all the history factiiis.	19	{DATA_REQUIRED}	history	History	APPROVED	{}	\N
6	1	\N	\N	2024-01-08 20:42:27.861	\N	20	{NONE}	science	Science	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.861	\N	21	{NONE}	ford	Ford	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	22	{NONE}	ford2	Ford 2	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	23	{NONE}	ford3	Ford 3	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	24	{NONE}	ford4	Ford 4	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	25	{NONE}	ford5	Ford 5	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	26	{NONE}	ford6	Ford 6	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	27	{NONE}	ford7	Ford 7	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	28	{NONE}	ford8	Ford 8	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	29	{NONE}	ford9	Ford 9	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	30	{NONE}	ford10	Ford 10	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	31	{NONE}	ford11	Ford 11	APPROVED	{}	\N
6	\N	\N	\N	2024-01-08 20:42:27.862	\N	32	{NONE}	ford12	Ford 12	APPROVED	{}	\N
3	\N	\N	\N	2024-01-08 20:42:27.863	\N	33	{NONE}	technology	Technology	APPROVED	{}	\N
3	\N	\N	\N	2024-01-08 20:42:27.864	\N	34	{NONE}	lonely_topic	Lonely Topic	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.864	I'm a human. https://factiii.com/about	35	{HUMAN_SOURCE}	jonathan-snyder	Jonathan Snyder	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.865	The Environmental Protection Agency is an independent executive agency of the United States federal government tasked with environmental protection matters. https://www.epa.gov/	36	{GOVERNMENT_SOURCE}	epa	EPA	APPROVED	{}	\N
2	2	\N	\N	2024-01-08 20:42:27.865	This is the unofficial Wikipedia factiii. https://en.wikipedia.org/wiki/Main_Page	37	{ENTERPRISE_SOURCE}	wikipedia	Wikipedia	APPROVED	{}	\N
2	\N	\N	\N	2024-01-08 20:42:27.866	\N	38	{ANONYMOUS_SOURCE}	mr-anonymous	Mr Anonymous	APPROVED	{}	\N
6	15	\N	\N	2024-01-08 20:42:27.891	Private factiii in s/private_Factiii if you see me then something is broken.	39	{NONE}	private-factiii	Private Factiii	APPROVED	{PRIVATE}	\N
6	15	\N	\N	2024-01-08 20:42:27.891	Public factiii in a private space s/private_Factiii.	40	{NONE}	public-factiii	Public Factiii	APPROVED	{}	\N
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

COPY public."Message" (id, "createdAt", content, "senderId", "conversationId", read) FROM stdin;
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
2	This is a post about history.	2024-01-08 20:42:27.797	PUBLISHED	0	0	\N	23347cf4-7cd7-4e29-aa26-65ef2fb8bf59	1	\N	\N
2	Post with factiiis science and politics	2024-01-08 20:42:27.866	PUBLISHED	0	0	\N	b87effd7-e13b-4c06-8765-3d377c9e115d	2	\N	\N
2	Post with factiiis science and history	2024-01-08 20:42:27.868	PUBLISHED	0	0	\N	7cc0aa51-593d-4580-9809-6bbf0d3f2281	3	\N	\N
2	Post with factiiis science and ford	2024-01-08 20:42:27.87	PUBLISHED	0	0	\N	8b897097-7032-440e-b744-a57a41127080	4	\N	\N
2	Post with factiiis science and technology	2024-01-08 20:42:27.872	PUBLISHED	0	0	\N	2cc738ac-813a-416a-b2bf-1e4c9fc2a20a	5	\N	\N
2	Post with factiii lonely	2024-01-08 20:42:27.873	PUBLISHED	0	0	\N	29f964b7-32d8-4170-8030-b909d84f66ac	6	\N	\N
6	haha you all are foolish loser robot people!	2024-01-08 20:42:27.875	PUBLISHED	0	0	\N	7d0d6bde-e0e8-450b-9d13-97913e78fc5f	7	\N	\N
6	removed post if you see this then it was not removed	2024-01-08 20:42:27.883	PUBLISHED	0	0	\N	693288bc-91e0-4d2f-89b9-94f86b39183d	8	\N	\N
2	private paid space post in s/paid	2024-01-08 20:42:27.886	PUBLISHED	0	0	13	7b271d0e-c643-4ec5-b266-09c563be95f2	9	\N	\N
6	Private post in s/private if you see me then something is broken.	2024-01-08 20:42:27.89	PUBLISHED	0	0	14	aaba389c-8cdd-4a3e-99ec-c9acc70af21c	10	\N	\N
6	Private post in s/private_Factiii with a private and public factiii attached. If you see me then something is broken.	2024-01-08 20:42:27.894	PUBLISHED	0	0	15	4fcbeecc-59c0-4fd8-a326-5549b8f3a385	11	\N	\N
6	Public post in s/factiii with a private and public factiii attached.	2024-01-08 20:42:27.896	PUBLISHED	0	0	1	9f5f8824-fe64-4669-b3ed-799618f5db51	12	\N	\N
6	Hi All! Post with 6 images and 15 awards!	2024-01-08 20:42:27.901	PUBLISHED	0	0	\N	de619021-01fe-4501-8167-239524960863	13	\N	\N
6	Post with 1920x1080 image.	2024-01-08 20:42:27.908	PUBLISHED	0	0	\N	d27bfa13-16d7-4ebd-8436-ddb76b7b3dcd	14	\N	\N
6	Post with very wide short image.	2024-01-08 20:42:27.909	PUBLISHED	0	0	\N	b01dc42b-50a3-4ff8-b087-600031956ba9	15	\N	\N
6	Post with very tall thin image.	2024-01-08 20:42:27.91	PUBLISHED	0	0	\N	ede57d27-ac68-450a-8771-3ede97c9f487	16	\N	\N
6	Very fucking NSFW post by @janice78 .	2024-01-08 20:42:27.912	PUBLISHED	0	0	\N	89cf5a90-7d87-4cc8-abfd-da10e8123ec1	18	\N	\N
4	Post 0	2014-01-10 20:42:27.917	PUBLISHED	-5591303.379622222	0	2	f68a2c59-e4fa-4008-90c5-1f2abc5426c8	19	\N	\N
4	Post 1	2014-01-10 20:42:28.918	PUBLISHED	-5591303.357377778	0	2	7ee75f68-50b9-4c51-9ce2-cbff3025b191	20	\N	\N
4	Post 2	2014-01-10 20:42:29.918	PUBLISHED	-5591303.335155556	0	2	68925cb6-8760-4a35-8932-7a4898a8dcef	21	\N	\N
4	Post 3	2014-01-10 20:42:30.919	PUBLISHED	-5591303.312911111	0	2	c13a94e7-fd47-4bf2-8572-d3455ccf949d	22	\N	\N
4	Post 4	2014-01-10 20:42:31.919	PUBLISHED	-5591303.290688889	0	2	1ed7b971-5647-4cdc-9817-813a7128269b	23	\N	\N
4	Post 5	2014-01-10 20:42:32.92	PUBLISHED	-5591303.268444444	0	2	67f3e0f7-5dc2-40aa-8813-33284a7a6761	24	\N	\N
4	Post 6	2014-01-10 20:42:33.92	PUBLISHED	-5591303.246222222	0	2	c716bd77-5427-431f-a18f-1309f609c40d	25	\N	\N
4	Post 7	2014-01-10 20:42:34.921	PUBLISHED	-5591303.223977778	0	2	15e4d9a1-a8f1-4739-af24-4e45e6efd69b	26	\N	\N
4	Post 8	2014-01-10 20:42:35.921	PUBLISHED	-5591303.201755555	0	2	43b38c82-66dd-4f43-ac4d-c11eb149422f	27	\N	\N
4	Post 9	2014-01-10 20:42:36.922	PUBLISHED	-5591303.179511111	0	2	d39d1b7a-3d65-46c4-9d9b-4f1cf1030c56	28	\N	\N
4	Post 10	2014-01-10 20:42:37.922	PUBLISHED	-5591303.157288888	0	2	727a0a8f-c8b3-43fc-a0f7-00edfdb671c4	29	\N	\N
4	Post 11	2014-01-10 20:42:38.923	PUBLISHED	-5591303.135044444	0	2	1f6b0ca0-1a05-4b4a-a845-a48f6a95ea8a	30	\N	\N
4	Post 12	2014-01-10 20:42:39.923	PUBLISHED	-5591303.112822223	0	2	718943e8-a3f3-4f45-9e86-62ea4afe78ae	31	\N	\N
4	Post 13	2014-01-10 20:42:40.924	PUBLISHED	-5591303.090577777	0	2	68bf25ee-3824-4129-b210-f24b4fb9a23a	32	\N	\N
4	Post 14	2014-01-10 20:42:41.924	PUBLISHED	-5591303.068355556	0	2	06e91e5f-3a4e-4140-8471-d48823ae0325	33	\N	\N
4	Post 15	2014-01-10 20:42:42.924	PUBLISHED	-5591303.046133333	0	2	52744b16-a787-430a-9a59-12d2eddd7fdc	34	\N	\N
4	Post 16	2014-01-10 20:42:43.925	PUBLISHED	-5591303.023888889	0	2	ca4e7bf0-4b50-4198-b453-4bc5b8a80f16	35	\N	\N
4	Post 17	2014-01-10 20:42:44.925	PUBLISHED	-5591303.001666667	0	2	4cc5923b-110b-4739-9d9e-d4c4165840b7	36	\N	\N
4	Post 18	2014-01-10 20:42:45.926	PUBLISHED	-5591302.979422222	0	2	2fe8eed0-ceba-4e0b-8f17-1b2cdfd3ae21	37	\N	\N
4	Post 19	2014-01-10 20:42:46.926	PUBLISHED	-5591302.9572	0	2	2ff4912c-8650-4e10-a45d-29d6a6d89cc9	38	\N	\N
4	Post 20	2014-01-10 20:42:47.927	PUBLISHED	-5591302.934955556	0	2	13683b8d-8707-4f1b-8eed-7cde5356b77a	39	\N	\N
4	Post 21	2014-01-10 20:42:48.927	PUBLISHED	-5591302.912733333	0	2	19a4f613-0abf-41a4-9112-1d6c03ef2aff	40	\N	\N
4	Post 22	2014-01-10 20:42:49.928	PUBLISHED	-5591302.890488889	0	2	b904f00d-673c-4b51-aa63-a69d55b41343	41	\N	\N
4	Post 23	2014-01-10 20:42:50.928	PUBLISHED	-5591302.868266666	0	2	a6c90ff5-54a7-4a53-b84d-1686433cd559	42	\N	\N
4	Post 24	2014-01-10 20:42:51.928	PUBLISHED	-5591302.846044444	0	2	b7c1176e-76da-4fc8-9586-83acb34b9f99	43	\N	\N
4	Post 25	2014-01-10 20:42:52.929	PUBLISHED	-5591302.8238	0	2	1aadcd50-07ec-42b6-9326-1087c1477a12	44	\N	\N
4	Post 26	2014-01-10 20:42:53.929	PUBLISHED	-5591302.801577778	0	2	63c14555-19cb-409e-8b30-c64df314528a	45	\N	\N
4	Post 27	2014-01-10 20:42:54.93	PUBLISHED	-5591302.779333333	0	2	0fd2f9b1-56d2-4c0b-84d5-59758edf2a8d	46	\N	\N
4	Post 28	2014-01-10 20:42:55.93	PUBLISHED	-5591302.757111111	0	2	87b3df84-3f7a-42c2-bb5f-17e4a1aa3623	47	\N	\N
4	Post 29	2014-01-10 20:42:56.931	PUBLISHED	-5591302.734866667	0	2	ba60eea8-e82f-4650-9b98-ca88c9606b8d	48	\N	\N
4	Post 30	2014-01-10 20:42:57.931	PUBLISHED	-5591302.712644445	0	2	049d3315-06c0-4e5d-b1a4-72696d431a1e	49	\N	\N
4	Post 31	2014-01-10 20:42:58.932	PUBLISHED	-5591302.6904	0	2	6afa0157-a5e8-4a89-b7e1-55be25e89aea	50	\N	\N
4	Post 32	2014-01-10 20:42:59.932	PUBLISHED	-5591302.668177778	0	2	537b194a-7167-458f-8a9a-a9ca4ec51ae7	51	\N	\N
4	Post 33	2014-01-10 20:43:00.933	PUBLISHED	-5591302.645933334	0	2	587af918-4235-4a41-8464-7b4a124d9be6	52	\N	\N
4	Post 34	2014-01-10 20:43:01.933	PUBLISHED	-5591302.623711111	0	2	e5abe23a-2566-4b91-8b03-4e09528e0404	53	\N	\N
4	Post 35	2014-01-10 20:43:02.934	PUBLISHED	-5591302.601466667	0	2	675fad07-bd89-4c28-9d94-86e29f16ee54	54	\N	\N
4	Post 36	2014-01-10 20:43:03.934	PUBLISHED	-5591302.579244444	0	2	6338bf89-8a6b-4480-a0da-1e1c0565605f	55	\N	\N
4	Post 37	2014-01-10 20:43:04.935	PUBLISHED	-5591302.557	0	2	0968be5b-5ebd-47d1-b087-8a31184b1eef	56	\N	\N
4	Post 38	2014-01-10 20:43:05.935	PUBLISHED	-5591302.534777778	0	2	269edd05-1951-486e-84e0-f4a561f5a12e	57	\N	\N
4	Post 39	2014-01-10 20:43:06.935	PUBLISHED	-5591302.512555555	0	2	62e3e4ed-f222-4d95-a4bb-04b5a92542ee	58	\N	\N
4	Post 40	2014-01-10 20:43:07.936	PUBLISHED	-5591302.490311111	0	2	f80f2e1e-5cd1-4028-b83c-d17220da17b7	59	\N	\N
4	Post 41	2014-01-10 20:43:08.936	PUBLISHED	-5591302.468088889	0	2	a3d8659a-fb79-48e9-a69f-83665ce09e3d	60	\N	\N
4	Post 42	2014-01-10 20:43:09.937	PUBLISHED	-5591302.445844444	0	2	9c2f6252-70e3-44eb-a4d5-55798b30cd2c	61	\N	\N
4	Post 43	2014-01-10 20:43:10.937	PUBLISHED	-5591302.423622223	0	2	a9a65464-b14f-4083-98db-b6bd88ec1d5e	62	\N	\N
4	Post 44	2014-01-10 20:43:11.938	PUBLISHED	-5591302.401377778	0	2	0892cf72-3239-41bf-8d03-22cb2c2662bb	63	\N	\N
4	Post 45	2014-01-10 20:43:12.938	PUBLISHED	-5591302.379155556	0	2	77188026-e24c-47dc-8628-aafde2f4dd49	64	\N	\N
4	Post 46	2014-01-10 20:43:13.939	PUBLISHED	-5591302.356911111	0	2	5b8fdafd-4bee-4c3e-9bed-32ae7d0cdd8f	65	\N	\N
4	Post 47	2014-01-10 20:43:14.939	PUBLISHED	-5591302.334688889	0	2	cca1b9f8-a597-4a50-9a3f-9810eb785b17	66	\N	\N
4	Post 48	2014-01-10 20:43:15.939	PUBLISHED	-5591302.312466667	0	2	26130cf3-0fd0-4275-9d72-c07b1ec95f3c	67	\N	\N
4	Post 49	2014-01-10 20:43:16.94	PUBLISHED	-5591302.290222222	0	2	6bef2194-1dcc-43a6-afba-9f20f1727079	68	\N	\N
4	Post 50	2014-01-10 20:43:17.94	PUBLISHED	-5591302.268	0	2	669729be-0988-4cb2-a9b6-4b7402e757be	69	\N	\N
4	Post 51	2014-01-10 20:43:18.941	PUBLISHED	-5591302.245755555	0	2	54037d19-46fe-4149-ad8f-2cb5ffc1e4fd	70	\N	\N
4	Post 52	2014-01-10 20:43:19.941	PUBLISHED	-5591302.223533333	0	2	12b76c3e-01db-40a2-b306-fa97d6950f0d	71	\N	\N
4	Post 53	2014-01-10 20:43:20.942	PUBLISHED	-5591302.201288889	0	2	01046813-2840-4c7d-9f3b-87b622afa9b0	72	\N	\N
4	Post 54	2014-01-10 20:43:21.942	PUBLISHED	-5591302.179066666	0	2	08cef618-9d2a-4599-838f-83d33890f146	73	\N	\N
7	banned post in space: Wikipedia	2013-01-10 20:42:27.995	PUBLISHED	-6292103.377888889	0	2	d1b1bbe6-6314-4195-b3b9-eccf964740a5	74	\N	\N
8	muted post in space: Wikipedia	2013-01-10 20:42:27.995	PUBLISHED	-6292103.377888889	0	2	68060ebf-c005-4e90-948b-6004105bba07	75	\N	\N
10	I blocked you post in space: Wikipedia	2013-01-10 20:42:27.995	PUBLISHED	-6292103.377888889	0	2	81b98261-7b91-4e9a-820e-27a742dae1bd	76	\N	\N
7	banned post in space: founders	2013-01-10 20:42:27.998	PUBLISHED	-6292103.377822222	0	3	159dcaba-f85d-438f-8063-07d81db754dd	77	\N	\N
8	muted post in space: founders	2013-01-10 20:42:27.998	PUBLISHED	-6292103.377822222	0	3	5ca4afa9-8876-4bd1-bcf0-44b73955e125	78	\N	\N
10	I blocked you post in space: founders	2013-01-10 20:42:27.998	PUBLISHED	-6292103.377822222	0	3	003537fb-8ada-4d1a-a8ad-8a99218b6da7	79	\N	\N
7	banned post in space: premium	2013-01-10 20:42:28	PUBLISHED	-6292103.377777778	0	4	d8acf80a-180c-41d1-a103-2d9ad29b9b48	80	\N	\N
8	muted post in space: premium	2013-01-10 20:42:28	PUBLISHED	-6292103.377777778	0	4	a96c14b0-5f1d-4c5d-a37d-144fda947d72	81	\N	\N
10	I blocked you post in space: premium	2013-01-10 20:42:28	PUBLISHED	-6292103.377777778	0	4	a0948ed1-cb39-4f2a-8088-8136e2595365	82	\N	\N
7	banned post in space: factiii	2013-01-10 20:42:28.002	PUBLISHED	-6292103.377733333	0	1	919c76ea-af8f-4489-bf81-67a60e88bf6b	83	\N	\N
8	muted post in space: factiii	2013-01-10 20:42:28.002	PUBLISHED	-6292103.377733333	0	1	3db51401-079e-4124-b4b6-ec4182196ea4	84	\N	\N
10	I blocked you post in space: factiii	2013-01-10 20:42:28.002	PUBLISHED	-6292103.377733333	0	1	0e8355b4-ab24-4ca8-94ad-4bbe4ee0b7b9	85	\N	\N
7	banned post in space: about	2013-01-10 20:42:28.005	PUBLISHED	-6292103.377666667	0	5	424831d4-b020-4a02-9a10-a029c8b0b3cc	86	\N	\N
8	muted post in space: about	2013-01-10 20:42:28.005	PUBLISHED	-6292103.377666667	0	5	b35bd422-47e7-416b-b52c-513f42a5a61c	87	\N	\N
10	I blocked you post in space: about	2013-01-10 20:42:28.005	PUBLISHED	-6292103.377666667	0	5	c436eb95-92d7-41c1-969e-a89166a8874e	88	\N	\N
7	banned post in space: science	2013-01-10 20:42:28.006	PUBLISHED	-6292103.377644445	0	6	cb36c4f8-9bc1-468d-a63d-3123f8c13422	89	\N	\N
8	muted post in space: science	2013-01-10 20:42:28.006	PUBLISHED	-6292103.377644445	0	6	7a4b6587-15d1-4306-bc13-48170f0cc897	90	\N	\N
10	I blocked you post in space: science	2013-01-10 20:42:28.006	PUBLISHED	-6292103.377644445	0	6	c8d9503d-0ba2-4afe-8a3c-c4ffca3c5d10	91	\N	\N
7	banned post in space: history	2013-01-10 20:42:28.009	PUBLISHED	-6292103.377577778	0	7	48afa4e6-ee59-45b6-b299-994a52ef27bc	92	\N	\N
8	muted post in space: history	2013-01-10 20:42:28.009	PUBLISHED	-6292103.377577778	0	7	85239bcd-3b15-494b-be1c-e83369c19573	93	\N	\N
10	I blocked you post in space: history	2013-01-10 20:42:28.009	PUBLISHED	-6292103.377577778	0	7	e4919454-7154-4e8b-87f5-b011bc6b5417	94	\N	\N
7	banned post in space: pics	2013-01-10 20:42:28.011	PUBLISHED	-6292103.377533333	0	8	91c52030-7ad0-4133-aaf7-3cd0db69a177	95	\N	\N
8	muted post in space: pics	2013-01-10 20:42:28.011	PUBLISHED	-6292103.377533333	0	8	5c18a468-bb9c-4c95-b4a8-a5c29c877aa2	96	\N	\N
10	I blocked you post in space: pics	2013-01-10 20:42:28.011	PUBLISHED	-6292103.377533333	0	8	696024a0-4aac-4125-b7a3-3a3fc5414718	97	\N	\N
7	banned post in space: videos	2013-01-10 20:42:28.012	PUBLISHED	-6292103.377511111	0	9	5fade75d-79a6-4ff5-8b49-88d057d9367f	98	\N	\N
8	muted post in space: videos	2013-01-10 20:42:28.012	PUBLISHED	-6292103.377511111	0	9	5f6cfb9e-261d-45d2-9db5-8635a3293ff6	99	\N	\N
10	I blocked you post in space: videos	2013-01-10 20:42:28.012	PUBLISHED	-6292103.377511111	0	9	e839e517-4ab9-42c4-b93f-c61d1922c6ea	100	\N	\N
7	banned post in space: news	2013-01-10 20:42:28.014	PUBLISHED	-6292103.377466667	0	10	5401824c-6f86-428e-8978-0b93eb666b7f	101	\N	\N
8	muted post in space: news	2013-01-10 20:42:28.014	PUBLISHED	-6292103.377466667	0	10	8b83d2e1-98f6-45fc-911a-3e45d21e3a65	102	\N	\N
10	I blocked you post in space: news	2013-01-10 20:42:28.014	PUBLISHED	-6292103.377466667	0	10	58ba9776-290b-4a61-94d1-9494edec4ddb	103	\N	\N
7	banned post in space: announcements	2013-01-10 20:42:28.016	PUBLISHED	-6292103.377422222	0	11	cddb4df6-7ea4-416f-be74-113363053ad3	104	\N	\N
8	muted post in space: announcements	2013-01-10 20:42:28.016	PUBLISHED	-6292103.377422222	0	11	4f25636a-b9a3-4216-9a8f-da11b3a547c4	105	\N	\N
10	I blocked you post in space: announcements	2013-01-10 20:42:28.016	PUBLISHED	-6292103.377422222	0	11	a15ba83b-bf4c-4d3e-b61c-2f4c5b2893cc	106	\N	\N
7	banned post in space: OpenAI	2013-01-10 20:42:28.017	PUBLISHED	-6292103.3774	0	12	baff9f51-0e10-4344-9786-27ab003fbdac	107	\N	\N
8	muted post in space: OpenAI	2013-01-10 20:42:28.017	PUBLISHED	-6292103.3774	0	12	fd3f49d5-b171-44cf-a3c5-45ef93641002	108	\N	\N
10	I blocked you post in space: OpenAI	2013-01-10 20:42:28.017	PUBLISHED	-6292103.3774	0	12	e88d8f45-a03b-40ca-ae65-a114d80a26ec	109	\N	\N
7	banned post in space: paid	2013-01-10 20:42:28.019	PUBLISHED	-6292103.377355556	0	13	ef951eb2-23d2-4e41-b57e-673f63db60da	110	\N	\N
8	muted post in space: paid	2013-01-10 20:42:28.019	PUBLISHED	-6292103.377355556	0	13	3e353f11-f7d6-4441-8c3a-75c30d6446bb	111	\N	\N
10	I blocked you post in space: paid	2013-01-10 20:42:28.019	PUBLISHED	-6292103.377355556	0	13	83b3753d-aa6d-4145-8c28-a77594661cbd	112	\N	\N
7	banned post in space: Private Test	2013-01-10 20:42:28.021	PUBLISHED	-6292103.377311111	0	14	8352ba30-be76-4b99-a6dd-d00f4aec28b4	113	\N	\N
8	muted post in space: Private Test	2013-01-10 20:42:28.021	PUBLISHED	-6292103.377311111	0	14	16941067-06e3-4acf-97f0-639cabe25384	114	\N	\N
10	I blocked you post in space: Private Test	2013-01-10 20:42:28.021	PUBLISHED	-6292103.377311111	0	14	65d9461e-6a42-4a4b-b14d-4ef901cd391b	115	\N	\N
7	banned post in space: Private Factiii	2013-01-10 20:42:28.022	PUBLISHED	-6292103.377288889	0	15	5138207f-67bc-4cd8-84c0-0991851e7a36	116	\N	\N
8	muted post in space: Private Factiii	2013-01-10 20:42:28.022	PUBLISHED	-6292103.377288889	0	15	3a9ad8f8-7c84-44c6-b72c-a6e1e2e90278	117	\N	\N
10	I blocked you post in space: Private Factiii	2013-01-10 20:42:28.022	PUBLISHED	-6292103.377288889	0	15	f2ec4486-00b9-487f-bf0d-0d8a47ff2579	118	\N	\N
7	banned reply to post	2012-01-11 20:42:28.024	PUBLISHED	-6992903.377244445	0	\N	d2f60f8e-26e4-4a83-9877-471e468663ef	119	1	\N
8	muted reply to post	2012-01-11 20:42:28.024	PUBLISHED	-6992903.377244445	0	\N	f12e8bb5-85d1-4e9a-a5c3-509eac2ca274	120	1	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.024	PUBLISHED	-6992903.377244445	0	\N	b7686f1b-6a7c-4599-90fa-c5d073f59ad5	121	1	\N
7	banned reply to post	2012-01-11 20:42:28.025	PUBLISHED	-6992903.377222222	0	\N	f89c4525-4e9a-4e5b-be5f-47d5d5b56287	122	2	\N
8	muted reply to post	2012-01-11 20:42:28.025	PUBLISHED	-6992903.377222222	0	\N	2024fa3e-3fa3-453a-983b-79a217438f63	123	2	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.025	PUBLISHED	-6992903.377222222	0	\N	46c6aded-1a3f-4b14-8ffb-9fa9341d70f4	124	2	\N
7	banned reply to post	2012-01-11 20:42:28.027	PUBLISHED	-6992903.377177778	0	\N	95a5e765-3036-4fa8-beec-e0cb7cf0db1b	125	3	\N
8	muted reply to post	2012-01-11 20:42:28.027	PUBLISHED	-6992903.377177778	0	\N	9d1322cf-613a-418b-8656-70c6fab0c876	126	3	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.027	PUBLISHED	-6992903.377177778	0	\N	6fce7542-2524-4e34-94c8-9e975162a25e	127	3	\N
7	banned reply to post	2012-01-11 20:42:28.028	PUBLISHED	-6992903.377155555	0	\N	f1cc92e4-356b-4f65-ae9d-e909a7edc1d3	128	4	\N
8	muted reply to post	2012-01-11 20:42:28.028	PUBLISHED	-6992903.377155555	0	\N	24bf5ec3-1783-4562-875b-a8042ed69323	129	4	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.028	PUBLISHED	-6992903.377155555	0	\N	940cb18c-7cf5-4b6c-8a43-60b6338b7596	130	4	\N
7	banned reply to post	2012-01-11 20:42:28.03	PUBLISHED	-6992903.377111111	0	\N	13b9ddad-8a90-4192-82de-d020693cc8ad	131	5	\N
8	muted reply to post	2012-01-11 20:42:28.03	PUBLISHED	-6992903.377111111	0	\N	43bfc990-6f42-433b-9d61-0f6f00595129	132	5	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.03	PUBLISHED	-6992903.377111111	0	\N	9f0b01b8-2115-4b41-81b7-1af7aa5282b5	133	5	\N
7	banned reply to post	2012-01-11 20:42:28.032	PUBLISHED	-6992903.377066666	0	\N	f10cf5b3-aba8-4476-8837-02eef711ae7c	134	6	\N
8	muted reply to post	2012-01-11 20:42:28.032	PUBLISHED	-6992903.377066666	0	\N	be87d37b-a101-4452-b19e-42ff30d32f00	135	6	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.032	PUBLISHED	-6992903.377066666	0	\N	a17d256f-12e1-4c60-8e53-71088d3531c4	136	6	\N
7	banned reply to post	2012-01-11 20:42:28.034	PUBLISHED	-6992903.377022223	0	\N	f7a208ff-0d60-4b6e-b679-a2c2856e16ee	137	7	\N
8	muted reply to post	2012-01-11 20:42:28.034	PUBLISHED	-6992903.377022223	0	\N	87cd9945-c2dc-4f8c-bf67-1de15ae957bb	138	7	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.034	PUBLISHED	-6992903.377022223	0	\N	733f5ebe-bba6-47b0-8d66-03c472b3b261	139	7	\N
7	banned reply to post	2012-01-11 20:42:28.035	PUBLISHED	-6992903.377	0	\N	7953a23f-5380-4d42-82ea-870598364134	140	8	\N
8	muted reply to post	2012-01-11 20:42:28.035	PUBLISHED	-6992903.377	0	\N	a35f6d24-4eb4-406c-aca0-899dbb6df7d1	141	8	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.035	PUBLISHED	-6992903.377	0	\N	91ea1194-7694-4536-a7b3-1aa411bb7537	142	8	\N
7	banned reply to post	2012-01-11 20:42:28.037	PUBLISHED	-6992903.376955556	0	\N	dbd20c6d-527b-4041-b9f8-e2b0fdf499c7	143	9	\N
8	muted reply to post	2012-01-11 20:42:28.037	PUBLISHED	-6992903.376955556	0	\N	7dca42b8-adcb-4ac1-8f52-af93e567c486	144	9	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.037	PUBLISHED	-6992903.376955556	0	\N	0143d55b-c00f-4633-95fc-d393d8560bd4	145	9	\N
7	banned reply to post	2012-01-11 20:42:28.038	PUBLISHED	-6992903.376933333	0	\N	2cce50be-b364-494b-afdf-c072834284c1	146	10	\N
8	muted reply to post	2012-01-11 20:42:28.038	PUBLISHED	-6992903.376933333	0	\N	a7ff813c-14c7-4f14-9d16-80d4e8e5ab43	147	10	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.038	PUBLISHED	-6992903.376933333	0	\N	8076bb2b-83ad-40d8-88d5-1bd5fde23344	148	10	\N
7	banned reply to post	2012-01-11 20:42:28.039	PUBLISHED	-6992903.376911111	0	\N	1bf0d01c-9bf7-4aa9-b597-d3aca062eca5	149	11	\N
8	muted reply to post	2012-01-11 20:42:28.039	PUBLISHED	-6992903.376911111	0	\N	63372fab-c54a-462e-b360-0a795cfe1788	150	11	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.039	PUBLISHED	-6992903.376911111	0	\N	cc15a8ed-6fe1-4da7-9460-7102ae3ed410	151	11	\N
7	banned reply to post	2012-01-11 20:42:28.041	PUBLISHED	-6992903.376866667	0	\N	4c145caf-2e88-4e31-9c5b-c0ab2e55cbd2	152	12	\N
8	muted reply to post	2012-01-11 20:42:28.041	PUBLISHED	-6992903.376866667	0	\N	f20b84eb-0ab9-4a39-a71b-abf92094c367	153	12	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.041	PUBLISHED	-6992903.376866667	0	\N	987843fe-6bb4-4229-874e-fbe8d8e64306	154	12	\N
7	banned reply to post	2012-01-11 20:42:28.042	PUBLISHED	-6992903.376844444	0	\N	30a731be-4a6b-4cf7-8865-db4bccdca665	155	13	\N
8	muted reply to post	2012-01-11 20:42:28.042	PUBLISHED	-6992903.376844444	0	\N	11c44315-3d46-4d92-9bc5-664090eee0b2	156	13	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.042	PUBLISHED	-6992903.376844444	0	\N	c6f19d80-66ef-4d88-8ff5-fbf6a5ab8ac4	157	13	\N
7	banned reply to post	2012-01-11 20:42:28.043	PUBLISHED	-6992903.376822222	0	\N	cc3a0fd8-a3ea-41ae-99c3-46314b7c0340	158	14	\N
8	muted reply to post	2012-01-11 20:42:28.043	PUBLISHED	-6992903.376822222	0	\N	c72e7d02-8d7b-4ad2-a9d4-545c61bbd260	159	14	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.043	PUBLISHED	-6992903.376822222	0	\N	b49456fc-4183-40b3-bfc1-b4e5bc65ba7f	160	14	\N
7	banned reply to post	2012-01-11 20:42:28.045	PUBLISHED	-6992903.376777777	0	\N	8a9419cc-f81f-4f04-8c96-2057ece8ca1a	161	15	\N
8	muted reply to post	2012-01-11 20:42:28.045	PUBLISHED	-6992903.376777777	0	\N	3d4ed388-09e1-4185-b703-60b6798a2a8e	162	15	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.045	PUBLISHED	-6992903.376777777	0	\N	18eb96bc-e187-43e6-9138-83a21974b1ae	163	15	\N
7	banned reply to post	2012-01-11 20:42:28.046	PUBLISHED	-6992903.376755555	0	\N	17f67895-9f79-40e3-ac2c-d08b5a8fc2dd	164	16	\N
8	muted reply to post	2012-01-11 20:42:28.046	PUBLISHED	-6992903.376755555	0	\N	a4eb8571-c6b2-43b9-a05b-24dd2fa9e2b4	165	16	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.046	PUBLISHED	-6992903.376755555	0	\N	9a2ac098-c6ab-4dd8-939f-9c5fec416c66	166	16	\N
7	banned reply to post	2012-01-11 20:42:28.048	PUBLISHED	-6992903.376711112	0	\N	0d3ed3db-5d6b-42d5-8511-ec36df17d1e2	167	17	\N
8	muted reply to post	2012-01-11 20:42:28.048	PUBLISHED	-6992903.376711112	0	\N	a9cabd50-fbbd-4cd1-bd60-29b2a94c6c2f	168	17	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.048	PUBLISHED	-6992903.376711112	0	\N	54ffcbbb-1923-4ffd-acf9-9deab6485531	169	17	\N
7	banned reply to post	2012-01-11 20:42:28.049	PUBLISHED	-6992903.376688889	0	\N	1ed8960b-7155-465e-9628-46d76690091c	170	18	\N
8	muted reply to post	2012-01-11 20:42:28.049	PUBLISHED	-6992903.376688889	0	\N	e2900f17-4cc1-4432-b8de-fd09c05148ed	171	18	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.049	PUBLISHED	-6992903.376688889	0	\N	5fe48e18-1ebe-45e8-b77c-e92578165fad	172	18	\N
7	banned reply to post	2012-01-11 20:42:28.051	PUBLISHED	-6992903.376644445	0	\N	c5bd4432-0962-4634-b8a2-9f7401dc19ee	173	19	\N
8	muted reply to post	2012-01-11 20:42:28.051	PUBLISHED	-6992903.376644445	0	\N	3da2b3ba-3231-46ae-bab8-72247abb3cb4	174	19	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.051	PUBLISHED	-6992903.376644445	0	\N	b21a3f40-1ac5-4264-9dc4-edc5fa6b08c4	175	19	\N
7	banned reply to post	2012-01-11 20:42:28.052	PUBLISHED	-6992903.376622222	0	\N	a5da1af9-87cb-4960-af26-a0c0589f16f9	176	20	\N
8	muted reply to post	2012-01-11 20:42:28.052	PUBLISHED	-6992903.376622222	0	\N	baa72a63-e887-4782-a59d-4ae2710bc8f3	177	20	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.052	PUBLISHED	-6992903.376622222	0	\N	0c8f6957-7f32-4b0b-a698-bc36c280c56a	178	20	\N
7	banned reply to post	2012-01-11 20:42:28.053	PUBLISHED	-6992903.3766	0	\N	c040cfbd-400c-401c-8152-ae7ba283ef4e	179	21	\N
8	muted reply to post	2012-01-11 20:42:28.053	PUBLISHED	-6992903.3766	0	\N	405efa7f-76bd-4c82-819a-8329bd2497ea	180	21	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.053	PUBLISHED	-6992903.3766	0	\N	ce6a7088-1820-4707-b9e7-c0a9edc0e7a0	181	21	\N
7	banned reply to post	2012-01-11 20:42:28.055	PUBLISHED	-6992903.376555556	0	\N	e0788d0f-80b7-4705-a3ea-fc07a378df07	182	22	\N
8	muted reply to post	2012-01-11 20:42:28.055	PUBLISHED	-6992903.376555556	0	\N	d93abdc2-e775-4cb5-a805-18eb88c84a95	183	22	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.055	PUBLISHED	-6992903.376555556	0	\N	df248a3d-8ea6-4245-808f-1a8b3b492045	184	22	\N
7	banned reply to post	2012-01-11 20:42:28.056	PUBLISHED	-6992903.376533333	0	\N	eae5e8ec-3f98-47d6-afd9-1f7e9f626c4d	185	23	\N
8	muted reply to post	2012-01-11 20:42:28.056	PUBLISHED	-6992903.376533333	0	\N	c675f887-2c9e-46aa-8751-99924dba0f7b	186	23	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.056	PUBLISHED	-6992903.376533333	0	\N	8248df1c-5582-4675-af58-fb79847687eb	187	23	\N
7	banned reply to post	2012-01-11 20:42:28.057	PUBLISHED	-6992903.376511111	0	\N	a5a2d105-2660-4a6c-ba10-00d694505507	188	24	\N
8	muted reply to post	2012-01-11 20:42:28.057	PUBLISHED	-6992903.376511111	0	\N	52d5e5fa-accc-4678-a99e-d2c67f1734b8	189	24	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.057	PUBLISHED	-6992903.376511111	0	\N	0ec7ac03-d6e0-457e-a3c3-75d87dd7e4b6	190	24	\N
7	banned reply to post	2012-01-11 20:42:28.059	PUBLISHED	-6992903.376466666	0	\N	0ffcdf2f-f3cd-44e3-8093-cfe6fe9210af	191	25	\N
8	muted reply to post	2012-01-11 20:42:28.059	PUBLISHED	-6992903.376466666	0	\N	a1c673c5-08be-46bc-adad-11f71da7abe5	192	25	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.059	PUBLISHED	-6992903.376466666	0	\N	7a9e165f-ad25-42d1-88f9-f79518e8f8e4	193	25	\N
7	banned reply to post	2012-01-11 20:42:28.06	PUBLISHED	-6992903.376444444	0	\N	f6224312-cf1d-40fc-825f-647b12aae6fe	194	26	\N
8	muted reply to post	2012-01-11 20:42:28.06	PUBLISHED	-6992903.376444444	0	\N	55e2e2fe-6d4c-4a12-bfd4-719decdf5589	195	26	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.06	PUBLISHED	-6992903.376444444	0	\N	90b714a2-be58-4ffb-b9d3-c6b1d4094c04	196	26	\N
7	banned reply to post	2012-01-11 20:42:28.061	PUBLISHED	-6992903.376422222	0	\N	60df53bb-1772-4a87-82e7-dbca791f7735	197	27	\N
8	muted reply to post	2012-01-11 20:42:28.061	PUBLISHED	-6992903.376422222	0	\N	6a7d277f-de73-45c8-9753-07ba2c519545	198	27	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.061	PUBLISHED	-6992903.376422222	0	\N	d90b5c4b-ba0a-4c06-ae3c-e16ac1c43376	199	27	\N
7	banned reply to post	2012-01-11 20:42:28.063	PUBLISHED	-6992903.376377778	0	\N	705f9f59-d090-4cd3-8363-7aa7f366b3f5	200	28	\N
8	muted reply to post	2012-01-11 20:42:28.063	PUBLISHED	-6992903.376377778	0	\N	584f1757-9e82-49a8-82eb-299b69d597e6	201	28	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.063	PUBLISHED	-6992903.376377778	0	\N	092f4d33-f844-4784-8839-0010f307d30f	202	28	\N
7	banned reply to post	2012-01-11 20:42:28.064	PUBLISHED	-6992903.376355556	0	\N	99befd12-7026-4a17-81a3-2f17b594a2fd	203	29	\N
8	muted reply to post	2012-01-11 20:42:28.064	PUBLISHED	-6992903.376355556	0	\N	d3b994c4-f62a-49c8-8978-ad2e422be858	204	29	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.064	PUBLISHED	-6992903.376355556	0	\N	5d6a4098-429b-491e-935f-140d1680cfb5	205	29	\N
7	banned reply to post	2012-01-11 20:42:28.066	PUBLISHED	-6992903.376311111	0	\N	a05128cf-0d71-4065-87f7-b198938fffe4	206	30	\N
8	muted reply to post	2012-01-11 20:42:28.066	PUBLISHED	-6992903.376311111	0	\N	a7518008-2c66-4183-a0f2-185cdb9fc6e2	207	30	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.066	PUBLISHED	-6992903.376311111	0	\N	a6359871-aa4c-409d-98f1-5299843eebb1	208	30	\N
7	banned reply to post	2012-01-11 20:42:28.067	PUBLISHED	-6992903.376288889	0	\N	838c7c86-f81d-427b-b783-ef5888a34844	209	31	\N
8	muted reply to post	2012-01-11 20:42:28.067	PUBLISHED	-6992903.376288889	0	\N	3c5b1272-cd80-4ace-8928-778ab1ffbebe	210	31	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.067	PUBLISHED	-6992903.376288889	0	\N	f486b4d1-5269-408a-9c5d-aba54c068a66	211	31	\N
7	banned reply to post	2012-01-11 20:42:28.068	PUBLISHED	-6992903.376266667	0	\N	9166435c-d0eb-4566-bdbd-bdb5c8e97dca	212	32	\N
8	muted reply to post	2012-01-11 20:42:28.068	PUBLISHED	-6992903.376266667	0	\N	4e941f70-8824-4dbc-9495-6d3e44ba26d8	213	32	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.068	PUBLISHED	-6992903.376266667	0	\N	a8fc803b-ef08-4b4a-b13b-86811d503b07	214	32	\N
7	banned reply to post	2012-01-11 20:42:28.07	PUBLISHED	-6992903.376222222	0	\N	57c60117-7360-4218-a680-0a2e925731e6	215	33	\N
8	muted reply to post	2012-01-11 20:42:28.07	PUBLISHED	-6992903.376222222	0	\N	6bc31801-2059-42f5-9e92-c1466acb1984	216	33	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.07	PUBLISHED	-6992903.376222222	0	\N	95b66f4f-0533-4c46-b9cf-e7524d6de19d	217	33	\N
7	banned reply to post	2012-01-11 20:42:28.071	PUBLISHED	-6992903.3762	0	\N	c40b0736-33bd-4994-ad81-f80532c89a4d	218	34	\N
8	muted reply to post	2012-01-11 20:42:28.071	PUBLISHED	-6992903.3762	0	\N	193fdaf7-8e47-44bf-bba3-f977e7de583a	219	34	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.071	PUBLISHED	-6992903.3762	0	\N	30abb7c2-078b-4fcd-ace0-d9171e38cee8	220	34	\N
7	banned reply to post	2012-01-11 20:42:28.072	PUBLISHED	-6992903.376177778	0	\N	1e59908b-73bf-41ee-8464-e4c0d6e202ad	221	35	\N
8	muted reply to post	2012-01-11 20:42:28.072	PUBLISHED	-6992903.376177778	0	\N	d72a1270-c219-4791-9095-798876dae675	222	35	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.072	PUBLISHED	-6992903.376177778	0	\N	4bdfee45-0be6-490f-8fc2-cbb412573702	223	35	\N
7	banned reply to post	2012-01-11 20:42:28.073	PUBLISHED	-6992903.376155555	0	\N	e04cd3b0-76f4-4812-a1e3-61955b4947dd	224	36	\N
8	muted reply to post	2012-01-11 20:42:28.073	PUBLISHED	-6992903.376155555	0	\N	3d2e7562-0d69-4b7a-9946-c3627b2daa43	225	36	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.073	PUBLISHED	-6992903.376155555	0	\N	c68e7545-0c61-4df1-b52b-da1bde75c382	226	36	\N
7	banned reply to post	2012-01-11 20:42:28.075	PUBLISHED	-6992903.376111111	0	\N	f4e4be9e-0634-4339-b6e4-67552ac3846a	227	37	\N
8	muted reply to post	2012-01-11 20:42:28.075	PUBLISHED	-6992903.376111111	0	\N	ba703320-a0f6-4006-b448-cefb11dc0b96	228	37	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.075	PUBLISHED	-6992903.376111111	0	\N	7df8267b-c28a-4e18-b3fc-5002b5a3a49e	229	37	\N
7	banned reply to post	2012-01-11 20:42:28.076	PUBLISHED	-6992903.376088889	0	\N	1f0d86b4-a0e1-424a-a91c-ac30aa4e0d96	230	38	\N
8	muted reply to post	2012-01-11 20:42:28.076	PUBLISHED	-6992903.376088889	0	\N	ee266aa8-2b52-4fc0-878d-67379db4ae12	231	38	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.076	PUBLISHED	-6992903.376088889	0	\N	3f41344c-07ae-4ba6-b274-27965493cfa5	232	38	\N
7	banned reply to post	2012-01-11 20:42:28.077	PUBLISHED	-6992903.376066667	0	\N	6eaf5bfc-acf9-4ac1-909d-1c4a9c92bb23	233	39	\N
8	muted reply to post	2012-01-11 20:42:28.077	PUBLISHED	-6992903.376066667	0	\N	5e68ee66-2b03-4aa0-ba8e-d03cb6e24e9c	234	39	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.077	PUBLISHED	-6992903.376066667	0	\N	ef7b0fa8-cafd-4bdf-affd-251b39d1e35a	235	39	\N
7	banned reply to post	2012-01-11 20:42:28.079	PUBLISHED	-6992903.376022222	0	\N	dfefea0b-6d03-41dd-aee4-597a1f7afce2	236	40	\N
8	muted reply to post	2012-01-11 20:42:28.079	PUBLISHED	-6992903.376022222	0	\N	2c7b668c-d175-4b7b-97c4-f71dec69b0e8	237	40	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.079	PUBLISHED	-6992903.376022222	0	\N	700f2b9f-4ab4-4cd4-9509-411d568c9023	238	40	\N
7	banned reply to post	2012-01-11 20:42:28.08	PUBLISHED	-6992903.376	0	\N	597b0474-0aa5-4a0a-813d-0a00cd238448	239	41	\N
8	muted reply to post	2012-01-11 20:42:28.08	PUBLISHED	-6992903.376	0	\N	76f4a812-ca98-43fd-bc80-4437be1199ce	240	41	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.08	PUBLISHED	-6992903.376	0	\N	8a9b7dbc-4b87-4d80-97c8-332237af86bf	241	41	\N
7	banned reply to post	2012-01-11 20:42:28.082	PUBLISHED	-6992903.375955556	0	\N	4f31d162-e781-44b8-8523-bdd111eb6b28	242	42	\N
8	muted reply to post	2012-01-11 20:42:28.082	PUBLISHED	-6992903.375955556	0	\N	8408f019-4063-4053-b7ac-f4d5042b0895	243	42	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.082	PUBLISHED	-6992903.375955556	0	\N	699a9f1d-172d-4f6a-9795-5fdcf4218a3d	244	42	\N
7	banned reply to post	2012-01-11 20:42:28.083	PUBLISHED	-6992903.375933333	0	\N	ce399897-201a-40a4-ba28-40c1757b3f8a	245	43	\N
8	muted reply to post	2012-01-11 20:42:28.083	PUBLISHED	-6992903.375933333	0	\N	82603f32-f5ab-4092-874f-c081937be89a	246	43	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.083	PUBLISHED	-6992903.375933333	0	\N	00fa0ac1-d56e-40ce-8177-f9b48c06fcbf	247	43	\N
7	banned reply to post	2012-01-11 20:42:28.084	PUBLISHED	-6992903.375911111	0	\N	3d44b250-9503-4c9b-bc78-0f1aacf0ce3d	248	44	\N
8	muted reply to post	2012-01-11 20:42:28.084	PUBLISHED	-6992903.375911111	0	\N	e3fae7c9-9b8c-4d58-8ba5-a5186605758e	249	44	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.084	PUBLISHED	-6992903.375911111	0	\N	f656201b-3abb-42db-a0b3-322c46506afa	250	44	\N
7	banned reply to post	2012-01-11 20:42:28.086	PUBLISHED	-6992903.375866666	0	\N	e33eaa7b-2b4b-4bf0-a2c5-ebc2e25b3637	251	45	\N
8	muted reply to post	2012-01-11 20:42:28.086	PUBLISHED	-6992903.375866666	0	\N	1026b701-c15a-4081-a75a-76fe68d8e740	252	45	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.086	PUBLISHED	-6992903.375866666	0	\N	b62ac71b-c011-443a-8a24-e10924adb245	253	45	\N
7	banned reply to post	2012-01-11 20:42:28.087	PUBLISHED	-6992903.375844444	0	\N	c34550a9-b928-4b25-8091-ce3d6f4fbef3	254	46	\N
8	muted reply to post	2012-01-11 20:42:28.087	PUBLISHED	-6992903.375844444	0	\N	19ba6d1b-3d4b-4634-8581-a3d764332f22	255	46	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.087	PUBLISHED	-6992903.375844444	0	\N	503780e3-b30f-4bce-9b1a-1cd2f0c12424	256	46	\N
7	banned reply to post	2012-01-11 20:42:28.088	PUBLISHED	-6992903.375822222	0	\N	4e2780b5-83fb-41a6-8e5d-65dd18e26288	257	47	\N
8	muted reply to post	2012-01-11 20:42:28.088	PUBLISHED	-6992903.375822222	0	\N	ab200639-474a-40b7-afc5-85a356d1dca2	258	47	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.088	PUBLISHED	-6992903.375822222	0	\N	75e16555-d000-4292-be98-070bc83c9687	259	47	\N
7	banned reply to post	2012-01-11 20:42:28.089	PUBLISHED	-6992903.3758	0	\N	d67f7e4e-86f4-4e38-863a-53ea591a3777	260	48	\N
8	muted reply to post	2012-01-11 20:42:28.089	PUBLISHED	-6992903.3758	0	\N	90cc61e5-66f3-4aac-a05e-1e33491df640	261	48	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.089	PUBLISHED	-6992903.3758	0	\N	d26b4adb-6f52-4c3c-9224-b9fabcdf5be8	262	48	\N
7	banned reply to post	2012-01-11 20:42:28.091	PUBLISHED	-6992903.375755556	0	\N	80ebd628-8af9-44d5-8ff3-461cd90e7f48	263	49	\N
8	muted reply to post	2012-01-11 20:42:28.091	PUBLISHED	-6992903.375755556	0	\N	136b5a3d-2bb5-4212-aa34-0631d6266790	264	49	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.091	PUBLISHED	-6992903.375755556	0	\N	da36ca1a-fa12-4a92-acba-ea238fe1dade	265	49	\N
7	banned reply to post	2012-01-11 20:42:28.092	PUBLISHED	-6992903.375733334	0	\N	30d1a0a0-e0f1-431a-921c-249e842270fe	266	50	\N
8	muted reply to post	2012-01-11 20:42:28.092	PUBLISHED	-6992903.375733334	0	\N	e49a26be-16c7-48df-a2a6-5c8b7c24a5fd	267	50	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.092	PUBLISHED	-6992903.375733334	0	\N	45bba025-b721-4d01-8c09-256be80145a8	268	50	\N
7	banned reply to post	2012-01-11 20:42:28.094	PUBLISHED	-6992903.375688889	0	\N	161497a9-dc30-4a50-af76-b27dbb0a3cc9	269	51	\N
8	muted reply to post	2012-01-11 20:42:28.094	PUBLISHED	-6992903.375688889	0	\N	f177e214-8ee6-4616-81c0-6c5813364305	270	51	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.094	PUBLISHED	-6992903.375688889	0	\N	a14213b0-1f0c-4e8a-a2ab-b9fec65ed093	271	51	\N
7	banned reply to post	2012-01-11 20:42:28.095	PUBLISHED	-6992903.375666667	0	\N	1b13376e-1c5b-4555-aea5-3107a8ae5319	272	52	\N
8	muted reply to post	2012-01-11 20:42:28.095	PUBLISHED	-6992903.375666667	0	\N	1f6fc44d-e0f9-4ced-b183-5d37148cbb59	273	52	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.095	PUBLISHED	-6992903.375666667	0	\N	bffe0be4-60cd-4c7c-b9d1-a2fb085e69ef	274	52	\N
7	banned reply to post	2012-01-11 20:42:28.097	PUBLISHED	-6992903.375622222	0	\N	7f0a92aa-cf58-47d7-8746-694a12029d86	275	53	\N
8	muted reply to post	2012-01-11 20:42:28.097	PUBLISHED	-6992903.375622222	0	\N	c13f7348-3d74-4960-b64c-66249b46a45c	276	53	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.097	PUBLISHED	-6992903.375622222	0	\N	2665ed30-d0ad-4a6d-8abd-ebc26f6a75b2	277	53	\N
7	banned reply to post	2012-01-11 20:42:28.098	PUBLISHED	-6992903.3756	0	\N	b8fed047-77ba-4e7f-b6dd-6d4742951089	278	54	\N
8	muted reply to post	2012-01-11 20:42:28.098	PUBLISHED	-6992903.3756	0	\N	1fc44b3a-fd32-40d3-a7fb-bec3d9ee1f6b	279	54	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.098	PUBLISHED	-6992903.3756	0	\N	ee43559d-d02e-48d2-807f-7042737b85a7	280	54	\N
7	banned reply to post	2012-01-11 20:42:28.099	PUBLISHED	-6992903.375577778	0	\N	52f6a17a-3c51-4059-bf87-16f52e4426c5	281	55	\N
8	muted reply to post	2012-01-11 20:42:28.099	PUBLISHED	-6992903.375577778	0	\N	0246cf7c-875e-400d-80ce-1ae64dfc59ea	282	55	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.099	PUBLISHED	-6992903.375577778	0	\N	d673afca-f3e3-4dab-8823-079452711418	283	55	\N
7	banned reply to post	2012-01-11 20:42:28.101	PUBLISHED	-6992903.375533333	0	\N	d58f20cf-a677-4ed1-8f55-00d0cdbcf4e2	284	56	\N
8	muted reply to post	2012-01-11 20:42:28.101	PUBLISHED	-6992903.375533333	0	\N	913d4908-e509-4c6f-b8d6-f866cd796bf1	285	56	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.101	PUBLISHED	-6992903.375533333	0	\N	f6382831-ef01-4459-b265-bb7618927b7e	286	56	\N
7	banned reply to post	2012-01-11 20:42:28.102	PUBLISHED	-6992903.375511111	0	\N	517fd959-70be-4a4e-8040-5c821e09d539	287	57	\N
8	muted reply to post	2012-01-11 20:42:28.102	PUBLISHED	-6992903.375511111	0	\N	9241254d-aae7-4a1e-a54d-3df08bba5303	288	57	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.102	PUBLISHED	-6992903.375511111	0	\N	27a99e41-0629-4d64-a39a-8e7bfeccccfb	289	57	\N
7	banned reply to post	2012-01-11 20:42:28.103	PUBLISHED	-6992903.375488888	0	\N	aff6e73d-36fd-47a5-9cd9-0ac18d8348ea	290	58	\N
8	muted reply to post	2012-01-11 20:42:28.103	PUBLISHED	-6992903.375488888	0	\N	9b6c776e-caca-43bb-88cd-84cba46f272b	291	58	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.103	PUBLISHED	-6992903.375488888	0	\N	c03e624e-ca32-482b-9362-49feb61cf25f	292	58	\N
7	banned reply to post	2012-01-11 20:42:28.105	PUBLISHED	-6992903.375444445	0	\N	9fe0dacb-9dd6-4f2c-b813-3d14362c2560	293	59	\N
8	muted reply to post	2012-01-11 20:42:28.105	PUBLISHED	-6992903.375444445	0	\N	f78c1464-75a1-4965-b232-07335d8858ae	294	59	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.105	PUBLISHED	-6992903.375444445	0	\N	461f59ce-e352-47c0-b1d6-bd2c7e30b7de	295	59	\N
7	banned reply to post	2012-01-11 20:42:28.107	PUBLISHED	-6992903.3754	0	\N	5b3634b8-3687-4a56-b6c9-76f881af994b	296	60	\N
8	muted reply to post	2012-01-11 20:42:28.107	PUBLISHED	-6992903.3754	0	\N	b7539fd8-6a3b-4094-8da8-e607a192b84d	297	60	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.107	PUBLISHED	-6992903.3754	0	\N	ecf23ca6-82c6-4e54-853b-d607a1f08821	298	60	\N
7	banned reply to post	2012-01-11 20:42:28.108	PUBLISHED	-6992903.375377778	0	\N	9abff9bb-75e5-4bca-bd8e-31d666c15730	299	61	\N
8	muted reply to post	2012-01-11 20:42:28.108	PUBLISHED	-6992903.375377778	0	\N	8136e49f-be45-4fde-a0f4-246c8dd9cf7e	300	61	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.108	PUBLISHED	-6992903.375377778	0	\N	16cd534e-6589-443d-8275-7ca26a8b5079	301	61	\N
7	banned reply to post	2012-01-11 20:42:28.109	PUBLISHED	-6992903.375355556	0	\N	f29af705-ccc7-4be8-919b-d1b708da4584	302	62	\N
8	muted reply to post	2012-01-11 20:42:28.109	PUBLISHED	-6992903.375355556	0	\N	79464d80-b90c-490b-8631-09098b2130a5	303	62	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.109	PUBLISHED	-6992903.375355556	0	\N	82eccbe4-439f-4ee8-a472-b9ab3384356b	304	62	\N
7	banned reply to post	2012-01-11 20:42:28.111	PUBLISHED	-6992903.375311111	0	\N	618747ab-89ec-4f15-9395-ec15c1a906ed	305	63	\N
8	muted reply to post	2012-01-11 20:42:28.111	PUBLISHED	-6992903.375311111	0	\N	1c159488-2ea2-42bb-af0f-25cb58fdace6	306	63	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.111	PUBLISHED	-6992903.375311111	0	\N	b35a5cb7-ea38-4ad8-9c7e-d31683e2802c	307	63	\N
7	banned reply to post	2012-01-11 20:42:28.112	PUBLISHED	-6992903.375288889	0	\N	dce96f4a-f982-4286-9623-b05250b6bf08	308	64	\N
8	muted reply to post	2012-01-11 20:42:28.112	PUBLISHED	-6992903.375288889	0	\N	fd6263c9-4917-49df-b4cd-5264c1640872	309	64	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.112	PUBLISHED	-6992903.375288889	0	\N	e9af7fd7-6399-47e3-8649-b3d14baa1cee	310	64	\N
7	banned reply to post	2012-01-11 20:42:28.113	PUBLISHED	-6992903.375266667	0	\N	9d85feae-fca0-4d03-96a1-bfa80bfe2e01	311	65	\N
8	muted reply to post	2012-01-11 20:42:28.113	PUBLISHED	-6992903.375266667	0	\N	c3444ebc-93fb-4f42-9f41-25e875040c97	312	65	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.113	PUBLISHED	-6992903.375266667	0	\N	bbc43dff-a9da-49d4-8d75-8b3160742a4c	313	65	\N
7	banned reply to post	2012-01-11 20:42:28.115	PUBLISHED	-6992903.375222222	0	\N	75201516-d01e-45ad-a1bf-04d5ac7ee086	314	66	\N
8	muted reply to post	2012-01-11 20:42:28.115	PUBLISHED	-6992903.375222222	0	\N	0530f0d4-b452-4788-af7f-b629a8de8789	315	66	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.115	PUBLISHED	-6992903.375222222	0	\N	7e2954ad-eb01-4262-97ad-98e639a15a7c	316	66	\N
7	banned reply to post	2012-01-11 20:42:28.116	PUBLISHED	-6992903.3752	0	\N	be7ab15a-d5fc-4d48-bc45-729148f3e170	317	67	\N
8	muted reply to post	2012-01-11 20:42:28.116	PUBLISHED	-6992903.3752	0	\N	2b0e5dca-614b-4433-8610-c5601f408e1e	318	67	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.116	PUBLISHED	-6992903.3752	0	\N	73cd9411-1e81-4341-9947-ab3e1f9a7f51	319	67	\N
7	banned reply to post	2012-01-11 20:42:28.117	PUBLISHED	-6992903.375177777	0	\N	4c5cc5d5-7f3a-4ed1-a71e-630c48875aee	320	68	\N
8	muted reply to post	2012-01-11 20:42:28.117	PUBLISHED	-6992903.375177777	0	\N	40333f42-2e9f-4f40-bd27-b2bb3909cf85	321	68	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.117	PUBLISHED	-6992903.375177777	0	\N	05252bdf-76aa-485a-8e6c-cc240dbffb26	322	68	\N
7	banned reply to post	2012-01-11 20:42:28.119	PUBLISHED	-6992903.375133334	0	\N	ebeba9e2-8058-49f6-b669-21dc2f1d8feb	323	69	\N
8	muted reply to post	2012-01-11 20:42:28.119	PUBLISHED	-6992903.375133334	0	\N	4ccc6e17-cfd5-4d82-bd21-3b3bc62971ee	324	69	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.119	PUBLISHED	-6992903.375133334	0	\N	c0b4e49b-4361-43c9-a296-985eb351380e	325	69	\N
7	banned reply to post	2012-01-11 20:42:28.12	PUBLISHED	-6992903.375111111	0	\N	2fc43156-a111-4efb-ba35-5dfd5c50c4a5	326	70	\N
8	muted reply to post	2012-01-11 20:42:28.12	PUBLISHED	-6992903.375111111	0	\N	51a7c5a9-94a3-400b-be6b-0c3a3cc80f0a	327	70	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.12	PUBLISHED	-6992903.375111111	0	\N	f6fba9f5-963f-4f2b-bbe9-2916ef207d1e	328	70	\N
7	banned reply to post	2012-01-11 20:42:28.122	PUBLISHED	-6992903.375066667	0	\N	b3c9eb68-9d18-49f9-904d-777d97bb85aa	329	71	\N
8	muted reply to post	2012-01-11 20:42:28.122	PUBLISHED	-6992903.375066667	0	\N	1e6fdddc-ec4a-40f7-9e76-f9bfc609099e	330	71	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.122	PUBLISHED	-6992903.375066667	0	\N	c59de9b3-c5ae-4275-ae76-b453bcb9324f	331	71	\N
7	banned reply to post	2012-01-11 20:42:28.123	PUBLISHED	-6992903.375044445	0	\N	6c3ed8e9-31a1-46d4-8737-4095aaeb24d0	332	72	\N
8	muted reply to post	2012-01-11 20:42:28.123	PUBLISHED	-6992903.375044445	0	\N	25bd93f8-9215-4bd8-81db-8c9923ab9fa5	333	72	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.123	PUBLISHED	-6992903.375044445	0	\N	83a5a88f-8db6-4f9a-8b55-57a7b68fee0b	334	72	\N
7	banned reply to post	2012-01-11 20:42:28.125	PUBLISHED	-6992903.375	0	\N	da0fea90-697d-4ec0-bd9c-ead7a8a80e1c	335	73	\N
8	muted reply to post	2012-01-11 20:42:28.125	PUBLISHED	-6992903.375	0	\N	fdd6a651-1ef8-438c-bf5d-2e0e6e8f99d6	336	73	\N
10	I blocked you and replied to your post	2012-01-11 20:42:28.125	PUBLISHED	-6992903.375	0	\N	bded0c4d-c8a9-4015-8953-11087a583431	337	73	\N
6	This is a fun video.\n\nVideo by KoolShooters: https://www.pexels.com/video/a-young-an-squeezing-an-orange-6975806	2024-01-08 20:42:27.911	WITHDRAWN	0	0	\N	b57d71dd-3e44-4c5f-a95b-3cc83cce1f24	17	\N	\N
2	<p>a paragraph in html</p>	2024-01-08 20:51:58.278	PUBLISHED	1416709.295	1	\N	3079c867-f9b8-4b10-b39f-9aaf77a3debe	338	\N	\N
2	/s/dog	2024-01-08 20:52:10.444	PUBLISHED	1416709.5654	1	\N	88b1c97c-335b-455b-a3a1-7da8d81eada9	339	\N	\N
\.


--
-- Data for Name: PostAward; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."PostAward" (id, "userId", "coinId", private, "createdAt", "postId") FROM stdin;
1	6	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	f	2024-01-08 20:42:27.901	13
2	6	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	f	2024-01-08 20:42:27.901	13
3	6	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	f	2024-01-08 20:42:27.901	13
4	6	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	f	2024-01-08 20:42:27.901	13
5	6	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	f	2024-01-08 20:42:27.901	13
6	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2024-01-08 20:42:27.901	13
7	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2024-01-08 20:42:27.901	13
8	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2024-01-08 20:42:27.901	13
9	6	price_1MGu3qDS6lFTllE6h6YgMmQl	f	2024-01-08 20:42:27.901	13
10	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2024-01-08 20:42:27.901	13
11	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2024-01-08 20:42:27.901	13
12	6	price_1MartCDS6lFTllE6fFgyZvxI	f	2024-01-08 20:42:27.901	13
13	6	price_1MarsIDS6lFTllE6SnBpfVkO	f	2024-01-08 20:42:27.901	13
14	6	price_1MarsIDS6lFTllE6SnBpfVkO	f	2024-01-08 20:42:27.901	13
15	6	price_1MLvQ8DS6lFTllE6BCNkQkSh	f	2024-01-08 20:42:27.901	13
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
1	2024-01-08 20:42:27.797	f	APPROVED	https://en.wikipedia.org/wiki/History	19	2	1
2	2024-01-08 20:42:27.866	f	APPROVED	\N	20	2	2
3	2024-01-08 20:42:27.866	f	APPROVED	\N	4	2	2
4	2024-01-08 20:42:27.868	f	APPROVED	\N	20	2	3
5	2024-01-08 20:42:27.868	f	APPROVED	\N	19	2	3
6	2024-01-08 20:42:27.87	f	APPROVED	\N	20	2	4
7	2024-01-08 20:42:27.87	f	APPROVED	\N	21	2	4
8	2024-01-08 20:42:27.872	f	APPROVED	\N	20	2	5
9	2024-01-08 20:42:27.872	f	APPROVED	\N	33	2	5
10	2024-01-08 20:42:27.873	f	APPROVED	\N	34	2	6
11	2024-01-08 20:42:27.875	f	APPROVED	\N	3	2	7
12	2024-01-08 20:42:27.894	f	APPROVED	\N	39	6	11
13	2024-01-08 20:42:27.894	f	APPROVED	\N	40	6	11
14	2024-01-08 20:42:27.896	f	APPROVED	\N	39	6	12
15	2024-01-08 20:42:27.896	f	APPROVED	\N	40	6	12
16	2024-01-08 20:42:27.912	f	APPROVED	\N	6	6	18
17	2024-01-08 20:49:45.557	f	APPROVED	\N	6	2	7
18	2024-01-08 20:51:04.621	f	APPROVED	\N	4	2	67
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
1	92fba5d2-e92c-4cf9-b084-f1ee21520025	2024-01-08 20:42:27.901	13
2	9f392100-f825-48a4-ac4d-0a09e545f1e9	2024-01-08 20:42:27.901	13
3	d224cb0d-e582-4519-9edd-ee93ecb2ca9a	2024-01-08 20:42:27.901	13
4	1a8e553d-9631-4a80-8b0c-1ea86e6a4ce9	2024-01-08 20:42:27.901	13
5	a571b9d9-6658-4142-b7ca-63629ca8f57e	2024-01-08 20:42:27.901	13
6	f22f6e00-e5dd-4e8f-a725-5ebd8424e523	2024-01-08 20:42:27.901	13
7	92fba5d2-e92c-4cf9-b084-f1ee21520025	2024-01-08 20:42:27.908	14
8	9f392100-f825-48a4-ac4d-0a09e545f1e9	2024-01-08 20:42:27.909	15
9	d224cb0d-e582-4519-9edd-ee93ecb2ca9a	2024-01-08 20:42:27.91	16
10	9dc992d3-3d59-439b-8f84-35f974d208a6	2024-01-08 20:42:27.911	17
11	5da6759f-6d2c-4757-8a11-dcc5bb575afb	2024-01-08 20:42:27.912	18
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Product" (id, active, "createdAt", "updatedAt", "saleTitle", price, type, "appStoreProductId", "playStoreProductId", "spaceId", "originalDisplayPrice") FROM stdin;
price_1MeotEDS6lFTllE61URh48EH	t	2024-01-08 20:42:27.83	2024-01-08 20:42:27.83	1 Month Premium + 200 Coins 20% off	800	MONTHLY_SUBSCRIPTION	\N	\N	4	\N
price_1MGu0TDS6lFTllE6BqybwcsE	t	2024-01-08 20:42:27.833	2024-01-08 20:42:27.833	Premium for Life %50 off + 2,000 Coins	10000	LIFETIME_PREMIUM	\N	\N	4	\N
price_1MMEzsDS6lFTllE6GjjrtD9W	f	2024-01-08 20:42:27.834	2024-01-08 20:42:27.834	Premium for Life %25 off + 3,000 Coins	15000	LIFETIME_PREMIUM	\N	\N	4	\N
price_1MMF3RDS6lFTllE6cgK0xec7	f	2024-01-08 20:42:27.836	2024-01-08 20:42:27.836	Premium for Life + 4,000 Coins	20000	LIFETIME_PREMIUM	\N	\N	4	\N
c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	t	2024-01-08 20:42:27.837	2024-01-08 20:42:27.837	10 Coins = 1 Bronze token	10	COIN	\N	\N	1	\N
price_1MGu3qDS6lFTllE6h6YgMmQl	t	2024-01-08 20:42:27.838	2024-01-08 20:42:27.838	Silver Package gets 200 Coins and 7 days of premium	200	COIN	\N	\N	1	\N
price_1MartCDS6lFTllE6fFgyZvxI	t	2024-01-08 20:42:27.84	2024-01-08 20:42:27.84	Gold Package gets 1,000 Coins and 31 days of premium for 5% off	950	COIN	\N	\N	1	\N
price_1MarsIDS6lFTllE6SnBpfVkO	t	2024-01-08 20:42:27.841	2024-01-08 20:42:27.841	Platinum package gets 5,000 Coins and 183 days of premium for 10% off	4500	COIN	\N	\N	1	\N
price_1MLvQ8DS6lFTllE6BCNkQkSh	t	2024-01-08 20:42:27.842	2024-01-08 20:42:27.842	Diamond Package gets 25,000 Coins and 2 years of premium for 15% off	21250	COIN	\N	\N	1	\N
donation	t	2024-01-08 20:42:27.917	2024-01-08 20:42:27.917	Donation to Factiii	0	DONATION	\N	\N	1	\N
\.


--
-- Data for Name: Report; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Report" (id, type, "ruleId", comment, status, "reportedUploadId", "reportedBio", "conversationId", public, "createdAt", "updatedAt", "userId", "actionTakenById", "reportedPostId", "reportedUserId", "reportedSpaceId") FROM stdin;
cfe09eae-2817-4f27-a273-8482e0bd2a3b	POST	1	this post is garbage	CONTENT_REMOVED	\N	\N	\N	f	2024-01-08 20:42:27.883	2024-01-08 20:42:27.883	2	\N	8	\N	\N
5e5c3431-0c49-4bfb-936e-572fe6cf6680	POST	1	hateful cnut	CONTENT_REMOVED	\N	\N	\N	f	2024-01-08 20:47:25.098	2024-01-08 20:47:30.62	2	2	17	\N	\N
a739482c-d241-45ed-8a2c-9b33078f0413	FACTIII	10	nsfw	PENDING	\N	\N	\N	f	2024-01-08 20:49:45.554	2024-01-08 20:49:45.554	2	\N	7	\N	\N
229ee549-dc32-478b-bd9c-d0f561daa6e0	FACTIII	11	Politics	PENDING	\N	\N	\N	f	2024-01-08 20:51:04.612	2024-01-08 20:51:04.612	2	\N	67	\N	\N
\.


--
-- Data for Name: Rule; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Rule" (id, title, description, "createdAt", "spaceId", edited, "factiiiId") FROM stdin;
1	No Hate	We do not tolerate content that expresses, incites, or promotes hate based on identity.	2024-01-08 20:42:27.761	1	f	\N
2	No Illegal Content	We do not allow content that violates any laws, trademarks, or copyrights.	2024-01-08 20:42:27.761	1	f	\N
3	Respect Others	Please keep your content respectful. We may not agree on everything, but as fellow humans, we should strive to respect each other.	2024-01-08 20:42:27.761	1	f	\N
4	No Deceptive Content	We do not allow content that is intentionally misleading or spreading false information. Parody is allowed, but impersonation is not.	2024-01-08 20:42:27.761	1	f	\N
5	No Harassment or Trolling	We do not tolerate content that is harassing or trolling.	2024-01-08 20:42:27.761	1	f	\N
6	No Name Trolling	We reserve the right to transfer account Space and User names to new owners. This will be done in a transparent and open manner.	2024-01-08 20:42:27.761	1	f	\N
7	No Violence	We do not allow content that encourages violence against others.	2024-01-08 20:42:27.761	1	f	\N
8	No Self-Harm	We do not allow content that promotes, encourages, or depicts acts of self-harm.	2024-01-08 20:42:27.761	1	f	\N
9	Political Content Discouraged	While political content is allowed, it is not encouraged. The default site filter deboosts political content. Please keep political discussion in s/politics.	2024-01-08 20:42:27.761	1	f	\N
10	nsfw	nsfw rule	2024-01-08 20:42:27.806	\N	f	6
11	Politics	Politics rule	2024-01-08 20:42:27.808	\N	f	4
12	No Hate	Content that expresses, incites, or promotes hate based on identity	2024-01-08 20:42:27.848	12	f	\N
13	No Harassment	Content that intends to harass, threaten, or bully an individual	2024-01-08 20:42:27.848	12	f	\N
14	No Violence	Content that promotes or glorifies violence or celebrates the suffering or humiliation of others	2024-01-08 20:42:27.848	12	f	\N
15	No Self-harm	Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders	2024-01-08 20:42:27.848	12	f	\N
16	No Sexual Material	Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness)	2024-01-08 20:42:27.848	12	f	\N
17	No Political Manipulation	Content attempting to influence the political process or to be used for campaigning purposes	2024-01-08 20:42:27.848	12	f	\N
18	No Spam	Unsolicited bulk content	2024-01-08 20:42:27.848	12	f	\N
19	No Deception	Content that is false or misleading, such as attempting to defraud individuals or spread disinformation	2024-01-08 20:42:27.848	12	f	\N
20	No Malware	Content that attempts to generate ransomware, keyloggers, viruses, or other software intended to impose some level of harm	2024-01-08 20:42:27.848	12	f	\N
21	Illegal or harmful industries	Includes gambling, payday lending, illegal substances, pseudo-pharmaceuticals, multi-level marketing, weapons development, warfare, cybercrime, adult industries, spam, and non-consensual surveillance.	2024-01-08 20:42:27.848	12	f	\N
22	Misuse of personal data	Includes classifying people based on protected characteristics, mining sensitive information without appropriate consent, products that claim to accurately predict behavior based on dubious evidence.	2024-01-08 20:42:27.848	12	f	\N
23	Promoting dishonesty	Includes testimonial generation, product or service review generation, educational dishonesty, contract cheating, astroturfing.	2024-01-08 20:42:27.848	12	f	\N
24	Deceiving or manipulating users	Includes automated phone calls that sound human, a romantic chatbot that emotionally manipulates end-users, automated systems (including conversational AI and chatbots) that don’t disclose that they are an AI system, or products that simulate another person without their explicit consent.	2024-01-08 20:42:27.848	12	f	\N
25	Trying to influence politics	Includes generating political fundraising emails, or classifying people in order to deliver targeted political messages.	2024-01-08 20:42:27.848	12	f	\N
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
1	f670ce1e-bcca-4e99-a1f8-fbd0cbc122b8	2024-01-08 20:42:35.79	Unknown	2024-01-08 20:42:35.79	2	\N
2	52237a47-456c-46e4-ace3-1f48378a7a89	2024-01-08 20:42:35.852	Unknown	2024-01-08 20:42:35.852	2	\N
3	7c1be607-94ea-4226-9b54-8a5d5d75b88c	2024-01-08 20:42:35.923	Unknown	2024-01-08 20:42:35.923	6	\N
4	6ce5c4f3-91ef-4ea8-860a-d83474e3208e	2024-01-08 20:42:35.956	Unknown	2024-01-08 20:42:35.956	6	\N
5	173bdfd1-dc93-4f5b-9523-29f7ae0d2538	2024-01-08 20:43:03.987	Unknown	2024-01-08 20:43:03.987	2	\N
6	d1764000-f9dc-4967-a8df-e3d95b758aa3	2024-01-08 20:43:04.004	Unknown	2024-01-08 20:43:04.004	2	\N
7	ad581cd8-7f6a-476c-b880-979188056fef	2024-01-08 20:43:04.044	Unknown	2024-01-08 20:43:04.044	2	\N
8	11c63049-822a-493a-8739-babcf0b10a93	2024-01-08 20:43:04.044	Unknown	2024-01-08 20:43:04.044	2	\N
9	c33ab9a1-5c3f-4076-9e4e-d5cd1a8277cb	2024-01-08 20:43:04.075	Unknown	2024-01-08 20:43:04.075	6	\N
10	9616dae6-c52d-4fea-b7c2-948c114b2f92	2024-01-08 20:43:04.113	Unknown	2024-01-08 20:43:04.113	6	\N
11	fe54ee48-3ae8-4414-b2b4-1c0aff63b81a	2024-01-08 20:43:04.113	Unknown	2024-01-08 20:43:04.113	6	\N
12	fc911394-4857-4b92-8dae-d6baefc3fcfb	2024-01-08 20:43:04.179	Unknown	2024-01-08 20:43:04.179	6	\N
13	14bb71a9-2ccc-4a70-9b2c-28e67e8ada71	2024-01-08 20:47:14.635	Firefox	2024-01-08 20:47:14.635	2	\N
15	c26cbc14-ca5f-4eb2-84e5-2f76778d7ca3	2024-01-08 20:55:22.147	Unknown	2024-01-08 20:55:22.147	2	\N
14	3e68db70-7a6c-4335-8fb2-06730732d1be	2024-01-08 20:55:22.147	Unknown	2024-01-08 20:55:22.147	2	\N
16	2f0ed9b7-917a-4676-8bb8-9c95f82e93d9	2024-01-08 20:55:22.15	Unknown	2024-01-08 20:55:22.15	2	\N
17	b2ff19ea-e68e-4910-b96b-d647384e5136	2024-01-08 20:55:22.175	Unknown	2024-01-08 20:55:22.175	2	\N
19	4b5efd6f-8546-4e57-804a-d60fdd477448	2024-01-08 20:55:22.217	Unknown	2024-01-08 20:55:22.217	6	\N
18	18af9419-fb6c-447c-83c8-9ad610c62af8	2024-01-08 20:55:22.217	Unknown	2024-01-08 20:55:22.217	6	\N
20	1e719794-934c-4b78-82b9-7e10f98d889c	2024-01-08 20:55:22.218	Unknown	2024-01-08 20:55:22.218	6	\N
21	a1564aea-e5d9-4c93-815e-c903d808bcb8	2024-01-08 20:55:22.333	Unknown	2024-01-08 20:55:22.333	6	\N
\.


--
-- Data for Name: SiteSettings; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SiteSettings" (id, "createdAt", "coinTronRatio", "coinTransferRatio", "requestRateLimit", "postsPerMinute", "maxSpacesPerUser", "openAiLimitPerHourPerUser", "openAiLimitPremiumUser") FROM stdin;
1	2024-01-08 20:42:27.733	3000	5	50	30	10	30	100
\.


--
-- Data for Name: Space; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Space" (id, slug, name, description, "avatarId", "bannerId", robohash, "createdAt", "updatedAt", status, "paidSpaceMonthlyPrice", "pinnedPostId", types) FROM stdin;
2	wikipedia	Wikipedia	Welcome to the unofficial Wikipedia Page!	\N	\N	a475fdbe-28cf-4ee1-b7f8-cd8ffb694078	2024-01-08 20:42:27.793	2024-01-08 20:42:27.793	ACTIVE	99	\N	{}
3	founders	founders	Welcome to founders! A place for founding members to hang out and share requests. This is only open to those who buy founders tokens	2194c7d9-da0a-4999-a41c-e4fc9f5716ef	d63908e6-ed18-490d-85b8-3ec4b06b0847	bcecf155-4900-4f34-95b4-aee0a7f22ab8	2024-01-08 20:42:27.819	2024-01-08 20:42:27.821	ACTIVE	99	\N	{PREMIUM}
4	premium	premium	Welcome to premium! A place for premium members to hang out and share requests. This is only open to those with active premium subscriptions.	de73fdac-e3df-4294-885f-b261407b5044	9ed1cb39-a806-4741-94d5-81f24d151b79	478e94f6-8cd8-42d7-9ffa-396b81fa48db	2024-01-08 20:42:27.822	2024-01-08 20:42:27.824	ACTIVE	99	\N	{PREMIUM}
1	factiii	factiii	Welcome to factiii. This is a place to discuss anything you like with an emphasis on factiii and how we can improve. Hope you all enjoy it here!	31dc67b6-2f8f-4cdb-b08c-41c5e3b801f4	85e47376-d5d1-4843-8f91-2260d34f07f7	9ac3e934-9b48-4d3d-926f-824494c87471	2024-01-08 20:42:27.761	2024-01-08 20:42:27.826	ACTIVE	99	\N	{}
5	about	about	Welcome to our about page. Here you can see our blog as well as learn about our Mission. Feel free to engage with us in s/factiii.	cc3b7c45-3889-48e4-9310-76cc930244cb	2319916d-8c65-4459-9a2a-f29d036c8a44	fa6cd9e9-d0fa-4340-89f7-f8f03a6325d9	2024-01-08 20:42:27.826	2024-01-08 20:42:27.829	ACTIVE	99	\N	{}
6	science	science	A place to talk about everything science!	\N	\N	d197adb1-6720-438f-863c-34119a3071bf	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
7	history	history	A place to discuss History!	\N	\N	be05b7dc-aad2-4a25-b10c-e2723cf2834c	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
8	pics	pics	A place to post fun pictures!	\N	\N	8ef44441-213e-49b9-a473-2c96831c0521	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
9	videos	videos	A place to post fun videos!	\N	\N	dfefe210-92d8-40d9-a033-92ecef33b1c7	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
10	news	news	A place to post world leading News!	\N	\N	c64e7b8b-e2c7-481c-b129-d4ca5424e82c	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
11	announcements	announcements	A place factiii uses to share announcements.	\N	\N	2568cad7-4921-4414-a056-86aadf2fc263	2024-01-08 20:42:27.843	2024-01-08 20:42:27.843	ACTIVE	99	\N	{}
12	openai	OpenAI	Get answers to every single question you have, powered by GPT-3. Not the official OpenAI account.	5f138fc3-2d0e-4c5a-96bd-76f8e43c8169	5e8dd406-2f95-4780-8b33-0fb4e17c619d	1ed3f00d-90e0-4c97-850a-271195b17923	2024-01-08 20:42:27.848	2024-01-08 20:42:27.853	ACTIVE	99	\N	{}
13	paid	paid	This is a test private paid space. Janice is not invited so we can do tests to see if she can see it.	40b09bf0-a90d-42d0-b88d-299ee0e14b2e	31d2178c-8fa5-4798-a971-1a072b9d91bd	12c6777d-aa02-42ea-98d7-252f1d56d656	2024-01-08 20:42:27.886	2024-01-08 20:42:27.889	ACTIVE	99	\N	{PRIVATE,PAID}
14	private-test	Private Test	This is a test private space. If you see me then something is broken. Janice loves this secret place.	\N	\N	fd38493c-f897-4f8c-972d-4902c1ff6975	2024-01-08 20:42:27.89	2024-01-08 20:42:27.89	ACTIVE	99	\N	{PRIVATE}
15	private-factiii	Private Factiii	This is a test private space. Janice is the owner and it holds private factiiis.	\N	\N	34715474-d5f9-4899-a1ac-65763468340b	2024-01-08 20:42:27.891	2024-01-08 20:42:27.891	ACTIVE	99	\N	{PRIVATE}
\.


--
-- Data for Name: SpaceFilter; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."SpaceFilter" ("spaceId", "userId", "createdAt") FROM stdin;
1	2	2024-01-08 20:42:27.761
1	3	2024-01-08 20:42:27.761
1	1	2024-01-08 20:42:27.761
1	6	2024-01-08 20:42:27.882
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
2024-01-08 20:42:27.761	\N	2	1	\N	\N	{OWNER}
2024-01-08 20:42:27.761	\N	3	1	\N	\N	{OWNER}
2024-01-08 20:42:27.761	\N	1	1	\N	\N	{MODERATOR}
2024-01-08 20:42:27.793	\N	2	2	\N	\N	{OWNER}
2024-01-08 20:42:27.793	\N	4	2	\N	\N	{OWNER}
2024-01-08 20:42:27.819	\N	2	3	\N	\N	{OWNER}
2024-01-08 20:42:27.819	\N	3	3	\N	\N	{OWNER}
2024-01-08 20:42:27.822	\N	2	4	\N	\N	{OWNER}
2024-01-08 20:42:27.822	\N	3	4	\N	\N	{OWNER}
2024-01-08 20:42:27.826	\N	2	5	\N	\N	{OWNER}
2024-01-08 20:42:27.826	\N	3	5	\N	\N	{OWNER}
2024-01-08 20:42:27.826	\N	1	5	\N	\N	{MODERATOR}
2024-01-08 20:42:27.848	\N	5	12	\N	\N	{OWNER}
2024-01-08 20:42:27.848	\N	2	12	\N	\N	{MODERATOR}
2024-01-08 20:42:27.848	\N	3	12	\N	\N	{MODERATOR}
2024-01-08 20:42:27.886	1969-12-31 23:59:57.975	2	13	\N	\N	{OWNER}
2024-01-08 20:42:27.886	1969-12-31 23:59:57.975	3	13	\N	\N	{OWNER}
2024-01-08 20:42:27.89	\N	6	14	\N	\N	{MEMBER}
2024-01-08 20:42:27.891	\N	6	15	\N	\N	{OWNER}
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
a5d7ae38-f706-4ac6-82d2-4d31b65e18b3	PUBLISHED	2024-01-08 20:42:27.777	2	static/tagFunny.jpg	IMAGE	\N	\N	\N
e9cedbb7-5332-452f-bde7-88e573aa4fec	PUBLISHED	2024-01-08 20:42:27.78	2	static/tagInformative.jpg	IMAGE	\N	\N	\N
d67f9dc0-ea30-4b3e-ac1a-f9ed4d6e31bc	PUBLISHED	2024-01-08 20:42:27.781	2	static/tagTroll.jpg	IMAGE	\N	\N	\N
8e36cb06-41f4-4795-924f-25d177796bcd	PUBLISHED	2024-01-08 20:42:27.782	2	static/tagPolitics.jpg	IMAGE	\N	\N	\N
378d4ed9-f63f-4cb3-933d-aa6a3142cb41	PUBLISHED	2024-01-08 20:42:27.783	2	static/tagMisleading.jpg	IMAGE	\N	\N	\N
ffccd04c-4903-4918-8987-bd9c9bda0a86	PUBLISHED	2024-01-08 20:42:27.783	2	static/tagNSFW.jpg	IMAGE	\N	\N	\N
9e73eada-0a16-4f34-9baf-6918e63aa086	PUBLISHED	2024-01-08 20:42:27.814	2	static/jonAvatar.jpg	IMAGE	\N	\N	\N
b4e6e037-8a43-4ae7-98a4-2af0397febb6	PUBLISHED	2024-01-08 20:42:27.815	2	static/jonBanner.jpg	IMAGE	\N	\N	\N
e8a9e102-2f54-48ca-9d52-b1e9282e88af	PUBLISHED	2024-01-08 20:42:27.816	3	static/parikAvatar.jpg	IMAGE	\N	\N	\N
f6b14962-9a19-4735-8b0c-4751f68371a2	PUBLISHED	2024-01-08 20:42:27.817	3	static/parikBanner.jpg	IMAGE	\N	\N	\N
af35273a-b7bc-47c8-b5f6-35aa802c72d6	PUBLISHED	2024-01-08 20:42:27.818	1	static/nataliiaAvatar.jpg	IMAGE	\N	\N	\N
be76b37a-b894-419a-8d38-b6ddf713e1b0	PUBLISHED	2024-01-08 20:42:27.818	1	static/nataliiaBanner.jpg	IMAGE	\N	\N	\N
2194c7d9-da0a-4999-a41c-e4fc9f5716ef	PUBLISHED	2024-01-08 20:42:27.821	2	static/foundersAvatar.jpg	IMAGE	\N	\N	\N
d63908e6-ed18-490d-85b8-3ec4b06b0847	PUBLISHED	2024-01-08 20:42:27.821	2	static/foundersBanner.jpg	IMAGE	\N	\N	\N
de73fdac-e3df-4294-885f-b261407b5044	PUBLISHED	2024-01-08 20:42:27.824	2	static/premiumAvatar.jpg	IMAGE	\N	\N	\N
9ed1cb39-a806-4741-94d5-81f24d151b79	PUBLISHED	2024-01-08 20:42:27.824	2	static/premiumBanner.jpg	IMAGE	\N	\N	\N
31dc67b6-2f8f-4cdb-b08c-41c5e3b801f4	PUBLISHED	2024-01-08 20:42:27.825	2	static/factiiiAvatar.jpg	IMAGE	\N	\N	\N
85e47376-d5d1-4843-8f91-2260d34f07f7	PUBLISHED	2024-01-08 20:42:27.825	2	static/factiiiBanner.jpg	IMAGE	\N	\N	\N
cc3b7c45-3889-48e4-9310-76cc930244cb	PUBLISHED	2024-01-08 20:42:27.828	2	static/aboutAvatar.jpg	IMAGE	\N	\N	\N
2319916d-8c65-4459-9a2a-f29d036c8a44	PUBLISHED	2024-01-08 20:42:27.828	2	static/aboutBanner.jpg	IMAGE	\N	\N	\N
9f009591-0362-476d-bcfa-0cff1f080245	PUBLISHED	2024-01-08 20:42:27.83	2	static/premium-icon.svg	IMAGE	price_1MeotEDS6lFTllE61URh48EH	\N	\N
2f446840-457a-495b-a60a-3b3ce7a297ef	PUBLISHED	2024-01-08 20:42:27.833	2	static/premium-icon.svg	IMAGE	price_1MGu0TDS6lFTllE6BqybwcsE	\N	\N
c0a71f97-fe0d-4bda-b0f8-36db7bb8a7bd	PUBLISHED	2024-01-08 20:42:27.834	2	static/premium-icon.svg	IMAGE	price_1MMEzsDS6lFTllE6GjjrtD9W	\N	\N
de4b7ed4-31da-4d6c-8e70-8eb7efe2ac87	PUBLISHED	2024-01-08 20:42:27.836	2	static/premium-icon.svg	IMAGE	price_1MMF3RDS6lFTllE6cgK0xec7	\N	\N
8c63ed2d-3ff6-40a6-befd-5257535844b1	PUBLISHED	2024-01-08 20:42:27.837	2	static/bronze.gif	IMAGE	c84d398f-6a88-44d9-9e0d-5de3cc8acc9a	\N	\N
ddc64827-05e8-481c-9b50-d9f20fe8e251	PUBLISHED	2024-01-08 20:42:27.838	2	static/silver.gif	IMAGE	price_1MGu3qDS6lFTllE6h6YgMmQl	\N	\N
d2065305-d88c-4f0a-8d98-ac3ad7830fec	PUBLISHED	2024-01-08 20:42:27.84	2	static/gold.gif	IMAGE	price_1MartCDS6lFTllE6fFgyZvxI	\N	\N
4ad8890c-6de5-4805-ac2a-9f744cd14a68	PUBLISHED	2024-01-08 20:42:27.841	2	static/platinum.gif	IMAGE	price_1MarsIDS6lFTllE6SnBpfVkO	\N	\N
bf6f9472-b916-42d1-a29d-acdec2c1fb98	PUBLISHED	2024-01-08 20:42:27.842	2	static/diamond.gif	IMAGE	price_1MLvQ8DS6lFTllE6BCNkQkSh	\N	\N
5f138fc3-2d0e-4c5a-96bd-76f8e43c8169	PUBLISHED	2024-01-08 20:42:27.851	5	static/openai-logo.jpg	IMAGE	\N	\N	\N
5e8dd406-2f95-4780-8b33-0fb4e17c619d	PUBLISHED	2024-01-08 20:42:27.852	5	static/openai-banner.png	IMAGE	\N	\N	\N
40b09bf0-a90d-42d0-b88d-299ee0e14b2e	PUBLISHED	2024-01-08 20:42:27.888	6	static/paidAvatar.svg	IMAGE	\N	\N	\N
31d2178c-8fa5-4798-a971-1a072b9d91bd	PUBLISHED	2024-01-08 20:42:27.889	6	static/paidBanner.svg	IMAGE	\N	\N	\N
92fba5d2-e92c-4cf9-b084-f1ee21520025	PUBLISHED	2024-01-08 20:42:27.897	6	static/test1.jpg	IMAGE	\N	\N	\N
9f392100-f825-48a4-ac4d-0a09e545f1e9	PUBLISHED	2024-01-08 20:42:27.898	6	static/test2.jpg	IMAGE	\N	\N	\N
d224cb0d-e582-4519-9edd-ee93ecb2ca9a	PUBLISHED	2024-01-08 20:42:27.898	6	static/test3.jpg	IMAGE	\N	\N	\N
1a8e553d-9631-4a80-8b0c-1ea86e6a4ce9	PUBLISHED	2024-01-08 20:42:27.898	6	static/test4.gif	IMAGE	\N	\N	\N
a571b9d9-6658-4142-b7ca-63629ca8f57e	PUBLISHED	2024-01-08 20:42:27.899	6	static/test5.gif	IMAGE	\N	\N	\N
f22f6e00-e5dd-4e8f-a725-5ebd8424e523	PUBLISHED	2024-01-08 20:42:27.899	6	static/test6.jpg	IMAGE	\N	\N	\N
9dc992d3-3d59-439b-8f84-35f974d208a6	PUBLISHED	2024-01-08 20:42:27.9	6	static/test7.mp4	VIDEO	\N	\N	\N
5da6759f-6d2c-4757-8a11-dcc5bb575afb	PUBLISHED	2024-01-08 20:42:27.9	6	static/test8.jpg	IMAGE	\N	\N	\N
a31fc7c6-25a7-4629-8112-99c695a99848	PUBLISHED	2024-01-08 20:42:27.913	6	static/janiceAvatar.jpg	IMAGE	\N	\N	\N
4d249288-d849-420f-9ec0-30cfb2fa60ce	PUBLISHED	2024-01-08 20:42:27.914	6	static/janiceBanner.jpg	IMAGE	\N	\N	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."User" (id, status, "tronsBalance", "coinsBalance", "createdAt", email, password, username, name, bio, "avatarId", "bannerId", "twoFaSecret", "referredById", robohash, tag, "pinnedPostId", types, read) FROM stdin;
4	ACTIVE	0	0	2024-01-08 20:42:27.791	parikshith8040@gmail.com	$2b$10$9BonSswdP4/T0YZvbiqHhekYSR66NuFy65nPnlW6XGqNVDNdxGdeS	wikipedia	Wikipedia	Unofficial Wikipedia account	\N	\N	\N	\N	2b87873a-6850-4292-a162-d780cd72c186	BOT	\N	{}	f
2	ACTIVE	0	0	2024-01-08 20:42:27.756	jsnyder@factiii.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	jon	Jonathan Snyder	Active duty Air Force. Full time parent. Part time programmer and science fanatic.	9e73eada-0a16-4f34-9baf-6918e63aa086	b4e6e037-8a43-4ae7-98a4-2af0397febb6	\N	\N	777d20ea-eea1-4c37-8d26-75f15e682022	NEW	\N	{}	f
3	ACTIVE	0	0	2024-01-08 20:42:27.758	parik36@icloud.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	parik	Parik	Factiii's #1 developer.	e8a9e102-2f54-48ca-9d52-b1e9282e88af	f6b14962-9a19-4735-8b0c-4751f68371a2	\N	\N	4f710552-37bb-4675-8673-07c61f024934	NEW	\N	{}	f
1	ACTIVE	0	0	2024-01-08 20:42:27.74	nasnyder10@gmail.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	nataliia	Nataliia Snyder	Factiii's #1 user.	af35273a-b7bc-47c8-b5f6-35aa802c72d6	be76b37a-b894-419a-8d38-b6ddf713e1b0	\N	\N	b79c985a-10af-426a-bac4-889f6cd97ec2	NEW	\N	{}	f
5	ACTIVE	0	0	2024-01-08 20:42:27.845	openaiBot@factiii.com	AHDJHSJCGHJSFCGSHJFCGH*&#$*&_#HSGFH	openai	OpenAI	Get answers to every single question you have, powered by GPT-3. This space is not managed or endorsed by OpenAI.	5f138fc3-2d0e-4c5a-96bd-76f8e43c8169	5e8dd406-2f95-4780-8b33-0fb4e17c619d	\N	\N	db1d130d-f7ef-4b8f-b2ad-584b39821280	BOT	\N	{}	f
7	ACTIVE	0	0	2024-01-08 20:42:27.855	banned@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	banned	I am banned from everywhere	I am a test user! I have 1 post in every space and I am banned from every space	\N	\N	\N	\N	ce94e55d-0aab-47a4-903f-aa32bc14df1c	NEW	\N	{}	f
8	ACTIVE	0	0	2024-01-08 20:42:27.856	muted@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	muted	I am muted by everyone	I am a test user! I have 1 post in every space and I am muted by every one	\N	\N	\N	\N	b2f469dd-5db6-497a-91dc-c53161283d2c	NEW	\N	{}	f
9	ACTIVE	0	0	2024-01-08 20:42:27.858	blocked@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	blocked	I am blocked by everyone	I am a test user! I have 1 post in every space and I am blocked by every one	\N	\N	\N	\N	c4734664-7e20-4cbc-8f9a-2ed887d2a090	NEW	\N	{}	f
10	ACTIVE	0	0	2024-01-08 20:42:27.859	blockAll@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	blockAll	I blocked everyone	I am a test user! I have 1 post in every space and I blocked every one	\N	\N	\N	\N	fc856287-6d33-47d0-8e3c-61b9f80a7810	NEW	\N	{}	f
11	ACTIVE	0	0	2024-01-08 20:42:27.876	private@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	private	Private User	I am a test Private user!	\N	\N	\N	\N	58cbaaac-5098-4656-b855-f9ca79d32946	NEW	\N	{}	f
12	ACTIVE	0	0	2024-01-08 20:42:27.877	privateUserFollowsJonParik@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	privateUserFollowsJonParik	Private User follows Jon and Parik	I am a test Private user that follows Jon and Parik!	\N	\N	\N	\N	fc86df7f-c22a-4c8d-b5ae-82443b6b4869	NEW	\N	{PRIVATE}	f
13	ACTIVE	0	0	2024-01-08 20:42:27.88	privateUserFollowedByJonParik@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	privateUserFollowedByJonParik	Private User followed by Jon and Parik	I am a test Private user that is followed by Jon and Parik!	\N	\N	\N	\N	ef204415-199b-44d1-9ef2-715dd4f65ae5	NEW	\N	{PRIVATE}	f
6	ACTIVE	0	0	2024-01-08 20:42:27.854	janice123@yahoot.com	$2b$10$Q4oF8y8x/2RivokaVcxllO6KGv8313NQaW98JC5wTTkC4ebpjzxbG	janice78	Janice Bogan PhD	I am a test user!	a31fc7c6-25a7-4629-8112-99c695a99848	4d249288-d849-420f-9ec0-30cfb2fa60ce	\N	\N	79d0c560-4caf-4849-80fa-08d528ef3b17	NEW	\N	{}	f
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
4	8	2024-01-08 20:42:27.945
2	8	2024-01-08 20:42:27.952
3	8	2024-01-08 20:42:27.956
1	8	2024-01-08 20:42:27.961
5	8	2024-01-08 20:42:27.965
7	8	2024-01-08 20:42:27.969
9	8	2024-01-08 20:42:27.976
10	8	2024-01-08 20:42:27.978
11	8	2024-01-08 20:42:27.98
12	8	2024-01-08 20:42:27.983
13	8	2024-01-08 20:42:27.987
6	8	2024-01-08 20:42:27.991
\.


--
-- Data for Name: UserPreference; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."UserPreference" ("userId", "awardsVisibilityPrivate", "allowProfanity", "betaAccess", "allowPoliticalContent", "hidePostsOnProfile", "hideProfileHistory", "allowNSFWContent") FROM stdin;
1	f	f	f	f	f	f	f
3	f	f	f	f	f	f	f
4	f	f	f	f	f	f	f
5	f	f	f	f	f	f	f
6	f	f	f	f	f	f	f
7	f	f	f	f	f	f	f
8	f	f	f	f	f	f	f
9	f	f	f	f	f	f	f
10	f	f	f	f	f	f	f
11	f	f	f	f	f	f	f
12	f	f	f	f	f	f	f
13	f	f	f	f	f	f	f
2	f	f	f	f	f	f	f
\.


--
-- Data for Name: Vote; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."Vote" ("userId", type, "createdAt", "postId") FROM stdin;
2	UPVOTE	2024-01-08 20:51:58.278	338
2	UPVOTE	2024-01-08 20:52:10.444	339
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
9a034a5e-357c-4518-82d0-482ed312ecfa	bb888c6e0965e5301acb804c571c5019abfc98eeddb1f4fbe1be8c23760dedc1	2024-01-08 20:42:25.978981+00	20230902135036_performance_updates	\N	\N	2024-01-08 20:42:25.941366+00	1
cce11b39-5e0f-4cc3-83b9-a927c52c8e7b	d3af867ee25ff66edd527be1a2e171c1100dd1b932655128dbc637415ab0f3ec	2024-01-08 20:42:25.799901+00	20230408144647_v1	\N	\N	2024-01-08 20:42:25.65282+00	1
04a6ba84-ff95-4565-a3c9-58cb45c79ff8	7f5f1e95d1399cc15c19969c5a76b46a5715390c3c080f33bce7a1fc5ec42b5d	2024-01-08 20:42:25.875283+00	20230509170749_new_pref	\N	\N	2024-01-08 20:42:25.871929+00	1
3570569a-fe4a-4819-8898-185ac92c98e3	cc08d3f8837f37d33936825f0305d961d4371903077c17793179846e0047a22e	2024-01-08 20:42:25.803961+00	20230416051547_iap	\N	\N	2024-01-08 20:42:25.801059+00	1
757677a1-b81b-4726-857e-4b8ab478a595	2d21b0927f14addc7fc7ef3f112c28ec58187695caa059f57b79778200e11f4a	2024-01-08 20:42:25.807014+00	20230422071836_preferences	\N	\N	2024-01-08 20:42:25.804848+00	1
40132bab-2923-4f0a-91c5-3019e2a059a2	0c6f53c187e2d396b2c82d58ec841253bd58383c3686f45e189e4a1b4e8fcc94	2024-01-08 20:42:25.814801+00	20230423073959_deletion_cascading	\N	\N	2024-01-08 20:42:25.80767+00	1
4047c8e6-dad7-4fdd-a771-6e0323c29703	e2413aea46b4c7009c5e5331a926d5be78f41053a3ee2d5aa43569b26384fa28	2024-01-08 20:42:25.877723+00	20230511055315_openai_site_settings	\N	\N	2024-01-08 20:42:25.875957+00	1
a8826e18-0bf0-459c-b337-8d5c4902ee0b	611da4bbd2e2066f59444def40eed76bc984d6f4477fc9174fbd4b94a2cb94f3	2024-01-08 20:42:25.817479+00	20230423170539_robohash	\N	\N	2024-01-08 20:42:25.815602+00	1
cb84fc7d-bd9f-40f1-adc9-24ef2dc1bc16	bf70a47533acfd528779df4d4965987cd66cce1660a6bd1638868c6fe11ad6f6	2024-01-08 20:42:25.820208+00	20230424030216_moderation_action	\N	\N	2024-01-08 20:42:25.818162+00	1
42a7552f-edc8-466f-972d-edfb445726af	038f95d141b76b7d5d93b176def96496fc9ad7a7309b357fe251f6ce386fb000	2024-01-08 20:42:25.825324+00	20230424052835_otp_login	\N	\N	2024-01-08 20:42:25.820876+00	1
e1acafb5-361a-4cf0-b718-4b06a826ac05	8eeae1681bbb86c9d1efd1d5a48f9a621b7f7b0a2fdb72ca365dbd4f01269861	2024-01-08 20:42:25.882656+00	20230513024650_feedbacks	\N	\N	2024-01-08 20:42:25.878479+00	1
83dd512e-eb5c-4950-b787-7349d2387dda	0f07fdf92de9c7131fa9ecae69560702747532255d28129412bf748a0b3033c2	2024-01-08 20:42:25.827683+00	20230424171408_otp_update	\N	\N	2024-01-08 20:42:25.825988+00	1
c6475111-3397-4cec-a07d-eb9db04e991f	5104d648cfd43c963bdf074e54fc0f457bb235c31250492e999c7ebc36e57735	2024-01-08 20:42:25.830189+00	20230430070337_site_settings	\N	\N	2024-01-08 20:42:25.828366+00	1
dc68f8ec-cfe9-4b4f-8d0d-76bdef9267c1	ac760b18e671bc54d8d7015e8302f28df3f82c1615d8812b679c52f4362ee560	2024-01-08 20:42:25.985381+00	20230909195814_public_to_private	\N	\N	2024-01-08 20:42:25.979801+00	1
a5a170a4-6171-41e1-af26-49e5259f9dd5	958e83654a6690a989a9b7e407c80f71b0e9380a223eaa81af870be98f871f7e	2024-01-08 20:42:25.832541+00	20230501053207_spaces_robohash	\N	\N	2024-01-08 20:42:25.83086+00	1
8361f54b-2456-4956-8534-00732c4d079d	6244bebf6ef8cf345d6a85212d182304ad12a806c1675d2f3a8de3cf25fcd77b	2024-01-08 20:42:25.924476+00	20230626170429_factiiis_and_iap	\N	\N	2024-01-08 20:42:25.883783+00	1
f6217c8d-b876-42c8-8045-b353830fb1f7	ad9db72be7db47c78bd26b7e37284ea25b0c60ac8f0b011c126f8dcbcc673330	2024-01-08 20:42:25.840045+00	20230501084421_rewards	\N	\N	2024-01-08 20:42:25.833236+00	1
c288aa7d-b54f-465a-9bb1-60bd761d6b6f	5738f27bfcd4c07c09e14f881397b50ffc54e919f42d88cff267d9f83409b125	2024-01-08 20:42:25.855242+00	20230504163541_spaces	\N	\N	2024-01-08 20:42:25.840966+00	1
fb969bc9-8d1c-476c-840f-d8973d1c49ad	722149b51148ec06846e3ef445f2ce3d8be6d4c000a868cd566903a5d06f2628	2024-01-08 20:42:25.865642+00	20230504164445_drop_communities	\N	\N	2024-01-08 20:42:25.85608+00	1
94b039db-050d-42d9-afb6-17569d1799bc	b1892de073a3873aac5a64b04df6777d4500ce872110877fb0dfb003499826d2	2024-01-08 20:42:25.93136+00	20230712232614_factiii_update_and_subscription	\N	\N	2024-01-08 20:42:25.925288+00	1
c0a85327-e471-4a65-899d-da91212f7664	25bc9b3830f8d0487e64c20dfc4b9df01a1ad784da5c808879015a79e37b9947	2024-01-08 20:42:25.870932+00	20230505153704_history	\N	\N	2024-01-08 20:42:25.86637+00	1
f2c76d62-7474-4e72-89dc-1e6fb348c542	5eb3284099d7e578c33ecd5dd84186b83a61f8a368c020d15d1af6ac62c45317	2024-01-08 20:42:26.005485+00	20240106225554_add_reported_users	\N	\N	2024-01-08 20:42:26.002711+00	1
19c3f091-ce13-4a69-90eb-a666a6188793	d8b2b04a46142cd62e21a647d795072e5e2d613cb13cf169f8c9889a6ddec9f4	2024-01-08 20:42:25.934873+00	20230719150222_votes_issue	\N	\N	2024-01-08 20:42:25.932091+00	1
64411528-c266-4028-a753-44cecf631837	753f3663bd2827c21ea1094536ac8629edb63bee48216859c28f09e6404a5eb5	2024-01-08 20:42:25.988297+00	20231026213645_new_factiiis_and_ban_update_and_waitlist	\N	\N	2024-01-08 20:42:25.986255+00	1
afeccd85-79c3-46d7-ac32-083de8a69b36	b1f4d269da8454d7909c9984538b69546c752ed6f2096a5eea7014a9c377753b	2024-01-08 20:42:25.937678+00	20230726224249_factiii_rule_update	\N	\N	2024-01-08 20:42:25.935561+00	1
445a5e0e-e01b-43f0-b5f5-7d77e08c4a88	b839e00a4a04d7b8160d3c8a9de4b70a0b86346996cdcb5bb0f14adb144f3f41	2024-01-08 20:42:25.940109+00	20230730113935_document_uploads	\N	\N	2024-01-08 20:42:25.938339+00	1
054df1ed-52ed-40da-8e3a-59b64a273db5	5bcb8940b00a05f518db963d918f27b80b6ef7a2e17b28a793db0553489e1fd3	2024-01-08 20:42:25.995564+00	20231126143503_expo_tokens_update	\N	\N	2024-01-08 20:42:25.98911+00	1
dfdff1ae-4d23-45b2-a33b-5d8215725733	018af65901d9eb8bcbb5606fd22cb04fa3efd3f7968086321bdddaa2e43422ba	2024-01-08 20:42:26.007583+00	20240107224147_add_user_to_report_type	\N	\N	2024-01-08 20:42:26.006035+00	1
8c5af300-1939-408d-9c72-7d54223f2808	de248e41b78a71707a23adc2a42dd3b93c2810e6a61adfaefc33edd064d831fe	2024-01-08 20:42:25.998226+00	20231210160546_allow_nsfw_content	\N	\N	2024-01-08 20:42:25.996681+00	1
15986342-288f-4051-b457-4cf703f8acea	73c14f8065b8734f18c6c4d817ae93f95131c59d4d54ece084f56e7ef6039ff1	2024-01-08 20:42:26.002097+00	20231231212617_change_read_column_type	\N	\N	2024-01-08 20:42:25.99888+00	1
895525c5-5a50-4881-9161-47eb36ba6dc5	4c8e1973886ff39c551c493d20865dc0a6c0bf04de8fbde81ab7ee56c5a1654b	2024-01-08 20:42:26.011146+00	20240108174955_add_reported_spaces	\N	\N	2024-01-08 20:42:26.008069+00	1
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

SELECT pg_catalog.setval('public."Error_id_seq"', 6, true);


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

SELECT pg_catalog.setval('public."PostFactiii_id_seq"', 18, true);


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

SELECT pg_catalog.setval('public."Post_id_seq"', 339, true);


--
-- Name: Rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Rule_id_seq"', 25, true);


--
-- Name: Session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."Session_id_seq"', 21, true);


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

SELECT pg_catalog.setval('public."Space_id_seq"', 15, true);


--
-- Name: UserCost_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."UserCost_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public."User_id_seq"', 13, true);


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
-- Name: Report_reportedPostId_reportedUserId_reportedSpaceId_status_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "Report_reportedPostId_reportedUserId_reportedSpaceId_status_idx" ON public."Report" USING btree ("reportedPostId", "reportedUserId", "reportedSpaceId", status, "ruleId");


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
-- Name: Report Report_reportedSpaceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_reportedSpaceId_fkey" FOREIGN KEY ("reportedSpaceId") REFERENCES public."Space"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Report Report_reportedUploadId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_reportedUploadId_fkey" FOREIGN KEY ("reportedUploadId") REFERENCES public."Upload"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Report Report_reportedUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."Report"
    ADD CONSTRAINT "Report_reportedUserId_fkey" FOREIGN KEY ("reportedUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


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

