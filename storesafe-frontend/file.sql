--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Postgres.app)
-- Dumped by pg_dump version 16.4 (Postgres.app)

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
-- Name: enum_Questions_type; Type: TYPE; Schema: public; Owner: iankilpatrick
--

CREATE TYPE public."enum_Questions_type" AS ENUM (
    'yes_no',
    'multiple_choice'
);


ALTER TYPE public."enum_Questions_type" OWNER TO iankilpatrick;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Assessments; Type: TABLE; Schema: public; Owner: iankilpatrick
--

CREATE TABLE public."Assessments" (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    "userId" integer NOT NULL,
    progress double precision NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    answers json NOT NULL,
    "currentQuestionIndex" integer NOT NULL,
    completed boolean NOT NULL
);


ALTER TABLE public."Assessments" OWNER TO iankilpatrick;

--
-- Name: Assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: iankilpatrick
--

CREATE SEQUENCE public."Assessments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Assessments_id_seq" OWNER TO iankilpatrick;

--
-- Name: Assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iankilpatrick
--

ALTER SEQUENCE public."Assessments_id_seq" OWNED BY public."Assessments".id;


--
-- Name: Questions; Type: TABLE; Schema: public; Owner: iankilpatrick
--

CREATE TABLE public."Questions" (
    id integer NOT NULL,
    "assessmentId" integer,
    question text,
    category character varying(255),
    type public."enum_Questions_type" DEFAULT 'yes_no'::public."enum_Questions_type",
    "weightFoodSafety" integer,
    "weightSpaceOptimization" integer,
    "weightCostSavings" integer,
    "weightLaborEfficiency" integer,
    "weightSustainability" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Questions" OWNER TO iankilpatrick;

--
-- Name: Questions_id_seq; Type: SEQUENCE; Schema: public; Owner: iankilpatrick
--

CREATE SEQUENCE public."Questions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Questions_id_seq" OWNER TO iankilpatrick;

--
-- Name: Questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iankilpatrick
--

ALTER SEQUENCE public."Questions_id_seq" OWNED BY public."Questions".id;


--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: iankilpatrick
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO iankilpatrick;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: iankilpatrick
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    name character varying(255),
    company character varying(255),
    industry character varying(255),
    email character varying(255),
    phone character varying(255),
    password character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "isAdmin" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."Users" OWNER TO iankilpatrick;

--
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: iankilpatrick
--

CREATE SEQUENCE public."Users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Users_id_seq" OWNER TO iankilpatrick;

--
-- Name: Users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: iankilpatrick
--

ALTER SEQUENCE public."Users_id_seq" OWNED BY public."Users".id;


--
-- Name: Assessments id; Type: DEFAULT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Assessments" ALTER COLUMN id SET DEFAULT nextval('public."Assessments_id_seq"'::regclass);


--
-- Name: Questions id; Type: DEFAULT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Questions" ALTER COLUMN id SET DEFAULT nextval('public."Questions_id_seq"'::regclass);


--
-- Name: Users id; Type: DEFAULT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."Users_id_seq"'::regclass);


--
-- Data for Name: Assessments; Type: TABLE DATA; Schema: public; Owner: iankilpatrick
--

COPY public."Assessments" (id, title, "userId", progress, "createdAt", "updatedAt", answers, "currentQuestionIndex", completed) FROM stdin;
47	Ian's Taco Bell	4	0	2024-08-13 09:26:24.896-05	2024-08-14 10:24:00.367-05	{"201":false,"202":true,"203":false,"204":false,"205":true}	0	f
46	Cafe	4	0	2024-08-12 21:56:12.207-05	2024-08-13 09:26:17.799-05	{"201":true,"202":false,"203":true,"204":false,"205":true,"206":true,"207":true,"208":true,"209":false,"210":false,"211":false,"212":true,"225":true,"226":true,"227":false,"239":true,"240":false,"241":true,"242":false,"243":false,"244":true,"247":false}	0	f
51	4th	4	0	2024-08-14 15:12:45.133-05	2024-08-14 15:12:46.501-05	{}	0	f
52	5th	4	0	2024-08-14 15:13:05.986-05	2024-08-14 15:13:06.953-05	{}	0	f
49	Fourth Assessment	4	0	2024-08-14 10:23:47.247-05	2024-08-15 12:47:52.932-05	{"201":true,"202":true,"203":true,"204":false,"205":false,"206":false,"207":true}	2	f
\.


--
-- Data for Name: Questions; Type: TABLE DATA; Schema: public; Owner: iankilpatrick
--

COPY public."Questions" (id, "assessmentId", question, category, type, "weightFoodSafety", "weightSpaceOptimization", "weightCostSavings", "weightLaborEfficiency", "weightSustainability", "createdAt", "updatedAt") FROM stdin;
201	1	Food is kept at least 6" (15,2 cm) off the floor during the receiving process to prevent physical and chemical contamination.	receiving	yes_no	4	2	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
202	1	At time of delivery, one designated staff member checks the Quality of food, as well as the Quantity, Weight, and Prices documented on the Invoice/PO.	receiving	yes_no	3	0	2	2	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
203	1	Transport equipment & supplies get food from unloading to proper storage as soon as possible to ensure safe food temperatures and holding.	receiving	yes_no	3	3	2	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
204	1	Approved food is transferred into food storage containers and out of cardboard boxes.	receiving	yes_no	3	4	4	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
205	1	Potentially hazardous food is transferred from cartons to food storage containers with proper lids and identification.	receiving	yes_no	5	2	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
206	1	Food and beverage items are stored at least 6" (15,2 cm) above the floor on approved shelving or dunnage racks.	storage	yes_no	5	2	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
207	1	Containers are labeled with the Common Name of the Food, if not easily identified by sight, as well as the Prepared Date and/or Use By Date.	storage	yes_no	5	0	0	3	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
208	1	Containers are labeled with easy to remove or dissolvable food rotation labels to reduce the risk of harmful bacteria from sticky label residue.	storage	yes_no	4	0	0	2	4	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
209	1	Containers are covered with a tight-fitting, reusable, seal lid and protected from overhead contamination.	storage	yes_no	4	0	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
210	1	Operators don't store product on top of food pans covered with saran wrap. (This is considered nesting and creates opportunities for cross contamination.)	storage	yes_no	5	3	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
211	1	Shelf plates are vented to promote the circulation of air.	storage	yes_no	5	0	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
212	1	Shelves aren't lined with aluminum foil, sheet pans, or paper, preventing the circulation of air.	storage	yes_no	4	3	1	0	2	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
213	1	FIFO (First In, First Out) procedures are used in all storage areas.	storage	yes_no	5	2	1	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
214	1	Inventory and storage procedures are communicated to staff in terms/languages they understand clearly.	storage	yes_no	4	0	0	5	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
215	1	Shelving units keep all food and beverage easily visible and accessible to avoid hidden products that might spoil.	storage	yes_no	4	4	2	4	2	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
216	1	Shelving is organized so that employees know exactly where to find and store food and beverage ingredients. Employees aren't digging through storage/shelving or spilling containers doing so.	storage	yes_no	4	5	2	5	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
217	1	Raw food and ready to eat food are stored on separate shelving units or in different storage rooms.	storage	yes_no	3	2	1	1	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
218	1	Potentially hazardous food is stored away from other foods, in a designated area.	storage	yes_no	5	1	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
219	1	If raw food and ready to eat food cannot be separated on different units, containers are stored on their appropriate shelves, top to bottom, in this order: ready-to-eat food, seafood, whole cuts of beef and pork, ground meat and seafood, and whole and ground poultry.	storage	yes_no	5	4	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
220	1	Food items are stored in clear, reusable containers to minimize handling and reduce the risk of contamination.	storage	yes_no	3	3	1	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
221	1	Ice used to keep food or beverages cold is stored separately from ice used as an ingredient.	storage	yes_no	5	0	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
222	1	Shelving is in food safe condition, with no rust, corrosion, warping, or broken/missing pieces needed to sustain the units.	storage	yes_no	4	2	0	0	3	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
223	1	Pesticides/chemicals are stored away from food handling and storage areas.	storage	yes_no	5	2	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
224	1	A menu ingredient par sheet is used for the Dry Storage, Walk-In, and Freezer areas to reduce inventory time and improve accuracy.	storage	yes_no	1	3	4	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
225	1	Produce is properly drained and stored after washing and before prep.	preparation	yes_no	5	0	3	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
226	1	Reusable, commercial grade food storage containers are used to store mise en place/ingredients instead of single-use, disposable containers.	preparation	yes_no	2	2	3	0	4	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
227	1	Food pans help extend correct internal food temperature on the prep table, minimizing the ingredients' time spent in the temperature danger zone or operators' time spent replacing food pans with new food.	preparation	yes_no	4	1	3	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
228	1	Ice Scoops are used instead of bare hands, cups, or glassware.	preparation	yes_no	5	0	3	3	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
229	1	Portioning tools such as ladles and measuring cups are used in the prep & cook area.	preparation	yes_no	2	0	4	3	3	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
230	1	Food is thawed at proper temperature in one of the following ways:\nRefrigeration: Food is thawed at 41°F (5°C) or lower to limit bacteria growth.\nMicrowave Oven: Food is thawed and then cooked immediately after.\nCooking: Food is thawed as part of the cooking process.\nRunning Water: Submerge food under running, drinkable water at 70°F (21,1°C) or lower.	preparation	yes_no	5	0	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
231	1	Food preparation is performed within two (2) hours so that food items don't reach the temperature danger zone: 42°F - 140°F (5,6°C – 56,7°C)	preparation	yes_no	5	0	1	4	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
232	1	Staff is using single-use gloves or utensils to avoid bare-hand contact.	preparation	yes_no	5	0	0	2	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
233	1	Raw meat, poultry, seafood, and ready to eat foods are organized and prepped separately to avoid cross contamination.	preparation	yes_no	5	2	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
234	1	If different foods are prepared at the same station, all food contact surfaces, including preparation tools, are properly cleaned and sanitized prior to handling new ingredients.	preparation	yes_no	5	0	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
235	1	Each prep cook is assigned a Food Box to toss "trash" in, instead of a trash bin, to promote management oversight on what is being considered food waste in the kitchen.	preparation	yes_no	1	0	5	0	4	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
236	1	Food is cooled to safe temperatures as quickly as possible, using an approved method such as a blast chiller, ice bath, ice paddle, iced container bin, separating food in smaller portions, and shallow food pans.	preparation	yes_no	5	2	3	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
237	1	Food that's stored on shelving for cooling is placed in a storage container with a loose-fitting lid or uncovered above other food like meat, seafood, and poultry. The food is covered with a tight-fitting, seal lid after cooling.	preparation	yes_no	5	3	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
238	1	Previously cooked and cooled TCS foods that will be hot held are reheated to an internal temperature of 165°F (73,9°C) for 15 seconds, within 2 hours of being removed from refrigeration. Equipment approved for reheating is used (no holding cabinets).	preparation	yes_no	5	0	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
239	1	Product is getting transported from the kitchen to the FOH prep tables, assembly stations, or self-service/buffet lines quickly and quietly.	service	yes_no	4	3	1	4	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
240	1	During service, hot ready-to-eat TCS foods maintain an internal temperature of 135°F (57,2°C) or above, and cold ready-to-eat TCS foods maintain an internal temperature of 41°F (5°C) or below.	service	yes_no	5	0	1	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
241	1	Food handlers regularly monitor food temperatures during hot and cold holding.	service	yes_no	5	0	1	3	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
242	1	Food is covered when not in use to minimize exposure to contaminants and hold food temperature.	service	yes_no	5	0	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
243	1	Food is consumed in full, within 6 hours for cold TCS food and 4 hours for hot TCS food, when holding without temperature control. If not, food is discarded.	service	yes_no	5	0	3	0	3	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
244	1	Self-Service: Separate serving utensils are used per item for safe dispensing of food. These tools include but aren’t limited to tongs, serving spoons, and ladles. (If your operation does not offer self-service, please select “Met”.)	service	yes_no	5	0	2	0	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
245	1	Self-Service: All food items are labeled on the self-service food bar. Names of salad dressings are identified on ladle handles. (If your operation does not offer self-service, please select “Met”.)	service	yes_no	5	0	0	0	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
246	1	Off-Site Service: Food is packed in food-grade insulated carriers, and does not mix, leak, or spill when transporting off-site. (If your operation does not offer off-site service, please select “Met”.)	service	yes_no	5	3	1	2	1	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
247	1	There are an adequate number of accessible hand sinks BOH that have hot water, soap, and paper towels.	sanitation	yes_no	5	1	0	2	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
248	1	After washing, rinsing, and sanitizing, wares are properly air dried before stacking, storing, or using them.	sanitation	yes_no	5	0	4	0	2	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
249	1	There’s both a designated area and system for air drying wares.	sanitation	yes_no	2	5	0	4	0	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
250	1	Dinnerware and glassware are properly stored and protected to prevent against physical/chemical contaminants and avoid re-washing.	sanitation	yes_no	5	3	4	3	4	2024-08-02 16:31:38.969-05	2024-08-02 16:31:38.969-05
\.


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: iankilpatrick
--

COPY public."SequelizeMeta" (name) FROM stdin;
20240726214153-create-user.js
20240726214159-create-assessment.js
20240726214204-create-question.js
20240731195336-add-answers-to-assessments.js
20240731200415-add-currentQuestionIndex-to-assessments.js
20240731200911-add-completed-to-assessments.js
20240813150345-add-is-admin-to-users.js
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: iankilpatrick
--

COPY public."Users" (id, name, company, industry, email, phone, password, "createdAt", "updatedAt", "isAdmin") FROM stdin;
1	John Doe	Company Inc.	Food	john.doe@example.com	1234567890	$2a$10$9YjTT.g9UUX9cvUORO/taOu/5dWaTnJ15cqA21KjKlT5LNF1vOD8y	2024-07-26 17:11:25.491-05	2024-07-26 17:11:25.491-05	f
2	John Doe	Company Inc.	Food	john.doe@example.com	1234567890	$2a$10$M8fwTAPXilmt/7p/SGr68OkMjaXThM8.BID4zCpgLtHxMB3foYtpi	2024-07-26 17:32:41.695-05	2024-07-26 17:32:41.695-05	f
3	ian	ian	ian	ian@ian.com	8181818181	$2a$10$iy.syx2wQRYqTSTtuMwN7uT5M0cmorbCkqNOUU8300oyqHkDzNPU.	2024-07-29 10:18:11.562-05	2024-07-29 10:18:11.562-05	f
4	ian	ianpk	Awesomeness	ian@ianpk.com	8182516623	$2a$10$GAxiyv3cWLzrs.NajYKOIO9DkxDrVedYujtIz62OfQp34E4sdsChq	2024-07-29 10:36:56.885-05	2024-07-29 10:36:56.885-05	t
\.


--
-- Name: Assessments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iankilpatrick
--

SELECT pg_catalog.setval('public."Assessments_id_seq"', 52, true);


--
-- Name: Questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iankilpatrick
--

SELECT pg_catalog.setval('public."Questions_id_seq"', 250, true);


--
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iankilpatrick
--

SELECT pg_catalog.setval('public."Users_id_seq"', 4, true);


--
-- Name: Assessments Assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Assessments"
    ADD CONSTRAINT "Assessments_pkey" PRIMARY KEY (id);


--
-- Name: Questions Questions_pkey; Type: CONSTRAINT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Questions"
    ADD CONSTRAINT "Questions_pkey" PRIMARY KEY (id);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: iankilpatrick
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

