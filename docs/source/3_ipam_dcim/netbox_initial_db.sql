--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO netbox;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO netbox;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO netbox;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO netbox;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO netbox;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO netbox;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO netbox;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO netbox;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO netbox;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO netbox;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO netbox;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO netbox;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: circuits_circuit; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.circuits_circuit (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    cid character varying(50) NOT NULL,
    install_date date,
    commit_rate integer,
    comments text NOT NULL,
    provider_id integer NOT NULL,
    type_id integer NOT NULL,
    tenant_id integer,
    description character varying(100) NOT NULL,
    status smallint NOT NULL,
    CONSTRAINT circuits_circuit_commit_rate_check CHECK ((commit_rate >= 0)),
    CONSTRAINT circuits_circuit_status_check CHECK ((status >= 0))
);


ALTER TABLE public.circuits_circuit OWNER TO netbox;

--
-- Name: circuits_circuit_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.circuits_circuit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_circuit_id_seq OWNER TO netbox;

--
-- Name: circuits_circuit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.circuits_circuit_id_seq OWNED BY public.circuits_circuit.id;


--
-- Name: circuits_circuittermination; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.circuits_circuittermination (
    id integer NOT NULL,
    term_side character varying(1) NOT NULL,
    port_speed integer NOT NULL,
    upstream_speed integer,
    xconnect_id character varying(50) NOT NULL,
    pp_info character varying(100) NOT NULL,
    circuit_id integer NOT NULL,
    site_id integer NOT NULL,
    connected_endpoint_id integer,
    connection_status boolean,
    cable_id integer,
    description character varying(100) NOT NULL,
    CONSTRAINT circuits_circuittermination_port_speed_check CHECK ((port_speed >= 0)),
    CONSTRAINT circuits_circuittermination_upstream_speed_check CHECK ((upstream_speed >= 0))
);


ALTER TABLE public.circuits_circuittermination OWNER TO netbox;

--
-- Name: circuits_circuittermination_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.circuits_circuittermination_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_circuittermination_id_seq OWNER TO netbox;

--
-- Name: circuits_circuittermination_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.circuits_circuittermination_id_seq OWNED BY public.circuits_circuittermination.id;


--
-- Name: circuits_circuittype; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.circuits_circuittype (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.circuits_circuittype OWNER TO netbox;

--
-- Name: circuits_circuittype_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.circuits_circuittype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_circuittype_id_seq OWNER TO netbox;

--
-- Name: circuits_circuittype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.circuits_circuittype_id_seq OWNED BY public.circuits_circuittype.id;


--
-- Name: circuits_provider; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.circuits_provider (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    asn bigint,
    account character varying(30) NOT NULL,
    portal_url character varying(200) NOT NULL,
    noc_contact text NOT NULL,
    admin_contact text NOT NULL,
    comments text NOT NULL
);


ALTER TABLE public.circuits_provider OWNER TO netbox;

--
-- Name: circuits_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.circuits_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_provider_id_seq OWNER TO netbox;

--
-- Name: circuits_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.circuits_provider_id_seq OWNED BY public.circuits_provider.id;


--
-- Name: dcim_cable; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_cable (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    termination_a_id integer NOT NULL,
    termination_b_id integer NOT NULL,
    type smallint,
    status boolean NOT NULL,
    label character varying(100) NOT NULL,
    color character varying(6) NOT NULL,
    length smallint,
    length_unit smallint,
    _abs_length numeric(10,4),
    termination_a_type_id integer NOT NULL,
    termination_b_type_id integer NOT NULL,
    _termination_a_device_id integer,
    _termination_b_device_id integer,
    CONSTRAINT dcim_cable_length_check CHECK ((length >= 0)),
    CONSTRAINT dcim_cable_length_unit_check CHECK ((length_unit >= 0)),
    CONSTRAINT dcim_cable_termination_a_id_check CHECK ((termination_a_id >= 0)),
    CONSTRAINT dcim_cable_termination_b_id_check CHECK ((termination_b_id >= 0)),
    CONSTRAINT dcim_cable_type_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_cable OWNER TO netbox;

--
-- Name: dcim_cable_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_cable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_cable_id_seq OWNER TO netbox;

--
-- Name: dcim_cable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_cable_id_seq OWNED BY public.dcim_cable.id;


--
-- Name: dcim_consoleport; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_consoleport (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    connection_status boolean,
    connected_endpoint_id integer,
    device_id integer NOT NULL,
    cable_id integer,
    description character varying(100) NOT NULL
);


ALTER TABLE public.dcim_consoleport OWNER TO netbox;

--
-- Name: dcim_consoleport_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_consoleport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_consoleport_id_seq OWNER TO netbox;

--
-- Name: dcim_consoleport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_consoleport_id_seq OWNED BY public.dcim_consoleport.id;


--
-- Name: dcim_consoleporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_consoleporttemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer NOT NULL
);


ALTER TABLE public.dcim_consoleporttemplate OWNER TO netbox;

--
-- Name: dcim_consoleporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_consoleporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_consoleporttemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_consoleporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_consoleporttemplate_id_seq OWNED BY public.dcim_consoleporttemplate.id;


--
-- Name: dcim_consoleserverport; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_consoleserverport (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_id integer NOT NULL,
    cable_id integer,
    connection_status boolean,
    description character varying(100) NOT NULL
);


ALTER TABLE public.dcim_consoleserverport OWNER TO netbox;

--
-- Name: dcim_consoleserverport_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_consoleserverport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_consoleserverport_id_seq OWNER TO netbox;

--
-- Name: dcim_consoleserverport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_consoleserverport_id_seq OWNED BY public.dcim_consoleserverport.id;


--
-- Name: dcim_consoleserverporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_consoleserverporttemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer NOT NULL
);


ALTER TABLE public.dcim_consoleserverporttemplate OWNER TO netbox;

--
-- Name: dcim_consoleserverporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_consoleserverporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_consoleserverporttemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_consoleserverporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_consoleserverporttemplate_id_seq OWNED BY public.dcim_consoleserverporttemplate.id;


--
-- Name: dcim_device; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_device (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(64),
    serial character varying(50) NOT NULL,
    "position" smallint,
    face smallint,
    status smallint NOT NULL,
    comments text NOT NULL,
    device_role_id integer NOT NULL,
    device_type_id integer NOT NULL,
    platform_id integer,
    rack_id integer,
    primary_ip4_id integer,
    primary_ip6_id integer,
    tenant_id integer,
    asset_tag character varying(50),
    site_id integer NOT NULL,
    cluster_id integer,
    virtual_chassis_id integer,
    vc_position smallint,
    vc_priority smallint,
    local_context_data jsonb,
    CONSTRAINT dcim_device_face_check CHECK ((face >= 0)),
    CONSTRAINT dcim_device_position_check CHECK (("position" >= 0)),
    CONSTRAINT dcim_device_status_4f698226_check CHECK ((status >= 0)),
    CONSTRAINT dcim_device_vc_position_check CHECK ((vc_position >= 0)),
    CONSTRAINT dcim_device_vc_priority_check CHECK ((vc_priority >= 0))
);


ALTER TABLE public.dcim_device OWNER TO netbox;

--
-- Name: dcim_device_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_device_id_seq OWNER TO netbox;

--
-- Name: dcim_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_device_id_seq OWNED BY public.dcim_device.id;


--
-- Name: dcim_devicebay; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_devicebay (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_id integer NOT NULL,
    installed_device_id integer,
    description character varying(100) NOT NULL
);


ALTER TABLE public.dcim_devicebay OWNER TO netbox;

--
-- Name: dcim_devicebay_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_devicebay_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_devicebay_id_seq OWNER TO netbox;

--
-- Name: dcim_devicebay_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_devicebay_id_seq OWNED BY public.dcim_devicebay.id;


--
-- Name: dcim_devicebaytemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_devicebaytemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer NOT NULL
);


ALTER TABLE public.dcim_devicebaytemplate OWNER TO netbox;

--
-- Name: dcim_devicebaytemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_devicebaytemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_devicebaytemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_devicebaytemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_devicebaytemplate_id_seq OWNED BY public.dcim_devicebaytemplate.id;


--
-- Name: dcim_devicerole; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_devicerole (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    color character varying(6) NOT NULL,
    vm_role boolean NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_devicerole OWNER TO netbox;

--
-- Name: dcim_devicerole_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_devicerole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_devicerole_id_seq OWNER TO netbox;

--
-- Name: dcim_devicerole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_devicerole_id_seq OWNED BY public.dcim_devicerole.id;


--
-- Name: dcim_devicetype; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_devicetype (
    id integer NOT NULL,
    model character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    u_height smallint NOT NULL,
    is_full_depth boolean NOT NULL,
    manufacturer_id integer NOT NULL,
    subdevice_role boolean,
    part_number character varying(50) NOT NULL,
    comments text NOT NULL,
    created date,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_devicetype_u_height_check CHECK ((u_height >= 0))
);


ALTER TABLE public.dcim_devicetype OWNER TO netbox;

--
-- Name: dcim_devicetype_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_devicetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_devicetype_id_seq OWNER TO netbox;

--
-- Name: dcim_devicetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_devicetype_id_seq OWNED BY public.dcim_devicetype.id;


--
-- Name: dcim_frontport; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_frontport (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    rear_port_position smallint NOT NULL,
    description character varying(100) NOT NULL,
    device_id integer NOT NULL,
    rear_port_id integer NOT NULL,
    cable_id integer,
    CONSTRAINT dcim_frontport_rear_port_position_check CHECK ((rear_port_position >= 0)),
    CONSTRAINT dcim_frontport_type_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_frontport OWNER TO netbox;

--
-- Name: dcim_frontport_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_frontport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_frontport_id_seq OWNER TO netbox;

--
-- Name: dcim_frontport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_frontport_id_seq OWNED BY public.dcim_frontport.id;


--
-- Name: dcim_frontporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_frontporttemplate (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    rear_port_position smallint NOT NULL,
    device_type_id integer NOT NULL,
    rear_port_id integer NOT NULL,
    CONSTRAINT dcim_frontporttemplate_rear_port_position_check CHECK ((rear_port_position >= 0)),
    CONSTRAINT dcim_frontporttemplate_type_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_frontporttemplate OWNER TO netbox;

--
-- Name: dcim_frontporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_frontporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_frontporttemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_frontporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_frontporttemplate_id_seq OWNED BY public.dcim_frontporttemplate.id;


--
-- Name: dcim_interface; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_interface (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    mgmt_only boolean NOT NULL,
    description character varying(100) NOT NULL,
    device_id integer,
    mac_address macaddr,
    lag_id integer,
    enabled boolean NOT NULL,
    mtu integer,
    virtual_machine_id integer,
    mode smallint,
    untagged_vlan_id integer,
    _connected_circuittermination_id integer,
    _connected_interface_id integer,
    connection_status boolean,
    cable_id integer,
    CONSTRAINT dcim_interface_mode_check CHECK ((mode >= 0)),
    CONSTRAINT dcim_interface_mtu_check CHECK ((mtu >= 0)),
    CONSTRAINT dcim_interface_type_b8044832_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_interface OWNER TO netbox;

--
-- Name: dcim_interface_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_interface_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_interface_id_seq OWNER TO netbox;

--
-- Name: dcim_interface_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_interface_id_seq OWNED BY public.dcim_interface.id;


--
-- Name: dcim_interface_tagged_vlans; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_interface_tagged_vlans (
    id integer NOT NULL,
    interface_id integer NOT NULL,
    vlan_id integer NOT NULL
);


ALTER TABLE public.dcim_interface_tagged_vlans OWNER TO netbox;

--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_interface_tagged_vlans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_interface_tagged_vlans_id_seq OWNER TO netbox;

--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_interface_tagged_vlans_id_seq OWNED BY public.dcim_interface_tagged_vlans.id;


--
-- Name: dcim_interfacetemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_interfacetemplate (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    mgmt_only boolean NOT NULL,
    device_type_id integer NOT NULL,
    CONSTRAINT dcim_interfacetemplate_type_ebd08d49_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_interfacetemplate OWNER TO netbox;

--
-- Name: dcim_interfacetemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_interfacetemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_interfacetemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_interfacetemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_interfacetemplate_id_seq OWNED BY public.dcim_interfacetemplate.id;


--
-- Name: dcim_inventoryitem; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_inventoryitem (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    part_id character varying(50) NOT NULL,
    serial character varying(50) NOT NULL,
    discovered boolean NOT NULL,
    device_id integer NOT NULL,
    parent_id integer,
    manufacturer_id integer,
    asset_tag character varying(50),
    description character varying(100) NOT NULL
);


ALTER TABLE public.dcim_inventoryitem OWNER TO netbox;

--
-- Name: dcim_manufacturer; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_manufacturer (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_manufacturer OWNER TO netbox;

--
-- Name: dcim_manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_manufacturer_id_seq OWNER TO netbox;

--
-- Name: dcim_manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_manufacturer_id_seq OWNED BY public.dcim_manufacturer.id;


--
-- Name: dcim_module_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_module_id_seq OWNER TO netbox;

--
-- Name: dcim_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_module_id_seq OWNED BY public.dcim_inventoryitem.id;


--
-- Name: dcim_platform; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_platform (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    napalm_driver character varying(50) NOT NULL,
    manufacturer_id integer,
    created date,
    last_updated timestamp with time zone,
    napalm_args jsonb
);


ALTER TABLE public.dcim_platform OWNER TO netbox;

--
-- Name: dcim_platform_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_platform_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_platform_id_seq OWNER TO netbox;

--
-- Name: dcim_platform_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_platform_id_seq OWNED BY public.dcim_platform.id;


--
-- Name: dcim_powerfeed; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_powerfeed (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    status smallint NOT NULL,
    type smallint NOT NULL,
    supply smallint NOT NULL,
    phase smallint NOT NULL,
    voltage smallint NOT NULL,
    amperage smallint NOT NULL,
    max_utilization smallint NOT NULL,
    available_power smallint NOT NULL,
    comments text NOT NULL,
    cable_id integer,
    power_panel_id integer NOT NULL,
    rack_id integer,
    connected_endpoint_id integer,
    connection_status boolean,
    CONSTRAINT dcim_powerfeed_amperage_check CHECK ((amperage >= 0)),
    CONSTRAINT dcim_powerfeed_available_power_check CHECK ((available_power >= 0)),
    CONSTRAINT dcim_powerfeed_max_utilization_check CHECK ((max_utilization >= 0)),
    CONSTRAINT dcim_powerfeed_phase_check CHECK ((phase >= 0)),
    CONSTRAINT dcim_powerfeed_status_check CHECK ((status >= 0)),
    CONSTRAINT dcim_powerfeed_supply_check CHECK ((supply >= 0)),
    CONSTRAINT dcim_powerfeed_type_check CHECK ((type >= 0)),
    CONSTRAINT dcim_powerfeed_voltage_check CHECK ((voltage >= 0))
);


ALTER TABLE public.dcim_powerfeed OWNER TO netbox;

--
-- Name: dcim_powerfeed_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_powerfeed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_powerfeed_id_seq OWNER TO netbox;

--
-- Name: dcim_powerfeed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_powerfeed_id_seq OWNED BY public.dcim_powerfeed.id;


--
-- Name: dcim_poweroutlet; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_poweroutlet (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_id integer NOT NULL,
    cable_id integer,
    connection_status boolean,
    description character varying(100) NOT NULL,
    feed_leg smallint,
    power_port_id integer,
    CONSTRAINT dcim_poweroutlet_feed_leg_check CHECK ((feed_leg >= 0))
);


ALTER TABLE public.dcim_poweroutlet OWNER TO netbox;

--
-- Name: dcim_poweroutlet_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_poweroutlet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_poweroutlet_id_seq OWNER TO netbox;

--
-- Name: dcim_poweroutlet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_poweroutlet_id_seq OWNED BY public.dcim_poweroutlet.id;


--
-- Name: dcim_poweroutlettemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_poweroutlettemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer NOT NULL,
    feed_leg smallint,
    power_port_id integer,
    CONSTRAINT dcim_poweroutlettemplate_feed_leg_check CHECK ((feed_leg >= 0))
);


ALTER TABLE public.dcim_poweroutlettemplate OWNER TO netbox;

--
-- Name: dcim_poweroutlettemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_poweroutlettemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_poweroutlettemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_poweroutlettemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_poweroutlettemplate_id_seq OWNED BY public.dcim_poweroutlettemplate.id;


--
-- Name: dcim_powerpanel; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_powerpanel (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    rack_group_id integer,
    site_id integer NOT NULL
);


ALTER TABLE public.dcim_powerpanel OWNER TO netbox;

--
-- Name: dcim_powerpanel_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_powerpanel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_powerpanel_id_seq OWNER TO netbox;

--
-- Name: dcim_powerpanel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_powerpanel_id_seq OWNED BY public.dcim_powerpanel.id;


--
-- Name: dcim_powerport; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_powerport (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    connection_status boolean,
    device_id integer NOT NULL,
    _connected_poweroutlet_id integer,
    cable_id integer,
    description character varying(100) NOT NULL,
    _connected_powerfeed_id integer,
    allocated_draw smallint,
    maximum_draw smallint,
    CONSTRAINT dcim_powerport_allocated_draw_check CHECK ((allocated_draw >= 0)),
    CONSTRAINT dcim_powerport_maximum_draw_check CHECK ((maximum_draw >= 0))
);


ALTER TABLE public.dcim_powerport OWNER TO netbox;

--
-- Name: dcim_powerport_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_powerport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_powerport_id_seq OWNER TO netbox;

--
-- Name: dcim_powerport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_powerport_id_seq OWNED BY public.dcim_powerport.id;


--
-- Name: dcim_powerporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_powerporttemplate (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    device_type_id integer NOT NULL,
    allocated_draw smallint,
    maximum_draw smallint,
    CONSTRAINT dcim_powerporttemplate_allocated_draw_check CHECK ((allocated_draw >= 0)),
    CONSTRAINT dcim_powerporttemplate_maximum_draw_check CHECK ((maximum_draw >= 0))
);


ALTER TABLE public.dcim_powerporttemplate OWNER TO netbox;

--
-- Name: dcim_powerporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_powerporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_powerporttemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_powerporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_powerporttemplate_id_seq OWNED BY public.dcim_powerporttemplate.id;


--
-- Name: dcim_rack; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rack (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    facility_id character varying(50),
    u_height smallint NOT NULL,
    comments text NOT NULL,
    group_id integer,
    site_id integer NOT NULL,
    tenant_id integer,
    type smallint,
    width smallint NOT NULL,
    role_id integer,
    desc_units boolean NOT NULL,
    serial character varying(50) NOT NULL,
    status smallint NOT NULL,
    asset_tag character varying(50),
    outer_depth smallint,
    outer_unit smallint,
    outer_width smallint,
    CONSTRAINT dcim_rack_outer_depth_check CHECK ((outer_depth >= 0)),
    CONSTRAINT dcim_rack_outer_unit_check CHECK ((outer_unit >= 0)),
    CONSTRAINT dcim_rack_outer_width_check CHECK ((outer_width >= 0)),
    CONSTRAINT dcim_rack_status_check CHECK ((status >= 0)),
    CONSTRAINT dcim_rack_type_check CHECK ((type >= 0)),
    CONSTRAINT dcim_rack_u_height_check CHECK ((u_height >= 0)),
    CONSTRAINT dcim_rack_width_check CHECK ((width >= 0))
);


ALTER TABLE public.dcim_rack OWNER TO netbox;

--
-- Name: dcim_rack_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rack_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rack_id_seq OWNER TO netbox;

--
-- Name: dcim_rack_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rack_id_seq OWNED BY public.dcim_rack.id;


--
-- Name: dcim_rackgroup; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rackgroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    site_id integer NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_rackgroup OWNER TO netbox;

--
-- Name: dcim_rackgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rackgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rackgroup_id_seq OWNER TO netbox;

--
-- Name: dcim_rackgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rackgroup_id_seq OWNED BY public.dcim_rackgroup.id;


--
-- Name: dcim_rackreservation; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rackreservation (
    id integer NOT NULL,
    units smallint[] NOT NULL,
    created date,
    description character varying(100) NOT NULL,
    rack_id integer NOT NULL,
    user_id integer NOT NULL,
    tenant_id integer,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_rackreservation OWNER TO netbox;

--
-- Name: dcim_rackreservation_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rackreservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rackreservation_id_seq OWNER TO netbox;

--
-- Name: dcim_rackreservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rackreservation_id_seq OWNED BY public.dcim_rackreservation.id;


--
-- Name: dcim_rackrole; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rackrole (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    color character varying(6) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_rackrole OWNER TO netbox;

--
-- Name: dcim_rackrole_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rackrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rackrole_id_seq OWNER TO netbox;

--
-- Name: dcim_rackrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rackrole_id_seq OWNED BY public.dcim_rackrole.id;


--
-- Name: dcim_rearport; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rearport (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    positions smallint NOT NULL,
    description character varying(100) NOT NULL,
    device_id integer NOT NULL,
    cable_id integer,
    CONSTRAINT dcim_rearport_positions_check CHECK ((positions >= 0)),
    CONSTRAINT dcim_rearport_type_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_rearport OWNER TO netbox;

--
-- Name: dcim_rearport_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rearport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rearport_id_seq OWNER TO netbox;

--
-- Name: dcim_rearport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rearport_id_seq OWNED BY public.dcim_rearport.id;


--
-- Name: dcim_rearporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_rearporttemplate (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    positions smallint NOT NULL,
    device_type_id integer NOT NULL,
    CONSTRAINT dcim_rearporttemplate_positions_check CHECK ((positions >= 0)),
    CONSTRAINT dcim_rearporttemplate_type_check CHECK ((type >= 0))
);


ALTER TABLE public.dcim_rearporttemplate OWNER TO netbox;

--
-- Name: dcim_rearporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_rearporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_rearporttemplate_id_seq OWNER TO netbox;

--
-- Name: dcim_rearporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_rearporttemplate_id_seq OWNED BY public.dcim_rearporttemplate.id;


--
-- Name: dcim_region; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_region (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    created date,
    last_updated timestamp with time zone,
    CONSTRAINT dcim_region_level_check CHECK ((level >= 0)),
    CONSTRAINT dcim_region_lft_check CHECK ((lft >= 0)),
    CONSTRAINT dcim_region_rght_check CHECK ((rght >= 0)),
    CONSTRAINT dcim_region_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.dcim_region OWNER TO netbox;

--
-- Name: dcim_region_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_region_id_seq OWNER TO netbox;

--
-- Name: dcim_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_region_id_seq OWNED BY public.dcim_region.id;


--
-- Name: dcim_site; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_site (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    facility character varying(50) NOT NULL,
    asn bigint,
    physical_address character varying(200) NOT NULL,
    shipping_address character varying(200) NOT NULL,
    comments text NOT NULL,
    tenant_id integer,
    contact_email character varying(254) NOT NULL,
    contact_name character varying(50) NOT NULL,
    contact_phone character varying(20) NOT NULL,
    region_id integer,
    description character varying(100) NOT NULL,
    status smallint NOT NULL,
    time_zone character varying(63) NOT NULL,
    latitude numeric(8,6),
    longitude numeric(9,6),
    CONSTRAINT dcim_site_status_check CHECK ((status >= 0))
);


ALTER TABLE public.dcim_site OWNER TO netbox;

--
-- Name: dcim_site_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_site_id_seq OWNER TO netbox;

--
-- Name: dcim_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_site_id_seq OWNED BY public.dcim_site.id;


--
-- Name: dcim_virtualchassis; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.dcim_virtualchassis (
    id integer NOT NULL,
    domain character varying(30) NOT NULL,
    master_id integer NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.dcim_virtualchassis OWNER TO netbox;

--
-- Name: dcim_virtualchassis_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.dcim_virtualchassis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dcim_virtualchassis_id_seq OWNER TO netbox;

--
-- Name: dcim_virtualchassis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.dcim_virtualchassis_id_seq OWNED BY public.dcim_virtualchassis.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO netbox;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO netbox;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO netbox;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO netbox;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO netbox;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO netbox;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO netbox;

--
-- Name: extras_configcontext; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    weight smallint NOT NULL,
    description character varying(100) NOT NULL,
    is_active boolean NOT NULL,
    data jsonb NOT NULL,
    CONSTRAINT extras_configcontext_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_configcontext OWNER TO netbox;

--
-- Name: extras_configcontext_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_id_seq OWNED BY public.extras_configcontext.id;


--
-- Name: extras_configcontext_platforms; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_platforms (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    platform_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_platforms OWNER TO netbox;

--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_platforms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_platforms_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_platforms_id_seq OWNED BY public.extras_configcontext_platforms.id;


--
-- Name: extras_configcontext_regions; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_regions (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_regions OWNER TO netbox;

--
-- Name: extras_configcontext_regions_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_regions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_regions_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_regions_id_seq OWNED BY public.extras_configcontext_regions.id;


--
-- Name: extras_configcontext_roles; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_roles (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    devicerole_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_roles OWNER TO netbox;

--
-- Name: extras_configcontext_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_roles_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_roles_id_seq OWNED BY public.extras_configcontext_roles.id;


--
-- Name: extras_configcontext_sites; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_sites (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_sites OWNER TO netbox;

--
-- Name: extras_configcontext_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_sites_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_sites_id_seq OWNED BY public.extras_configcontext_sites.id;


--
-- Name: extras_configcontext_tenant_groups; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_tenant_groups (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    tenantgroup_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_tenant_groups OWNER TO netbox;

--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_tenant_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_tenant_groups_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_tenant_groups_id_seq OWNED BY public.extras_configcontext_tenant_groups.id;


--
-- Name: extras_configcontext_tenants; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_configcontext_tenants (
    id integer NOT NULL,
    configcontext_id integer NOT NULL,
    tenant_id integer NOT NULL
);


ALTER TABLE public.extras_configcontext_tenants OWNER TO netbox;

--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_configcontext_tenants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_configcontext_tenants_id_seq OWNER TO netbox;

--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_configcontext_tenants_id_seq OWNED BY public.extras_configcontext_tenants.id;


--
-- Name: extras_customfield; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_customfield (
    id integer NOT NULL,
    type smallint NOT NULL,
    name character varying(50) NOT NULL,
    label character varying(50) NOT NULL,
    description character varying(100) NOT NULL,
    required boolean NOT NULL,
    "default" character varying(100) NOT NULL,
    weight smallint NOT NULL,
    filter_logic smallint NOT NULL,
    CONSTRAINT extras_customfield_filter_logic_check CHECK ((filter_logic >= 0)),
    CONSTRAINT extras_customfield_type_check CHECK ((type >= 0)),
    CONSTRAINT extras_customfield_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customfield OWNER TO netbox;

--
-- Name: extras_customfield_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_customfield_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customfield_id_seq OWNER TO netbox;

--
-- Name: extras_customfield_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_customfield_id_seq OWNED BY public.extras_customfield.id;


--
-- Name: extras_customfield_obj_type; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_customfield_obj_type (
    id integer NOT NULL,
    customfield_id integer NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_customfield_obj_type OWNER TO netbox;

--
-- Name: extras_customfield_obj_type_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_customfield_obj_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customfield_obj_type_id_seq OWNER TO netbox;

--
-- Name: extras_customfield_obj_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_customfield_obj_type_id_seq OWNED BY public.extras_customfield_obj_type.id;


--
-- Name: extras_customfieldchoice; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_customfieldchoice (
    id integer NOT NULL,
    value character varying(100) NOT NULL,
    weight smallint NOT NULL,
    field_id integer NOT NULL,
    CONSTRAINT extras_customfieldchoice_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customfieldchoice OWNER TO netbox;

--
-- Name: extras_customfieldchoice_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_customfieldchoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customfieldchoice_id_seq OWNER TO netbox;

--
-- Name: extras_customfieldchoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_customfieldchoice_id_seq OWNED BY public.extras_customfieldchoice.id;


--
-- Name: extras_customfieldvalue; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_customfieldvalue (
    id integer NOT NULL,
    obj_id integer NOT NULL,
    serialized_value character varying(255) NOT NULL,
    field_id integer NOT NULL,
    obj_type_id integer NOT NULL,
    CONSTRAINT extras_customfieldvalue_obj_id_check CHECK ((obj_id >= 0))
);


ALTER TABLE public.extras_customfieldvalue OWNER TO netbox;

--
-- Name: extras_customfieldvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_customfieldvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customfieldvalue_id_seq OWNER TO netbox;

--
-- Name: extras_customfieldvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_customfieldvalue_id_seq OWNED BY public.extras_customfieldvalue.id;


--
-- Name: extras_customlink; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_customlink (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    text character varying(500) NOT NULL,
    url character varying(500) NOT NULL,
    weight smallint NOT NULL,
    group_name character varying(50) NOT NULL,
    button_class character varying(30) NOT NULL,
    new_window boolean NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT extras_customlink_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_customlink OWNER TO netbox;

--
-- Name: extras_customlink_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_customlink_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_customlink_id_seq OWNER TO netbox;

--
-- Name: extras_customlink_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_customlink_id_seq OWNED BY public.extras_customlink.id;


--
-- Name: extras_exporttemplate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_exporttemplate (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    template_code text NOT NULL,
    mime_type character varying(50) NOT NULL,
    file_extension character varying(15) NOT NULL,
    content_type_id integer NOT NULL,
    description character varying(200) NOT NULL,
    template_language smallint NOT NULL,
    CONSTRAINT extras_exporttemplate_template_language_check CHECK ((template_language >= 0))
);


ALTER TABLE public.extras_exporttemplate OWNER TO netbox;

--
-- Name: extras_exporttemplate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_exporttemplate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_exporttemplate_id_seq OWNER TO netbox;

--
-- Name: extras_exporttemplate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_exporttemplate_id_seq OWNED BY public.extras_exporttemplate.id;


--
-- Name: extras_graph; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_graph (
    id integer NOT NULL,
    type smallint NOT NULL,
    weight smallint NOT NULL,
    name character varying(100) NOT NULL,
    source character varying(500) NOT NULL,
    link character varying(200) NOT NULL,
    CONSTRAINT extras_graph_type_check CHECK ((type >= 0)),
    CONSTRAINT extras_graph_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.extras_graph OWNER TO netbox;

--
-- Name: extras_graph_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_graph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_graph_id_seq OWNER TO netbox;

--
-- Name: extras_graph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_graph_id_seq OWNED BY public.extras_graph.id;


--
-- Name: extras_imageattachment; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_imageattachment (
    id integer NOT NULL,
    object_id integer NOT NULL,
    image character varying(100) NOT NULL,
    image_height smallint NOT NULL,
    image_width smallint NOT NULL,
    name character varying(50) NOT NULL,
    created timestamp with time zone NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT extras_imageattachment_image_height_check CHECK ((image_height >= 0)),
    CONSTRAINT extras_imageattachment_image_width_check CHECK ((image_width >= 0)),
    CONSTRAINT extras_imageattachment_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.extras_imageattachment OWNER TO netbox;

--
-- Name: extras_imageattachment_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_imageattachment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_imageattachment_id_seq OWNER TO netbox;

--
-- Name: extras_imageattachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_imageattachment_id_seq OWNED BY public.extras_imageattachment.id;


--
-- Name: extras_objectchange; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_objectchange (
    id integer NOT NULL,
    "time" timestamp with time zone NOT NULL,
    user_name character varying(150) NOT NULL,
    request_id uuid NOT NULL,
    action smallint NOT NULL,
    changed_object_id integer NOT NULL,
    related_object_id integer,
    object_repr character varying(200) NOT NULL,
    object_data jsonb NOT NULL,
    changed_object_type_id integer NOT NULL,
    related_object_type_id integer,
    user_id integer,
    CONSTRAINT extras_objectchange_action_check CHECK ((action >= 0)),
    CONSTRAINT extras_objectchange_changed_object_id_check CHECK ((changed_object_id >= 0)),
    CONSTRAINT extras_objectchange_related_object_id_check CHECK ((related_object_id >= 0))
);


ALTER TABLE public.extras_objectchange OWNER TO netbox;

--
-- Name: extras_objectchange_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_objectchange_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_objectchange_id_seq OWNER TO netbox;

--
-- Name: extras_objectchange_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_objectchange_id_seq OWNED BY public.extras_objectchange.id;


--
-- Name: extras_reportresult; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_reportresult (
    id integer NOT NULL,
    report character varying(255) NOT NULL,
    created timestamp with time zone NOT NULL,
    failed boolean NOT NULL,
    data jsonb NOT NULL,
    user_id integer
);


ALTER TABLE public.extras_reportresult OWNER TO netbox;

--
-- Name: extras_reportresult_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_reportresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_reportresult_id_seq OWNER TO netbox;

--
-- Name: extras_reportresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_reportresult_id_seq OWNED BY public.extras_reportresult.id;


--
-- Name: extras_tag; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    color character varying(6) NOT NULL,
    comments text NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.extras_tag OWNER TO netbox;

--
-- Name: extras_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_tag_id_seq OWNER TO netbox;

--
-- Name: extras_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_tag_id_seq OWNED BY public.extras_tag.id;


--
-- Name: extras_taggeditem; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.extras_taggeditem OWNER TO netbox;

--
-- Name: extras_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_taggeditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_taggeditem_id_seq OWNER TO netbox;

--
-- Name: extras_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_taggeditem_id_seq OWNED BY public.extras_taggeditem.id;


--
-- Name: extras_topologymap; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_topologymap (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    device_patterns text NOT NULL,
    description character varying(100) NOT NULL,
    site_id integer,
    type smallint NOT NULL,
    CONSTRAINT extras_topologymap_type_check CHECK ((type >= 0))
);


ALTER TABLE public.extras_topologymap OWNER TO netbox;

--
-- Name: extras_topologymap_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_topologymap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_topologymap_id_seq OWNER TO netbox;

--
-- Name: extras_topologymap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_topologymap_id_seq OWNED BY public.extras_topologymap.id;


--
-- Name: extras_webhook; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_webhook (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    type_create boolean NOT NULL,
    type_update boolean NOT NULL,
    type_delete boolean NOT NULL,
    payload_url character varying(500) NOT NULL,
    http_content_type smallint NOT NULL,
    secret character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    ssl_verification boolean NOT NULL,
    ca_file_path character varying(4096),
    additional_headers jsonb,
    CONSTRAINT extras_webhook_http_content_type_check CHECK ((http_content_type >= 0))
);


ALTER TABLE public.extras_webhook OWNER TO netbox;

--
-- Name: extras_webhook_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_webhook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_webhook_id_seq OWNER TO netbox;

--
-- Name: extras_webhook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_webhook_id_seq OWNED BY public.extras_webhook.id;


--
-- Name: extras_webhook_obj_type; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.extras_webhook_obj_type (
    id integer NOT NULL,
    webhook_id integer NOT NULL,
    contenttype_id integer NOT NULL
);


ALTER TABLE public.extras_webhook_obj_type OWNER TO netbox;

--
-- Name: extras_webhook_obj_type_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.extras_webhook_obj_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.extras_webhook_obj_type_id_seq OWNER TO netbox;

--
-- Name: extras_webhook_obj_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.extras_webhook_obj_type_id_seq OWNED BY public.extras_webhook_obj_type.id;


--
-- Name: ipam_aggregate; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_aggregate (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    family smallint NOT NULL,
    prefix cidr NOT NULL,
    date_added date,
    description character varying(100) NOT NULL,
    rir_id integer NOT NULL,
    CONSTRAINT ipam_aggregate_family_check CHECK ((family >= 0))
);


ALTER TABLE public.ipam_aggregate OWNER TO netbox;

--
-- Name: ipam_aggregate_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_aggregate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_aggregate_id_seq OWNER TO netbox;

--
-- Name: ipam_aggregate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_aggregate_id_seq OWNED BY public.ipam_aggregate.id;


--
-- Name: ipam_ipaddress; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_ipaddress (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    family smallint NOT NULL,
    address inet NOT NULL,
    description character varying(100) NOT NULL,
    interface_id integer,
    nat_inside_id integer,
    vrf_id integer,
    tenant_id integer,
    status smallint NOT NULL,
    role smallint,
    dns_name character varying(255) NOT NULL,
    CONSTRAINT ipam_ipaddress_family_check CHECK ((family >= 0)),
    CONSTRAINT ipam_ipaddress_role_check CHECK ((role >= 0)),
    CONSTRAINT ipam_ipaddress_status_check CHECK ((status >= 0))
);


ALTER TABLE public.ipam_ipaddress OWNER TO netbox;

--
-- Name: ipam_ipaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_ipaddress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_ipaddress_id_seq OWNER TO netbox;

--
-- Name: ipam_ipaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_ipaddress_id_seq OWNED BY public.ipam_ipaddress.id;


--
-- Name: ipam_prefix; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_prefix (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    family smallint NOT NULL,
    prefix cidr NOT NULL,
    status smallint NOT NULL,
    description character varying(100) NOT NULL,
    role_id integer,
    site_id integer,
    vlan_id integer,
    vrf_id integer,
    tenant_id integer,
    is_pool boolean NOT NULL,
    CONSTRAINT ipam_prefix_family_check CHECK ((family >= 0)),
    CONSTRAINT ipam_prefix_status_check CHECK ((status >= 0))
);


ALTER TABLE public.ipam_prefix OWNER TO netbox;

--
-- Name: ipam_prefix_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_prefix_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_prefix_id_seq OWNER TO netbox;

--
-- Name: ipam_prefix_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_prefix_id_seq OWNED BY public.ipam_prefix.id;


--
-- Name: ipam_rir; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_rir (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    is_private boolean NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.ipam_rir OWNER TO netbox;

--
-- Name: ipam_rir_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_rir_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_rir_id_seq OWNER TO netbox;

--
-- Name: ipam_rir_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_rir_id_seq OWNED BY public.ipam_rir.id;


--
-- Name: ipam_role; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_role (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    weight smallint NOT NULL,
    created date,
    last_updated timestamp with time zone,
    CONSTRAINT ipam_role_weight_check CHECK ((weight >= 0))
);


ALTER TABLE public.ipam_role OWNER TO netbox;

--
-- Name: ipam_role_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_role_id_seq OWNER TO netbox;

--
-- Name: ipam_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_role_id_seq OWNED BY public.ipam_role.id;


--
-- Name: ipam_service; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_service (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(30) NOT NULL,
    protocol smallint NOT NULL,
    port integer NOT NULL,
    description character varying(100) NOT NULL,
    device_id integer,
    virtual_machine_id integer,
    CONSTRAINT ipam_service_port_check CHECK ((port >= 0)),
    CONSTRAINT ipam_service_protocol_check CHECK ((protocol >= 0))
);


ALTER TABLE public.ipam_service OWNER TO netbox;

--
-- Name: ipam_service_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_service_id_seq OWNER TO netbox;

--
-- Name: ipam_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_service_id_seq OWNED BY public.ipam_service.id;


--
-- Name: ipam_service_ipaddresses; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_service_ipaddresses (
    id integer NOT NULL,
    service_id integer NOT NULL,
    ipaddress_id integer NOT NULL
);


ALTER TABLE public.ipam_service_ipaddresses OWNER TO netbox;

--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_service_ipaddresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_service_ipaddresses_id_seq OWNER TO netbox;

--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_service_ipaddresses_id_seq OWNED BY public.ipam_service_ipaddresses.id;


--
-- Name: ipam_vlan; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_vlan (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    vid smallint NOT NULL,
    name character varying(64) NOT NULL,
    status smallint NOT NULL,
    role_id integer,
    site_id integer,
    group_id integer,
    description character varying(100) NOT NULL,
    tenant_id integer,
    CONSTRAINT ipam_vlan_status_check CHECK ((status >= 0)),
    CONSTRAINT ipam_vlan_vid_check CHECK ((vid >= 0))
);


ALTER TABLE public.ipam_vlan OWNER TO netbox;

--
-- Name: ipam_vlan_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_vlan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_vlan_id_seq OWNER TO netbox;

--
-- Name: ipam_vlan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_vlan_id_seq OWNED BY public.ipam_vlan.id;


--
-- Name: ipam_vlangroup; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_vlangroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    site_id integer,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.ipam_vlangroup OWNER TO netbox;

--
-- Name: ipam_vlangroup_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_vlangroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_vlangroup_id_seq OWNER TO netbox;

--
-- Name: ipam_vlangroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_vlangroup_id_seq OWNED BY public.ipam_vlangroup.id;


--
-- Name: ipam_vrf; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.ipam_vrf (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(50) NOT NULL,
    rd character varying(21),
    description character varying(100) NOT NULL,
    enforce_unique boolean NOT NULL,
    tenant_id integer
);


ALTER TABLE public.ipam_vrf OWNER TO netbox;

--
-- Name: ipam_vrf_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.ipam_vrf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ipam_vrf_id_seq OWNER TO netbox;

--
-- Name: ipam_vrf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.ipam_vrf_id_seq OWNED BY public.ipam_vrf.id;


--
-- Name: secrets_secret; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_secret (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    ciphertext bytea NOT NULL,
    hash character varying(128) NOT NULL,
    device_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.secrets_secret OWNER TO netbox;

--
-- Name: secrets_secret_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_secret_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_secret_id_seq OWNER TO netbox;

--
-- Name: secrets_secret_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_secret_id_seq OWNED BY public.secrets_secret.id;


--
-- Name: secrets_secretrole; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_secretrole (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.secrets_secretrole OWNER TO netbox;

--
-- Name: secrets_secretrole_groups; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_secretrole_groups (
    id integer NOT NULL,
    secretrole_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.secrets_secretrole_groups OWNER TO netbox;

--
-- Name: secrets_secretrole_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_secretrole_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_secretrole_groups_id_seq OWNER TO netbox;

--
-- Name: secrets_secretrole_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_secretrole_groups_id_seq OWNED BY public.secrets_secretrole_groups.id;


--
-- Name: secrets_secretrole_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_secretrole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_secretrole_id_seq OWNER TO netbox;

--
-- Name: secrets_secretrole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_secretrole_id_seq OWNED BY public.secrets_secretrole.id;


--
-- Name: secrets_secretrole_users; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_secretrole_users (
    id integer NOT NULL,
    secretrole_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.secrets_secretrole_users OWNER TO netbox;

--
-- Name: secrets_secretrole_users_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_secretrole_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_secretrole_users_id_seq OWNER TO netbox;

--
-- Name: secrets_secretrole_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_secretrole_users_id_seq OWNED BY public.secrets_secretrole_users.id;


--
-- Name: secrets_sessionkey; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_sessionkey (
    id integer NOT NULL,
    cipher bytea NOT NULL,
    hash character varying(128) NOT NULL,
    created timestamp with time zone NOT NULL,
    userkey_id integer NOT NULL
);


ALTER TABLE public.secrets_sessionkey OWNER TO netbox;

--
-- Name: secrets_sessionkey_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_sessionkey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_sessionkey_id_seq OWNER TO netbox;

--
-- Name: secrets_sessionkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_sessionkey_id_seq OWNED BY public.secrets_sessionkey.id;


--
-- Name: secrets_userkey; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.secrets_userkey (
    id integer NOT NULL,
    created date NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    public_key text NOT NULL,
    master_key_cipher bytea,
    user_id integer NOT NULL
);


ALTER TABLE public.secrets_userkey OWNER TO netbox;

--
-- Name: secrets_userkey_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.secrets_userkey_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.secrets_userkey_id_seq OWNER TO netbox;

--
-- Name: secrets_userkey_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.secrets_userkey_id_seq OWNED BY public.secrets_userkey.id;


--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO netbox;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.taggit_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO netbox;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO netbox;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO netbox;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: tenancy_tenant; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.tenancy_tenant (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(30) NOT NULL,
    slug character varying(50) NOT NULL,
    description character varying(100) NOT NULL,
    comments text NOT NULL,
    group_id integer
);


ALTER TABLE public.tenancy_tenant OWNER TO netbox;

--
-- Name: tenancy_tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.tenancy_tenant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenancy_tenant_id_seq OWNER TO netbox;

--
-- Name: tenancy_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.tenancy_tenant_id_seq OWNED BY public.tenancy_tenant.id;


--
-- Name: tenancy_tenantgroup; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.tenancy_tenantgroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.tenancy_tenantgroup OWNER TO netbox;

--
-- Name: tenancy_tenantgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.tenancy_tenantgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tenancy_tenantgroup_id_seq OWNER TO netbox;

--
-- Name: tenancy_tenantgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.tenancy_tenantgroup_id_seq OWNED BY public.tenancy_tenantgroup.id;


--
-- Name: users_token; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.users_token (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    expires timestamp with time zone,
    key character varying(40) NOT NULL,
    write_enabled boolean NOT NULL,
    description character varying(100) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.users_token OWNER TO netbox;

--
-- Name: users_token_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.users_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_token_id_seq OWNER TO netbox;

--
-- Name: users_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.users_token_id_seq OWNED BY public.users_token.id;


--
-- Name: virtualization_cluster; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.virtualization_cluster (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(100) NOT NULL,
    comments text NOT NULL,
    group_id integer,
    type_id integer NOT NULL,
    site_id integer
);


ALTER TABLE public.virtualization_cluster OWNER TO netbox;

--
-- Name: virtualization_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.virtualization_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtualization_cluster_id_seq OWNER TO netbox;

--
-- Name: virtualization_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.virtualization_cluster_id_seq OWNED BY public.virtualization_cluster.id;


--
-- Name: virtualization_clustergroup; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.virtualization_clustergroup (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.virtualization_clustergroup OWNER TO netbox;

--
-- Name: virtualization_clustergroup_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.virtualization_clustergroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtualization_clustergroup_id_seq OWNER TO netbox;

--
-- Name: virtualization_clustergroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.virtualization_clustergroup_id_seq OWNED BY public.virtualization_clustergroup.id;


--
-- Name: virtualization_clustertype; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.virtualization_clustertype (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    created date,
    last_updated timestamp with time zone
);


ALTER TABLE public.virtualization_clustertype OWNER TO netbox;

--
-- Name: virtualization_clustertype_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.virtualization_clustertype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtualization_clustertype_id_seq OWNER TO netbox;

--
-- Name: virtualization_clustertype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.virtualization_clustertype_id_seq OWNED BY public.virtualization_clustertype.id;


--
-- Name: virtualization_virtualmachine; Type: TABLE; Schema: public; Owner: netbox
--

CREATE TABLE public.virtualization_virtualmachine (
    id integer NOT NULL,
    created date,
    last_updated timestamp with time zone,
    name character varying(64) NOT NULL,
    vcpus smallint,
    memory integer,
    disk integer,
    comments text NOT NULL,
    cluster_id integer NOT NULL,
    platform_id integer,
    primary_ip4_id integer,
    primary_ip6_id integer,
    tenant_id integer,
    status smallint NOT NULL,
    role_id integer,
    local_context_data jsonb,
    CONSTRAINT virtualization_virtualmachine_disk_check CHECK ((disk >= 0)),
    CONSTRAINT virtualization_virtualmachine_memory_check CHECK ((memory >= 0)),
    CONSTRAINT virtualization_virtualmachine_status_check CHECK ((status >= 0)),
    CONSTRAINT virtualization_virtualmachine_vcpus_check CHECK ((vcpus >= 0))
);


ALTER TABLE public.virtualization_virtualmachine OWNER TO netbox;

--
-- Name: virtualization_virtualmachine_id_seq; Type: SEQUENCE; Schema: public; Owner: netbox
--

CREATE SEQUENCE public.virtualization_virtualmachine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtualization_virtualmachine_id_seq OWNER TO netbox;

--
-- Name: virtualization_virtualmachine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: netbox
--

ALTER SEQUENCE public.virtualization_virtualmachine_id_seq OWNED BY public.virtualization_virtualmachine.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: circuits_circuit id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit ALTER COLUMN id SET DEFAULT nextval('public.circuits_circuit_id_seq'::regclass);


--
-- Name: circuits_circuittermination id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination ALTER COLUMN id SET DEFAULT nextval('public.circuits_circuittermination_id_seq'::regclass);


--
-- Name: circuits_circuittype id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittype ALTER COLUMN id SET DEFAULT nextval('public.circuits_circuittype_id_seq'::regclass);


--
-- Name: circuits_provider id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_provider ALTER COLUMN id SET DEFAULT nextval('public.circuits_provider_id_seq'::regclass);


--
-- Name: dcim_cable id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable ALTER COLUMN id SET DEFAULT nextval('public.dcim_cable_id_seq'::regclass);


--
-- Name: dcim_consoleport id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport ALTER COLUMN id SET DEFAULT nextval('public.dcim_consoleport_id_seq'::regclass);


--
-- Name: dcim_consoleporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleporttemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_consoleporttemplate_id_seq'::regclass);


--
-- Name: dcim_consoleserverport id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverport ALTER COLUMN id SET DEFAULT nextval('public.dcim_consoleserverport_id_seq'::regclass);


--
-- Name: dcim_consoleserverporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_consoleserverporttemplate_id_seq'::regclass);


--
-- Name: dcim_device id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device ALTER COLUMN id SET DEFAULT nextval('public.dcim_device_id_seq'::regclass);


--
-- Name: dcim_devicebay id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay ALTER COLUMN id SET DEFAULT nextval('public.dcim_devicebay_id_seq'::regclass);


--
-- Name: dcim_devicebaytemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebaytemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_devicebaytemplate_id_seq'::regclass);


--
-- Name: dcim_devicerole id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicerole ALTER COLUMN id SET DEFAULT nextval('public.dcim_devicerole_id_seq'::regclass);


--
-- Name: dcim_devicetype id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicetype ALTER COLUMN id SET DEFAULT nextval('public.dcim_devicetype_id_seq'::regclass);


--
-- Name: dcim_frontport id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport ALTER COLUMN id SET DEFAULT nextval('public.dcim_frontport_id_seq'::regclass);


--
-- Name: dcim_frontporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_frontporttemplate_id_seq'::regclass);


--
-- Name: dcim_interface id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface ALTER COLUMN id SET DEFAULT nextval('public.dcim_interface_id_seq'::regclass);


--
-- Name: dcim_interface_tagged_vlans id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans ALTER COLUMN id SET DEFAULT nextval('public.dcim_interface_tagged_vlans_id_seq'::regclass);


--
-- Name: dcim_interfacetemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interfacetemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_interfacetemplate_id_seq'::regclass);


--
-- Name: dcim_inventoryitem id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem ALTER COLUMN id SET DEFAULT nextval('public.dcim_module_id_seq'::regclass);


--
-- Name: dcim_manufacturer id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_manufacturer ALTER COLUMN id SET DEFAULT nextval('public.dcim_manufacturer_id_seq'::regclass);


--
-- Name: dcim_platform id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_platform ALTER COLUMN id SET DEFAULT nextval('public.dcim_platform_id_seq'::regclass);


--
-- Name: dcim_powerfeed id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed ALTER COLUMN id SET DEFAULT nextval('public.dcim_powerfeed_id_seq'::regclass);


--
-- Name: dcim_poweroutlet id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet ALTER COLUMN id SET DEFAULT nextval('public.dcim_poweroutlet_id_seq'::regclass);


--
-- Name: dcim_poweroutlettemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_poweroutlettemplate_id_seq'::regclass);


--
-- Name: dcim_powerpanel id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerpanel ALTER COLUMN id SET DEFAULT nextval('public.dcim_powerpanel_id_seq'::regclass);


--
-- Name: dcim_powerport id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport ALTER COLUMN id SET DEFAULT nextval('public.dcim_powerport_id_seq'::regclass);


--
-- Name: dcim_powerporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerporttemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_powerporttemplate_id_seq'::regclass);


--
-- Name: dcim_rack id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack ALTER COLUMN id SET DEFAULT nextval('public.dcim_rack_id_seq'::regclass);


--
-- Name: dcim_rackgroup id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackgroup ALTER COLUMN id SET DEFAULT nextval('public.dcim_rackgroup_id_seq'::regclass);


--
-- Name: dcim_rackreservation id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackreservation ALTER COLUMN id SET DEFAULT nextval('public.dcim_rackreservation_id_seq'::regclass);


--
-- Name: dcim_rackrole id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackrole ALTER COLUMN id SET DEFAULT nextval('public.dcim_rackrole_id_seq'::regclass);


--
-- Name: dcim_rearport id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearport ALTER COLUMN id SET DEFAULT nextval('public.dcim_rearport_id_seq'::regclass);


--
-- Name: dcim_rearporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearporttemplate ALTER COLUMN id SET DEFAULT nextval('public.dcim_rearporttemplate_id_seq'::regclass);


--
-- Name: dcim_region id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_region ALTER COLUMN id SET DEFAULT nextval('public.dcim_region_id_seq'::regclass);


--
-- Name: dcim_site id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site ALTER COLUMN id SET DEFAULT nextval('public.dcim_site_id_seq'::regclass);


--
-- Name: dcim_virtualchassis id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_virtualchassis ALTER COLUMN id SET DEFAULT nextval('public.dcim_virtualchassis_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: extras_configcontext id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_id_seq'::regclass);


--
-- Name: extras_configcontext_platforms id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_platforms ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_platforms_id_seq'::regclass);


--
-- Name: extras_configcontext_regions id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_regions ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_regions_id_seq'::regclass);


--
-- Name: extras_configcontext_roles id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_roles ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_roles_id_seq'::regclass);


--
-- Name: extras_configcontext_sites id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_sites ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_sites_id_seq'::regclass);


--
-- Name: extras_configcontext_tenant_groups id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_tenant_groups_id_seq'::regclass);


--
-- Name: extras_configcontext_tenants id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenants ALTER COLUMN id SET DEFAULT nextval('public.extras_configcontext_tenants_id_seq'::regclass);


--
-- Name: extras_customfield id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield ALTER COLUMN id SET DEFAULT nextval('public.extras_customfield_id_seq'::regclass);


--
-- Name: extras_customfield_obj_type id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield_obj_type ALTER COLUMN id SET DEFAULT nextval('public.extras_customfield_obj_type_id_seq'::regclass);


--
-- Name: extras_customfieldchoice id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldchoice ALTER COLUMN id SET DEFAULT nextval('public.extras_customfieldchoice_id_seq'::regclass);


--
-- Name: extras_customfieldvalue id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldvalue ALTER COLUMN id SET DEFAULT nextval('public.extras_customfieldvalue_id_seq'::regclass);


--
-- Name: extras_customlink id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customlink ALTER COLUMN id SET DEFAULT nextval('public.extras_customlink_id_seq'::regclass);


--
-- Name: extras_exporttemplate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_exporttemplate ALTER COLUMN id SET DEFAULT nextval('public.extras_exporttemplate_id_seq'::regclass);


--
-- Name: extras_graph id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_graph ALTER COLUMN id SET DEFAULT nextval('public.extras_graph_id_seq'::regclass);


--
-- Name: extras_imageattachment id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_imageattachment ALTER COLUMN id SET DEFAULT nextval('public.extras_imageattachment_id_seq'::regclass);


--
-- Name: extras_objectchange id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_objectchange ALTER COLUMN id SET DEFAULT nextval('public.extras_objectchange_id_seq'::regclass);


--
-- Name: extras_reportresult id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_reportresult ALTER COLUMN id SET DEFAULT nextval('public.extras_reportresult_id_seq'::regclass);


--
-- Name: extras_tag id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_tag ALTER COLUMN id SET DEFAULT nextval('public.extras_tag_id_seq'::regclass);


--
-- Name: extras_taggeditem id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.extras_taggeditem_id_seq'::regclass);


--
-- Name: extras_topologymap id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_topologymap ALTER COLUMN id SET DEFAULT nextval('public.extras_topologymap_id_seq'::regclass);


--
-- Name: extras_webhook id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook ALTER COLUMN id SET DEFAULT nextval('public.extras_webhook_id_seq'::regclass);


--
-- Name: extras_webhook_obj_type id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook_obj_type ALTER COLUMN id SET DEFAULT nextval('public.extras_webhook_obj_type_id_seq'::regclass);


--
-- Name: ipam_aggregate id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_aggregate ALTER COLUMN id SET DEFAULT nextval('public.ipam_aggregate_id_seq'::regclass);


--
-- Name: ipam_ipaddress id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress ALTER COLUMN id SET DEFAULT nextval('public.ipam_ipaddress_id_seq'::regclass);


--
-- Name: ipam_prefix id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix ALTER COLUMN id SET DEFAULT nextval('public.ipam_prefix_id_seq'::regclass);


--
-- Name: ipam_rir id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_rir ALTER COLUMN id SET DEFAULT nextval('public.ipam_rir_id_seq'::regclass);


--
-- Name: ipam_role id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_role ALTER COLUMN id SET DEFAULT nextval('public.ipam_role_id_seq'::regclass);


--
-- Name: ipam_service id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service ALTER COLUMN id SET DEFAULT nextval('public.ipam_service_id_seq'::regclass);


--
-- Name: ipam_service_ipaddresses id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service_ipaddresses ALTER COLUMN id SET DEFAULT nextval('public.ipam_service_ipaddresses_id_seq'::regclass);


--
-- Name: ipam_vlan id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan ALTER COLUMN id SET DEFAULT nextval('public.ipam_vlan_id_seq'::regclass);


--
-- Name: ipam_vlangroup id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlangroup ALTER COLUMN id SET DEFAULT nextval('public.ipam_vlangroup_id_seq'::regclass);


--
-- Name: ipam_vrf id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vrf ALTER COLUMN id SET DEFAULT nextval('public.ipam_vrf_id_seq'::regclass);


--
-- Name: secrets_secret id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secret ALTER COLUMN id SET DEFAULT nextval('public.secrets_secret_id_seq'::regclass);


--
-- Name: secrets_secretrole id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole ALTER COLUMN id SET DEFAULT nextval('public.secrets_secretrole_id_seq'::regclass);


--
-- Name: secrets_secretrole_groups id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_groups ALTER COLUMN id SET DEFAULT nextval('public.secrets_secretrole_groups_id_seq'::regclass);


--
-- Name: secrets_secretrole_users id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_users ALTER COLUMN id SET DEFAULT nextval('public.secrets_secretrole_users_id_seq'::regclass);


--
-- Name: secrets_sessionkey id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_sessionkey ALTER COLUMN id SET DEFAULT nextval('public.secrets_sessionkey_id_seq'::regclass);


--
-- Name: secrets_userkey id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_userkey ALTER COLUMN id SET DEFAULT nextval('public.secrets_userkey_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Name: tenancy_tenant id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenant ALTER COLUMN id SET DEFAULT nextval('public.tenancy_tenant_id_seq'::regclass);


--
-- Name: tenancy_tenantgroup id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenantgroup ALTER COLUMN id SET DEFAULT nextval('public.tenancy_tenantgroup_id_seq'::regclass);


--
-- Name: users_token id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.users_token ALTER COLUMN id SET DEFAULT nextval('public.users_token_id_seq'::regclass);


--
-- Name: virtualization_cluster id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster ALTER COLUMN id SET DEFAULT nextval('public.virtualization_cluster_id_seq'::regclass);


--
-- Name: virtualization_clustergroup id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustergroup ALTER COLUMN id SET DEFAULT nextval('public.virtualization_clustergroup_id_seq'::regclass);


--
-- Name: virtualization_clustertype id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustertype ALTER COLUMN id SET DEFAULT nextval('public.virtualization_clustertype_id_seq'::regclass);


--
-- Name: virtualization_virtualmachine id; Type: DEFAULT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine ALTER COLUMN id SET DEFAULT nextval('public.virtualization_virtualmachine_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	8	add_logentry
2	Can change log entry	8	change_logentry
3	Can delete log entry	8	delete_logentry
4	Can view log entry	8	view_logentry
5	Can add permission	9	add_permission
6	Can change permission	9	change_permission
7	Can delete permission	9	delete_permission
8	Can view permission	9	view_permission
9	Can add group	10	add_group
10	Can change group	10	change_group
11	Can delete group	10	delete_group
12	Can view group	10	view_group
13	Can add user	11	add_user
14	Can change user	11	change_user
15	Can delete user	11	delete_user
16	Can view user	11	view_user
17	Can add content type	12	add_contenttype
18	Can change content type	12	change_contenttype
19	Can delete content type	12	delete_contenttype
20	Can view content type	12	view_contenttype
21	Can add session	13	add_session
22	Can change session	13	change_session
23	Can delete session	13	delete_session
24	Can view session	13	view_session
25	Can add Tag	14	add_tag
26	Can change Tag	14	change_tag
27	Can delete Tag	14	delete_tag
28	Can view Tag	14	view_tag
29	Can add Tagged Item	15	add_taggeditem
30	Can change Tagged Item	15	change_taggeditem
31	Can delete Tagged Item	15	delete_taggeditem
32	Can view Tagged Item	15	view_taggeditem
33	Can add provider	16	add_provider
34	Can change provider	16	change_provider
35	Can delete provider	16	delete_provider
36	Can view provider	16	view_provider
37	Can add circuit type	17	add_circuittype
38	Can change circuit type	17	change_circuittype
39	Can delete circuit type	17	delete_circuittype
40	Can view circuit type	17	view_circuittype
41	Can add circuit	18	add_circuit
42	Can change circuit	18	change_circuit
43	Can delete circuit	18	delete_circuit
44	Can view circuit	18	view_circuit
45	Can add circuit termination	7	add_circuittermination
46	Can change circuit termination	7	change_circuittermination
47	Can delete circuit termination	7	delete_circuittermination
48	Can view circuit termination	7	view_circuittermination
49	Can add console port	1	add_consoleport
50	Can change console port	1	change_consoleport
51	Can delete console port	1	delete_consoleport
52	Can view console port	1	view_consoleport
53	Can add console port template	19	add_consoleporttemplate
54	Can change console port template	19	change_consoleporttemplate
55	Can delete console port template	19	delete_consoleporttemplate
56	Can view console port template	19	view_consoleporttemplate
57	Can add console server port	2	add_consoleserverport
58	Can change console server port	2	change_consoleserverport
59	Can delete console server port	2	delete_consoleserverport
60	Can view console server port	2	view_consoleserverport
61	Can add console server port template	20	add_consoleserverporttemplate
62	Can change console server port template	20	change_consoleserverporttemplate
63	Can delete console server port template	20	delete_consoleserverporttemplate
64	Can view console server port template	20	view_consoleserverporttemplate
65	Can add device	21	add_device
66	Can change device	21	change_device
67	Can delete device	21	delete_device
68	Can view device	21	view_device
69	Read-only access to devices via NAPALM	21	napalm_read
70	Read/write access to devices via NAPALM	21	napalm_write
71	Can add device role	22	add_devicerole
72	Can change device role	22	change_devicerole
73	Can delete device role	22	delete_devicerole
74	Can view device role	22	view_devicerole
75	Can add device type	23	add_devicetype
76	Can change device type	23	change_devicetype
77	Can delete device type	23	delete_devicetype
78	Can view device type	23	view_devicetype
79	Can add interface	5	add_interface
80	Can change interface	5	change_interface
81	Can delete interface	5	delete_interface
82	Can view interface	5	view_interface
83	Can add interface template	24	add_interfacetemplate
84	Can change interface template	24	change_interfacetemplate
85	Can delete interface template	24	delete_interfacetemplate
86	Can view interface template	24	view_interfacetemplate
87	Can add manufacturer	25	add_manufacturer
88	Can change manufacturer	25	change_manufacturer
89	Can delete manufacturer	25	delete_manufacturer
90	Can view manufacturer	25	view_manufacturer
91	Can add platform	26	add_platform
92	Can change platform	26	change_platform
93	Can delete platform	26	delete_platform
94	Can view platform	26	view_platform
95	Can add power outlet	4	add_poweroutlet
96	Can change power outlet	4	change_poweroutlet
97	Can delete power outlet	4	delete_poweroutlet
98	Can view power outlet	4	view_poweroutlet
99	Can add power outlet template	27	add_poweroutlettemplate
100	Can change power outlet template	27	change_poweroutlettemplate
101	Can delete power outlet template	27	delete_poweroutlettemplate
102	Can view power outlet template	27	view_poweroutlettemplate
103	Can add power port	3	add_powerport
104	Can change power port	3	change_powerport
105	Can delete power port	3	delete_powerport
106	Can view power port	3	view_powerport
107	Can add power port template	28	add_powerporttemplate
108	Can change power port template	28	change_powerporttemplate
109	Can delete power port template	28	delete_powerporttemplate
110	Can view power port template	28	view_powerporttemplate
111	Can add rack	29	add_rack
112	Can change rack	29	change_rack
113	Can delete rack	29	delete_rack
114	Can view rack	29	view_rack
115	Can add rack group	30	add_rackgroup
116	Can change rack group	30	change_rackgroup
117	Can delete rack group	30	delete_rackgroup
118	Can view rack group	30	view_rackgroup
119	Can add site	31	add_site
120	Can change site	31	change_site
121	Can delete site	31	delete_site
122	Can view site	31	view_site
123	Can add device bay	32	add_devicebay
124	Can change device bay	32	change_devicebay
125	Can delete device bay	32	delete_devicebay
126	Can view device bay	32	view_devicebay
127	Can add device bay template	33	add_devicebaytemplate
128	Can change device bay template	33	change_devicebaytemplate
129	Can delete device bay template	33	delete_devicebaytemplate
130	Can view device bay template	33	view_devicebaytemplate
131	Can add rack role	34	add_rackrole
132	Can change rack role	34	change_rackrole
133	Can delete rack role	34	delete_rackrole
134	Can view rack role	34	view_rackrole
135	Can add rack reservation	35	add_rackreservation
136	Can change rack reservation	35	change_rackreservation
137	Can delete rack reservation	35	delete_rackreservation
138	Can view rack reservation	35	view_rackreservation
139	Can add region	36	add_region
140	Can change region	36	change_region
141	Can delete region	36	delete_region
142	Can view region	36	view_region
143	Can add inventory item	37	add_inventoryitem
144	Can change inventory item	37	change_inventoryitem
145	Can delete inventory item	37	delete_inventoryitem
146	Can view inventory item	37	view_inventoryitem
147	Can add virtual chassis	38	add_virtualchassis
148	Can change virtual chassis	38	change_virtualchassis
149	Can delete virtual chassis	38	delete_virtualchassis
150	Can view virtual chassis	38	view_virtualchassis
151	Can add front port	39	add_frontport
152	Can change front port	39	change_frontport
153	Can delete front port	39	delete_frontport
154	Can view front port	39	view_frontport
155	Can add front port template	40	add_frontporttemplate
156	Can change front port template	40	change_frontporttemplate
157	Can delete front port template	40	delete_frontporttemplate
158	Can view front port template	40	view_frontporttemplate
159	Can add rear port	41	add_rearport
160	Can change rear port	41	change_rearport
161	Can delete rear port	41	delete_rearport
162	Can view rear port	41	view_rearport
163	Can add rear port template	42	add_rearporttemplate
164	Can change rear port template	42	change_rearporttemplate
165	Can delete rear port template	42	delete_rearporttemplate
166	Can view rear port template	42	view_rearporttemplate
167	Can add cable	43	add_cable
168	Can change cable	43	change_cable
169	Can delete cable	43	delete_cable
170	Can view cable	43	view_cable
171	Can add power feed	44	add_powerfeed
172	Can change power feed	44	change_powerfeed
173	Can delete power feed	44	delete_powerfeed
174	Can view power feed	44	view_powerfeed
175	Can add power panel	45	add_powerpanel
176	Can change power panel	45	change_powerpanel
177	Can delete power panel	45	delete_powerpanel
178	Can view power panel	45	view_powerpanel
179	Can add aggregate	46	add_aggregate
180	Can change aggregate	46	change_aggregate
181	Can delete aggregate	46	delete_aggregate
182	Can view aggregate	46	view_aggregate
183	Can add IP address	47	add_ipaddress
184	Can change IP address	47	change_ipaddress
185	Can delete IP address	47	delete_ipaddress
186	Can view IP address	47	view_ipaddress
187	Can add prefix	48	add_prefix
188	Can change prefix	48	change_prefix
189	Can delete prefix	48	delete_prefix
190	Can view prefix	48	view_prefix
191	Can add RIR	49	add_rir
192	Can change RIR	49	change_rir
193	Can delete RIR	49	delete_rir
194	Can view RIR	49	view_rir
195	Can add role	50	add_role
196	Can change role	50	change_role
197	Can delete role	50	delete_role
198	Can view role	50	view_role
199	Can add VLAN	51	add_vlan
200	Can change VLAN	51	change_vlan
201	Can delete VLAN	51	delete_vlan
202	Can view VLAN	51	view_vlan
203	Can add VRF	52	add_vrf
204	Can change VRF	52	change_vrf
205	Can delete VRF	52	delete_vrf
206	Can view VRF	52	view_vrf
207	Can add VLAN group	53	add_vlangroup
208	Can change VLAN group	53	change_vlangroup
209	Can delete VLAN group	53	delete_vlangroup
210	Can view VLAN group	53	view_vlangroup
211	Can add service	54	add_service
212	Can change service	54	change_service
213	Can delete service	54	delete_service
214	Can view service	54	view_service
215	Can add export template	55	add_exporttemplate
216	Can change export template	55	change_exporttemplate
217	Can delete export template	55	delete_exporttemplate
218	Can view export template	55	view_exporttemplate
219	Can add graph	56	add_graph
220	Can change graph	56	change_graph
221	Can delete graph	56	delete_graph
222	Can view graph	56	view_graph
223	Can add topology map	57	add_topologymap
224	Can change topology map	57	change_topologymap
225	Can delete topology map	57	delete_topologymap
226	Can view topology map	57	view_topologymap
227	Can add custom field	58	add_customfield
228	Can change custom field	58	change_customfield
229	Can delete custom field	58	delete_customfield
230	Can view custom field	58	view_customfield
231	Can add custom field choice	59	add_customfieldchoice
232	Can change custom field choice	59	change_customfieldchoice
233	Can delete custom field choice	59	delete_customfieldchoice
234	Can view custom field choice	59	view_customfieldchoice
235	Can add custom field value	60	add_customfieldvalue
236	Can change custom field value	60	change_customfieldvalue
237	Can delete custom field value	60	delete_customfieldvalue
238	Can view custom field value	60	view_customfieldvalue
239	Can add image attachment	61	add_imageattachment
240	Can change image attachment	61	change_imageattachment
241	Can delete image attachment	61	delete_imageattachment
242	Can view image attachment	61	view_imageattachment
243	Can add report result	62	add_reportresult
244	Can change report result	62	change_reportresult
245	Can delete report result	62	delete_reportresult
246	Can view report result	62	view_reportresult
247	Can add webhook	63	add_webhook
248	Can change webhook	63	change_webhook
249	Can delete webhook	63	delete_webhook
250	Can view webhook	63	view_webhook
251	Can add object change	64	add_objectchange
252	Can change object change	64	change_objectchange
253	Can delete object change	64	delete_objectchange
254	Can view object change	64	view_objectchange
255	Can add config context	65	add_configcontext
256	Can change config context	65	change_configcontext
257	Can delete config context	65	delete_configcontext
258	Can view config context	65	view_configcontext
259	Can add tag	66	add_tag
260	Can change tag	66	change_tag
261	Can delete tag	66	delete_tag
262	Can view tag	66	view_tag
263	Can add tagged item	67	add_taggeditem
264	Can change tagged item	67	change_taggeditem
265	Can delete tagged item	67	delete_taggeditem
266	Can view tagged item	67	view_taggeditem
267	Can add custom link	68	add_customlink
268	Can change custom link	68	change_customlink
269	Can delete custom link	68	delete_customlink
270	Can view custom link	68	view_customlink
271	Can add script	69	add_script
272	Can change script	69	change_script
273	Can delete script	69	delete_script
274	Can view script	69	view_script
275	Can run script	69	run_script
276	Can add secret role	70	add_secretrole
277	Can change secret role	70	change_secretrole
278	Can delete secret role	70	delete_secretrole
279	Can view secret role	70	view_secretrole
280	Can add secret	71	add_secret
281	Can change secret	71	change_secret
282	Can delete secret	71	delete_secret
283	Can view secret	71	view_secret
284	Can add user key	72	add_userkey
285	Can change user key	72	change_userkey
286	Can delete user key	72	delete_userkey
287	Can view user key	72	view_userkey
288	Can activate user keys for decryption	72	activate_userkey
289	Can add session key	73	add_sessionkey
290	Can change session key	73	change_sessionkey
291	Can delete session key	73	delete_sessionkey
292	Can view session key	73	view_sessionkey
293	Can add tenant	74	add_tenant
294	Can change tenant	74	change_tenant
295	Can delete tenant	74	delete_tenant
296	Can view tenant	74	view_tenant
297	Can add tenant group	75	add_tenantgroup
298	Can change tenant group	75	change_tenantgroup
299	Can delete tenant group	75	delete_tenantgroup
300	Can view tenant group	75	view_tenantgroup
301	Can add token	76	add_token
302	Can change token	76	change_token
303	Can delete token	76	delete_token
304	Can view token	76	view_token
305	Can add cluster	77	add_cluster
306	Can change cluster	77	change_cluster
307	Can delete cluster	77	delete_cluster
308	Can view cluster	77	view_cluster
309	Can add cluster group	78	add_clustergroup
310	Can change cluster group	78	change_clustergroup
311	Can delete cluster group	78	delete_clustergroup
312	Can view cluster group	78	view_clustergroup
313	Can add cluster type	79	add_clustertype
314	Can change cluster type	79	change_clustertype
315	Can delete cluster type	79	delete_clustertype
316	Can view cluster type	79	view_clustertype
317	Can add virtual machine	80	add_virtualmachine
318	Can change virtual machine	80	change_virtualmachine
319	Can delete virtual machine	80	delete_virtualmachine
320	Can view virtual machine	80	view_virtualmachine
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$150000$BiGPzkUex4pw$g7OX1oddQbKWCNquK96CmRfVEXuMhn/0PiKxtle1/7U=	2020-01-13 22:09:25.454932+03	t	admin				t	t	2020-01-13 21:58:50.078569+03
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: circuits_circuit; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.circuits_circuit (id, created, last_updated, cid, install_date, commit_rate, comments, provider_id, type_id, tenant_id, description, status) FROM stdin;
\.


--
-- Data for Name: circuits_circuittermination; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.circuits_circuittermination (id, term_side, port_speed, upstream_speed, xconnect_id, pp_info, circuit_id, site_id, connected_endpoint_id, connection_status, cable_id, description) FROM stdin;
\.


--
-- Data for Name: circuits_circuittype; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.circuits_circuittype (id, name, slug, created, last_updated) FROM stdin;
\.


--
-- Data for Name: circuits_provider; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.circuits_provider (id, created, last_updated, name, slug, asn, account, portal_url, noc_contact, admin_contact, comments) FROM stdin;
\.


--
-- Data for Name: dcim_cable; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_cable (id, created, last_updated, termination_a_id, termination_b_id, type, status, label, color, length, length_unit, _abs_length, termination_a_type_id, termination_b_type_id, _termination_a_device_id, _termination_b_device_id) FROM stdin;
1	2020-01-14	2020-01-14 21:57:18.721369+03	8	48	\N	t		4caf50	\N	\N	\N	5	5	8	12
2	2020-01-14	2020-01-14 21:57:58.501691+03	9	58	\N	t		4caf50	\N	\N	\N	5	5	8	13
3	2020-01-14	2020-01-14 21:58:36.115916+03	10	68	\N	t		4caf50	\N	\N	\N	5	5	8	14
4	2020-01-14	2020-01-14 21:59:05.422076+03	11	78	\N	t		4caf50	\N	\N	\N	5	5	8	15
5	2020-01-14	2020-01-14 21:59:34.190112+03	18	49	\N	t		4caf50	\N	\N	\N	5	5	9	12
6	2020-01-14	2020-01-14 21:59:54.237099+03	19	59	\N	t		4caf50	\N	\N	\N	5	5	9	13
7	2020-01-14	2020-01-14 22:00:20.536464+03	20	69	\N	t		4caf50	\N	\N	\N	5	5	9	14
8	2020-01-14	2020-01-14 22:00:46.655352+03	21	79	\N	t		4caf50	\N	\N	\N	5	5	9	15
9	2020-01-14	2020-01-14 22:01:14.367413+03	28	50	\N	t		4caf50	\N	\N	\N	5	5	10	12
10	2020-01-14	2020-01-14 22:01:32.822111+03	29	60	\N	t		4caf50	\N	\N	\N	5	5	10	13
11	2020-01-14	2020-01-14 22:02:18.371239+03	30	70	\N	t		4caf50	\N	\N	\N	5	5	10	14
12	2020-01-14	2020-01-14 22:02:54.508271+03	31	80	\N	t		4caf50	\N	\N	\N	5	5	10	15
13	2020-01-14	2020-01-14 22:03:50.347431+03	38	51	\N	t		4caf50	\N	\N	\N	5	5	11	12
14	2020-01-14	2020-01-14 22:04:25.802044+03	39	61	\N	t		4caf50	\N	\N	\N	5	5	11	13
15	2020-01-14	2020-01-14 22:04:44.396996+03	40	71	\N	t		4caf50	\N	\N	\N	5	5	11	14
16	2020-01-14	2020-01-14 22:05:04.519105+03	41	81	\N	t		4caf50	\N	\N	\N	5	5	11	15
18	2020-01-14	2020-01-14 22:07:55.379943+03	89	66	\N	t		f44336	\N	\N	\N	5	5	16	13
17	2020-01-14	2020-01-14 22:08:46.490294+03	88	56	\N	t		f44336	\N	\N	\N	5	5	16	12
19	2020-01-14	2020-01-14 22:09:22.441858+03	90	76	\N	t		f44336	\N	\N	\N	5	5	16	14
20	2020-01-14	2020-01-14 22:09:41.980361+03	91	86	\N	t		f44336	\N	\N	\N	5	5	16	15
21	2020-01-14	2020-01-14 22:10:13.218225+03	99	55	\N	t		f44336	\N	\N	\N	5	5	17	12
22	2020-01-14	2020-01-14 22:10:32.005587+03	100	65	\N	t		f44336	\N	\N	\N	5	5	17	13
23	2020-01-14	2020-01-14 22:11:30.901923+03	101	75	\N	t		f44336	\N	\N	\N	5	5	17	14
24	2020-01-14	2020-01-14 22:12:12.664645+03	102	85	\N	t		f44336	\N	\N	\N	5	5	17	15
25	2020-01-16	2020-01-16 17:52:37.616757+03	16	3	\N	t			\N	\N	\N	5	5	8	3
26	2020-01-16	2020-01-16 17:52:57.482071+03	15	2	\N	t			\N	\N	\N	5	5	8	2
27	2020-01-16	2020-01-16 17:53:15.934754+03	14	1	\N	t			\N	\N	\N	5	5	8	1
28	2020-01-16	2020-01-16 17:56:56.778255+03	26	5	\N	t			\N	\N	\N	5	5	9	5
29	2020-01-16	2020-01-16 17:57:46.991346+03	25	4	\N	t			\N	\N	\N	5	5	9	4
30	2020-01-16	2020-01-16 17:58:46.346734+03	36	7	\N	t			\N	\N	\N	5	5	10	7
31	2020-01-16	2020-01-16 17:59:12.219654+03	35	6	\N	t			\N	\N	\N	5	5	10	6
\.


--
-- Data for Name: dcim_consoleport; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_consoleport (id, name, connection_status, connected_endpoint_id, device_id, cable_id, description) FROM stdin;
\.


--
-- Data for Name: dcim_consoleporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_consoleporttemplate (id, name, device_type_id) FROM stdin;
\.


--
-- Data for Name: dcim_consoleserverport; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_consoleserverport (id, name, device_id, cable_id, connection_status, description) FROM stdin;
\.


--
-- Data for Name: dcim_consoleserverporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_consoleserverporttemplate (id, name, device_type_id) FROM stdin;
\.


--
-- Data for Name: dcim_device; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_device (id, created, last_updated, name, serial, "position", face, status, comments, device_role_id, device_type_id, platform_id, rack_id, primary_ip4_id, primary_ip6_id, tenant_id, asset_tag, site_id, cluster_id, virtual_chassis_id, vc_position, vc_priority, local_context_data) FROM stdin;
1	2020-01-14	2020-01-14 21:39:01.288081+03	mlg-host-0		41	0	1		1	4	\N	1	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
2	2020-01-14	2020-01-14 21:39:45.587387+03	mlg-host-1		40	0	1		1	4	\N	1	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
3	2020-01-14	2020-01-14 21:40:08.164421+03	mlg-host-2		39	0	1		1	4	\N	1	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
4	2020-01-14	2020-01-14 21:40:57.10606+03	mlg-host-30		41	0	1		1	4	\N	2	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
5	2020-01-14	2020-01-14 21:41:43.599753+03	mlg-host-31		40	0	1		1	4	\N	2	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
6	2020-01-14	2020-01-14 21:42:55.398266+03	mlg-host-150		41	0	1		1	4	\N	7	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
7	2020-01-14	2020-01-14 21:43:28.101451+03	mlg-host-152		39	0	1		1	4	\N	7	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
10	2020-01-14	2020-01-14 21:45:52.925053+03	mlg-leaf-5		42	0	1		2	2	\N	7	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
11	2020-01-14	2020-01-14 21:46:26.297299+03	mlg-leaf-6		42	0	1		2	2	\N	8	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
8	2020-01-14	2020-01-14 21:46:55.066672+03	mlg-leaf-0		42	0	1		2	2	\N	1	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
9	2020-01-14	2020-01-14 21:47:06.080779+03	mlg-leaf-1		42	0	1		2	2	\N	2	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
12	2020-01-14	2020-01-14 21:51:35.621663+03	mlg-spine-0		38	0	1		3	2	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
13	2020-01-14	2020-01-14 21:52:13.466283+03	mlg-spine-1		37	0	1		3	2	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
14	2020-01-14	2020-01-14 21:52:53.055019+03	mlg-spine-2		36	0	1		3	2	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
15	2020-01-14	2020-01-14 21:53:18.702559+03	mlg-spine-3		35	0	1		3	2	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
16	2020-01-14	2020-01-14 21:54:23.617154+03	mlg-edge-0		42	0	1		4	1	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
17	2020-01-14	2020-01-14 21:54:50.860253+03	mlg-edge-1		41	0	1		4	1	\N	5	\N	\N	\N	\N	6	\N	\N	\N	\N	\N
\.


--
-- Data for Name: dcim_devicebay; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_devicebay (id, name, device_id, installed_device_id, description) FROM stdin;
\.


--
-- Data for Name: dcim_devicebaytemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_devicebaytemplate (id, name, device_type_id) FROM stdin;
\.


--
-- Data for Name: dcim_devicerole; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_devicerole (id, name, slug, color, vm_role, created, last_updated) FROM stdin;
1	Server	server	aa1409	f	2020-01-14	2020-01-14 21:33:11.826337+03
2	Leaf	leaf	4caf50	f	2020-01-14	2020-01-14 21:35:13.226353+03
3	Spine	spine	2196f3	f	2020-01-14	2020-01-14 21:35:25.173903+03
4	Edge	edge	f44336	f	2020-01-14	2020-01-14 21:35:41.295523+03
5	MGMT switch	mgmt-switch	9e9e9e	f	2020-01-14	2020-01-14 21:37:15.246936+03
\.


--
-- Data for Name: dcim_devicetype; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_devicetype (id, model, slug, u_height, is_full_depth, manufacturer_id, subdevice_role, part_number, comments, created, last_updated) FROM stdin;
1	vMX	vmx	1	t	2	\N			2020-01-14	2020-01-14 09:57:20.579179+03
2	vEOS	veos	1	t	1	\N			2020-01-14	2020-01-14 10:20:48.809702+03
3	vIOS	vios	1	t	3	\N			2020-01-14	2020-01-14 10:26:16.000386+03
4	Server	server	1	t	4	\N			2020-01-14	2020-01-14 21:30:29.481031+03
\.


--
-- Data for Name: dcim_frontport; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_frontport (id, name, type, rear_port_position, description, device_id, rear_port_id, cable_id) FROM stdin;
\.


--
-- Data for Name: dcim_frontporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_frontporttemplate (id, name, type, rear_port_position, device_type_id, rear_port_id) FROM stdin;
\.


--
-- Data for Name: dcim_interface; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_interface (id, name, type, mgmt_only, description, device_id, mac_address, lag_id, enabled, mtu, virtual_machine_id, mode, untagged_vlan_id, _connected_circuittermination_id, _connected_interface_id, connection_status, cable_id) FROM stdin;
88	ge-0/0/0	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	56	t	17
56	Ethernet9	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	88	t	17
12	Ethernet5	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
13	Ethernet6	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
17	Mgmt1	1000	f		8	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
90	ge-0/0/2	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	76	t	19
76	Ethernet9	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	90	t	19
22	Ethernet5	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
23	Ethernet6	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
24	Ethernet7	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
27	Mgmt1	1000	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
91	ge-0/0/3	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	86	t	20
86	Ethernet9	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	91	t	20
32	Ethernet5	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
33	Ethernet6	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
34	Ethernet7	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
37	Mgmt1	1000	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
99	ge-0/0/0	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	55	t	21
55	Ethernet8	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	99	t	21
42	Ethernet5	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
43	Ethernet6	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
44	Ethernet7	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
45	Ethernet8	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
46	Ethernet9	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
47	Mgmt1	1000	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
100	ge-0/0/1	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	65	t	22
65	Ethernet8	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	100	t	22
52	Ethernet5	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
53	Ethernet6	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
54	Ethernet7	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
101	ge-0/0/2	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	75	t	23
57	Mgmt1	1000	f		12	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
75	Ethernet8	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	101	t	23
102	ge-0/0/3	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	85	t	24
62	Ethernet5	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
63	Ethernet6	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
64	Ethernet7	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
85	Ethernet8	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	102	t	24
67	Mgmt1	1000	f		13	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
110	Loopback0	0	f		8	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
111	Vlan127	0	f		8	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
112	Loopback0	0	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
72	Ethernet5	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
73	Ethernet6	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
74	Ethernet7	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
77	Mgmt1	1000	f		14	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
3	eth0	1200	f		3	\N	\N	t	\N	\N	\N	\N	\N	16	t	25
82	Ethernet5	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
83	Ethernet6	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
84	Ethernet7	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
87	Mgmt1	1000	f		15	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
92	ge-0/0/4	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
93	ge-0/0/5	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
94	ge-0/0/6	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
95	ge-0/0/7	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
96	ge-0/0/8	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
97	ge-0/0/9	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
98	em0	1000	t		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
103	ge-0/0/4	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
104	ge-0/0/5	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
105	ge-0/0/6	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
106	ge-0/0/7	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
107	ge-0/0/8	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
108	ge-0/0/9	1200	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
109	em0	1000	t		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
1	eth0	1200	f		1	\N	\N	t	\N	\N	\N	\N	\N	14	t	27
8	Ethernet1	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	48	t	1
48	Ethernet1	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	8	t	1
15	Ethernet8	1200	f		8	\N	\N	t	\N	\N	100	1	\N	2	t	26
14	Ethernet7	1200	f		8	\N	\N	t	\N	\N	100	1	\N	1	t	27
9	Ethernet2	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	58	t	2
58	Ethernet1	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	9	t	2
10	Ethernet3	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	68	t	3
68	Ethernet1	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	10	t	3
5	eth0	1200	f		5	\N	\N	t	\N	\N	\N	\N	\N	26	t	28
11	Ethernet4	1200	f		8	\N	\N	t	\N	\N	\N	\N	\N	78	t	4
78	Ethernet1	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	11	t	4
18	Ethernet1	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	49	t	5
49	Ethernet2	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	18	t	5
4	eth0	1200	f		4	\N	\N	t	\N	\N	\N	\N	\N	25	t	29
26	Ethernet9	1200	f		9	\N	\N	t	\N	\N	100	1	\N	5	t	28
19	Ethernet2	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	59	t	6
59	Ethernet2	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	19	t	6
20	Ethernet3	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	69	t	7
69	Ethernet2	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	20	t	7
7	eth0	1200	f		7	\N	\N	t	\N	\N	\N	\N	\N	36	t	30
21	Ethernet4	1200	f		9	\N	\N	t	\N	\N	\N	\N	\N	79	t	8
79	Ethernet2	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	21	t	8
28	Ethernet1	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	50	t	9
50	Ethernet3	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	28	t	9
35	Ethernet8	1200	f		10	\N	\N	t	\N	\N	100	1	\N	6	t	31
29	Ethernet2	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	60	t	10
60	Ethernet3	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	29	t	10
30	Ethernet3	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	70	t	11
70	Ethernet3	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	30	t	11
31	Ethernet4	1200	f		10	\N	\N	t	\N	\N	\N	\N	\N	80	t	12
80	Ethernet3	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	31	t	12
38	Ethernet1	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	51	t	13
51	Ethernet4	1200	f		12	\N	\N	t	\N	\N	\N	\N	\N	38	t	13
39	Ethernet2	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	61	t	14
61	Ethernet4	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	39	t	14
40	Ethernet3	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	71	t	15
71	Ethernet4	1200	f		14	\N	\N	t	\N	\N	\N	\N	\N	40	t	15
41	Ethernet4	1200	f		11	\N	\N	t	\N	\N	\N	\N	\N	81	t	16
81	Ethernet4	1200	f		15	\N	\N	t	\N	\N	\N	\N	\N	41	t	16
89	ge-0/0/1	1200	f		16	\N	\N	t	\N	\N	\N	\N	\N	66	t	18
66	Ethernet9	1200	f		13	\N	\N	t	\N	\N	\N	\N	\N	89	t	18
113	Vlan127	0	f		9	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
115	Vlan127	0	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
114	Loopback0	0	f		10	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
116	Loopback0	0	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
117	Vlan127	0	f		11	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
118	Loopback0	0	f		12	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
119	Loopback0	0	f		13	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
120	Loopback0	0	f		14	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
121	Loopback0	0	f		15	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
123	lo0	0	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
124	lo0.0	0	f		16	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
125	lo0	0	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
126	lo0.0	0	f		17	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
2	eth0	1200	f		2	\N	\N	t	\N	\N	\N	\N	\N	15	t	26
16	Ethernet9	1200	f		8	\N	\N	t	\N	\N	100	1	\N	3	t	25
25	Ethernet8	1200	f		9	\N	\N	t	\N	\N	100	1	\N	4	t	29
6	eth0	1200	f		6	\N	\N	t	\N	\N	\N	\N	\N	35	t	31
36	Ethernet9	1200	f		10	\N	\N	t	\N	\N	100	1	\N	7	t	30
\.


--
-- Data for Name: dcim_interface_tagged_vlans; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_interface_tagged_vlans (id, interface_id, vlan_id) FROM stdin;
\.


--
-- Data for Name: dcim_interfacetemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_interfacetemplate (id, name, type, mgmt_only, device_type_id) FROM stdin;
1	Mgmt1	1000	f	2
2	GigabitEthernet0/0	1000	f	3
3	GigabitEthernet0/1	1000	f	3
4	GigabitEthernet0/2	1000	f	3
5	GigabitEthernet0/3	1000	f	3
6	GigabitEthernet1/0	1000	f	3
7	GigabitEthernet1/1	1000	f	3
8	GigabitEthernet1/2	1000	f	3
9	GigabitEthernet1/3	1000	f	3
10	GigabitEthernet2/0	1000	f	3
11	GigabitEthernet2/1	1000	f	3
12	GigabitEthernet2/2	1000	f	3
13	GigabitEthernet2/3	1000	f	3
14	GigabitEthernet3/0	1000	f	3
15	GigabitEthernet3/1	1000	f	3
16	GigabitEthernet3/2	1000	f	3
17	GigabitEthernet3/3	1000	f	3
18	ge-0/0/0	1200	f	1
19	ge-0/0/1	1200	f	1
20	ge-0/0/2	1200	f	1
21	ge-0/0/3	1200	f	1
22	ge-0/0/4	1200	f	1
23	ge-0/0/5	1200	f	1
24	ge-0/0/6	1200	f	1
25	ge-0/0/7	1200	f	1
26	ge-0/0/8	1200	f	1
27	ge-0/0/9	1200	f	1
28	em0	1000	t	1
29	Ethernet1	1200	f	2
30	Ethernet2	1200	f	2
31	Ethernet3	1200	f	2
32	Ethernet4	1200	f	2
33	Ethernet5	1200	f	2
34	Ethernet6	1200	f	2
35	Ethernet7	1200	f	2
36	Ethernet8	1200	f	2
37	Ethernet9	1200	f	2
38	eth0	1200	f	4
\.


--
-- Data for Name: dcim_inventoryitem; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_inventoryitem (id, name, part_id, serial, discovered, device_id, parent_id, manufacturer_id, asset_tag, description) FROM stdin;
\.


--
-- Data for Name: dcim_manufacturer; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_manufacturer (id, name, slug, created, last_updated) FROM stdin;
1	Arista	arista	2020-01-14	2020-01-14 09:53:25.673945+03
2	Juniper	juniper	2020-01-14	2020-01-14 09:53:35.080969+03
3	Cisco	cisco	2020-01-14	2020-01-14 10:26:04.144997+03
4	Hypermacro	hypermacro	2020-01-14	2020-01-14 21:30:00.909169+03
\.


--
-- Data for Name: dcim_platform; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_platform (id, name, slug, napalm_driver, manufacturer_id, created, last_updated, napalm_args) FROM stdin;
\.


--
-- Data for Name: dcim_powerfeed; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_powerfeed (id, created, last_updated, name, status, type, supply, phase, voltage, amperage, max_utilization, available_power, comments, cable_id, power_panel_id, rack_id, connected_endpoint_id, connection_status) FROM stdin;
\.


--
-- Data for Name: dcim_poweroutlet; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_poweroutlet (id, name, device_id, cable_id, connection_status, description, feed_leg, power_port_id) FROM stdin;
\.


--
-- Data for Name: dcim_poweroutlettemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_poweroutlettemplate (id, name, device_type_id, feed_leg, power_port_id) FROM stdin;
\.


--
-- Data for Name: dcim_powerpanel; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_powerpanel (id, created, last_updated, name, rack_group_id, site_id) FROM stdin;
\.


--
-- Data for Name: dcim_powerport; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_powerport (id, name, connection_status, device_id, _connected_poweroutlet_id, cable_id, description, _connected_powerfeed_id, allocated_draw, maximum_draw) FROM stdin;
\.


--
-- Data for Name: dcim_powerporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_powerporttemplate (id, name, device_type_id, allocated_draw, maximum_draw) FROM stdin;
\.


--
-- Data for Name: dcim_rack; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rack (id, created, last_updated, name, facility_id, u_height, comments, group_id, site_id, tenant_id, type, width, role_id, desc_units, serial, status, asset_tag, outer_depth, outer_unit, outer_width) FROM stdin;
4	2020-01-14	2020-01-14 10:13:51.072309+03	C	\N	42		\N	3	\N	\N	19	1	f		3	\N	\N	\N	\N
1	2020-01-14	2020-01-14 10:14:20.795246+03	A	\N	42		\N	6	\N	\N	19	1	f		3	\N	\N	\N	\N
2	2020-01-14	2020-01-14 10:14:20.806152+03	B	\N	42		\N	6	\N	\N	19	1	f		3	\N	\N	\N	\N
3	2020-01-14	2020-01-14 10:14:36.768405+03	A	\N	42		\N	3	\N	\N	19	1	f		3	\N	\N	\N	\N
5	2020-01-14	2020-01-14 10:15:07.050848+03	L	\N	42		\N	6	\N	\N	19	2	f		3	\N	\N	\N	\N
6	2020-01-14	2020-01-14 10:15:30.67357+03	L	\N	42		\N	3	\N	\N	19	2	f		3	\N	\N	\N	\N
7	2020-01-14	2020-01-14 10:16:26.60946+03	F	\N	42		\N	6	\N	\N	19	1	f		3	\N	\N	\N	\N
8	2020-01-14	2020-01-14 10:18:31.583979+03	G	\N	42		\N	6	\N	\N	19	1	f		3	\N	\N	\N	\N
\.


--
-- Data for Name: dcim_rackgroup; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rackgroup (id, name, slug, site_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_rackreservation; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rackreservation (id, units, created, description, rack_id, user_id, tenant_id, last_updated) FROM stdin;
\.


--
-- Data for Name: dcim_rackrole; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rackrole (id, name, slug, color, created, last_updated) FROM stdin;
1	Серверные стойки	server-racks	c0c0c0	2020-01-14	2020-01-14 10:07:34.191237+03
2	Инфраструктурные стойки	infra-racks	f44336	2020-01-14	2020-01-14 10:07:47.171428+03
\.


--
-- Data for Name: dcim_rearport; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rearport (id, name, type, positions, description, device_id, cable_id) FROM stdin;
\.


--
-- Data for Name: dcim_rearporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_rearporttemplate (id, name, type, positions, device_type_id) FROM stdin;
\.


--
-- Data for Name: dcim_region; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_region (id, name, slug, lft, rght, tree_id, level, parent_id, created, last_updated) FROM stdin;
2	Испания	sp	1	2	1	0	\N	2020-01-14	2020-01-14 09:17:18.960303+03
1	Россия	ru	1	2	3	0	\N	2020-01-14	2020-01-14 09:16:54.940447+03
3	Китай	cn	1	2	2	0	\N	2020-01-14	2020-01-14 09:17:27.719496+03
\.


--
-- Data for Name: dcim_site; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_site (id, created, last_updated, name, slug, facility, asn, physical_address, shipping_address, comments, tenant_id, contact_email, contact_name, contact_phone, region_id, description, status, time_zone, latitude, longitude) FROM stdin;
1	2020-01-14	2020-01-14 09:13:25.082782+03	Москва	msk		64512				\N				1		1	Europe/Moscow	\N	\N
2	2020-01-14	2020-01-14 09:15:20.561601+03	Казань	kzn		64513				\N				1		1	Europe/Moscow	\N	\N
3	2020-01-14	2020-01-14 09:19:15.623089+03	Шанхай	sha		64516				\N				3		1	Asia/Shanghai	\N	\N
4	2020-01-14	2020-01-14 09:19:58.610489+03	Сиань	Sia		64517				\N				3		1	Asia/Shanghai	\N	\N
5	2020-01-14	2020-01-14 09:45:44.09549+03	Барселона	bcn		64514				\N				2		1	Europe/Madrid	\N	\N
6	2020-01-14	2020-01-14 09:47:15.786059+03	Малага	mlg		64515				\N				2		1	Europe/Madrid	\N	\N
\.


--
-- Data for Name: dcim_virtualchassis; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.dcim_virtualchassis (id, domain, master_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	dcim	consoleport
2	dcim	consoleserverport
3	dcim	powerport
4	dcim	poweroutlet
5	dcim	interface
7	circuits	circuittermination
8	admin	logentry
9	auth	permission
10	auth	group
11	auth	user
12	contenttypes	contenttype
13	sessions	session
14	taggit	tag
15	taggit	taggeditem
16	circuits	provider
17	circuits	circuittype
18	circuits	circuit
19	dcim	consoleporttemplate
20	dcim	consoleserverporttemplate
21	dcim	device
22	dcim	devicerole
23	dcim	devicetype
24	dcim	interfacetemplate
25	dcim	manufacturer
26	dcim	platform
27	dcim	poweroutlettemplate
28	dcim	powerporttemplate
29	dcim	rack
30	dcim	rackgroup
31	dcim	site
32	dcim	devicebay
33	dcim	devicebaytemplate
34	dcim	rackrole
35	dcim	rackreservation
36	dcim	region
37	dcim	inventoryitem
38	dcim	virtualchassis
39	dcim	frontport
40	dcim	frontporttemplate
41	dcim	rearport
42	dcim	rearporttemplate
43	dcim	cable
44	dcim	powerfeed
45	dcim	powerpanel
46	ipam	aggregate
47	ipam	ipaddress
48	ipam	prefix
49	ipam	rir
50	ipam	role
51	ipam	vlan
52	ipam	vrf
53	ipam	vlangroup
54	ipam	service
55	extras	exporttemplate
56	extras	graph
57	extras	topologymap
58	extras	customfield
59	extras	customfieldchoice
60	extras	customfieldvalue
61	extras	imageattachment
62	extras	reportresult
63	extras	webhook
64	extras	objectchange
65	extras	configcontext
66	extras	tag
67	extras	taggeditem
68	extras	customlink
69	extras	script
70	secrets	secretrole
71	secrets	secret
72	secrets	userkey
73	secrets	sessionkey
74	tenancy	tenant
75	tenancy	tenantgroup
76	users	token
77	virtualization	cluster
78	virtualization	clustergroup
79	virtualization	clustertype
80	virtualization	virtualmachine
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-01-13 21:57:51.610809+03
2	auth	0001_initial	2020-01-13 21:57:51.645468+03
3	admin	0001_initial	2020-01-13 21:57:51.68181+03
4	admin	0002_logentry_remove_auto_add	2020-01-13 21:57:51.697371+03
5	admin	0003_logentry_add_action_flag_choices	2020-01-13 21:57:51.707178+03
6	contenttypes	0002_remove_content_type_name	2020-01-13 21:57:51.730495+03
7	auth	0002_alter_permission_name_max_length	2020-01-13 21:57:51.736553+03
8	auth	0003_alter_user_email_max_length	2020-01-13 21:57:51.746963+03
9	auth	0004_alter_user_username_opts	2020-01-13 21:57:51.757298+03
10	auth	0005_alter_user_last_login_null	2020-01-13 21:57:51.767834+03
11	auth	0006_require_contenttypes_0002	2020-01-13 21:57:51.769606+03
12	auth	0007_alter_validators_add_error_messages	2020-01-13 21:57:51.781057+03
13	auth	0008_alter_user_username_max_length	2020-01-13 21:57:51.793618+03
14	auth	0009_alter_user_last_name_max_length	2020-01-13 21:57:51.804095+03
15	auth	0010_alter_group_name_max_length	2020-01-13 21:57:51.814161+03
16	auth	0011_update_proxy_permissions	2020-01-13 21:57:51.823979+03
17	tenancy	0001_initial	2020-01-13 21:57:51.842789+03
18	tenancy	0002_tenant_group_optional	2020-01-13 21:57:51.865173+03
19	tenancy	0003_unicode_literals	2020-01-13 21:57:51.866339+03
20	taggit	0001_initial	2020-01-13 21:57:51.886049+03
21	taggit	0002_auto_20150616_2121	2020-01-13 21:57:51.903403+03
22	tenancy	0004_tags	2020-01-13 21:57:51.911189+03
23	tenancy	0005_change_logging	2020-01-13 21:57:51.939623+03
24	dcim	0001_initial	2020-01-13 21:57:52.135267+03
25	ipam	0001_initial	2020-01-13 21:57:52.382656+03
26	dcim	0002_auto_20160622_1821	2020-01-13 21:57:53.098954+03
27	dcim	0003_auto_20160628_1721	2020-01-13 21:57:53.100271+03
28	dcim	0004_auto_20160701_2049	2020-01-13 21:57:53.101474+03
29	dcim	0005_auto_20160706_1722	2020-01-13 21:57:53.102694+03
30	dcim	0006_add_device_primary_ip4_ip6	2020-01-13 21:57:53.103882+03
31	dcim	0007_device_copy_primary_ip	2020-01-13 21:57:53.105069+03
32	dcim	0008_device_remove_primary_ip	2020-01-13 21:57:53.106291+03
33	dcim	0009_site_32bit_asn_support	2020-01-13 21:57:53.107497+03
34	dcim	0010_devicebay_installed_device_set_null	2020-01-13 21:57:53.108681+03
35	dcim	0011_devicetype_part_number	2020-01-13 21:57:53.109889+03
36	dcim	0012_site_rack_device_add_tenant	2020-01-13 21:57:53.111089+03
37	dcim	0013_add_interface_form_factors	2020-01-13 21:57:53.112268+03
38	dcim	0014_rack_add_type_width	2020-01-13 21:57:53.113445+03
39	dcim	0015_rack_add_u_height_validator	2020-01-13 21:57:53.114658+03
40	dcim	0016_module_add_manufacturer	2020-01-13 21:57:53.115849+03
41	dcim	0017_rack_add_role	2020-01-13 21:57:53.117049+03
42	dcim	0018_device_add_asset_tag	2020-01-13 21:57:53.11826+03
43	dcim	0019_new_iface_form_factors	2020-01-13 21:57:53.119521+03
44	dcim	0020_rack_desc_units	2020-01-13 21:57:53.120862+03
45	dcim	0021_add_ff_flexstack	2020-01-13 21:57:53.122106+03
46	dcim	0022_color_names_to_rgb	2020-01-13 21:57:53.123298+03
47	extras	0001_initial	2020-01-13 21:57:53.571553+03
48	extras	0002_custom_fields	2020-01-13 21:57:53.572981+03
49	extras	0003_exporttemplate_add_description	2020-01-13 21:57:53.574348+03
50	extras	0004_topologymap_change_comma_to_semicolon	2020-01-13 21:57:53.575667+03
51	extras	0005_useraction_add_bulk_create	2020-01-13 21:57:53.57696+03
52	extras	0006_add_imageattachments	2020-01-13 21:57:53.578283+03
53	extras	0007_unicode_literals	2020-01-13 21:57:53.579533+03
54	extras	0008_reports	2020-01-13 21:57:53.580769+03
55	extras	0009_topologymap_type	2020-01-13 21:57:53.582089+03
56	extras	0010_customfield_filter_logic	2020-01-13 21:57:53.583352+03
57	extras	0011_django2	2020-01-13 21:57:53.741415+03
58	extras	0012_webhooks	2020-01-13 21:57:53.802274+03
59	extras	0013_objectchange	2020-01-13 21:57:53.856426+03
60	ipam	0002_vrf_add_enforce_unique	2020-01-13 21:57:54.841927+03
61	ipam	0003_ipam_add_vlangroups	2020-01-13 21:57:54.843428+03
62	ipam	0004_ipam_vlangroup_uniqueness	2020-01-13 21:57:54.844744+03
63	ipam	0005_auto_20160725_1842	2020-01-13 21:57:54.846047+03
64	ipam	0006_vrf_vlan_add_tenant	2020-01-13 21:57:54.847324+03
65	ipam	0007_prefix_ipaddress_add_tenant	2020-01-13 21:57:54.848592+03
66	ipam	0008_prefix_change_order	2020-01-13 21:57:54.849891+03
67	ipam	0009_ipaddress_add_status	2020-01-13 21:57:54.851173+03
68	ipam	0010_ipaddress_help_texts	2020-01-13 21:57:54.852444+03
69	ipam	0011_rir_add_is_private	2020-01-13 21:57:54.853707+03
70	ipam	0012_services	2020-01-13 21:57:54.85501+03
71	ipam	0013_prefix_add_is_pool	2020-01-13 21:57:54.856277+03
72	ipam	0014_ipaddress_status_add_deprecated	2020-01-13 21:57:54.857559+03
73	ipam	0015_global_vlans	2020-01-13 21:57:54.858849+03
74	ipam	0016_unicode_literals	2020-01-13 21:57:54.860109+03
75	ipam	0017_ipaddress_roles	2020-01-13 21:57:54.86141+03
76	ipam	0018_remove_service_uniqueness_constraint	2020-01-13 21:57:54.862728+03
77	dcim	0023_devicetype_comments	2020-01-13 21:57:56.77044+03
78	dcim	0024_site_add_contact_fields	2020-01-13 21:57:56.771943+03
79	dcim	0025_devicetype_add_interface_ordering	2020-01-13 21:57:56.773288+03
80	dcim	0026_add_rack_reservations	2020-01-13 21:57:56.774655+03
81	dcim	0027_device_add_site	2020-01-13 21:57:56.775987+03
82	dcim	0028_device_copy_rack_to_site	2020-01-13 21:57:56.777319+03
83	dcim	0029_allow_rackless_devices	2020-01-13 21:57:56.778645+03
84	dcim	0030_interface_add_lag	2020-01-13 21:57:56.780039+03
85	dcim	0031_regions	2020-01-13 21:57:56.781492+03
86	dcim	0032_device_increase_name_length	2020-01-13 21:57:56.782812+03
87	dcim	0033_rackreservation_rack_editable	2020-01-13 21:57:56.784115+03
88	dcim	0034_rename_module_to_inventoryitem	2020-01-13 21:57:56.785414+03
89	dcim	0035_device_expand_status_choices	2020-01-13 21:57:56.786748+03
90	dcim	0036_add_ff_juniper_vcp	2020-01-13 21:57:56.788026+03
91	dcim	0037_unicode_literals	2020-01-13 21:57:56.789363+03
92	dcim	0038_wireless_interfaces	2020-01-13 21:57:56.790857+03
93	dcim	0039_interface_add_enabled_mtu	2020-01-13 21:57:56.792277+03
94	dcim	0040_inventoryitem_add_asset_tag_description	2020-01-13 21:57:56.793825+03
95	dcim	0041_napalm_integration	2020-01-13 21:57:56.79512+03
96	dcim	0042_interface_ff_10ge_cx4	2020-01-13 21:57:56.796411+03
97	dcim	0043_device_component_name_lengths	2020-01-13 21:57:56.797707+03
98	virtualization	0001_virtualization	2020-01-13 21:57:56.930217+03
99	ipam	0019_virtualization	2020-01-13 21:57:57.177572+03
100	ipam	0020_ipaddress_add_role_carp	2020-01-13 21:57:57.179033+03
101	dcim	0044_virtualization	2020-01-13 21:57:58.109935+03
102	dcim	0045_devicerole_vm_role	2020-01-13 21:57:58.111891+03
103	dcim	0046_rack_lengthen_facility_id	2020-01-13 21:57:58.113712+03
104	dcim	0047_more_100ge_form_factors	2020-01-13 21:57:58.115559+03
105	dcim	0048_rack_serial	2020-01-13 21:57:58.117375+03
106	dcim	0049_rackreservation_change_user	2020-01-13 21:57:58.119221+03
107	dcim	0050_interface_vlan_tagging	2020-01-13 21:57:58.121038+03
108	dcim	0051_rackreservation_tenant	2020-01-13 21:57:58.122876+03
109	dcim	0052_virtual_chassis	2020-01-13 21:57:58.124672+03
110	dcim	0053_platform_manufacturer	2020-01-13 21:57:58.126692+03
111	dcim	0054_site_status_timezone_description	2020-01-13 21:57:58.128557+03
112	dcim	0055_virtualchassis_ordering	2020-01-13 21:57:58.130416+03
113	dcim	0056_django2	2020-01-13 21:57:58.275985+03
114	dcim	0057_tags	2020-01-13 21:57:59.019809+03
115	dcim	0058_relax_rack_naming_constraints	2020-01-13 21:57:59.104361+03
116	dcim	0059_site_latitude_longitude	2020-01-13 21:57:59.173107+03
117	dcim	0060_change_logging	2020-01-13 21:57:59.629816+03
118	dcim	0061_platform_napalm_args	2020-01-13 21:57:59.647802+03
119	extras	0014_configcontexts	2020-01-13 21:58:00.038326+03
120	extras	0015_remove_useraction	2020-01-13 21:58:00.196085+03
121	extras	0016_exporttemplate_add_cable	2020-01-13 21:58:00.260093+03
122	extras	0017_exporttemplate_mime_type_length	2020-01-13 21:58:00.278005+03
123	extras	0018_exporttemplate_add_jinja2	2020-01-13 21:58:00.368671+03
124	extras	0019_tag_taggeditem	2020-01-13 21:58:00.451972+03
125	dcim	0062_interface_mtu	2020-01-13 21:58:00.539129+03
126	dcim	0063_device_local_context_data	2020-01-13 21:58:00.57737+03
127	dcim	0064_remove_platform_rpc_client	2020-01-13 21:58:00.591598+03
128	dcim	0065_front_rear_ports	2020-01-13 21:58:01.25612+03
129	circuits	0001_initial	2020-01-13 21:58:01.433054+03
130	circuits	0002_auto_20160622_1821	2020-01-13 21:58:01.434585+03
131	circuits	0003_provider_32bit_asn_support	2020-01-13 21:58:01.435961+03
132	circuits	0004_circuit_add_tenant	2020-01-13 21:58:01.437349+03
133	circuits	0005_circuit_add_upstream_speed	2020-01-13 21:58:01.438756+03
134	circuits	0006_terminations	2020-01-13 21:58:01.440119+03
135	circuits	0007_circuit_add_description	2020-01-13 21:58:01.441485+03
136	circuits	0008_circuittermination_interface_protect_on_delete	2020-01-13 21:58:01.442876+03
137	circuits	0009_unicode_literals	2020-01-13 21:58:01.444246+03
138	circuits	0010_circuit_status	2020-01-13 21:58:01.445608+03
139	dcim	0066_cables	2020-01-13 21:58:03.646403+03
140	circuits	0011_tags	2020-01-13 21:58:03.794418+03
141	circuits	0012_change_logging	2020-01-13 21:58:03.972093+03
142	circuits	0013_cables	2020-01-13 21:58:04.397935+03
143	circuits	0014_circuittermination_description	2020-01-13 21:58:04.445437+03
144	circuits	0015_custom_tag_models	2020-01-13 21:58:04.583436+03
145	virtualization	0002_virtualmachine_add_status	2020-01-13 21:58:04.768933+03
146	virtualization	0003_cluster_add_site	2020-01-13 21:58:04.770515+03
147	virtualization	0004_virtualmachine_add_role	2020-01-13 21:58:04.771947+03
148	virtualization	0005_django2	2020-01-13 21:58:04.855088+03
149	virtualization	0006_tags	2020-01-13 21:58:04.992423+03
150	virtualization	0007_change_logging	2020-01-13 21:58:05.34066+03
151	virtualization	0008_virtualmachine_local_context_data	2020-01-13 21:58:05.384378+03
152	virtualization	0009_custom_tag_models	2020-01-13 21:58:05.526176+03
153	tenancy	0006_custom_tag_models	2020-01-13 21:58:05.595024+03
154	secrets	0001_initial	2020-01-13 21:58:05.937924+03
155	secrets	0002_userkey_add_session_key	2020-01-13 21:58:05.939499+03
156	secrets	0003_unicode_literals	2020-01-13 21:58:05.940919+03
157	secrets	0004_tags	2020-01-13 21:58:06.181214+03
158	secrets	0005_change_logging	2020-01-13 21:58:06.2986+03
159	secrets	0006_custom_tag_models	2020-01-13 21:58:06.370774+03
160	ipam	0021_vrf_ordering	2020-01-13 21:58:06.39968+03
161	ipam	0022_tags	2020-01-13 21:58:06.83541+03
162	ipam	0023_change_logging	2020-01-13 21:58:07.449308+03
163	ipam	0024_vrf_allow_null_rd	2020-01-13 21:58:07.484154+03
164	ipam	0025_custom_tag_models	2020-01-13 21:58:08.00283+03
165	dcim	0067_device_type_remove_qualifiers	2020-01-13 21:58:08.085131+03
166	dcim	0068_rack_new_fields	2020-01-13 21:58:08.261869+03
167	dcim	0069_deprecate_nullablecharfield	2020-01-13 21:58:08.413966+03
168	dcim	0070_custom_tag_models	2020-01-13 21:58:09.832854+03
169	extras	0020_tag_data	2020-01-13 21:58:10.183207+03
170	extras	0021_add_color_comments_changelog_to_tag	2020-01-13 21:58:10.504338+03
171	dcim	0071_device_components_add_description	2020-01-13 21:58:10.782369+03
172	dcim	0072_powerfeeds	2020-01-13 21:58:11.972301+03
173	dcim	0073_interface_form_factor_to_type	2020-01-13 21:58:12.285315+03
174	dcim	0074_increase_field_length_platform_name_slug	2020-01-13 21:58:12.325876+03
175	dcim	0075_cable_devices	2020-01-13 21:58:12.544563+03
176	extras	0022_custom_links	2020-01-13 21:58:12.907886+03
177	extras	0023_fix_tag_sequences	2020-01-13 21:58:12.920372+03
178	extras	0024_scripts	2020-01-13 21:58:12.925895+03
179	extras	0025_objectchange_time_index	2020-01-13 21:58:12.955216+03
180	extras	0026_webhook_ca_file_path	2020-01-13 21:58:12.975276+03
181	extras	0027_webhook_additional_headers	2020-01-13 21:58:12.994271+03
182	ipam	0026_prefix_ordering_vrf_nulls_first	2020-01-13 21:58:13.219654+03
183	ipam	0027_ipaddress_add_dns_name	2020-01-13 21:58:13.283405+03
184	sessions	0001_initial	2020-01-13 21:58:13.293709+03
185	taggit	0003_taggeditem_add_unique_index	2020-01-13 21:58:13.316151+03
186	users	0001_api_tokens	2020-01-13 21:58:13.40599+03
187	users	0002_unicode_literals	2020-01-13 21:58:13.407547+03
188	users	0003_token_permissions	2020-01-13 21:58:13.42927+03
189	circuits	0001_initial_squashed_0010_circuit_status	2020-01-13 21:58:13.43305+03
190	dcim	0002_auto_20160622_1821_squashed_0022_color_names_to_rgb	2020-01-13 21:58:13.43471+03
191	dcim	0044_virtualization_squashed_0055_virtualchassis_ordering	2020-01-13 21:58:13.436336+03
192	dcim	0023_devicetype_comments_squashed_0043_device_component_name_lengths	2020-01-13 21:58:13.437973+03
193	ipam	0019_virtualization_squashed_0020_ipaddress_add_role_carp	2020-01-13 21:58:13.439604+03
194	ipam	0002_vrf_add_enforce_unique_squashed_0018_remove_service_uniqueness_constraint	2020-01-13 21:58:13.441238+03
195	extras	0001_initial_squashed_0010_customfield_filter_logic	2020-01-13 21:58:13.442985+03
196	secrets	0001_initial_squashed_0003_unicode_literals	2020-01-13 21:58:13.444624+03
197	tenancy	0002_tenant_group_optional_squashed_0003_unicode_literals	2020-01-13 21:58:13.446278+03
198	users	0001_api_tokens_squashed_0002_unicode_literals	2020-01-13 21:58:13.447901+03
199	virtualization	0002_virtualmachine_add_status_squashed_0004_virtualmachine_add_role	2020-01-13 21:58:13.44951+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
cm5bytxn4cac4dqls4xpah7egnny3094	YmJjZDQ4M2E4ZThkN2FlYTYyNTQ3NThlMmVjYzZjOWY0YTFhYzVmNjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXRpbGl0aWVzLmF1dGhfYmFja2VuZHMuVmlld0V4ZW1wdE1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNhMDRjY2M4N2MzMzk0OWEyNDAxMmRiOGM3Y2I4MDJjNDhlOGRmMGQifQ==	2020-01-27 22:09:25.461183+03
\.


--
-- Data for Name: extras_configcontext; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext (id, name, weight, description, is_active, data) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_platforms; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_platforms (id, configcontext_id, platform_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_regions; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_regions (id, configcontext_id, region_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_roles; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_roles (id, configcontext_id, devicerole_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_sites; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_sites (id, configcontext_id, site_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_tenant_groups; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_tenant_groups (id, configcontext_id, tenantgroup_id) FROM stdin;
\.


--
-- Data for Name: extras_configcontext_tenants; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_configcontext_tenants (id, configcontext_id, tenant_id) FROM stdin;
\.


--
-- Data for Name: extras_customfield; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_customfield (id, type, name, label, description, required, "default", weight, filter_logic) FROM stdin;
\.


--
-- Data for Name: extras_customfield_obj_type; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_customfield_obj_type (id, customfield_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: extras_customfieldchoice; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_customfieldchoice (id, value, weight, field_id) FROM stdin;
\.


--
-- Data for Name: extras_customfieldvalue; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_customfieldvalue (id, obj_id, serialized_value, field_id, obj_type_id) FROM stdin;
\.


--
-- Data for Name: extras_customlink; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_customlink (id, name, text, url, weight, group_name, button_class, new_window, content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_exporttemplate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_exporttemplate (id, name, template_code, mime_type, file_extension, content_type_id, description, template_language) FROM stdin;
\.


--
-- Data for Name: extras_graph; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_graph (id, type, weight, name, source, link) FROM stdin;
\.


--
-- Data for Name: extras_imageattachment; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_imageattachment (id, object_id, image, image_height, image_width, name, created, content_type_id) FROM stdin;
\.


--
-- Data for Name: extras_objectchange; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_objectchange (id, "time", user_name, request_id, action, changed_object_id, related_object_id, object_repr, object_data, changed_object_type_id, related_object_type_id, user_id) FROM stdin;
1	2020-01-14 09:11:50.187291+03	admin	048f6307-ddf4-4f29-a798-16740d6d6d14	1	1	\N	RU	{"lft": 1, "name": "RU", "rght": 2, "slug": "ru", "level": 0, "parent": null, "created": "2020-01-14", "tree_id": 1, "last_updated": "2020-01-14T06:11:50.162Z"}	36	\N	1
2	2020-01-14 09:13:25.107404+03	admin	9a1f4da7-b060-4a71-8461-dfd295dea0ef	1	1	\N	Москва	{"asn": 64512, "name": "Москва", "slug": "msk", "tags": [], "region": 1, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Europe/Moscow", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:13:25.082Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
3	2020-01-14 09:15:06.11353+03	admin	cddbd8a7-2575-4c65-b185-0cfce725cfac	1	2	\N	Казань	{"asn": 64513, "name": "Казань", "slug": "kzn", "tags": [], "region": null, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Europe/Moscow", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:15:06.075Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
4	2020-01-14 09:15:20.568791+03	admin	66de7167-41d9-4752-be05-256aae503863	2	2	\N	Казань	{"asn": 64513, "name": "Казань", "slug": "kzn", "tags": [], "region": 1, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Europe/Moscow", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:15:20.561Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
5	2020-01-14 09:16:54.94525+03	admin	bcc6d8ba-756b-4d68-87eb-1f51f7c22f98	2	1	\N	Россия	{"lft": 1, "name": "Россия", "rght": 2, "slug": "ru", "level": 0, "parent": null, "created": "2020-01-14", "tree_id": 1, "last_updated": "2020-01-14T06:16:54.940Z"}	36	\N	1
6	2020-01-14 09:17:18.963088+03	admin	489a3617-0a02-4520-93ae-d2e6cb51cebd	1	2	\N	Испания	{"lft": 1, "name": "Испания", "rght": 2, "slug": "sp", "level": 0, "parent": null, "created": "2020-01-14", "tree_id": 1, "last_updated": "2020-01-14T06:17:18.960Z"}	36	\N	1
7	2020-01-14 09:17:27.722353+03	admin	62f9f79f-31d0-41d8-be96-64db9471ba8b	1	3	\N	Китай	{"lft": 1, "name": "Китай", "rght": 2, "slug": "cn", "level": 0, "parent": null, "created": "2020-01-14", "tree_id": 2, "last_updated": "2020-01-14T06:17:27.719Z"}	36	\N	1
8	2020-01-14 09:19:15.638415+03	admin	eda5a9c0-0509-4007-81c4-88fe1897b5ad	1	3	\N	Шанхай	{"asn": 64516, "name": "Шанхай", "slug": "sha", "tags": [], "region": 3, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Asia/Shanghai", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:19:15.623Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
9	2020-01-14 09:19:58.624627+03	admin	94e5ec3e-4333-42bf-b87b-9a115fbf239e	1	4	\N	Сиань	{"asn": 64517, "name": "Сиань", "slug": "Sia", "tags": [], "region": 3, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Asia/Shanghai", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:19:58.610Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
10	2020-01-14 09:45:44.112304+03	admin	96dc4d2b-4c2e-4fe4-b2c6-a73edbfdf64e	1	5	\N	Барселона	{"asn": 64514, "name": "Барселона", "slug": "bcn", "tags": [], "region": 2, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Europe/Madrid", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:45:44.095Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
11	2020-01-14 09:47:15.80494+03	admin	482ded3d-37b8-4bdf-89c9-2a283ec94afa	1	6	\N	Малага	{"asn": 64515, "name": "Малага", "slug": "mlg", "tags": [], "region": 2, "status": 1, "tenant": null, "created": "2020-01-14", "comments": "", "facility": "", "latitude": null, "longitude": null, "time_zone": "Europe/Madrid", "description": "", "contact_name": "", "last_updated": "2020-01-14T06:47:15.786Z", "contact_email": "", "contact_phone": "", "custom_fields": {}, "physical_address": "", "shipping_address": ""}	31	\N	1
12	2020-01-14 09:53:25.678497+03	admin	b22467c9-2cc0-452b-8bae-17698e79d26c	1	1	\N	Arista	{"name": "Arista", "slug": "arista", "created": "2020-01-14", "last_updated": "2020-01-14T06:53:25.673Z"}	25	\N	1
13	2020-01-14 09:53:35.083844+03	admin	1963ea9d-f940-4621-9d86-ec076868a17e	1	2	\N	Juniper	{"name": "Juniper", "slug": "juniper", "created": "2020-01-14", "last_updated": "2020-01-14T06:53:35.080Z"}	25	\N	1
14	2020-01-14 09:57:20.595421+03	admin	dae69c98-eee3-463c-b505-549a29166468	1	1	\N	vMX	{"slug": "vmx", "tags": [], "model": "vMX", "created": "2020-01-14", "comments": "", "u_height": 1, "part_number": "", "last_updated": "2020-01-14T06:57:20.579Z", "manufacturer": 2, "custom_fields": {}, "is_full_depth": true, "subdevice_role": null}	23	\N	1
15	2020-01-14 09:59:14.196685+03	admin	35c91008-46d6-40a0-a5fe-654077c0c41b	1	1	\N	Серверные стойки	{"name": "Серверные стойки", "site": 5, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:14.192Z"}	30	\N	1
16	2020-01-14 09:59:36.490327+03	admin	ef803097-3575-4a84-a115-0e75c29dcd50	1	2	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 5, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:36.485Z"}	30	\N	1
17	2020-01-14 09:59:45.485559+03	admin	b9747b83-8b58-4e03-8fda-c9706463c104	1	3	\N	Серверные стойки	{"name": "Серверные стойки", "site": 2, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:45.483Z"}	30	\N	1
18	2020-01-14 09:59:56.881988+03	admin	06bd72b6-b966-4950-8e9b-052216de27e8	1	4	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 2, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:56.877Z"}	30	\N	1
19	2020-01-14 10:00:06.711568+03	admin	d8f4245a-0c0e-4e63-bb4e-aea7eeae6d26	1	5	\N	Серверные стойки	{"name": "Серверные стойки", "site": 6, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:00:06.709Z"}	30	\N	1
20	2020-01-14 10:00:19.535554+03	admin	3932d4f5-e33c-47ae-aa67-56d54093c593	1	6	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 6, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:00:19.533Z"}	30	\N	1
85	2020-01-14 10:37:54.672517+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	31	2	Ethernet3	{"name": "Ethernet3", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
21	2020-01-14 10:01:26.496446+03	admin	32003414-b33e-4e42-bc95-cdd65de87f4f	1	7	\N	Серверные стойки	{"name": "Серверные стойки", "site": 1, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:01:26.492Z"}	30	\N	1
22	2020-01-14 10:01:36.414289+03	admin	c2e92407-e012-4bed-adcf-30a8564539b7	1	8	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 1, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:01:36.411Z"}	30	\N	1
23	2020-01-14 10:06:06.164841+03	admin	3a078bc2-72f7-4d8f-bda7-09eb660c68cd	1	9	\N	Серверные стойки	{"name": "Серверные стойки", "site": 4, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:06.161Z"}	30	\N	1
24	2020-01-14 10:06:14.861244+03	admin	77bd0c21-19ec-4e1c-8d8b-93d6579a7428	1	10	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 4, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:14.858Z"}	30	\N	1
25	2020-01-14 10:06:26.413159+03	admin	8e433648-3f94-481a-a4f7-8cee67fc24ae	1	11	\N	Серверные стойки	{"name": "Серверные стойки", "site": 3, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:26.409Z"}	30	\N	1
26	2020-01-14 10:06:34.136473+03	admin	b787f9ec-307f-421c-af55-bab442f06dda	1	12	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 3, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:34.133Z"}	30	\N	1
27	2020-01-14 10:07:34.195248+03	admin	fab48526-c9e1-4998-a2b3-0c3268a8455e	1	1	\N	Серверные стойки	{"name": "Серверные стойки", "slug": "server-racks", "color": "c0c0c0", "created": "2020-01-14", "last_updated": "2020-01-14T07:07:34.191Z"}	34	\N	1
28	2020-01-14 10:07:47.174974+03	admin	83ac66d6-1955-46cb-94f3-0e3ebce48025	1	2	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "slug": "infra-racks", "color": "f44336", "created": "2020-01-14", "last_updated": "2020-01-14T07:07:47.171Z"}	34	\N	1
29	2020-01-14 10:07:55.788103+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	1	\N	Серверные стойки	{"name": "Серверные стойки", "site": 5, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:14.192Z"}	30	\N	1
30	2020-01-14 10:07:55.790157+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	2	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 5, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:36.485Z"}	30	\N	1
31	2020-01-14 10:07:55.791837+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	3	\N	Серверные стойки	{"name": "Серверные стойки", "site": 2, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:45.483Z"}	30	\N	1
32	2020-01-14 10:07:55.79351+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	4	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 2, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T06:59:56.877Z"}	30	\N	1
33	2020-01-14 10:07:55.795165+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	5	\N	Серверные стойки	{"name": "Серверные стойки", "site": 6, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:00:06.709Z"}	30	\N	1
34	2020-01-14 10:07:55.796728+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	6	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 6, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:00:19.533Z"}	30	\N	1
35	2020-01-14 10:07:55.798454+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	7	\N	Серверные стойки	{"name": "Серверные стойки", "site": 1, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:01:26.492Z"}	30	\N	1
36	2020-01-14 10:07:55.800012+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	8	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 1, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:01:36.411Z"}	30	\N	1
37	2020-01-14 10:07:55.801549+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	9	\N	Серверные стойки	{"name": "Серверные стойки", "site": 4, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:06.161Z"}	30	\N	1
38	2020-01-14 10:07:55.80312+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	10	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 4, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:14.858Z"}	30	\N	1
39	2020-01-14 10:07:55.804666+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	11	\N	Серверные стойки	{"name": "Серверные стойки", "site": 3, "slug": "server-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:26.409Z"}	30	\N	1
40	2020-01-14 10:07:55.806386+03	admin	cbac2f0a-0ea0-4ce5-963b-2fe70dfccfba	3	12	\N	Инфраструктурные стойки	{"name": "Инфраструктурные стойки", "site": 3, "slug": "infra-racks", "created": "2020-01-14", "last_updated": "2020-01-14T07:06:34.133Z"}	30	\N	1
41	2020-01-14 10:11:32.875949+03	admin	e2f08b3b-5970-458f-8acb-edd847458ee9	1	1	\N	A	{"name": "A", "role": 1, "site": 5, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:11:32.857Z", "custom_fields": {}}	29	\N	1
42	2020-01-14 10:11:51.716776+03	admin	3ed92ee2-b83c-4bd1-96cc-ef4e0b128191	1	2	\N	B	{"name": "B", "role": 1, "site": 5, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:11:51.698Z", "custom_fields": {}}	29	\N	1
43	2020-01-14 10:12:15.119946+03	admin	e63c29ca-3a47-49ae-8041-a0e2dc358435	1	3	\N	A	{"name": "A", "role": 1, "site": 2, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:12:15.105Z", "custom_fields": {}}	29	\N	1
44	2020-01-14 10:13:51.086802+03	admin	268064d7-6f81-4056-bf6c-a3bc6bbafa74	1	4	\N	C	{"name": "C", "role": 1, "site": 3, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:13:51.072Z", "custom_fields": {}}	29	\N	1
86	2020-01-14 10:37:54.674517+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	32	2	Ethernet4	{"name": "Ethernet4", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
45	2020-01-14 10:14:20.815829+03	admin	731e8299-579a-4560-9e2f-24cae5039c3b	2	1	\N	A	{"name": "A", "role": 1, "site": 6, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:14:20.795Z", "custom_fields": {}}	29	\N	1
46	2020-01-14 10:14:20.821322+03	admin	731e8299-579a-4560-9e2f-24cae5039c3b	2	2	\N	B	{"name": "B", "role": 1, "site": 6, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:14:20.806Z", "custom_fields": {}}	29	\N	1
47	2020-01-14 10:14:36.777838+03	admin	26f370cb-b644-4d0e-9dc5-39a33b71f327	2	3	\N	A	{"name": "A", "role": 1, "site": 3, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:14:36.768Z", "custom_fields": {}}	29	\N	1
48	2020-01-14 10:15:07.068017+03	admin	328e4bbf-b6fc-4fb6-85cb-1445d31389e5	1	5	\N	L	{"name": "L", "role": 2, "site": 6, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:15:07.050Z", "custom_fields": {}}	29	\N	1
49	2020-01-14 10:15:30.687997+03	admin	63d30082-92fa-4adf-bd2e-ec79df391214	1	6	\N	L	{"name": "L", "role": 2, "site": 3, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:15:30.673Z", "custom_fields": {}}	29	\N	1
50	2020-01-14 10:16:26.624604+03	admin	787477cb-4b7e-44de-b8e7-ae749c507ed4	1	7	\N	F	{"name": "F", "role": 1, "site": 6, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:16:26.609Z", "custom_fields": {}}	29	\N	1
51	2020-01-14 10:18:31.600398+03	admin	3c074dbb-ae79-4874-ac89-9f590366eead	1	8	\N	G	{"name": "G", "role": 1, "site": 6, "tags": [], "type": null, "group": null, "width": 19, "serial": "", "status": 3, "tenant": null, "created": "2020-01-14", "comments": "", "u_height": 42, "asset_tag": null, "desc_units": false, "outer_unit": null, "facility_id": null, "outer_depth": null, "outer_width": null, "last_updated": "2020-01-14T07:18:31.583Z", "custom_fields": {}}	29	\N	1
52	2020-01-14 10:20:48.8259+03	admin	81b47bf3-92eb-41f3-8dff-07a237dad4b6	1	2	\N	vEOS	{"slug": "veos", "tags": [], "model": "vEOS", "created": "2020-01-14", "comments": "", "u_height": 1, "part_number": "", "last_updated": "2020-01-14T07:20:48.809Z", "manufacturer": 1, "custom_fields": {}, "is_full_depth": true, "subdevice_role": null}	23	\N	1
53	2020-01-14 10:23:41.071466+03	admin	3572d02f-d75f-4b87-8e1c-2d7b4bf75cad	1	1	2	Mgmt1	{"name": "Mgmt1", "type": 1000, "mgmt_only": false, "device_type": 2}	24	23	1
54	2020-01-14 10:26:04.147936+03	admin	e66fa71d-e6f2-41d7-9820-6c1000585661	1	3	\N	Cisco	{"name": "Cisco", "slug": "cisco", "created": "2020-01-14", "last_updated": "2020-01-14T07:26:04.144Z"}	25	\N	1
55	2020-01-14 10:26:16.014824+03	admin	c7535de6-5d6c-4910-b7bc-dac6172fee36	1	3	\N	vIOS	{"slug": "vios", "tags": [], "model": "vIOS", "created": "2020-01-14", "comments": "", "u_height": 1, "part_number": "", "last_updated": "2020-01-14T07:26:16.000Z", "manufacturer": 3, "custom_fields": {}, "is_full_depth": true, "subdevice_role": null}	23	\N	1
56	2020-01-14 10:30:36.867773+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	2	3	GigabitEthernet0/0	{"name": "GigabitEthernet0/0", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
57	2020-01-14 10:30:36.870755+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	3	3	GigabitEthernet0/1	{"name": "GigabitEthernet0/1", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
58	2020-01-14 10:30:36.872479+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	4	3	GigabitEthernet0/2	{"name": "GigabitEthernet0/2", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
59	2020-01-14 10:30:36.87425+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	5	3	GigabitEthernet0/3	{"name": "GigabitEthernet0/3", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
60	2020-01-14 10:30:36.87614+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	6	3	GigabitEthernet1/0	{"name": "GigabitEthernet1/0", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
61	2020-01-14 10:30:36.877925+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	7	3	GigabitEthernet1/1	{"name": "GigabitEthernet1/1", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
62	2020-01-14 10:30:36.879884+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	8	3	GigabitEthernet1/2	{"name": "GigabitEthernet1/2", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
63	2020-01-14 10:30:36.881575+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	9	3	GigabitEthernet1/3	{"name": "GigabitEthernet1/3", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
64	2020-01-14 10:30:36.883242+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	10	3	GigabitEthernet2/0	{"name": "GigabitEthernet2/0", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
65	2020-01-14 10:30:36.884879+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	11	3	GigabitEthernet2/1	{"name": "GigabitEthernet2/1", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
66	2020-01-14 10:30:36.886676+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	12	3	GigabitEthernet2/2	{"name": "GigabitEthernet2/2", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
67	2020-01-14 10:30:36.888276+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	13	3	GigabitEthernet2/3	{"name": "GigabitEthernet2/3", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
68	2020-01-14 10:30:36.89016+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	14	3	GigabitEthernet3/0	{"name": "GigabitEthernet3/0", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
69	2020-01-14 10:30:36.891873+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	15	3	GigabitEthernet3/1	{"name": "GigabitEthernet3/1", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
70	2020-01-14 10:30:36.893514+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	16	3	GigabitEthernet3/2	{"name": "GigabitEthernet3/2", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
71	2020-01-14 10:30:36.895471+03	admin	110f6127-aae2-4c4a-a571-5212f2355c0a	1	17	3	GigabitEthernet3/3	{"name": "GigabitEthernet3/3", "type": 1000, "mgmt_only": false, "device_type": 3}	24	23	1
72	2020-01-14 10:36:28.39651+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	18	1	ge-0/0/0	{"name": "ge-0/0/0", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
73	2020-01-14 10:36:28.399874+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	19	1	ge-0/0/1	{"name": "ge-0/0/1", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
74	2020-01-14 10:36:28.401651+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	20	1	ge-0/0/2	{"name": "ge-0/0/2", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
75	2020-01-14 10:36:28.403841+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	21	1	ge-0/0/3	{"name": "ge-0/0/3", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
76	2020-01-14 10:36:28.405724+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	22	1	ge-0/0/4	{"name": "ge-0/0/4", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
77	2020-01-14 10:36:28.40745+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	23	1	ge-0/0/5	{"name": "ge-0/0/5", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
78	2020-01-14 10:36:28.409206+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	24	1	ge-0/0/6	{"name": "ge-0/0/6", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
79	2020-01-14 10:36:28.410819+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	25	1	ge-0/0/7	{"name": "ge-0/0/7", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
80	2020-01-14 10:36:28.412407+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	26	1	ge-0/0/8	{"name": "ge-0/0/8", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
81	2020-01-14 10:36:28.41404+03	admin	f59f0680-7599-4400-a1ce-ac2fcae85c83	1	27	1	ge-0/0/9	{"name": "ge-0/0/9", "type": 1200, "mgmt_only": false, "device_type": 1}	24	23	1
82	2020-01-14 10:36:36.507739+03	admin	9c5fc16d-4a38-4e30-a880-a79d967391c1	1	28	1	em0	{"name": "em0", "type": 1000, "mgmt_only": true, "device_type": 1}	24	23	1
83	2020-01-14 10:37:54.668733+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	29	2	Ethernet1	{"name": "Ethernet1", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
84	2020-01-14 10:37:54.670742+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	30	2	Ethernet2	{"name": "Ethernet2", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
87	2020-01-14 10:37:54.676543+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	33	2	Ethernet5	{"name": "Ethernet5", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
88	2020-01-14 10:37:54.678652+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	34	2	Ethernet6	{"name": "Ethernet6", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
89	2020-01-14 10:37:54.680384+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	35	2	Ethernet7	{"name": "Ethernet7", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
90	2020-01-14 10:37:54.682028+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	36	2	Ethernet8	{"name": "Ethernet8", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
91	2020-01-14 10:37:54.683675+03	admin	ff56ddf8-cc36-415e-aca1-8b08d3cfd4c3	1	37	2	Ethernet9	{"name": "Ethernet9", "type": 1200, "mgmt_only": false, "device_type": 2}	24	23	1
92	2020-01-14 21:30:01.030472+03	admin	4f950a1d-1bbe-4f8a-9f59-eb81eff3aef4	1	4	\N	Hypermacro	{"name": "Hypermacro", "slug": "hypermacro", "created": "2020-01-14", "last_updated": "2020-01-14T18:30:00.909Z"}	25	\N	1
93	2020-01-14 21:30:29.520987+03	admin	eb808035-f888-4b81-92fc-b6bd07c3c2a0	1	4	\N	Server	{"slug": "server", "tags": [], "model": "Server", "created": "2020-01-14", "comments": "", "u_height": 1, "part_number": "", "last_updated": "2020-01-14T18:30:29.481Z", "manufacturer": 4, "custom_fields": {}, "is_full_depth": true, "subdevice_role": null}	23	\N	1
94	2020-01-14 21:31:06.788008+03	admin	c868dbd3-a082-4666-b5d6-585582a02018	1	38	4	eth0	{"name": "eth0", "type": 1200, "mgmt_only": false, "device_type": 4}	24	23	1
95	2020-01-14 21:33:11.830785+03	admin	eaaf1904-d549-4423-ba06-8c0909ec3f41	1	1	\N	Server	{"name": "Server", "slug": "server", "color": "aa1409", "created": "2020-01-14", "vm_role": false, "last_updated": "2020-01-14T18:33:11.826Z"}	22	\N	1
96	2020-01-14 21:35:13.229214+03	admin	e608b901-aaf2-4dc9-89d8-c8ad5e5e70a3	1	2	\N	Leaf	{"name": "Leaf", "slug": "leaf", "color": "4caf50", "created": "2020-01-14", "vm_role": false, "last_updated": "2020-01-14T18:35:13.226Z"}	22	\N	1
97	2020-01-14 21:35:25.17639+03	admin	1368f22f-838b-4c19-a89e-f4c1f3b4f881	1	3	\N	Spine	{"name": "Spine", "slug": "spine", "color": "2196f3", "created": "2020-01-14", "vm_role": false, "last_updated": "2020-01-14T18:35:25.173Z"}	22	\N	1
98	2020-01-14 21:35:41.306757+03	admin	c7751a83-8efe-46c0-bf03-b0ff05fa53f5	1	4	\N	Edge	{"name": "Edge", "slug": "edge", "color": "f44336", "created": "2020-01-14", "vm_role": false, "last_updated": "2020-01-14T18:35:41.295Z"}	22	\N	1
99	2020-01-14 21:37:15.249939+03	admin	d6ad0503-097a-4730-8907-c029dde71f2b	1	5	\N	MGMT switch	{"name": "MGMT switch", "slug": "mgmt-switch", "color": "9e9e9e", "created": "2020-01-14", "vm_role": false, "last_updated": "2020-01-14T18:37:15.246Z"}	22	\N	1
100	2020-01-14 21:39:01.346645+03	admin	cb8ede64-d3fe-4817-8188-d73cb21f02db	1	1	\N	mlg-host-0	{"face": 0, "name": "mlg-host-0", "rack": 1, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 41, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:39:01.288Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
101	2020-01-14 21:39:45.62399+03	admin	0c92e29a-6333-4dc1-93b3-bb6b6a34137e	1	2	\N	mlg-host-1	{"face": 0, "name": "mlg-host-1", "rack": 1, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 40, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:39:45.587Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
102	2020-01-14 21:40:08.202981+03	admin	620e501c-c6a9-4323-9157-0d3cbd3fe5a7	1	3	\N	mlg-host-2	{"face": 0, "name": "mlg-host-2", "rack": 1, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 39, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:40:08.164Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
103	2020-01-14 21:40:57.141902+03	admin	f3cf7ba1-d6eb-4b8e-9871-b96c39cc5bb3	1	4	\N	mlg-host-30	{"face": 0, "name": "mlg-host-30", "rack": 2, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 41, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:40:57.106Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
104	2020-01-14 21:41:43.636357+03	admin	cc20efce-6917-47da-ac4f-a523020be553	1	5	\N	mlg-host-31	{"face": 0, "name": "mlg-host-31", "rack": 2, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 40, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:41:43.599Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
105	2020-01-14 21:42:55.43376+03	admin	82c3ba10-8ac9-44c3-bddf-918082710bfe	1	6	\N	mlg-host-150	{"face": 0, "name": "mlg-host-150", "rack": 7, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 41, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:42:55.398Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
106	2020-01-14 21:43:28.141665+03	admin	c4cb8211-7c26-4de9-9454-a29d73ea6a20	1	7	\N	mlg-host-152	{"face": 0, "name": "mlg-host-152", "rack": 7, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 39, "asset_tag": null, "device_role": 1, "device_type": 4, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:43:28.101Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
107	2020-01-14 21:44:34.813716+03	admin	5c5b7333-4ea6-46cc-8397-2ee7923a6b30	1	8	\N	mlg-leaf0	{"face": 0, "name": "mlg-leaf0", "rack": 1, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:44:34.753Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
108	2020-01-14 21:45:15.907124+03	admin	f68a22b7-3ef7-4130-a09a-e8c41f805f01	1	9	\N	mlg-leaf1	{"face": 0, "name": "mlg-leaf1", "rack": 2, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:45:15.867Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
109	2020-01-14 21:45:52.968575+03	admin	6e2099c4-4ba8-4060-aecc-1e3c3bba4d5b	1	10	\N	mlg-leaf-5	{"face": 0, "name": "mlg-leaf-5", "rack": 7, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:45:52.925Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
110	2020-01-14 21:46:26.336942+03	admin	74aa66e8-41af-4bc5-9cc9-cc06da279acd	1	11	\N	mlg-leaf-6	{"face": 0, "name": "mlg-leaf-6", "rack": 8, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:46:26.297Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
111	2020-01-14 21:46:55.081155+03	admin	c38c2de4-a671-477e-95c0-14f2a0b9d22f	2	8	\N	mlg-leaf-0	{"face": 0, "name": "mlg-leaf-0", "rack": 1, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:46:55.066Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
112	2020-01-14 21:47:06.096854+03	admin	3397e380-b3f0-4e4a-80da-b2c4a004992f	2	9	\N	mlg-leaf-1	{"face": 0, "name": "mlg-leaf-1", "rack": 2, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 2, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:47:06.080Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
113	2020-01-14 21:51:35.665265+03	admin	b1ad47ad-17e3-4d51-811f-da21bd6172d7	1	12	\N	mlg-spine-0	{"face": 0, "name": "mlg-spine-0", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 38, "asset_tag": null, "device_role": 3, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:51:35.621Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
114	2020-01-14 21:52:13.50705+03	admin	739c0e53-836a-4e48-9dd0-3254d288df90	1	13	\N	mlg-spine-1	{"face": 0, "name": "mlg-spine-1", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 37, "asset_tag": null, "device_role": 3, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:52:13.466Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
115	2020-01-14 21:52:53.098707+03	admin	b19e7ed5-d88e-49c7-aa6b-43bf20ef44ca	1	14	\N	mlg-spine-2	{"face": 0, "name": "mlg-spine-2", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 36, "asset_tag": null, "device_role": 3, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:52:53.055Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
116	2020-01-14 21:53:18.746726+03	admin	e3cc9266-c6d4-4802-8953-ace30279d99b	1	15	\N	mlg-spine-3	{"face": 0, "name": "mlg-spine-3", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 35, "asset_tag": null, "device_role": 3, "device_type": 2, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:53:18.702Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
117	2020-01-14 21:54:23.672627+03	admin	ff523ce7-8135-4f7f-8dbd-dea4af5e0994	1	16	\N	mlg-edge-0	{"face": 0, "name": "mlg-edge-0", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 42, "asset_tag": null, "device_role": 4, "device_type": 1, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:54:23.617Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
118	2020-01-14 21:54:50.904885+03	admin	9b1977a2-ce4e-45b4-8839-ef4be452d63e	1	17	\N	mlg-edge-1	{"face": 0, "name": "mlg-edge-1", "rack": 5, "site": 6, "tags": [], "serial": "", "status": 1, "tenant": null, "cluster": null, "created": "2020-01-14", "comments": "", "platform": null, "position": 41, "asset_tag": null, "device_role": 4, "device_type": 1, "primary_ip4": null, "primary_ip6": null, "vc_position": null, "vc_priority": null, "last_updated": "2020-01-14T18:54:50.860Z", "custom_fields": {}, "virtual_chassis": null, "local_context_data": null}	21	\N	1
119	2020-01-14 21:57:18.771362+03	admin	2bdeb3e6-9627-4666-9e33-252a08275827	2	8	8	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 1, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 48, "_connected_circuittermination": null}	5	21	1
120	2020-01-14 21:57:18.779346+03	admin	2bdeb3e6-9627-4666-9e33-252a08275827	2	48	12	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 1, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 8, "_connected_circuittermination": null}	5	21	1
121	2020-01-14 21:57:18.785002+03	admin	2bdeb3e6-9627-4666-9e33-252a08275827	2	8	8	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 1, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 48, "_connected_circuittermination": null}	5	21	1
122	2020-01-14 21:57:18.79082+03	admin	2bdeb3e6-9627-4666-9e33-252a08275827	2	48	12	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 1, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 8, "_connected_circuittermination": null}	5	21	1
123	2020-01-14 21:57:18.792674+03	admin	2bdeb3e6-9627-4666-9e33-252a08275827	1	1	\N	#1	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:57:18.721Z", "termination_a_id": 8, "termination_b_id": 48, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 12}	43	\N	1
164	2020-01-14 22:01:32.857878+03	admin	2a8de8a4-c8b4-4bac-aceb-d9cd50b5339f	2	29	10	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 10, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 60, "_connected_circuittermination": null}	5	21	1
165	2020-01-14 22:01:32.865227+03	admin	2a8de8a4-c8b4-4bac-aceb-d9cd50b5339f	2	60	13	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 10, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 29, "_connected_circuittermination": null}	5	21	1
166	2020-01-14 22:01:32.870785+03	admin	2a8de8a4-c8b4-4bac-aceb-d9cd50b5339f	2	29	10	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 10, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 60, "_connected_circuittermination": null}	5	21	1
167	2020-01-14 22:01:32.876544+03	admin	2a8de8a4-c8b4-4bac-aceb-d9cd50b5339f	2	60	13	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 10, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 29, "_connected_circuittermination": null}	5	21	1
168	2020-01-14 22:01:32.878233+03	admin	2a8de8a4-c8b4-4bac-aceb-d9cd50b5339f	1	10	\N	#10	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:01:32.822Z", "termination_a_id": 29, "termination_b_id": 60, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 13}	43	\N	1
124	2020-01-14 21:57:58.539371+03	admin	e7c38dc0-472e-4de0-9739-6859b67c6b08	2	9	8	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 2, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 58, "_connected_circuittermination": null}	5	21	1
125	2020-01-14 21:57:58.548108+03	admin	e7c38dc0-472e-4de0-9739-6859b67c6b08	2	58	13	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 2, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 9, "_connected_circuittermination": null}	5	21	1
126	2020-01-14 21:57:58.55391+03	admin	e7c38dc0-472e-4de0-9739-6859b67c6b08	2	9	8	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 2, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 58, "_connected_circuittermination": null}	5	21	1
127	2020-01-14 21:57:58.560078+03	admin	e7c38dc0-472e-4de0-9739-6859b67c6b08	2	58	13	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 2, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 9, "_connected_circuittermination": null}	5	21	1
128	2020-01-14 21:57:58.563019+03	admin	e7c38dc0-472e-4de0-9739-6859b67c6b08	1	2	\N	#2	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:57:58.501Z", "termination_a_id": 9, "termination_b_id": 58, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 13}	43	\N	1
129	2020-01-14 21:58:36.157539+03	admin	0a8d9adb-7d86-4cb8-bd44-92fa856e71b5	2	10	8	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 3, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 68, "_connected_circuittermination": null}	5	21	1
130	2020-01-14 21:58:36.165485+03	admin	0a8d9adb-7d86-4cb8-bd44-92fa856e71b5	2	68	14	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 3, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 10, "_connected_circuittermination": null}	5	21	1
131	2020-01-14 21:58:36.174286+03	admin	0a8d9adb-7d86-4cb8-bd44-92fa856e71b5	2	10	8	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 3, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 68, "_connected_circuittermination": null}	5	21	1
132	2020-01-14 21:58:36.179973+03	admin	0a8d9adb-7d86-4cb8-bd44-92fa856e71b5	2	68	14	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 3, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 10, "_connected_circuittermination": null}	5	21	1
133	2020-01-14 21:58:36.182706+03	admin	0a8d9adb-7d86-4cb8-bd44-92fa856e71b5	1	3	\N	#3	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:58:36.115Z", "termination_a_id": 10, "termination_b_id": 68, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 14}	43	\N	1
134	2020-01-14 21:59:05.459799+03	admin	45cb5745-b61f-4730-bc84-6c87d2485cc7	2	11	8	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 4, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 78, "_connected_circuittermination": null}	5	21	1
135	2020-01-14 21:59:05.467646+03	admin	45cb5745-b61f-4730-bc84-6c87d2485cc7	2	78	15	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 4, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 11, "_connected_circuittermination": null}	5	21	1
136	2020-01-14 21:59:05.473643+03	admin	45cb5745-b61f-4730-bc84-6c87d2485cc7	2	11	8	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 4, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 78, "_connected_circuittermination": null}	5	21	1
137	2020-01-14 21:59:05.479476+03	admin	45cb5745-b61f-4730-bc84-6c87d2485cc7	2	78	15	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 4, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 11, "_connected_circuittermination": null}	5	21	1
138	2020-01-14 21:59:05.481211+03	admin	45cb5745-b61f-4730-bc84-6c87d2485cc7	1	4	\N	#4	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:59:05.422Z", "termination_a_id": 11, "termination_b_id": 78, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 15}	43	\N	1
139	2020-01-14 21:59:34.230709+03	admin	2dfcf971-4e72-4533-a7e9-73dad0327fb3	2	18	9	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 5, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 49, "_connected_circuittermination": null}	5	21	1
140	2020-01-14 21:59:34.23874+03	admin	2dfcf971-4e72-4533-a7e9-73dad0327fb3	2	49	12	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 5, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 18, "_connected_circuittermination": null}	5	21	1
141	2020-01-14 21:59:34.24532+03	admin	2dfcf971-4e72-4533-a7e9-73dad0327fb3	2	18	9	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 5, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 49, "_connected_circuittermination": null}	5	21	1
142	2020-01-14 21:59:34.251185+03	admin	2dfcf971-4e72-4533-a7e9-73dad0327fb3	2	49	12	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 5, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 18, "_connected_circuittermination": null}	5	21	1
143	2020-01-14 21:59:34.253126+03	admin	2dfcf971-4e72-4533-a7e9-73dad0327fb3	1	5	\N	#5	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:59:34.190Z", "termination_a_id": 18, "termination_b_id": 49, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 12}	43	\N	1
154	2020-01-14 22:00:46.693797+03	admin	ce3f04a6-191e-4f8a-a752-ef5c91fd9bd5	2	21	9	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 8, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 79, "_connected_circuittermination": null}	5	21	1
155	2020-01-14 22:00:46.701557+03	admin	ce3f04a6-191e-4f8a-a752-ef5c91fd9bd5	2	79	15	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 8, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 21, "_connected_circuittermination": null}	5	21	1
156	2020-01-14 22:00:46.707498+03	admin	ce3f04a6-191e-4f8a-a752-ef5c91fd9bd5	2	21	9	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 8, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 79, "_connected_circuittermination": null}	5	21	1
157	2020-01-14 22:00:46.713046+03	admin	ce3f04a6-191e-4f8a-a752-ef5c91fd9bd5	2	79	15	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 8, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 21, "_connected_circuittermination": null}	5	21	1
158	2020-01-14 22:00:46.714731+03	admin	ce3f04a6-191e-4f8a-a752-ef5c91fd9bd5	1	8	\N	#8	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:00:46.655Z", "termination_a_id": 21, "termination_b_id": 79, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 15}	43	\N	1
159	2020-01-14 22:01:14.403468+03	admin	f4807cac-21a9-4620-893e-1269cbf31207	2	28	10	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 9, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 50, "_connected_circuittermination": null}	5	21	1
160	2020-01-14 22:01:14.410738+03	admin	f4807cac-21a9-4620-893e-1269cbf31207	2	50	12	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 9, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 28, "_connected_circuittermination": null}	5	21	1
161	2020-01-14 22:01:14.416286+03	admin	f4807cac-21a9-4620-893e-1269cbf31207	2	28	10	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 9, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 50, "_connected_circuittermination": null}	5	21	1
162	2020-01-14 22:01:14.421826+03	admin	f4807cac-21a9-4620-893e-1269cbf31207	2	50	12	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 9, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 28, "_connected_circuittermination": null}	5	21	1
163	2020-01-14 22:01:14.423507+03	admin	f4807cac-21a9-4620-893e-1269cbf31207	1	9	\N	#9	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:01:14.367Z", "termination_a_id": 28, "termination_b_id": 50, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 12}	43	\N	1
169	2020-01-14 22:02:18.409204+03	admin	faf5ea57-f317-4b12-9a97-74adb37c2c01	2	30	10	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 11, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 70, "_connected_circuittermination": null}	5	21	1
170	2020-01-14 22:02:18.416828+03	admin	faf5ea57-f317-4b12-9a97-74adb37c2c01	2	70	14	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 11, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 30, "_connected_circuittermination": null}	5	21	1
144	2020-01-14 21:59:54.272394+03	admin	83825c64-7327-4827-8e4a-bfe43832e1b8	2	19	9	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 6, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 59, "_connected_circuittermination": null}	5	21	1
145	2020-01-14 21:59:54.279597+03	admin	83825c64-7327-4827-8e4a-bfe43832e1b8	2	59	13	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 6, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 19, "_connected_circuittermination": null}	5	21	1
146	2020-01-14 21:59:54.285087+03	admin	83825c64-7327-4827-8e4a-bfe43832e1b8	2	19	9	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 6, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 59, "_connected_circuittermination": null}	5	21	1
147	2020-01-14 21:59:54.290581+03	admin	83825c64-7327-4827-8e4a-bfe43832e1b8	2	59	13	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 6, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 19, "_connected_circuittermination": null}	5	21	1
148	2020-01-14 21:59:54.292252+03	admin	83825c64-7327-4827-8e4a-bfe43832e1b8	1	6	\N	#6	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T18:59:54.237Z", "termination_a_id": 19, "termination_b_id": 59, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 13}	43	\N	1
149	2020-01-14 22:00:20.577046+03	admin	21e0791d-a7eb-4b93-bce9-a598b90aa04e	2	20	9	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 7, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 69, "_connected_circuittermination": null}	5	21	1
150	2020-01-14 22:00:20.584178+03	admin	21e0791d-a7eb-4b93-bce9-a598b90aa04e	2	69	14	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 7, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 20, "_connected_circuittermination": null}	5	21	1
151	2020-01-14 22:00:20.589829+03	admin	21e0791d-a7eb-4b93-bce9-a598b90aa04e	2	20	9	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 7, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 69, "_connected_circuittermination": null}	5	21	1
152	2020-01-14 22:00:20.595518+03	admin	21e0791d-a7eb-4b93-bce9-a598b90aa04e	2	69	14	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 7, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 20, "_connected_circuittermination": null}	5	21	1
153	2020-01-14 22:00:20.597512+03	admin	21e0791d-a7eb-4b93-bce9-a598b90aa04e	1	7	\N	#7	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:00:20.536Z", "termination_a_id": 20, "termination_b_id": 69, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 14}	43	\N	1
171	2020-01-14 22:02:18.42265+03	admin	faf5ea57-f317-4b12-9a97-74adb37c2c01	2	30	10	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 11, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 70, "_connected_circuittermination": null}	5	21	1
172	2020-01-14 22:02:18.429652+03	admin	faf5ea57-f317-4b12-9a97-74adb37c2c01	2	70	14	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 11, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 30, "_connected_circuittermination": null}	5	21	1
173	2020-01-14 22:02:18.43161+03	admin	faf5ea57-f317-4b12-9a97-74adb37c2c01	1	11	\N	#11	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:02:18.371Z", "termination_a_id": 30, "termination_b_id": 70, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 14}	43	\N	1
174	2020-01-14 22:02:54.54717+03	admin	3e5b0266-e852-4bf9-a77e-2d21c6c1a7bb	2	31	10	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 12, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 80, "_connected_circuittermination": null}	5	21	1
175	2020-01-14 22:02:54.555332+03	admin	3e5b0266-e852-4bf9-a77e-2d21c6c1a7bb	2	80	15	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 12, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 31, "_connected_circuittermination": null}	5	21	1
176	2020-01-14 22:02:54.56155+03	admin	3e5b0266-e852-4bf9-a77e-2d21c6c1a7bb	2	31	10	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 12, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 80, "_connected_circuittermination": null}	5	21	1
177	2020-01-14 22:02:54.567267+03	admin	3e5b0266-e852-4bf9-a77e-2d21c6c1a7bb	2	80	15	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 12, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 31, "_connected_circuittermination": null}	5	21	1
178	2020-01-14 22:02:54.569126+03	admin	3e5b0266-e852-4bf9-a77e-2d21c6c1a7bb	1	12	\N	#12	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:02:54.508Z", "termination_a_id": 31, "termination_b_id": 80, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 15}	43	\N	1
179	2020-01-14 22:03:50.383407+03	admin	8838efea-b46c-4a5e-8e15-f625723e0366	2	38	11	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 13, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 51, "_connected_circuittermination": null}	5	21	1
180	2020-01-14 22:03:50.390636+03	admin	8838efea-b46c-4a5e-8e15-f625723e0366	2	51	12	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 13, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 38, "_connected_circuittermination": null}	5	21	1
181	2020-01-14 22:03:50.396131+03	admin	8838efea-b46c-4a5e-8e15-f625723e0366	2	38	11	Ethernet1	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet1", "tags": [], "type": 1200, "cable": 13, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 51, "_connected_circuittermination": null}	5	21	1
182	2020-01-14 22:03:50.401869+03	admin	8838efea-b46c-4a5e-8e15-f625723e0366	2	51	12	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 13, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 38, "_connected_circuittermination": null}	5	21	1
183	2020-01-14 22:03:50.403614+03	admin	8838efea-b46c-4a5e-8e15-f625723e0366	1	13	\N	#13	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:03:50.347Z", "termination_a_id": 38, "termination_b_id": 51, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 11, "_termination_b_device": 12}	43	\N	1
184	2020-01-14 22:04:25.841435+03	admin	34a86d1b-a9cb-45b2-838a-88ccd88c7486	2	39	11	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 14, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 61, "_connected_circuittermination": null}	5	21	1
185	2020-01-14 22:04:25.849018+03	admin	34a86d1b-a9cb-45b2-838a-88ccd88c7486	2	61	13	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 14, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 39, "_connected_circuittermination": null}	5	21	1
186	2020-01-14 22:04:25.854789+03	admin	34a86d1b-a9cb-45b2-838a-88ccd88c7486	2	39	11	Ethernet2	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet2", "tags": [], "type": 1200, "cable": 14, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 61, "_connected_circuittermination": null}	5	21	1
187	2020-01-14 22:04:25.860497+03	admin	34a86d1b-a9cb-45b2-838a-88ccd88c7486	2	61	13	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 14, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 39, "_connected_circuittermination": null}	5	21	1
188	2020-01-14 22:04:25.862382+03	admin	34a86d1b-a9cb-45b2-838a-88ccd88c7486	1	14	\N	#14	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:04:25.802Z", "termination_a_id": 39, "termination_b_id": 61, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 11, "_termination_b_device": 13}	43	\N	1
189	2020-01-14 22:04:44.438072+03	admin	30782c93-00fe-4b70-a1f0-502622b66c80	2	40	11	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 15, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 71, "_connected_circuittermination": null}	5	21	1
190	2020-01-14 22:04:44.548237+03	admin	30782c93-00fe-4b70-a1f0-502622b66c80	2	71	14	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 15, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 40, "_connected_circuittermination": null}	5	21	1
191	2020-01-14 22:04:44.554128+03	admin	30782c93-00fe-4b70-a1f0-502622b66c80	2	40	11	Ethernet3	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet3", "tags": [], "type": 1200, "cable": 15, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 71, "_connected_circuittermination": null}	5	21	1
192	2020-01-14 22:04:44.559733+03	admin	30782c93-00fe-4b70-a1f0-502622b66c80	2	71	14	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 15, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 40, "_connected_circuittermination": null}	5	21	1
193	2020-01-14 22:04:44.561658+03	admin	30782c93-00fe-4b70-a1f0-502622b66c80	1	15	\N	#15	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:04:44.396Z", "termination_a_id": 40, "termination_b_id": 71, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 11, "_termination_b_device": 14}	43	\N	1
194	2020-01-14 22:05:04.556352+03	admin	b2bf2862-4463-47e7-a77e-34de00ce3dbc	2	41	11	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 16, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 81, "_connected_circuittermination": null}	5	21	1
195	2020-01-14 22:05:04.563791+03	admin	b2bf2862-4463-47e7-a77e-34de00ce3dbc	2	81	15	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 16, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 41, "_connected_circuittermination": null}	5	21	1
196	2020-01-14 22:05:04.569632+03	admin	b2bf2862-4463-47e7-a77e-34de00ce3dbc	2	41	11	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 16, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 81, "_connected_circuittermination": null}	5	21	1
197	2020-01-14 22:05:04.575695+03	admin	b2bf2862-4463-47e7-a77e-34de00ce3dbc	2	81	15	Ethernet4	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet4", "tags": [], "type": 1200, "cable": 16, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 41, "_connected_circuittermination": null}	5	21	1
198	2020-01-14 22:05:04.577749+03	admin	b2bf2862-4463-47e7-a77e-34de00ce3dbc	1	16	\N	#16	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:05:04.519Z", "termination_a_id": 41, "termination_b_id": 81, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 11, "_termination_b_device": 15}	43	\N	1
199	2020-01-14 22:05:59.386018+03	admin	27083460-e655-457e-8c08-b37dca83be94	2	88	16	ge-0/0/0	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/0", "tags": [], "type": 1200, "cable": 17, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 56, "_connected_circuittermination": null}	5	21	1
200	2020-01-14 22:05:59.393184+03	admin	27083460-e655-457e-8c08-b37dca83be94	2	56	12	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 17, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 88, "_connected_circuittermination": null}	5	21	1
201	2020-01-14 22:05:59.398975+03	admin	27083460-e655-457e-8c08-b37dca83be94	2	88	16	ge-0/0/0	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/0", "tags": [], "type": 1200, "cable": 17, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 56, "_connected_circuittermination": null}	5	21	1
202	2020-01-14 22:05:59.404443+03	admin	27083460-e655-457e-8c08-b37dca83be94	2	56	12	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 17, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 88, "_connected_circuittermination": null}	5	21	1
203	2020-01-14 22:05:59.406173+03	admin	27083460-e655-457e-8c08-b37dca83be94	1	17	\N	#17	{"type": null, "color": "4caf50", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:05:59.349Z", "termination_a_id": 88, "termination_b_id": 56, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 16, "_termination_b_device": 12}	43	\N	1
204	2020-01-14 22:07:55.422218+03	admin	1e36b69c-e965-4eec-b6a5-cb14251bbfba	2	89	16	ge-0/0/1	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/1", "tags": [], "type": 1200, "cable": 18, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 66, "_connected_circuittermination": null}	5	21	1
205	2020-01-14 22:07:55.431256+03	admin	1e36b69c-e965-4eec-b6a5-cb14251bbfba	2	66	13	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 18, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 89, "_connected_circuittermination": null}	5	21	1
206	2020-01-14 22:07:55.437766+03	admin	1e36b69c-e965-4eec-b6a5-cb14251bbfba	2	89	16	ge-0/0/1	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/1", "tags": [], "type": 1200, "cable": 18, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 66, "_connected_circuittermination": null}	5	21	1
207	2020-01-14 22:07:55.444002+03	admin	1e36b69c-e965-4eec-b6a5-cb14251bbfba	2	66	13	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 18, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 89, "_connected_circuittermination": null}	5	21	1
208	2020-01-14 22:07:55.4461+03	admin	1e36b69c-e965-4eec-b6a5-cb14251bbfba	1	18	\N	#18	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:07:55.379Z", "termination_a_id": 89, "termination_b_id": 66, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 16, "_termination_b_device": 13}	43	\N	1
209	2020-01-14 22:08:46.514141+03	admin	afc26bb7-dc27-4d2c-a1cd-6b636c13583a	2	88	16	ge-0/0/0	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/0", "tags": [], "type": 1200, "cable": 17, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 56, "_connected_circuittermination": null}	5	21	1
210	2020-01-14 22:08:46.521289+03	admin	afc26bb7-dc27-4d2c-a1cd-6b636c13583a	2	56	12	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 17, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 88, "_connected_circuittermination": null}	5	21	1
211	2020-01-14 22:08:46.523417+03	admin	afc26bb7-dc27-4d2c-a1cd-6b636c13583a	2	17	\N	#17	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:08:46.490Z", "termination_a_id": 88, "termination_b_id": 56, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 16, "_termination_b_device": 12}	43	\N	1
212	2020-01-14 22:09:22.478849+03	admin	7b0934fd-dbcc-4a34-8739-e729b2820c1f	2	90	16	ge-0/0/2	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/2", "tags": [], "type": 1200, "cable": 19, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 76, "_connected_circuittermination": null}	5	21	1
213	2020-01-14 22:09:22.485907+03	admin	7b0934fd-dbcc-4a34-8739-e729b2820c1f	2	76	14	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 19, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 90, "_connected_circuittermination": null}	5	21	1
214	2020-01-14 22:09:22.491614+03	admin	7b0934fd-dbcc-4a34-8739-e729b2820c1f	2	90	16	ge-0/0/2	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/2", "tags": [], "type": 1200, "cable": 19, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 76, "_connected_circuittermination": null}	5	21	1
215	2020-01-14 22:09:22.497665+03	admin	7b0934fd-dbcc-4a34-8739-e729b2820c1f	2	76	14	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 19, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 90, "_connected_circuittermination": null}	5	21	1
216	2020-01-14 22:09:22.499428+03	admin	7b0934fd-dbcc-4a34-8739-e729b2820c1f	1	19	\N	#19	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:09:22.441Z", "termination_a_id": 90, "termination_b_id": 76, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 16, "_termination_b_device": 14}	43	\N	1
217	2020-01-14 22:09:42.017657+03	admin	67a6174a-58a1-4fc3-9bbc-2bd2b3a2bb01	2	91	16	ge-0/0/3	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/3", "tags": [], "type": 1200, "cable": 20, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 86, "_connected_circuittermination": null}	5	21	1
218	2020-01-14 22:09:42.025362+03	admin	67a6174a-58a1-4fc3-9bbc-2bd2b3a2bb01	2	86	15	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 20, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 91, "_connected_circuittermination": null}	5	21	1
219	2020-01-14 22:09:42.035836+03	admin	67a6174a-58a1-4fc3-9bbc-2bd2b3a2bb01	2	91	16	ge-0/0/3	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/3", "tags": [], "type": 1200, "cable": 20, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 86, "_connected_circuittermination": null}	5	21	1
220	2020-01-14 22:09:42.050049+03	admin	67a6174a-58a1-4fc3-9bbc-2bd2b3a2bb01	2	86	15	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 20, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 91, "_connected_circuittermination": null}	5	21	1
221	2020-01-14 22:09:42.051894+03	admin	67a6174a-58a1-4fc3-9bbc-2bd2b3a2bb01	1	20	\N	#20	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:09:41.980Z", "termination_a_id": 91, "termination_b_id": 86, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 16, "_termination_b_device": 15}	43	\N	1
227	2020-01-14 22:10:32.042563+03	admin	00146d26-d7df-462d-aee1-e2126c591172	2	100	17	ge-0/0/1	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/1", "tags": [], "type": 1200, "cable": 22, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 65, "_connected_circuittermination": null}	5	21	1
228	2020-01-14 22:10:32.049535+03	admin	00146d26-d7df-462d-aee1-e2126c591172	2	65	13	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 22, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 100, "_connected_circuittermination": null}	5	21	1
229	2020-01-14 22:10:32.054943+03	admin	00146d26-d7df-462d-aee1-e2126c591172	2	100	17	ge-0/0/1	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/1", "tags": [], "type": 1200, "cable": 22, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 65, "_connected_circuittermination": null}	5	21	1
230	2020-01-14 22:10:32.060483+03	admin	00146d26-d7df-462d-aee1-e2126c591172	2	65	13	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 22, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 100, "_connected_circuittermination": null}	5	21	1
231	2020-01-14 22:10:32.062223+03	admin	00146d26-d7df-462d-aee1-e2126c591172	1	22	\N	#22	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:10:32.005Z", "termination_a_id": 100, "termination_b_id": 65, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 17, "_termination_b_device": 13}	43	\N	1
222	2020-01-14 22:10:13.254033+03	admin	632f2e2f-b7a1-4131-979e-b44c39e18ad0	2	99	17	ge-0/0/0	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/0", "tags": [], "type": 1200, "cable": 21, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 55, "_connected_circuittermination": null}	5	21	1
223	2020-01-14 22:10:13.261399+03	admin	632f2e2f-b7a1-4131-979e-b44c39e18ad0	2	55	12	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 21, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 99, "_connected_circuittermination": null}	5	21	1
224	2020-01-14 22:10:13.266969+03	admin	632f2e2f-b7a1-4131-979e-b44c39e18ad0	2	99	17	ge-0/0/0	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/0", "tags": [], "type": 1200, "cable": 21, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 55, "_connected_circuittermination": null}	5	21	1
225	2020-01-14 22:10:13.272601+03	admin	632f2e2f-b7a1-4131-979e-b44c39e18ad0	2	55	12	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 21, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 99, "_connected_circuittermination": null}	5	21	1
226	2020-01-14 22:10:13.27448+03	admin	632f2e2f-b7a1-4131-979e-b44c39e18ad0	1	21	\N	#21	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:10:13.218Z", "termination_a_id": 99, "termination_b_id": 55, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 17, "_termination_b_device": 12}	43	\N	1
232	2020-01-14 22:11:30.940864+03	admin	e68f75dc-64fe-4a6b-87cb-405c095397a7	2	101	17	ge-0/0/2	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/2", "tags": [], "type": 1200, "cable": 23, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 75, "_connected_circuittermination": null}	5	21	1
233	2020-01-14 22:11:30.948678+03	admin	e68f75dc-64fe-4a6b-87cb-405c095397a7	2	75	14	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 23, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 101, "_connected_circuittermination": null}	5	21	1
234	2020-01-14 22:11:30.954563+03	admin	e68f75dc-64fe-4a6b-87cb-405c095397a7	2	101	17	ge-0/0/2	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/2", "tags": [], "type": 1200, "cable": 23, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 75, "_connected_circuittermination": null}	5	21	1
235	2020-01-14 22:11:30.960292+03	admin	e68f75dc-64fe-4a6b-87cb-405c095397a7	2	75	14	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 23, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 101, "_connected_circuittermination": null}	5	21	1
236	2020-01-14 22:11:30.962199+03	admin	e68f75dc-64fe-4a6b-87cb-405c095397a7	1	23	\N	#23	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:11:30.901Z", "termination_a_id": 101, "termination_b_id": 75, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 17, "_termination_b_device": 14}	43	\N	1
237	2020-01-14 22:12:12.702701+03	admin	fa9125d4-7a7c-46c7-800c-10299def7e1e	2	102	17	ge-0/0/3	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/3", "tags": [], "type": 1200, "cable": 24, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 85, "_connected_circuittermination": null}	5	21	1
238	2020-01-14 22:12:12.710131+03	admin	fa9125d4-7a7c-46c7-800c-10299def7e1e	2	85	15	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 24, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 102, "_connected_circuittermination": null}	5	21	1
239	2020-01-14 22:12:12.715471+03	admin	fa9125d4-7a7c-46c7-800c-10299def7e1e	2	102	17	ge-0/0/3	{"lag": null, "mtu": null, "mode": null, "name": "ge-0/0/3", "tags": [], "type": 1200, "cable": 24, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 85, "_connected_circuittermination": null}	5	21	1
240	2020-01-14 22:12:12.720885+03	admin	fa9125d4-7a7c-46c7-800c-10299def7e1e	2	85	15	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 24, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 102, "_connected_circuittermination": null}	5	21	1
241	2020-01-14 22:12:12.7228+03	admin	fa9125d4-7a7c-46c7-800c-10299def7e1e	1	24	\N	#24	{"type": null, "color": "f44336", "label": "", "length": null, "status": true, "created": "2020-01-14", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-14T19:12:12.664Z", "termination_a_id": 102, "termination_b_id": 85, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 17, "_termination_b_device": 15}	43	\N	1
242	2020-01-14 22:14:30.572676+03	admin	6eaf88d0-15a5-4683-840d-ffe693869a7e	1	1	\N	Loopbacks	{"name": "Loopbacks", "slug": "loopbacks", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:14:30.557Z"}	50	\N	1
243	2020-01-14 22:14:42.349142+03	admin	ebbb3a9e-0359-462c-ac67-73da6c858760	1	2	\N	P2P	{"name": "P2P", "slug": "p2p", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:14:42.345Z"}	50	\N	1
244	2020-01-14 22:16:24.126858+03	admin	8cc311ed-9941-4c40-a88c-688111154af0	1	3	\N	Underlay	{"name": "Underlay", "slug": "underlay", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:16:24.123Z"}	50	\N	1
245	2020-01-14 22:18:19.708637+03	admin	e3f943af-287f-4068-a796-92504a31cae6	1	1	\N	172.16.0.0/12	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/12", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Префикс для лупбэков", "last_updated": "2020-01-14T19:18:19.677Z", "custom_fields": {}}	48	\N	1
246	2020-01-14 22:20:37.699303+03	admin	a2e17dcb-852a-4389-a0de-bfff57f9c8db	1	2	\N	172.16.0.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для Edge-устройств", "last_updated": "2020-01-14T19:20:37.679Z", "custom_fields": {}}	48	\N	1
247	2020-01-14 22:21:01.823595+03	admin	146b673d-b2ce-4229-b21c-bf1272ae9879	1	3	\N	172.16.2.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для", "last_updated": "2020-01-14T19:21:01.809Z", "custom_fields": {}}	48	\N	1
248	2020-01-14 22:21:14.676705+03	admin	1fd71242-ac7e-4a27-849c-6ebe33701da8	2	3	\N	172.16.2.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для Spine-устройств", "last_updated": "2020-01-14T19:21:14.666Z", "custom_fields": {}}	48	\N	1
249	2020-01-14 22:22:26.84328+03	admin	f9a4d9bb-f74c-45f9-b766-4ac47cea029a	1	4	\N	172.16.8.0/21	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/21", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств", "last_updated": "2020-01-14T19:22:26.827Z", "custom_fields": {}}	48	\N	1
250	2020-01-14 22:22:43.516886+03	admin	e3fa9195-0cc5-4c8e-ba44-b6853bba280c	2	2	\N	172.16.0.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств", "last_updated": "2020-01-14T19:22:43.505Z", "custom_fields": {}}	48	\N	1
251	2020-01-14 22:22:43.523302+03	admin	e3fa9195-0cc5-4c8e-ba44-b6853bba280c	2	3	\N	172.16.2.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств", "last_updated": "2020-01-14T19:22:43.509Z", "custom_fields": {}}	48	\N	1
252	2020-01-14 22:23:35.01515+03	admin	3b1201dc-52c6-4112-b610-7168a17ab83d	1	5	\N	172.16.0.0/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для региона RU", "last_updated": "2020-01-14T19:23:35.000Z", "custom_fields": {}}	48	\N	1
253	2020-01-14 22:24:16.528144+03	admin	cc4a221a-e021-4f67-b2f8-c2358cbdba7c	1	6	\N	172.16.0.0/29	{"vrf": null, "role": 1, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для ДЦ msk", "last_updated": "2020-01-14T19:24:16.513Z", "custom_fields": {}}	48	\N	1
254	2020-01-14 22:24:46.89156+03	admin	67821f17-d53f-49cb-a656-a7f598b26afe	1	7	\N	172.16.0.8/29	{"vrf": null, "role": 1, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.8/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ kzn", "last_updated": "2020-01-14T19:24:46.876Z", "custom_fields": {}}	48	\N	1
255	2020-01-14 22:25:16.961289+03	admin	a810026b-3f53-4e62-aede-60b6854faa44	2	6	\N	172.16.0.0/29	{"vrf": null, "role": 1, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ msk", "last_updated": "2020-01-14T19:25:16.950Z", "custom_fields": {}}	48	\N	1
256	2020-01-14 22:26:07.361849+03	admin	e73198b7-5dc5-4d48-8e66-c9e4bd3f71ff	1	8	\N	172.16.0.32/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.32/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для региона SP", "last_updated": "2020-01-14T19:26:07.344Z", "custom_fields": {}}	48	\N	1
257	2020-01-14 22:26:39.268807+03	admin	95e0df83-6599-430d-b778-805dce40cdc3	1	9	\N	172.16.0.32/29	{"vrf": null, "role": 1, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.32/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ bcn", "last_updated": "2020-01-14T19:26:39.253Z", "custom_fields": {}}	48	\N	1
258	2020-01-14 22:27:02.294679+03	admin	24e52671-d415-400f-a90b-1f5600347a8d	1	10	\N	172.16.0.40/29	{"vrf": null, "role": 1, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.40/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:27:02.278Z", "custom_fields": {}}	48	\N	1
259	2020-01-14 22:27:18.232188+03	admin	d2eb84fa-5284-4463-a9ca-8a41840e7809	1	11	\N	172.16.0.64/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.64/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для региона CN", "last_updated": "2020-01-14T19:27:18.217Z", "custom_fields": {}}	48	\N	1
260	2020-01-14 22:27:44.900184+03	admin	210a003b-54fd-4083-85b8-069f705fa755	1	12	\N	172.16.0.64/29	{"vrf": null, "role": 1, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.64/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ sha", "last_updated": "2020-01-14T19:27:44.885Z", "custom_fields": {}}	48	\N	1
261	2020-01-14 22:28:10.903314+03	admin	e846bcfd-a18b-4e00-aeee-3f749950cbac	1	13	\N	172.16.0.72/29	{"vrf": null, "role": 1, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.72/29", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств в ДЦ sia", "last_updated": "2020-01-14T19:28:10.888Z", "custom_fields": {}}	48	\N	1
262	2020-01-14 22:29:43.504468+03	admin	af0f19a5-4e05-45ff-907a-17e3172b793f	1	14	\N	172.16.2.0/26	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе RU", "last_updated": "2020-01-14T19:29:43.488Z", "custom_fields": {}}	48	\N	1
263	2020-01-14 22:30:12.949017+03	admin	d58c7940-95b4-4220-ad43-75db34177914	1	15	\N	172.16.2.0/28	{"vrf": null, "role": 1, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ msk", "last_updated": "2020-01-14T19:30:12.933Z", "custom_fields": {}}	48	\N	1
265	2020-01-14 22:30:59.853496+03	admin	a617c105-05db-44bf-ae04-88f6f14bd8d1	1	17	\N	172.16.2.64/26	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.64/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе SP", "last_updated": "2020-01-14T19:30:59.838Z", "custom_fields": {}}	48	\N	1
266	2020-01-14 22:31:28.940729+03	admin	87b6aa9f-274f-4ebb-a514-bcb10fb443c9	1	18	\N	172.16.2.64/28	{"vrf": null, "role": 1, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.64/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ bcn", "last_updated": "2020-01-14T19:31:28.925Z", "custom_fields": {}}	48	\N	1
267	2020-01-14 22:31:56.085939+03	admin	0ec0e288-0ebb-4a28-8496-1190733c1029	1	19	\N	172.16.2.80/28	{"vrf": null, "role": 1, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.80/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для Spine-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:31:56.071Z", "custom_fields": {}}	48	\N	1
264	2020-01-14 22:30:37.860151+03	admin	0f2ca306-4e87-40d0-a1fc-df5c02603f91	1	16	\N	172.16.2.16/28	{"vrf": null, "role": 1, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.16/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ kzn", "last_updated": "2020-01-14T19:30:37.845Z", "custom_fields": {}}	48	\N	1
268	2020-01-14 22:32:14.526006+03	admin	4a3c9978-a893-4bc9-9c5c-41365e2c393d	1	20	\N	172.16.2.128/26	{"vrf": null, "role": 1, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.128/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для Spine-устройств в регионе", "last_updated": "2020-01-14T19:32:14.508Z", "custom_fields": {}}	48	\N	1
269	2020-01-14 22:32:25.115139+03	admin	e4a9bd88-b582-4749-8038-d271e32cedfc	2	20	\N	172.16.2.128/26	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.128/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе CN", "last_updated": "2020-01-14T19:32:25.103Z", "custom_fields": {}}	48	\N	1
270	2020-01-14 22:32:49.958187+03	admin	86be893e-ad31-45f7-bcf3-f3182de7ac05	1	21	\N	172.16.2.128/28	{"vrf": null, "role": 1, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.128/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ sha", "last_updated": "2020-01-14T19:32:49.939Z", "custom_fields": {}}	48	\N	1
271	2020-01-14 22:33:21.482772+03	admin	238c4117-11b4-48f5-a7c0-bc7ed80a6b9a	1	22	\N	172.16.2.144/28	{"vrf": null, "role": 1, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.144/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ sia", "last_updated": "2020-01-14T19:33:21.468Z", "custom_fields": {}}	48	\N	1
272	2020-01-14 22:34:10.610075+03	admin	feb22564-9fc4-4ee3-b475-1a61ed60fa5e	1	23	\N	172.16.8.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе RU", "last_updated": "2020-01-14T19:34:10.594Z", "custom_fields": {}}	48	\N	1
273	2020-01-14 22:34:35.260901+03	admin	bb318c9f-e7bc-4acd-bbae-a33a0407bff9	1	24	\N	172.16.8.0/25	{"vrf": null, "role": 1, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ msk", "last_updated": "2020-01-14T19:34:35.244Z", "custom_fields": {}}	48	\N	1
274	2020-01-14 22:35:01.214568+03	admin	7c2b5067-b9f4-4f2b-a7e7-4ecb39bd85d1	1	25	\N	172.16.8.128/25	{"vrf": null, "role": 1, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ kzn", "last_updated": "2020-01-14T19:35:01.199Z", "custom_fields": {}}	48	\N	1
275	2020-01-14 22:35:52.818039+03	admin	847f35b2-6493-4ddc-96f1-d039449ad9a1	1	26	\N	172.16.10.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе SP", "last_updated": "2020-01-14T19:35:52.801Z", "custom_fields": {}}	48	\N	1
276	2020-01-14 22:36:27.235583+03	admin	219c5981-38a7-4b77-9223-d3d6cdd6ca54	1	27	\N	172.16.10.0/25	{"vrf": null, "role": 1, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ bcn", "last_updated": "2020-01-14T19:36:27.220Z", "custom_fields": {}}	48	\N	1
277	2020-01-14 22:36:52.578939+03	admin	6fc0ab5f-6237-4bfc-89d8-45fc9a7148b8	1	28	\N	172.16.10.128/25	{"vrf": null, "role": 1, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:36:52.564Z", "custom_fields": {}}	48	\N	1
278	2020-01-14 22:37:24.091942+03	admin	fd93a8a9-6239-4bd1-b191-c6686935415a	1	29	\N	172.16.12.0/23	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе CN", "last_updated": "2020-01-14T19:37:24.075Z", "custom_fields": {}}	48	\N	1
279	2020-01-14 22:37:52.972012+03	admin	c09b7ed4-902f-4b74-a43c-5cc4766de6ac	1	30	\N	172.16.12.0/25	{"vrf": null, "role": 1, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ sha", "last_updated": "2020-01-14T19:37:52.955Z", "custom_fields": {}}	48	\N	1
280	2020-01-14 22:38:11.838971+03	admin	cf3ab91e-1167-4958-b72b-5764fb1f3740	1	31	\N	172.16.12.128/25	{"vrf": null, "role": 1, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ sia", "last_updated": "2020-01-14T19:38:11.823Z", "custom_fields": {}}	48	\N	1
281	2020-01-14 22:41:05.364912+03	admin	f73a637c-1bb7-470a-a25a-81a98aacbfbd	2	1	\N	Edge Loopbacks	{"name": "Edge Loopbacks", "slug": "edge-loopbacks", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:41:05.361Z"}	50	\N	1
282	2020-01-14 22:41:14.990148+03	admin	f51eeedd-2887-41bf-887a-c35254c375c9	1	4	\N	Spine Loopbacks	{"name": "Spine Loopbacks", "slug": "spine-loopbacks", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:41:14.987Z"}	50	\N	1
283	2020-01-14 22:41:21.51459+03	admin	31ce2a79-66dc-4a25-a832-5a89b00e3b85	1	5	\N	Leaf Loopbacks	{"name": "Leaf Loopbacks", "slug": "leaf-loopbacks", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:41:21.512Z"}	50	\N	1
284	2020-01-14 22:41:45.734559+03	admin	788bfa4f-3021-4b59-8221-3fedd20ca68a	2	3	\N	172.16.2.0/23	{"vrf": null, "role": 4, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств", "last_updated": "2020-01-14T19:41:45.724Z", "custom_fields": {}}	48	\N	1
285	2020-01-14 22:41:57.484115+03	admin	dcc86481-1cc8-403e-990c-723cece4e8ec	2	4	\N	172.16.8.0/21	{"vrf": null, "role": 5, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/21", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств", "last_updated": "2020-01-14T19:41:57.472Z", "custom_fields": {}}	48	\N	1
286	2020-01-14 22:42:21.30004+03	admin	bf5eb2b5-3ef2-433a-9297-b17e2b21ad9d	2	14	\N	172.16.2.0/26	{"vrf": null, "role": 4, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе RU", "last_updated": "2020-01-14T19:42:21.285Z", "custom_fields": {}}	48	\N	1
287	2020-01-14 22:42:21.305402+03	admin	bf5eb2b5-3ef2-433a-9297-b17e2b21ad9d	2	17	\N	172.16.2.64/26	{"vrf": null, "role": 4, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.64/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе SP", "last_updated": "2020-01-14T19:42:21.289Z", "custom_fields": {}}	48	\N	1
288	2020-01-14 22:42:21.310496+03	admin	bf5eb2b5-3ef2-433a-9297-b17e2b21ad9d	2	20	\N	172.16.2.128/26	{"vrf": null, "role": 4, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.128/26", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в регионе CN", "last_updated": "2020-01-14T19:42:21.292Z", "custom_fields": {}}	48	\N	1
289	2020-01-14 22:42:48.045157+03	admin	881a5016-a774-43d4-b87a-de03afd9ca86	2	15	\N	172.16.2.0/28	{"vrf": null, "role": 4, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.0/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ msk", "last_updated": "2020-01-14T19:42:48.033Z", "custom_fields": {}}	48	\N	1
290	2020-01-14 22:42:48.050591+03	admin	881a5016-a774-43d4-b87a-de03afd9ca86	2	16	\N	172.16.2.16/28	{"vrf": null, "role": 4, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.16/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ kzn", "last_updated": "2020-01-14T19:42:48.037Z", "custom_fields": {}}	48	\N	1
291	2020-01-14 22:43:17.794051+03	admin	94f28509-b3d4-4f04-a2a2-a0fad0660ab4	2	1	\N	172.16.0.0/12	{"vrf": null, "role": null, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/12", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Префикс для лупбэков", "last_updated": "2020-01-14T19:43:17.781Z", "custom_fields": {}}	48	\N	1
292	2020-01-14 22:43:48.795068+03	admin	5df13e1e-c796-4a4d-9daf-bf8f9b886071	2	23	\N	172.16.8.0/23	{"vrf": null, "role": 5, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе RU", "last_updated": "2020-01-14T19:43:48.780Z", "custom_fields": {}}	48	\N	1
293	2020-01-14 22:43:48.801235+03	admin	5df13e1e-c796-4a4d-9daf-bf8f9b886071	2	26	\N	172.16.10.0/23	{"vrf": null, "role": 5, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе SP", "last_updated": "2020-01-14T19:43:48.783Z", "custom_fields": {}}	48	\N	1
294	2020-01-14 22:43:48.806451+03	admin	5df13e1e-c796-4a4d-9daf-bf8f9b886071	2	29	\N	172.16.12.0/23	{"vrf": null, "role": 5, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.0/23", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в регионе CN", "last_updated": "2020-01-14T19:43:48.787Z", "custom_fields": {}}	48	\N	1
295	2020-01-14 22:44:06.404505+03	admin	9e7db77a-a238-4605-a588-3b77df289856	2	24	\N	172.16.8.0/25	{"vrf": null, "role": 5, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ msk", "last_updated": "2020-01-14T19:44:06.390Z", "custom_fields": {}}	48	\N	1
296	2020-01-14 22:44:06.412261+03	admin	9e7db77a-a238-4605-a588-3b77df289856	2	25	\N	172.16.8.128/25	{"vrf": null, "role": 5, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.8.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ kzn", "last_updated": "2020-01-14T19:44:06.396Z", "custom_fields": {}}	48	\N	1
297	2020-01-14 22:44:30.00663+03	admin	fdb4f9df-204a-4a02-b522-c1e2545518d6	2	27	\N	172.16.10.0/25	{"vrf": null, "role": 5, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ bcn", "last_updated": "2020-01-14T19:44:29.993Z", "custom_fields": {}}	48	\N	1
298	2020-01-14 22:44:30.012356+03	admin	fdb4f9df-204a-4a02-b522-c1e2545518d6	2	28	\N	172.16.10.128/25	{"vrf": null, "role": 5, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.10.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:44:29.998Z", "custom_fields": {}}	48	\N	1
299	2020-01-14 22:44:53.587057+03	admin	929bc3f1-b83c-433b-94f6-d0b74c1f43a0	2	30	\N	172.16.12.0/25	{"vrf": null, "role": 5, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.0/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ sha", "last_updated": "2020-01-14T19:44:53.574Z", "custom_fields": {}}	48	\N	1
300	2020-01-14 22:44:53.59254+03	admin	929bc3f1-b83c-433b-94f6-d0b74c1f43a0	2	31	\N	172.16.12.128/25	{"vrf": null, "role": 5, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.12.128/25", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Leaf-устройств в ДЦ sia", "last_updated": "2020-01-14T19:44:53.579Z", "custom_fields": {}}	48	\N	1
301	2020-01-14 22:45:22.741218+03	admin	ab6c15d0-6667-4544-a315-cdf085f74219	2	18	\N	172.16.2.64/28	{"vrf": null, "role": 4, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.64/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ bcn", "last_updated": "2020-01-14T19:45:22.728Z", "custom_fields": {}}	48	\N	1
302	2020-01-14 22:45:22.746647+03	admin	ab6c15d0-6667-4544-a315-cdf085f74219	2	19	\N	172.16.2.80/28	{"vrf": null, "role": 4, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.80/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Для Spine-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:45:22.733Z", "custom_fields": {}}	48	\N	1
303	2020-01-14 22:45:54.507688+03	admin	18f733f7-c312-4f71-aeb9-f8b32a49f17c	2	21	\N	172.16.2.128/28	{"vrf": null, "role": 4, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.128/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ sha", "last_updated": "2020-01-14T19:45:54.495Z", "custom_fields": {}}	48	\N	1
304	2020-01-14 22:45:54.512816+03	admin	18f733f7-c312-4f71-aeb9-f8b32a49f17c	2	22	\N	172.16.2.144/28	{"vrf": null, "role": 4, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.144/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ sia", "last_updated": "2020-01-14T19:45:54.500Z", "custom_fields": {}}	48	\N	1
305	2020-01-14 22:46:25.654417+03	admin	d77cbe1b-b582-45a3-8543-5a823b170eb0	2	5	\N	172.16.0.0/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств региона RU", "last_updated": "2020-01-14T19:46:25.641Z", "custom_fields": {}}	48	\N	1
306	2020-01-14 22:46:33.528371+03	admin	3be9967a-3736-401e-ab1a-32c0a33c4dd9	2	8	\N	172.16.0.32/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.32/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств региона SP", "last_updated": "2020-01-14T19:46:33.515Z", "custom_fields": {}}	48	\N	1
307	2020-01-14 22:46:41.292503+03	admin	7315c4a4-aea2-4100-a148-32c4a832cf7e	2	11	\N	172.16.0.64/27	{"vrf": null, "role": 1, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.64/27", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Edge-устройств региона CN", "last_updated": "2020-01-14T19:46:41.279Z", "custom_fields": {}}	48	\N	1
308	2020-01-14 22:47:18.875036+03	admin	4572a07e-a798-44a8-8ab2-de99a4b8fd26	2	19	\N	172.16.2.80/28	{"vrf": null, "role": 4, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.2.80/28", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Для Spine-устройств в ДЦ mlg", "last_updated": "2020-01-14T19:47:18.863Z", "custom_fields": {}}	48	\N	1
309	2020-01-14 22:48:42.976008+03	admin	802dc14c-aecf-4326-bf0d-5882e7b7cb3c	1	32	\N	169.254.0.0/16	{"vrf": null, "role": 2, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "169.254.0.0/16", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Link Local адреса", "last_updated": "2020-01-14T19:48:42.959Z", "custom_fields": {}}	48	\N	1
310	2020-01-14 22:49:35.353602+03	admin	1f9460cd-784b-4553-aa52-cb4a194e2586	1	33	\N	10.0.0.0/8	{"vrf": null, "role": 3, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.0.0/8", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay-адреса для подключения серверов", "last_updated": "2020-01-14T19:49:35.338Z", "custom_fields": {}}	48	\N	1
311	2020-01-14 22:50:14.203267+03	admin	beba9ed7-36d1-4edd-83f5-879a526842c0	2	2	\N	P2P Link Local	{"name": "P2P Link Local", "slug": "p2p-link-local", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:50:14.199Z"}	50	\N	1
312	2020-01-14 22:50:24.236622+03	admin	b740be0a-9914-4ef4-aa92-b691b74ac2af	1	6	\N	P2P Edge	{"name": "P2P Edge", "slug": "p2p-edge", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T19:50:24.233Z"}	50	\N	1
313	2020-01-14 22:53:01.357393+03	admin	71079f41-92b7-407a-acb0-5ac26e9e5957	1	34	\N	192.168.0.0/16	{"vrf": null, "role": 6, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "192.168.0.0/16", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "", "last_updated": "2020-01-14T19:53:01.340Z", "custom_fields": {}}	48	\N	1
314	2020-01-14 22:55:00.811745+03	admin	34cb47c1-6db9-4720-a6d1-1b16f5e3a129	1	35	\N	10.0.0.0/17	{"vrf": null, "role": 6, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.0.0/17", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Edge P2P-адреса для региона RU", "last_updated": "2020-01-14T19:55:00.795Z", "custom_fields": {}}	48	\N	1
315	2020-01-14 22:55:51.873814+03	admin	40034893-0fff-4758-94ea-a38e702f2ca4	1	36	\N	10.0.0.0/19	{"vrf": null, "role": 3, "site": 1, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.0.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ msk", "last_updated": "2020-01-14T19:55:51.857Z", "custom_fields": {}}	48	\N	1
316	2020-01-14 22:56:25.681026+03	admin	a77c0ddb-3f82-4be0-bdb8-158e3143a8c7	2	35	\N	10.0.0.0/17	{"vrf": null, "role": 3, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.0.0/17", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Edge P2P-адреса для региона RU", "last_updated": "2020-01-14T19:56:25.670Z", "custom_fields": {}}	48	\N	1
317	2020-01-14 22:58:19.675123+03	admin	9e147df1-0ddf-4346-bc21-7da0dacd877c	2	35	\N	10.0.0.0/17	{"vrf": null, "role": 3, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.0.0/17", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для региона RU", "last_updated": "2020-01-14T19:58:19.663Z", "custom_fields": {}}	48	\N	1
318	2020-01-14 22:59:35.291585+03	admin	26219438-4421-41e5-9c09-2f61cb68f12f	1	37	\N	10.0.32.0/19	{"vrf": null, "role": 3, "site": 2, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.32.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ kzn", "last_updated": "2020-01-14T19:59:35.275Z", "custom_fields": {}}	48	\N	1
319	2020-01-14 22:59:55.358621+03	admin	1aae6d37-7c20-4f2f-a88f-1c3133628d0d	1	38	\N	10.0.128.0/17	{"vrf": null, "role": 3, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.128.0/17", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для региона SP", "last_updated": "2020-01-14T19:59:55.344Z", "custom_fields": {}}	48	\N	1
320	2020-01-14 23:00:19.681323+03	admin	8f8164b5-10c0-4eed-8ef4-0f139ee4d52c	1	39	\N	10.0.128.0/19	{"vrf": null, "role": 3, "site": 5, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.128.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ bcn", "last_updated": "2020-01-14T20:00:19.665Z", "custom_fields": {}}	48	\N	1
321	2020-01-14 23:00:40.619826+03	admin	c026dc54-ddc2-42bb-9910-a106897f0684	1	40	\N	10.0.160.0/19	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ mlg", "last_updated": "2020-01-14T20:00:40.604Z", "custom_fields": {}}	48	\N	1
322	2020-01-14 23:01:07.351391+03	admin	0e1728a5-843f-45e2-8a9a-d0816c22caea	1	41	\N	10.1.0.0/17	{"vrf": null, "role": 3, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "10.1.0.0/17", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для региона CN", "last_updated": "2020-01-14T20:01:07.336Z", "custom_fields": {}}	48	\N	1
323	2020-01-14 23:01:28.331817+03	admin	fee95aff-6932-47fa-be00-bfd4883aca01	1	42	\N	10.1.0.0/19	{"vrf": null, "role": 3, "site": 3, "tags": [], "vlan": null, "family": 4, "prefix": "10.1.0.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ sha", "last_updated": "2020-01-14T20:01:28.314Z", "custom_fields": {}}	48	\N	1
324	2020-01-14 23:01:47.202239+03	admin	5428fdd1-88a6-4ffc-8bed-5f3fc68e0697	1	43	\N	10.1.32.0/19	{"vrf": null, "role": 3, "site": 4, "tags": [], "vlan": null, "family": 4, "prefix": "10.1.32.0/19", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "Underlay для ДЦ sia", "last_updated": "2020-01-14T20:01:47.187Z", "custom_fields": {}}	48	\N	1
325	2020-01-14 23:02:34.061519+03	admin	7c261fe7-191a-4014-8599-2afdc2807d97	1	7	\N	Loopbacks	{"name": "Loopbacks", "slug": "loopbacks", "weight": 1000, "created": "2020-01-14", "last_updated": "2020-01-14T20:02:34.058Z"}	50	\N	1
346	2020-01-16 10:20:32.012704+03	admin	8090bf27-4963-45b5-a4a2-5a6314794bdc	1	1	\N	172.16.0.40/29	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.0.40/29", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:20:31.975Z", "custom_fields": {}}	47	\N	1
326	2020-01-14 23:04:07.876429+03	admin	6def1b0b-1a69-4339-a082-5ea6f108938d	2	1	\N	172.16.0.0/12	{"vrf": null, "role": 7, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "172.16.0.0/12", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": true, "description": "Префикс для лупбэков", "last_updated": "2020-01-14T20:04:07.863Z", "custom_fields": {}}	48	\N	1
327	2020-01-14 23:04:33.764527+03	admin	c17bfe3f-78d3-4043-a590-3a6c5655aecb	2	34	\N	192.168.0.0/16	{"vrf": null, "role": 6, "site": null, "tags": [], "vlan": null, "family": 4, "prefix": "192.168.0.0/16", "status": 1, "tenant": null, "created": "2020-01-14", "is_pool": false, "description": "P2P адреса для Edge-устройств", "last_updated": "2020-01-14T20:04:33.753Z", "custom_fields": {}}	48	\N	1
328	2020-01-16 09:15:53.631839+03	admin	499e8f78-ae39-4a6a-888a-b643de37067e	1	110	8	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
329	2020-01-16 10:06:48.068403+03	admin	b94b0833-6d69-4678-9423-3cc3ff0a9e9d	1	111	8	Vlan127	{"lag": null, "mtu": null, "mode": null, "name": "Vlan127", "tags": [], "type": 0, "cable": null, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
330	2020-01-16 10:07:20.559807+03	admin	8364cb63-7471-42bc-a88b-8d4a55f29d55	1	112	9	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
331	2020-01-16 10:07:27.397837+03	admin	1c741dfc-5ed2-4cfd-a664-6575809d7105	1	113	9	Vlan127	{"lag": null, "mtu": null, "mode": null, "name": "Vlan127", "tags": [], "type": 0, "cable": null, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
332	2020-01-16 10:07:43.483315+03	admin	e8e6ead4-a145-473e-86d7-b69a36605b7c	1	114	10	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
333	2020-01-16 10:07:49.918621+03	admin	69e85af2-79e5-4f53-bab1-da62f6db820d	1	115	10	Vlan127	{"lag": null, "mtu": null, "mode": null, "name": "Vlan127", "tags": [], "type": 0, "cable": null, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
334	2020-01-16 10:08:10.892476+03	admin	63fd247d-9ce5-4976-b2de-430acbf39769	1	116	11	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
335	2020-01-16 10:09:38.44249+03	admin	d1af190c-dbb5-423c-884c-a243f3a9a027	1	117	11	Vlan127	{"lag": null, "mtu": null, "mode": null, "name": "Vlan127", "tags": [], "type": 0, "cable": null, "device": 11, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
336	2020-01-16 10:11:54.161812+03	admin	d786fe00-eb42-4d16-8ea1-721f8899846d	1	118	12	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 12, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
337	2020-01-16 10:13:06.634502+03	admin	5d1b822a-4794-4c05-b1c2-1c1c7c9d89de	1	119	13	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 13, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
338	2020-01-16 10:13:19.941258+03	admin	56455ce1-56ba-4361-9627-7a8d220dce3e	1	120	14	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 14, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
339	2020-01-16 10:13:34.783306+03	admin	ad56e2e7-8c62-47c5-a340-6d4c3c259517	1	121	15	Loopback0	{"lag": null, "mtu": null, "mode": null, "name": "Loopback0", "tags": [], "type": 0, "cable": null, "device": 15, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
340	2020-01-16 10:17:34.053444+03	admin	9d508786-8297-4754-ab66-f0d7ac8f42c5	1	122	16	irb.127	{"lag": null, "mtu": null, "mode": null, "name": "irb.127", "tags": [], "type": 0, "cable": null, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
341	2020-01-16 10:17:40.941739+03	admin	c136f696-c4c3-40d6-ae20-bea46938698d	3	122	16	irb.127	{"lag": null, "mtu": null, "mode": null, "name": "irb.127", "tags": [], "type": 0, "cable": null, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
342	2020-01-16 10:18:18.787229+03	admin	6ca7f853-396f-4df3-b8b3-9d7ab820dcd4	1	123	16	lo0	{"lag": null, "mtu": null, "mode": null, "name": "lo0", "tags": [], "type": 0, "cable": null, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
343	2020-01-16 10:18:24.392306+03	admin	1783e53a-b0fb-432e-bb80-f3e6abd059bd	1	124	16	lo0.0	{"lag": null, "mtu": null, "mode": null, "name": "lo0.0", "tags": [], "type": 0, "cable": null, "device": 16, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
344	2020-01-16 10:18:56.083826+03	admin	ed21f3d8-4ab4-4a92-9d60-56128415a681	1	125	17	lo0	{"lag": null, "mtu": null, "mode": null, "name": "lo0", "tags": [], "type": 0, "cable": null, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
345	2020-01-16 10:19:00.110184+03	admin	98fd9408-395d-4b09-b293-6604ae5ce12a	1	126	17	lo0.0	{"lag": null, "mtu": null, "mode": null, "name": "lo0.0", "tags": [], "type": 0, "cable": null, "device": 17, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": null, "_connected_interface": null, "_connected_circuittermination": null}	5	21	1
347	2020-01-16 10:20:40.364091+03	admin	29405888-0882-400e-ace7-533725fe6904	1	2	\N	172.16.0.41/29	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.0.41/29", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:20:40.349Z", "custom_fields": {}}	47	\N	1
348	2020-01-16 10:21:07.550891+03	admin	2420bdc7-61f4-471b-8329-8e432f42b6c8	2	1	124	172.16.0.40/29	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.0.40/29", "created": "2020-01-16", "dns_name": "", "interface": 124, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:21:07.539Z", "custom_fields": {}}	47	5	1
350	2020-01-16 10:22:22.427946+03	admin	746896df-4f59-44fc-989a-a3e456dc8258	1	3	\N	172.16.2.80/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.80/28", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:22:22.412Z", "custom_fields": {}}	47	\N	1
352	2020-01-16 10:22:42.93737+03	admin	416713a7-83d7-455f-b504-0e9498744f9f	1	5	\N	172.16.2.82/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.82/28", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:22:42.923Z", "custom_fields": {}}	47	\N	1
353	2020-01-16 10:22:47.607974+03	admin	f170bc9e-21af-46b4-9e1c-9b46c2d23521	1	6	\N	172.16.2.83/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.83/28", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:22:47.593Z", "custom_fields": {}}	47	\N	1
349	2020-01-16 10:21:49.803978+03	admin	02ffa54b-fee8-4af2-b919-46bb16fe7302	2	2	126	172.16.0.41/29	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.0.41/29", "created": "2020-01-16", "dns_name": "", "interface": 126, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:21:49.791Z", "custom_fields": {}}	47	5	1
351	2020-01-16 10:22:36.583694+03	admin	5570b6e0-5dc6-4d46-b25d-da641e7411d8	1	4	\N	172.16.2.81/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.81/28", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:22:36.567Z", "custom_fields": {}}	47	\N	1
354	2020-01-16 10:24:29.732709+03	admin	7fc459a6-e971-475d-804b-b79e061fb5c6	2	3	118	172.16.2.80/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.80/28", "created": "2020-01-16", "dns_name": "", "interface": 118, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:24:29.720Z", "custom_fields": {}}	47	5	1
355	2020-01-16 10:25:00.143121+03	admin	570c3f34-36d5-4c2e-8275-79f5412e119d	2	4	119	172.16.2.81/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.81/28", "created": "2020-01-16", "dns_name": "", "interface": 119, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:25:00.131Z", "custom_fields": {}}	47	5	1
356	2020-01-16 10:25:25.160271+03	admin	288b7101-9bfa-4e86-8df7-3ab45b5c7f4a	2	5	120	172.16.2.82/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.82/28", "created": "2020-01-16", "dns_name": "", "interface": 120, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:25:25.148Z", "custom_fields": {}}	47	5	1
357	2020-01-16 10:25:48.91098+03	admin	c7b96d20-a31c-49ad-ac4e-538f4296d22d	2	6	121	172.16.2.83/28	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.2.83/28", "created": "2020-01-16", "dns_name": "", "interface": 121, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:25:48.899Z", "custom_fields": {}}	47	5	1
358	2020-01-16 10:26:27.440876+03	admin	bcd337bb-5fa6-41a4-a664-80ec766e736e	1	7	\N	172.16.10.128/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.128/25", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:26:27.426Z", "custom_fields": {}}	47	\N	1
359	2020-01-16 10:26:37.104767+03	admin	c99974f5-3fdb-4c46-9c95-315217a36c51	1	8	\N	172.16.10.129/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.129/25", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:26:37.089Z", "custom_fields": {}}	47	\N	1
360	2020-01-16 10:26:41.942535+03	admin	8b24182a-b357-47b0-8cba-1f718d7385dc	1	9	\N	172.16.10.130/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.130/25", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:26:41.927Z", "custom_fields": {}}	47	\N	1
361	2020-01-16 10:26:48.671305+03	admin	9ebcdff0-2d6f-4888-a11f-b3bb95381846	1	10	\N	172.16.10.131/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.131/25", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:26:48.656Z", "custom_fields": {}}	47	\N	1
362	2020-01-16 10:27:44.596353+03	admin	663d5565-1bfb-447d-8baf-079a4d407779	2	7	110	172.16.10.128/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.128/25", "created": "2020-01-16", "dns_name": "", "interface": 110, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:27:44.584Z", "custom_fields": {}}	47	5	1
363	2020-01-16 10:28:06.422902+03	admin	1e9994c5-0c5e-4436-beff-c88b327aa240	2	8	112	172.16.10.129/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.129/25", "created": "2020-01-16", "dns_name": "", "interface": 112, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:28:06.411Z", "custom_fields": {}}	47	5	1
364	2020-01-16 10:28:40.702323+03	admin	c0747a30-f200-456a-8af1-6fd57146de6e	2	9	114	172.16.10.130/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.130/25", "created": "2020-01-16", "dns_name": "", "interface": 114, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:28:40.690Z", "custom_fields": {}}	47	5	1
365	2020-01-16 10:29:03.605921+03	admin	caa5122d-45f7-48ac-b3f0-cd5b37821853	2	10	116	172.16.10.131/25	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "172.16.10.131/25", "created": "2020-01-16", "dns_name": "", "interface": 116, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:29:03.594Z", "custom_fields": {}}	47	5	1
366	2020-01-16 10:32:14.583857+03	admin	90818f5a-3a29-471b-b399-c33d15ed5e58	1	44	\N	10.0.160.0/26	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.0/26", "status": 1, "tenant": null, "created": "2020-01-16", "is_pool": false, "description": "Underlay для mlg-leaf-0", "last_updated": "2020-01-16T07:32:14.568Z", "custom_fields": {}}	48	\N	1
367	2020-01-16 10:33:20.966618+03	admin	2547607a-fce3-41a3-a818-cf391a3cc80b	1	11	\N	10.0.160.1/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.1/26", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:33:20.950Z", "custom_fields": {}}	47	\N	1
368	2020-01-16 10:34:13.262071+03	admin	e1ac9757-a4f2-4b11-beaa-fef546464828	1	45	\N	10.0.160.64/26	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.64/26", "status": 1, "tenant": null, "created": "2020-01-16", "is_pool": false, "description": "Для mlg-leaf-1", "last_updated": "2020-01-16T07:34:13.245Z", "custom_fields": {}}	48	\N	1
369	2020-01-16 10:34:21.944245+03	admin	19d74184-94a1-47d5-a8fc-a4d456e3db4e	1	12	\N	10.0.160.65/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.65/26", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:34:21.927Z", "custom_fields": {}}	47	\N	1
370	2020-01-16 10:35:59.710999+03	admin	413b87b7-8b7c-4b6e-94a6-cacafe25e74d	2	45	\N	10.0.160.64/26	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.64/26", "status": 1, "tenant": null, "created": "2020-01-16", "is_pool": false, "description": "Underlay для mlg-leaf-1", "last_updated": "2020-01-16T07:35:59.700Z", "custom_fields": {}}	48	\N	1
371	2020-01-16 10:36:40.408651+03	admin	03df5096-89d6-441b-b91a-a6051a59318b	1	46	\N	10.0.160.128/26	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.128/26", "status": 1, "tenant": null, "created": "2020-01-16", "is_pool": false, "description": "Underlay для mlg-leaf-5", "last_updated": "2020-01-16T07:36:40.393Z", "custom_fields": {}}	48	\N	1
373	2020-01-16 10:37:17.295105+03	admin	b9e67abd-1bf7-46cc-b08e-cc171713b04a	1	13	\N	10.0.160.193/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.193/26", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:37:17.280Z", "custom_fields": {}}	47	\N	1
375	2020-01-16 10:38:46.416977+03	admin	12af6ba5-0b4f-4450-8c83-11ecf14e2813	2	11	111	10.0.160.1/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.1/26", "created": "2020-01-16", "dns_name": "", "interface": 111, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:38:46.405Z", "custom_fields": {}}	47	5	1
372	2020-01-16 10:37:04.220719+03	admin	249c2b4f-4bcf-4be0-bde4-4c72496de0f8	1	47	\N	10.0.160.192/26	{"vrf": null, "role": 3, "site": 6, "tags": [], "vlan": null, "family": 4, "prefix": "10.0.160.192/26", "status": 1, "tenant": null, "created": "2020-01-16", "is_pool": false, "description": "Underlay для mlg-leaf-6", "last_updated": "2020-01-16T07:37:04.205Z", "custom_fields": {}}	48	\N	1
374	2020-01-16 10:38:03.172477+03	admin	4bf40293-570f-467f-9012-0dfc1d3ca0c6	1	14	\N	10.0.160.129/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.129/26", "created": "2020-01-16", "dns_name": "", "interface": null, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:38:03.158Z", "custom_fields": {}}	47	\N	1
376	2020-01-16 10:39:04.695167+03	admin	88231ccc-8feb-460e-a4fa-ec0733f781c5	2	12	113	10.0.160.65/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.65/26", "created": "2020-01-16", "dns_name": "", "interface": 113, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:39:04.683Z", "custom_fields": {}}	47	5	1
377	2020-01-16 10:39:46.247163+03	admin	d3a4b63d-9e39-4cf8-b40c-a642b1486cb6	2	14	115	10.0.160.129/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.129/26", "created": "2020-01-16", "dns_name": "", "interface": 115, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:39:46.235Z", "custom_fields": {}}	47	5	1
378	2020-01-16 10:40:06.92155+03	admin	d5cc156e-7b7b-409f-a8a6-b6f5aecade2f	2	13	117	10.0.160.193/26	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "10.0.160.193/26", "created": "2020-01-16", "dns_name": "", "interface": 117, "nat_inside": null, "description": "", "last_updated": "2020-01-16T07:40:06.909Z", "custom_fields": {}}	47	5	1
379	2020-01-16 17:28:57.099865+03	admin	dc33325b-b83a-4134-a9ad-4cb12a91eb75	1	15	8	169.254.0.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.0/31", "created": "2020-01-16", "dns_name": "", "interface": 8, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:28:57.083Z", "custom_fields": {}}	47	5	1
380	2020-01-16 17:29:19.970263+03	admin	4a063869-6dcb-47dd-b50e-9c1bf8e8756d	1	16	48	169.254.0.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.1/31", "created": "2020-01-16", "dns_name": "", "interface": 48, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:29:19.952Z", "custom_fields": {}}	47	5	1
381	2020-01-16 17:29:31.627772+03	admin	d21057ae-d6ff-4b49-825f-ecb5e2b119e8	1	17	9	169.254.1.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.0/31", "created": "2020-01-16", "dns_name": "", "interface": 9, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:29:31.612Z", "custom_fields": {}}	47	5	1
382	2020-01-16 17:29:50.275684+03	admin	beaa6ead-65ab-4764-b3cc-3e27a03b6acc	1	18	58	169.254.1.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.1/31", "created": "2020-01-16", "dns_name": "", "interface": 58, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:29:50.259Z", "custom_fields": {}}	47	5	1
383	2020-01-16 17:30:00.242562+03	admin	c1e0207e-ecae-4050-96c2-c65593ccfa14	1	19	10	169.254.2.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.0/31", "created": "2020-01-16", "dns_name": "", "interface": 10, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:30:00.226Z", "custom_fields": {}}	47	5	1
384	2020-01-16 17:30:20.174542+03	admin	a1c509c3-ddc2-4937-8499-ade022eabddc	1	20	68	169.254.2.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.1/31", "created": "2020-01-16", "dns_name": "", "interface": 68, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:30:20.159Z", "custom_fields": {}}	47	5	1
385	2020-01-16 17:30:32.57446+03	admin	541d4540-1b09-434d-a065-858625019534	1	21	11	169.254.3.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.0/31", "created": "2020-01-16", "dns_name": "", "interface": 11, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:30:32.557Z", "custom_fields": {}}	47	5	1
386	2020-01-16 17:30:47.374488+03	admin	198650ec-e5a7-40f9-9e62-09f00f6e923e	1	22	78	169.254.3.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.1/31", "created": "2020-01-16", "dns_name": "", "interface": 78, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:30:47.356Z", "custom_fields": {}}	47	5	1
387	2020-01-16 17:31:10.345735+03	admin	7d58733c-21e7-436e-b5ea-e0bf607d9b3c	1	23	18	169.254.0.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.2/31", "created": "2020-01-16", "dns_name": "", "interface": 18, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:31:10.330Z", "custom_fields": {}}	47	5	1
388	2020-01-16 17:31:24.043801+03	admin	b4799290-1ef6-4972-9473-26ffdd52df7e	1	24	49	169.254.0.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.3/31", "created": "2020-01-16", "dns_name": "", "interface": 49, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:31:24.026Z", "custom_fields": {}}	47	5	1
389	2020-01-16 17:31:33.660362+03	admin	cce6792e-90e7-42ed-9dc1-74f174a2739b	1	25	19	169.254.1.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.2/31", "created": "2020-01-16", "dns_name": "", "interface": 19, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:31:33.644Z", "custom_fields": {}}	47	5	1
390	2020-01-16 17:31:47.371948+03	admin	7ff78f18-0849-4bce-86e0-3035a521b5c0	1	26	59	169.254.1.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.3/31", "created": "2020-01-16", "dns_name": "", "interface": 59, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:31:47.356Z", "custom_fields": {}}	47	5	1
391	2020-01-16 17:31:59.115324+03	admin	23f15f51-e4c6-42c8-85d6-fb5c35b48059	1	27	20	169.254.2.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.2/31", "created": "2020-01-16", "dns_name": "", "interface": 20, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:31:59.098Z", "custom_fields": {}}	47	5	1
392	2020-01-16 17:32:11.818132+03	admin	800ec150-ec14-49f5-af40-f215d62527eb	1	28	69	169.254.2.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.3/31", "created": "2020-01-16", "dns_name": "", "interface": 69, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:32:11.802Z", "custom_fields": {}}	47	5	1
393	2020-01-16 17:32:21.132609+03	admin	ba8029ce-0294-4a90-8386-67daea70e489	1	29	21	169.254.3.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.2/31", "created": "2020-01-16", "dns_name": "", "interface": 21, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:32:21.117Z", "custom_fields": {}}	47	5	1
394	2020-01-16 17:32:31.148935+03	admin	39ebbb15-de3e-4f0f-a543-c8087dd57a7d	1	30	79	169.254.3.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.3/31", "created": "2020-01-16", "dns_name": "", "interface": 79, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:32:31.133Z", "custom_fields": {}}	47	5	1
397	2020-01-16 17:33:25.600077+03	admin	7845bb18-b0b0-4899-b999-1134d13a3225	1	33	29	169.254.1.10/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.10/31", "created": "2020-01-16", "dns_name": "", "interface": 29, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:33:25.584Z", "custom_fields": {}}	47	5	1
399	2020-01-16 17:33:47.244708+03	admin	a12777a6-87b3-4115-a3f7-f7227031b525	1	35	30	169.254.2.10/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.10/31", "created": "2020-01-16", "dns_name": "", "interface": 30, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:33:47.228Z", "custom_fields": {}}	47	5	1
401	2020-01-16 17:34:07.648889+03	admin	ea70cd4c-9f6d-4c83-9871-d9e82816fefe	1	37	31	169.254.3.10/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.10/31", "created": "2020-01-16", "dns_name": "", "interface": 31, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:34:07.633Z", "custom_fields": {}}	47	5	1
402	2020-01-16 17:34:16.459946+03	admin	553d55bc-d148-4a2e-9bed-dfbfde7175fb	1	38	80	169.254.3.11/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.11/31", "created": "2020-01-16", "dns_name": "", "interface": 80, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:34:16.444Z", "custom_fields": {}}	47	5	1
403	2020-01-16 17:34:33.192346+03	admin	7cac87f2-8abf-4010-aebe-282a4e27afeb	1	39	38	169.254.0.12/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.12/31", "created": "2020-01-16", "dns_name": "", "interface": 38, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:34:33.176Z", "custom_fields": {}}	47	5	1
405	2020-01-16 17:34:53.068191+03	admin	b44b571d-b452-4ca1-8dbe-f7a409080110	1	41	39	169.254.1.12/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.12/31", "created": "2020-01-16", "dns_name": "", "interface": 39, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:34:53.052Z", "custom_fields": {}}	47	5	1
406	2020-01-16 17:35:10.288717+03	admin	96e724d4-3dc4-4a5d-9aa5-ac2577b23e65	1	42	61	169.254.1.13/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.13/31", "created": "2020-01-16", "dns_name": "", "interface": 61, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:35:10.273Z", "custom_fields": {}}	47	5	1
408	2020-01-16 17:35:47.454625+03	admin	675ed01f-3e07-4bd0-806b-20ecd6671d3e	1	44	71	169.254.2.13/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.13/31", "created": "2020-01-16", "dns_name": "", "interface": 71, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:35:47.439Z", "custom_fields": {}}	47	5	1
395	2020-01-16 17:32:59.520295+03	admin	b135add1-387c-4f73-a0b8-206f112d746d	1	31	28	169.254.0.10/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.10/31", "created": "2020-01-16", "dns_name": "", "interface": 28, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:32:59.503Z", "custom_fields": {}}	47	5	1
396	2020-01-16 17:33:14.199607+03	admin	078cc71a-b66e-49ae-82e8-37e260923f53	1	32	50	169.254.0.11/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.11/31", "created": "2020-01-16", "dns_name": "", "interface": 50, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:33:14.184Z", "custom_fields": {}}	47	5	1
398	2020-01-16 17:33:33.748223+03	admin	d5741284-59a4-4a7c-9498-3054413a80f4	1	34	60	169.254.1.11/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.1.11/31", "created": "2020-01-16", "dns_name": "", "interface": 60, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:33:33.730Z", "custom_fields": {}}	47	5	1
400	2020-01-16 17:33:55.752927+03	admin	baf54cae-8332-4245-bd94-cec0efa1a29e	1	36	70	169.254.2.11/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.11/31", "created": "2020-01-16", "dns_name": "", "interface": 70, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:33:55.736Z", "custom_fields": {}}	47	5	1
404	2020-01-16 17:34:45.481438+03	admin	c6d70ad9-4d72-4d66-a402-ea710416f474	1	40	51	169.254.0.13/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.0.13/31", "created": "2020-01-16", "dns_name": "", "interface": 51, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:34:45.464Z", "custom_fields": {}}	47	5	1
407	2020-01-16 17:35:30.11343+03	admin	2988854a-386b-4b9f-a1b1-220e679ac08d	1	43	40	169.254.2.12/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.2.12/31", "created": "2020-01-16", "dns_name": "", "interface": 40, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:35:30.097Z", "custom_fields": {}}	47	5	1
409	2020-01-16 17:35:57.435598+03	admin	e0c5c8ff-12bf-4d11-a6a5-68d46d1bb227	1	45	41	169.254.3.12/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.12/31", "created": "2020-01-16", "dns_name": "", "interface": 41, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:35:57.417Z", "custom_fields": {}}	47	5	1
410	2020-01-16 17:36:20.377824+03	admin	f53989c7-4c0e-4abb-99bc-1fc22c9b1bc3	1	46	81	169.254.3.13/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.3.13/31", "created": "2020-01-16", "dns_name": "", "interface": 81, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:36:20.360Z", "custom_fields": {}}	47	5	1
411	2020-01-16 17:38:12.925285+03	admin	37423c16-6486-4901-bc59-6adcebe011dc	1	47	86	169.254.103.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.0/31", "created": "2020-01-16", "dns_name": "", "interface": 86, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:38:12.909Z", "custom_fields": {}}	47	5	1
412	2020-01-16 17:38:29.501385+03	admin	4f1c64c6-7355-4b7d-abf9-10070d413cf9	1	48	91	169.254.103.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.1/31", "created": "2020-01-16", "dns_name": "", "interface": 91, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:38:29.483Z", "custom_fields": {}}	47	5	1
413	2020-01-16 17:38:48.375841+03	admin	09c097bb-9e76-4962-b76e-30f02bd5d07f	1	49	85	169.254.103.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.2/31", "created": "2020-01-16", "dns_name": "", "interface": 85, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:38:48.357Z", "custom_fields": {}}	47	5	1
414	2020-01-16 17:39:04.248757+03	admin	3e305b5f-a30d-4b14-b68d-a786a1135bdb	1	50	102	169.254.103.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.3/31", "created": "2020-01-16", "dns_name": "", "interface": 102, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:39:04.233Z", "custom_fields": {}}	47	5	1
415	2020-01-16 17:39:24.188655+03	admin	ed22e1b1-f8e1-411a-b682-d3a62c9922ae	2	50	102	169.254.103.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.2/31", "created": "2020-01-16", "dns_name": "", "interface": 102, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:39:24.176Z", "custom_fields": {}}	47	5	1
416	2020-01-16 17:39:38.61318+03	admin	fcd15090-fcf1-4d7b-bd26-65f4f69b9538	2	49	85	169.254.103.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.3/31", "created": "2020-01-16", "dns_name": "", "interface": 85, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:39:38.601Z", "custom_fields": {}}	47	5	1
417	2020-01-16 17:39:47.586179+03	admin	2bca740d-1cb2-42f7-85ca-687ed9316568	2	47	86	169.254.103.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.1/31", "created": "2020-01-16", "dns_name": "", "interface": 86, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:39:47.574Z", "custom_fields": {}}	47	5	1
418	2020-01-16 17:40:13.697312+03	admin	c68a6cb2-74fc-438d-b518-d19357cabc7b	1	51	56	169.254.100.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.1/31", "created": "2020-01-16", "dns_name": "", "interface": 56, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:40:13.680Z", "custom_fields": {}}	47	5	1
419	2020-01-16 17:40:37.708112+03	admin	4befabce-908d-44b1-9ac9-2217054fb548	2	48	91	169.254.100.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.0/31", "created": "2020-01-16", "dns_name": "", "interface": 91, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:40:37.696Z", "custom_fields": {}}	47	5	1
420	2020-01-16 17:40:55.206691+03	admin	b0355a27-04fa-4616-93d0-057aa7aae983	2	48	91	169.254.103.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.103.0/31", "created": "2020-01-16", "dns_name": "", "interface": 91, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:40:55.194Z", "custom_fields": {}}	47	5	1
421	2020-01-16 17:41:03.747141+03	admin	cd2d6422-dbc1-49d4-8538-0261d2c7a97a	1	52	88	169.254.100.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.0/31", "created": "2020-01-16", "dns_name": "", "interface": 88, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:41:03.731Z", "custom_fields": {}}	47	5	1
422	2020-01-16 17:41:30.267329+03	admin	b12ec939-059c-4e22-9523-f14fd61dede0	1	53	55	169.254.100.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.3/31", "created": "2020-01-16", "dns_name": "", "interface": 55, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:41:30.252Z", "custom_fields": {}}	47	5	1
423	2020-01-16 17:41:38.207062+03	admin	93e72652-86f3-4f80-9313-511fe8e5fe91	1	54	99	169.254.100.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.0/31", "created": "2020-01-16", "dns_name": "", "interface": 99, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:41:38.190Z", "custom_fields": {}}	47	5	1
424	2020-01-16 17:41:47.443308+03	admin	704f795a-7177-46dd-8165-aa3da1d64ca0	2	54	99	169.254.100.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.100.2/31", "created": "2020-01-16", "dns_name": "", "interface": 99, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:41:47.431Z", "custom_fields": {}}	47	5	1
425	2020-01-16 17:42:25.743788+03	admin	a051a346-ac40-48e6-b025-3c83eb3440c9	1	55	66	169.254.101.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.101.1/31", "created": "2020-01-16", "dns_name": "", "interface": 66, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:42:25.728Z", "custom_fields": {}}	47	5	1
426	2020-01-16 17:42:35.127662+03	admin	d9cb0f3b-cb38-4e8c-ac45-9f77ccf53903	1	56	89	169.254.101.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.101.0/31", "created": "2020-01-16", "dns_name": "", "interface": 89, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:42:35.112Z", "custom_fields": {}}	47	5	1
427	2020-01-16 17:47:26.950186+03	admin	c0e5a609-b70f-425a-af76-a2420b32f1ce	1	57	65	169.254.101.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.101.3/31", "created": "2020-01-16", "dns_name": "", "interface": 65, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:47:26.931Z", "custom_fields": {}}	47	5	1
428	2020-01-16 17:48:02.87975+03	admin	847e5af6-1314-4bce-83c4-557e52a4b9cd	1	58	100	169.254.101.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.101.2/31", "created": "2020-01-16", "dns_name": "", "interface": 100, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:48:02.864Z", "custom_fields": {}}	47	5	1
429	2020-01-16 17:48:46.300429+03	admin	7196d606-7f26-43c5-8554-4adfd23e6e8a	1	59	76	169.254.102.1/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.102.1/31", "created": "2020-01-16", "dns_name": "", "interface": 76, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:48:46.283Z", "custom_fields": {}}	47	5	1
430	2020-01-16 17:49:01.054974+03	admin	6db8b721-1455-4303-98c2-e80c2cd099be	1	60	90	169.254.102.0/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.102.0/31", "created": "2020-01-16", "dns_name": "", "interface": 90, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:49:01.039Z", "custom_fields": {}}	47	5	1
431	2020-01-16 17:49:16.885355+03	admin	34ca385b-20ee-448e-b4aa-b57836593592	1	61	75	169.254.102.3/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.102.3/31", "created": "2020-01-16", "dns_name": "", "interface": 75, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:49:16.869Z", "custom_fields": {}}	47	5	1
432	2020-01-16 17:49:25.343843+03	admin	03be2a88-7635-48e3-a928-b960475c1077	1	62	101	169.254.102.2/31	{"vrf": null, "role": null, "tags": [], "family": 4, "status": 1, "tenant": null, "address": "169.254.102.2/31", "created": "2020-01-16", "dns_name": "", "interface": 101, "nat_inside": null, "description": "", "last_updated": "2020-01-16T14:49:25.327Z", "custom_fields": {}}	47	5	1
433	2020-01-16 17:52:37.659035+03	admin	8c94c214-e49f-4561-884a-000ad68738b2	2	16	8	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 25, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 3, "_connected_circuittermination": null}	5	21	1
434	2020-01-16 17:52:37.667186+03	admin	8c94c214-e49f-4561-884a-000ad68738b2	2	3	3	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 25, "device": 3, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 16, "_connected_circuittermination": null}	5	21	1
435	2020-01-16 17:52:37.672989+03	admin	8c94c214-e49f-4561-884a-000ad68738b2	2	16	8	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 25, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 3, "_connected_circuittermination": null}	5	21	1
436	2020-01-16 17:52:37.678823+03	admin	8c94c214-e49f-4561-884a-000ad68738b2	2	3	3	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 25, "device": 3, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 16, "_connected_circuittermination": null}	5	21	1
437	2020-01-16 17:52:37.680743+03	admin	8c94c214-e49f-4561-884a-000ad68738b2	1	25	\N	#25	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:52:37.616Z", "termination_a_id": 16, "termination_b_id": 3, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 3}	43	\N	1
438	2020-01-16 17:52:57.520906+03	admin	1bb40905-b097-4ab4-81fd-fd473e5bd2bc	2	15	8	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 26, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 2, "_connected_circuittermination": null}	5	21	1
439	2020-01-16 17:52:57.52886+03	admin	1bb40905-b097-4ab4-81fd-fd473e5bd2bc	2	2	2	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 26, "device": 2, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 15, "_connected_circuittermination": null}	5	21	1
440	2020-01-16 17:52:57.535202+03	admin	1bb40905-b097-4ab4-81fd-fd473e5bd2bc	2	15	8	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 26, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 2, "_connected_circuittermination": null}	5	21	1
441	2020-01-16 17:52:57.541505+03	admin	1bb40905-b097-4ab4-81fd-fd473e5bd2bc	2	2	2	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 26, "device": 2, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 15, "_connected_circuittermination": null}	5	21	1
442	2020-01-16 17:52:57.543287+03	admin	1bb40905-b097-4ab4-81fd-fd473e5bd2bc	1	26	\N	#26	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:52:57.482Z", "termination_a_id": 15, "termination_b_id": 2, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 2}	43	\N	1
450	2020-01-16 17:55:53.886093+03	admin	c8ea0632-b8ad-4cf6-b32e-b589b3e95aa7	2	14	8	Ethernet7	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet7", "tags": [], "type": 1200, "cable": 27, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 1, "_connected_circuittermination": null}	5	21	1
443	2020-01-16 17:53:15.977837+03	admin	62650bad-0fa2-4f05-8f2d-ca87ab3814cf	2	14	8	Ethernet7	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet7", "tags": [], "type": 1200, "cable": 27, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 1, "_connected_circuittermination": null}	5	21	1
444	2020-01-16 17:53:15.985448+03	admin	62650bad-0fa2-4f05-8f2d-ca87ab3814cf	2	1	1	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 27, "device": 1, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 14, "_connected_circuittermination": null}	5	21	1
445	2020-01-16 17:53:15.991534+03	admin	62650bad-0fa2-4f05-8f2d-ca87ab3814cf	2	14	8	Ethernet7	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet7", "tags": [], "type": 1200, "cable": 27, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 1, "_connected_circuittermination": null}	5	21	1
446	2020-01-16 17:53:15.99737+03	admin	62650bad-0fa2-4f05-8f2d-ca87ab3814cf	2	1	1	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 27, "device": 1, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 14, "_connected_circuittermination": null}	5	21	1
447	2020-01-16 17:53:15.999207+03	admin	62650bad-0fa2-4f05-8f2d-ca87ab3814cf	1	27	\N	#27	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:53:15.934Z", "termination_a_id": 14, "termination_b_id": 1, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 8, "_termination_b_device": 1}	43	\N	1
448	2020-01-16 17:54:18.269172+03	admin	2f210a44-32bf-41c8-9ad3-2ae1d5cbb0bd	2	14	8	Ethernet7	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet7", "tags": [], "type": 1200, "cable": 27, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": "", "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 1, "_connected_circuittermination": null}	5	21	1
449	2020-01-16 17:55:33.866725+03	admin	11736687-2ad8-4441-9aab-12e74fbbf202	1	1	\N	127 (Underlay)	{"vid": 127, "name": "Underlay", "role": null, "site": null, "tags": [], "group": null, "status": 1, "tenant": null, "created": "2020-01-16", "description": "", "last_updated": "2020-01-16T14:55:33.825Z", "custom_fields": {}}	51	\N	1
451	2020-01-16 17:56:14.502041+03	admin	5b8abfb3-5236-4b3e-82a2-b7cd68330e4e	2	15	8	Ethernet8	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 26, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 2, "_connected_circuittermination": null}	5	21	1
452	2020-01-16 17:56:14.508148+03	admin	5b8abfb3-5236-4b3e-82a2-b7cd68330e4e	2	16	8	Ethernet9	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 25, "device": 8, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 3, "_connected_circuittermination": null}	5	21	1
453	2020-01-16 17:56:56.816976+03	admin	f1f53329-a4af-41b7-bff8-faaaada966de	2	26	9	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 28, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 5, "_connected_circuittermination": null}	5	21	1
454	2020-01-16 17:56:56.825234+03	admin	f1f53329-a4af-41b7-bff8-faaaada966de	2	5	5	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 28, "device": 5, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 26, "_connected_circuittermination": null}	5	21	1
455	2020-01-16 17:56:56.83157+03	admin	f1f53329-a4af-41b7-bff8-faaaada966de	2	26	9	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 28, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 5, "_connected_circuittermination": null}	5	21	1
456	2020-01-16 17:56:56.837739+03	admin	f1f53329-a4af-41b7-bff8-faaaada966de	2	5	5	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 28, "device": 5, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 26, "_connected_circuittermination": null}	5	21	1
457	2020-01-16 17:56:56.839593+03	admin	f1f53329-a4af-41b7-bff8-faaaada966de	1	28	\N	#28	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:56:56.778Z", "termination_a_id": 26, "termination_b_id": 5, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 5}	43	\N	1
458	2020-01-16 17:57:47.030586+03	admin	33aaf39b-31e6-44e4-8cce-ddc42b92bd5d	2	25	9	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 29, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 4, "_connected_circuittermination": null}	5	21	1
459	2020-01-16 17:57:47.038674+03	admin	33aaf39b-31e6-44e4-8cce-ddc42b92bd5d	2	4	4	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 29, "device": 4, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 25, "_connected_circuittermination": null}	5	21	1
460	2020-01-16 17:57:47.044482+03	admin	33aaf39b-31e6-44e4-8cce-ddc42b92bd5d	2	25	9	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 29, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 4, "_connected_circuittermination": null}	5	21	1
461	2020-01-16 17:57:47.050436+03	admin	33aaf39b-31e6-44e4-8cce-ddc42b92bd5d	2	4	4	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 29, "device": 4, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 25, "_connected_circuittermination": null}	5	21	1
462	2020-01-16 17:57:47.052375+03	admin	33aaf39b-31e6-44e4-8cce-ddc42b92bd5d	1	29	\N	#29	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:57:46.991Z", "termination_a_id": 25, "termination_b_id": 4, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 9, "_termination_b_device": 4}	43	\N	1
463	2020-01-16 17:58:09.054965+03	admin	2f42a1ed-f995-4cb0-b684-e67dcddf26b9	2	25	9	Ethernet8	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 29, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 4, "_connected_circuittermination": null}	5	21	1
464	2020-01-16 17:58:09.060938+03	admin	2f42a1ed-f995-4cb0-b684-e67dcddf26b9	2	26	9	Ethernet9	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 28, "device": 9, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 5, "_connected_circuittermination": null}	5	21	1
465	2020-01-16 17:58:46.385222+03	admin	88fdd74e-8c53-49be-8f81-e9ac8fbf64bf	2	36	10	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 30, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 7, "_connected_circuittermination": null}	5	21	1
466	2020-01-16 17:58:46.393558+03	admin	88fdd74e-8c53-49be-8f81-e9ac8fbf64bf	2	7	7	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 30, "device": 7, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 36, "_connected_circuittermination": null}	5	21	1
467	2020-01-16 17:58:46.39956+03	admin	88fdd74e-8c53-49be-8f81-e9ac8fbf64bf	2	36	10	Ethernet9	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 30, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 7, "_connected_circuittermination": null}	5	21	1
468	2020-01-16 17:58:46.40532+03	admin	88fdd74e-8c53-49be-8f81-e9ac8fbf64bf	2	7	7	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 30, "device": 7, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 36, "_connected_circuittermination": null}	5	21	1
469	2020-01-16 17:58:46.407058+03	admin	88fdd74e-8c53-49be-8f81-e9ac8fbf64bf	1	30	\N	#30	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:58:46.346Z", "termination_a_id": 36, "termination_b_id": 7, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 7}	43	\N	1
470	2020-01-16 17:59:12.259368+03	admin	15d0f3c4-3ba1-4949-88ee-94e1ca0fc1eb	2	35	10	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 31, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 6, "_connected_circuittermination": null}	5	21	1
471	2020-01-16 17:59:12.267278+03	admin	15d0f3c4-3ba1-4949-88ee-94e1ca0fc1eb	2	6	6	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 31, "device": 6, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 35, "_connected_circuittermination": null}	5	21	1
472	2020-01-16 17:59:12.273029+03	admin	15d0f3c4-3ba1-4949-88ee-94e1ca0fc1eb	2	35	10	Ethernet8	{"lag": null, "mtu": null, "mode": null, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 31, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 6, "_connected_circuittermination": null}	5	21	1
473	2020-01-16 17:59:12.279067+03	admin	15d0f3c4-3ba1-4949-88ee-94e1ca0fc1eb	2	6	6	eth0	{"lag": null, "mtu": null, "mode": null, "name": "eth0", "tags": [], "type": 1200, "cable": 31, "device": 6, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": null, "virtual_machine": null, "connection_status": true, "_connected_interface": 35, "_connected_circuittermination": null}	5	21	1
474	2020-01-16 17:59:12.281112+03	admin	15d0f3c4-3ba1-4949-88ee-94e1ca0fc1eb	1	31	\N	#31	{"type": null, "color": "", "label": "", "length": null, "status": true, "created": "2020-01-16", "_abs_length": null, "length_unit": null, "last_updated": "2020-01-16T14:59:12.219Z", "termination_a_id": 35, "termination_b_id": 6, "termination_a_type": 5, "termination_b_type": 5, "_termination_a_device": 10, "_termination_b_device": 6}	43	\N	1
475	2020-01-16 17:59:28.519079+03	admin	fe5ec0fc-5144-466b-be16-5183c39eac0a	2	35	10	Ethernet8	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet8", "tags": [], "type": 1200, "cable": 31, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 6, "_connected_circuittermination": null}	5	21	1
476	2020-01-16 17:59:28.526005+03	admin	fe5ec0fc-5144-466b-be16-5183c39eac0a	2	36	10	Ethernet9	{"lag": null, "mtu": null, "mode": 100, "name": "Ethernet9", "tags": [], "type": 1200, "cable": 30, "device": 10, "enabled": true, "mgmt_only": false, "description": "", "mac_address": null, "tagged_vlans": [], "untagged_vlan": 1, "virtual_machine": null, "connection_status": true, "_connected_interface": 7, "_connected_circuittermination": null}	5	21	1
\.


--
-- Data for Name: extras_reportresult; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_reportresult (id, report, created, failed, data, user_id) FROM stdin;
\.


--
-- Data for Name: extras_tag; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_tag (id, name, slug, color, comments, created, last_updated) FROM stdin;
\.


--
-- Data for Name: extras_taggeditem; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: extras_topologymap; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_topologymap (id, name, slug, device_patterns, description, site_id, type) FROM stdin;
\.


--
-- Data for Name: extras_webhook; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_webhook (id, name, type_create, type_update, type_delete, payload_url, http_content_type, secret, enabled, ssl_verification, ca_file_path, additional_headers) FROM stdin;
\.


--
-- Data for Name: extras_webhook_obj_type; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.extras_webhook_obj_type (id, webhook_id, contenttype_id) FROM stdin;
\.


--
-- Data for Name: ipam_aggregate; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_aggregate (id, created, last_updated, family, prefix, date_added, description, rir_id) FROM stdin;
\.


--
-- Data for Name: ipam_ipaddress; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_ipaddress (id, created, last_updated, family, address, description, interface_id, nat_inside_id, vrf_id, tenant_id, status, role, dns_name) FROM stdin;
1	2020-01-16	2020-01-16 10:21:07.539596+03	4	172.16.0.40/29		124	\N	\N	\N	1	\N	
2	2020-01-16	2020-01-16 10:21:49.791485+03	4	172.16.0.41/29		126	\N	\N	\N	1	\N	
3	2020-01-16	2020-01-16 10:24:29.720378+03	4	172.16.2.80/28		118	\N	\N	\N	1	\N	
4	2020-01-16	2020-01-16 10:25:00.131571+03	4	172.16.2.81/28		119	\N	\N	\N	1	\N	
5	2020-01-16	2020-01-16 10:25:25.148816+03	4	172.16.2.82/28		120	\N	\N	\N	1	\N	
6	2020-01-16	2020-01-16 10:25:48.899776+03	4	172.16.2.83/28		121	\N	\N	\N	1	\N	
7	2020-01-16	2020-01-16 10:27:44.58438+03	4	172.16.10.128/25		110	\N	\N	\N	1	\N	
8	2020-01-16	2020-01-16 10:28:06.411324+03	4	172.16.10.129/25		112	\N	\N	\N	1	\N	
9	2020-01-16	2020-01-16 10:28:40.690876+03	4	172.16.10.130/25		114	\N	\N	\N	1	\N	
10	2020-01-16	2020-01-16 10:29:03.594233+03	4	172.16.10.131/25		116	\N	\N	\N	1	\N	
11	2020-01-16	2020-01-16 10:38:46.405179+03	4	10.0.160.1/26		111	\N	\N	\N	1	\N	
12	2020-01-16	2020-01-16 10:39:04.683755+03	4	10.0.160.65/26		113	\N	\N	\N	1	\N	
14	2020-01-16	2020-01-16 10:39:46.235009+03	4	10.0.160.129/26		115	\N	\N	\N	1	\N	
13	2020-01-16	2020-01-16 10:40:06.909922+03	4	10.0.160.193/26		117	\N	\N	\N	1	\N	
15	2020-01-16	2020-01-16 17:28:57.083333+03	4	169.254.0.0/31		8	\N	\N	\N	1	\N	
16	2020-01-16	2020-01-16 17:29:19.952004+03	4	169.254.0.1/31		48	\N	\N	\N	1	\N	
17	2020-01-16	2020-01-16 17:29:31.612719+03	4	169.254.1.0/31		9	\N	\N	\N	1	\N	
18	2020-01-16	2020-01-16 17:29:50.259197+03	4	169.254.1.1/31		58	\N	\N	\N	1	\N	
19	2020-01-16	2020-01-16 17:30:00.226028+03	4	169.254.2.0/31		10	\N	\N	\N	1	\N	
20	2020-01-16	2020-01-16 17:30:20.159344+03	4	169.254.2.1/31		68	\N	\N	\N	1	\N	
21	2020-01-16	2020-01-16 17:30:32.557628+03	4	169.254.3.0/31		11	\N	\N	\N	1	\N	
22	2020-01-16	2020-01-16 17:30:47.35619+03	4	169.254.3.1/31		78	\N	\N	\N	1	\N	
23	2020-01-16	2020-01-16 17:31:10.330785+03	4	169.254.0.2/31		18	\N	\N	\N	1	\N	
24	2020-01-16	2020-01-16 17:31:24.026391+03	4	169.254.0.3/31		49	\N	\N	\N	1	\N	
25	2020-01-16	2020-01-16 17:31:33.644479+03	4	169.254.1.2/31		19	\N	\N	\N	1	\N	
26	2020-01-16	2020-01-16 17:31:47.356827+03	4	169.254.1.3/31		59	\N	\N	\N	1	\N	
27	2020-01-16	2020-01-16 17:31:59.098644+03	4	169.254.2.2/31		20	\N	\N	\N	1	\N	
28	2020-01-16	2020-01-16 17:32:11.802198+03	4	169.254.2.3/31		69	\N	\N	\N	1	\N	
29	2020-01-16	2020-01-16 17:32:21.117302+03	4	169.254.3.2/31		21	\N	\N	\N	1	\N	
30	2020-01-16	2020-01-16 17:32:31.133495+03	4	169.254.3.3/31		79	\N	\N	\N	1	\N	
31	2020-01-16	2020-01-16 17:32:59.50368+03	4	169.254.0.10/31		28	\N	\N	\N	1	\N	
32	2020-01-16	2020-01-16 17:33:14.184607+03	4	169.254.0.11/31		50	\N	\N	\N	1	\N	
33	2020-01-16	2020-01-16 17:33:25.584697+03	4	169.254.1.10/31		29	\N	\N	\N	1	\N	
34	2020-01-16	2020-01-16 17:33:33.730692+03	4	169.254.1.11/31		60	\N	\N	\N	1	\N	
35	2020-01-16	2020-01-16 17:33:47.228678+03	4	169.254.2.10/31		30	\N	\N	\N	1	\N	
36	2020-01-16	2020-01-16 17:33:55.736304+03	4	169.254.2.11/31		70	\N	\N	\N	1	\N	
37	2020-01-16	2020-01-16 17:34:07.633572+03	4	169.254.3.10/31		31	\N	\N	\N	1	\N	
38	2020-01-16	2020-01-16 17:34:16.444624+03	4	169.254.3.11/31		80	\N	\N	\N	1	\N	
39	2020-01-16	2020-01-16 17:34:33.176992+03	4	169.254.0.12/31		38	\N	\N	\N	1	\N	
40	2020-01-16	2020-01-16 17:34:45.464186+03	4	169.254.0.13/31		51	\N	\N	\N	1	\N	
41	2020-01-16	2020-01-16 17:34:53.052311+03	4	169.254.1.12/31		39	\N	\N	\N	1	\N	
42	2020-01-16	2020-01-16 17:35:10.273306+03	4	169.254.1.13/31		61	\N	\N	\N	1	\N	
43	2020-01-16	2020-01-16 17:35:30.097325+03	4	169.254.2.12/31		40	\N	\N	\N	1	\N	
44	2020-01-16	2020-01-16 17:35:47.439477+03	4	169.254.2.13/31		71	\N	\N	\N	1	\N	
45	2020-01-16	2020-01-16 17:35:57.41793+03	4	169.254.3.12/31		41	\N	\N	\N	1	\N	
46	2020-01-16	2020-01-16 17:36:20.360131+03	4	169.254.3.13/31		81	\N	\N	\N	1	\N	
50	2020-01-16	2020-01-16 17:39:24.176905+03	4	169.254.103.2/31		102	\N	\N	\N	1	\N	
49	2020-01-16	2020-01-16 17:39:38.601246+03	4	169.254.103.3/31		85	\N	\N	\N	1	\N	
47	2020-01-16	2020-01-16 17:39:47.574214+03	4	169.254.103.1/31		86	\N	\N	\N	1	\N	
51	2020-01-16	2020-01-16 17:40:13.680407+03	4	169.254.100.1/31		56	\N	\N	\N	1	\N	
48	2020-01-16	2020-01-16 17:40:55.194535+03	4	169.254.103.0/31		91	\N	\N	\N	1	\N	
52	2020-01-16	2020-01-16 17:41:03.731745+03	4	169.254.100.0/31		88	\N	\N	\N	1	\N	
53	2020-01-16	2020-01-16 17:41:30.25236+03	4	169.254.100.3/31		55	\N	\N	\N	1	\N	
54	2020-01-16	2020-01-16 17:41:47.431834+03	4	169.254.100.2/31		99	\N	\N	\N	1	\N	
55	2020-01-16	2020-01-16 17:42:25.728273+03	4	169.254.101.1/31		66	\N	\N	\N	1	\N	
56	2020-01-16	2020-01-16 17:42:35.112547+03	4	169.254.101.0/31		89	\N	\N	\N	1	\N	
57	2020-01-16	2020-01-16 17:47:26.931773+03	4	169.254.101.3/31		65	\N	\N	\N	1	\N	
58	2020-01-16	2020-01-16 17:48:02.864034+03	4	169.254.101.2/31		100	\N	\N	\N	1	\N	
59	2020-01-16	2020-01-16 17:48:46.283672+03	4	169.254.102.1/31		76	\N	\N	\N	1	\N	
60	2020-01-16	2020-01-16 17:49:01.0395+03	4	169.254.102.0/31		90	\N	\N	\N	1	\N	
61	2020-01-16	2020-01-16 17:49:16.869494+03	4	169.254.102.3/31		75	\N	\N	\N	1	\N	
62	2020-01-16	2020-01-16 17:49:25.327563+03	4	169.254.102.2/31		101	\N	\N	\N	1	\N	
\.


--
-- Data for Name: ipam_prefix; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_prefix (id, created, last_updated, family, prefix, status, description, role_id, site_id, vlan_id, vrf_id, tenant_id, is_pool) FROM stdin;
33	2020-01-14	2020-01-14 22:49:35.338684+03	4	10.0.0.0/8	1	Underlay-адреса для подключения серверов	3	\N	\N	\N	\N	f
2	2020-01-14	2020-01-14 22:22:43.50515+03	4	172.16.0.0/23	1	Для Edge-устройств	1	\N	\N	\N	\N	t
7	2020-01-14	2020-01-14 22:24:46.876009+03	4	172.16.0.8/29	1	Для Edge-устройств в ДЦ kzn	1	2	\N	\N	\N	t
6	2020-01-14	2020-01-14 22:25:16.950887+03	4	172.16.0.0/29	1	Для Edge-устройств в ДЦ msk	1	1	\N	\N	\N	t
9	2020-01-14	2020-01-14 22:26:39.253869+03	4	172.16.0.32/29	1	Для Edge-устройств в ДЦ bcn	1	5	\N	\N	\N	t
10	2020-01-14	2020-01-14 22:27:02.278318+03	4	172.16.0.40/29	1	Для Edge-устройств в ДЦ mlg	1	6	\N	\N	\N	t
12	2020-01-14	2020-01-14 22:27:44.885012+03	4	172.16.0.64/29	1	Для Edge-устройств в ДЦ sha	1	3	\N	\N	\N	t
13	2020-01-14	2020-01-14 22:28:10.888055+03	4	172.16.0.72/29	1	Для Edge-устройств в ДЦ sia	1	4	\N	\N	\N	t
3	2020-01-14	2020-01-14 22:41:45.724496+03	4	172.16.2.0/23	1	Для Spine-устройств	4	\N	\N	\N	\N	t
4	2020-01-14	2020-01-14 22:41:57.472476+03	4	172.16.8.0/21	1	Для Leaf-устройств	5	\N	\N	\N	\N	t
14	2020-01-14	2020-01-14 22:42:21.285782+03	4	172.16.2.0/26	1	Для Spine-устройств в регионе RU	4	\N	\N	\N	\N	t
17	2020-01-14	2020-01-14 22:42:21.289113+03	4	172.16.2.64/26	1	Для Spine-устройств в регионе SP	4	\N	\N	\N	\N	t
20	2020-01-14	2020-01-14 22:42:21.292165+03	4	172.16.2.128/26	1	Для Spine-устройств в регионе CN	4	\N	\N	\N	\N	t
15	2020-01-14	2020-01-14 22:42:48.033115+03	4	172.16.2.0/28	1	Для Spine-устройств в ДЦ msk	4	1	\N	\N	\N	t
16	2020-01-14	2020-01-14 22:42:48.037672+03	4	172.16.2.16/28	1	Для Spine-устройств в ДЦ kzn	4	2	\N	\N	\N	t
23	2020-01-14	2020-01-14 22:43:48.780465+03	4	172.16.8.0/23	1	Для Leaf-устройств в регионе RU	5	\N	\N	\N	\N	t
26	2020-01-14	2020-01-14 22:43:48.783965+03	4	172.16.10.0/23	1	Для Leaf-устройств в регионе SP	5	\N	\N	\N	\N	t
29	2020-01-14	2020-01-14 22:43:48.787044+03	4	172.16.12.0/23	1	Для Leaf-устройств в регионе CN	5	\N	\N	\N	\N	t
24	2020-01-14	2020-01-14 22:44:06.390769+03	4	172.16.8.0/25	1	Для Leaf-устройств в ДЦ msk	5	1	\N	\N	\N	t
25	2020-01-14	2020-01-14 22:44:06.396294+03	4	172.16.8.128/25	1	Для Leaf-устройств в ДЦ kzn	5	2	\N	\N	\N	t
27	2020-01-14	2020-01-14 22:44:29.993849+03	4	172.16.10.0/25	1	Для Leaf-устройств в ДЦ bcn	5	5	\N	\N	\N	t
28	2020-01-14	2020-01-14 22:44:29.998623+03	4	172.16.10.128/25	1	Для Leaf-устройств в ДЦ mlg	5	6	\N	\N	\N	t
30	2020-01-14	2020-01-14 22:44:53.574484+03	4	172.16.12.0/25	1	Для Leaf-устройств в ДЦ sha	5	3	\N	\N	\N	t
31	2020-01-14	2020-01-14 22:44:53.579113+03	4	172.16.12.128/25	1	Для Leaf-устройств в ДЦ sia	5	4	\N	\N	\N	t
18	2020-01-14	2020-01-14 22:45:22.72842+03	4	172.16.2.64/28	1	Для Spine-устройств в ДЦ bcn	4	5	\N	\N	\N	t
21	2020-01-14	2020-01-14 22:45:54.495977+03	4	172.16.2.128/28	1	Для Spine-устройств в ДЦ sha	4	3	\N	\N	\N	t
22	2020-01-14	2020-01-14 22:45:54.500424+03	4	172.16.2.144/28	1	Для Spine-устройств в ДЦ sia	4	4	\N	\N	\N	t
5	2020-01-14	2020-01-14 22:46:25.641612+03	4	172.16.0.0/27	1	Для Edge-устройств региона RU	1	\N	\N	\N	\N	t
8	2020-01-14	2020-01-14 22:46:33.515838+03	4	172.16.0.32/27	1	Для Edge-устройств региона SP	1	\N	\N	\N	\N	t
11	2020-01-14	2020-01-14 22:46:41.279664+03	4	172.16.0.64/27	1	Для Edge-устройств региона CN	1	\N	\N	\N	\N	t
19	2020-01-14	2020-01-14 22:47:18.863811+03	4	172.16.2.80/28	1	Для Spine-устройств в ДЦ mlg	4	6	\N	\N	\N	t
32	2020-01-14	2020-01-14 22:48:42.959089+03	4	169.254.0.0/16	1	Link Local адреса	2	\N	\N	\N	\N	f
36	2020-01-14	2020-01-14 22:55:51.857593+03	4	10.0.0.0/19	1	Underlay для ДЦ msk	3	1	\N	\N	\N	f
35	2020-01-14	2020-01-14 22:58:19.663918+03	4	10.0.0.0/17	1	Underlay для региона RU	3	\N	\N	\N	\N	f
37	2020-01-14	2020-01-14 22:59:35.275009+03	4	10.0.32.0/19	1	Underlay для ДЦ kzn	3	2	\N	\N	\N	f
38	2020-01-14	2020-01-14 22:59:55.344289+03	4	10.0.128.0/17	1	Underlay для региона SP	3	\N	\N	\N	\N	f
39	2020-01-14	2020-01-14 23:00:19.665896+03	4	10.0.128.0/19	1	Underlay для ДЦ bcn	3	5	\N	\N	\N	f
40	2020-01-14	2020-01-14 23:00:40.604187+03	4	10.0.160.0/19	1	Underlay для ДЦ mlg	3	6	\N	\N	\N	f
41	2020-01-14	2020-01-14 23:01:07.336775+03	4	10.1.0.0/17	1	Underlay для региона CN	3	\N	\N	\N	\N	f
42	2020-01-14	2020-01-14 23:01:28.314234+03	4	10.1.0.0/19	1	Underlay для ДЦ sha	3	3	\N	\N	\N	f
43	2020-01-14	2020-01-14 23:01:47.187066+03	4	10.1.32.0/19	1	Underlay для ДЦ sia	3	4	\N	\N	\N	f
1	2020-01-14	2020-01-14 23:04:07.863718+03	4	172.16.0.0/12	1	Префикс для лупбэков	7	\N	\N	\N	\N	t
34	2020-01-14	2020-01-14 23:04:33.753618+03	4	192.168.0.0/16	1	P2P адреса для Edge-устройств	6	\N	\N	\N	\N	f
44	2020-01-16	2020-01-16 10:32:14.5681+03	4	10.0.160.0/26	1	Underlay для mlg-leaf-0	3	6	\N	\N	\N	f
45	2020-01-16	2020-01-16 10:35:59.700745+03	4	10.0.160.64/26	1	Underlay для mlg-leaf-1	3	6	\N	\N	\N	f
46	2020-01-16	2020-01-16 10:36:40.393924+03	4	10.0.160.128/26	1	Underlay для mlg-leaf-5	3	6	\N	\N	\N	f
47	2020-01-16	2020-01-16 10:37:04.205483+03	4	10.0.160.192/26	1	Underlay для mlg-leaf-6	3	6	\N	\N	\N	f
\.


--
-- Data for Name: ipam_rir; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_rir (id, name, slug, is_private, created, last_updated) FROM stdin;
\.


--
-- Data for Name: ipam_role; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_role (id, name, slug, weight, created, last_updated) FROM stdin;
3	Underlay	underlay	1000	2020-01-14	2020-01-14 22:16:24.123951+03
1	Edge Loopbacks	edge-loopbacks	1000	2020-01-14	2020-01-14 22:41:05.361216+03
4	Spine Loopbacks	spine-loopbacks	1000	2020-01-14	2020-01-14 22:41:14.987351+03
5	Leaf Loopbacks	leaf-loopbacks	1000	2020-01-14	2020-01-14 22:41:21.512097+03
2	P2P Link Local	p2p-link-local	1000	2020-01-14	2020-01-14 22:50:14.199655+03
6	P2P Edge	p2p-edge	1000	2020-01-14	2020-01-14 22:50:24.233919+03
7	Loopbacks	loopbacks	1000	2020-01-14	2020-01-14 23:02:34.058734+03
\.


--
-- Data for Name: ipam_service; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_service (id, created, last_updated, name, protocol, port, description, device_id, virtual_machine_id) FROM stdin;
\.


--
-- Data for Name: ipam_service_ipaddresses; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_service_ipaddresses (id, service_id, ipaddress_id) FROM stdin;
\.


--
-- Data for Name: ipam_vlan; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_vlan (id, created, last_updated, vid, name, status, role_id, site_id, group_id, description, tenant_id) FROM stdin;
1	2020-01-16	2020-01-16 17:55:33.825534+03	127	Underlay	1	\N	\N	\N		\N
\.


--
-- Data for Name: ipam_vlangroup; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_vlangroup (id, name, slug, site_id, created, last_updated) FROM stdin;
\.


--
-- Data for Name: ipam_vrf; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.ipam_vrf (id, created, last_updated, name, rd, description, enforce_unique, tenant_id) FROM stdin;
\.


--
-- Data for Name: secrets_secret; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_secret (id, created, last_updated, name, ciphertext, hash, device_id, role_id) FROM stdin;
\.


--
-- Data for Name: secrets_secretrole; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_secretrole (id, name, slug, created, last_updated) FROM stdin;
\.


--
-- Data for Name: secrets_secretrole_groups; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_secretrole_groups (id, secretrole_id, group_id) FROM stdin;
\.


--
-- Data for Name: secrets_secretrole_users; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_secretrole_users (id, secretrole_id, user_id) FROM stdin;
\.


--
-- Data for Name: secrets_sessionkey; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_sessionkey (id, cipher, hash, created, userkey_id) FROM stdin;
\.


--
-- Data for Name: secrets_userkey; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.secrets_userkey (id, created, last_updated, public_key, master_key_cipher, user_id) FROM stdin;
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Data for Name: tenancy_tenant; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.tenancy_tenant (id, created, last_updated, name, slug, description, comments, group_id) FROM stdin;
\.


--
-- Data for Name: tenancy_tenantgroup; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.tenancy_tenantgroup (id, name, slug, created, last_updated) FROM stdin;
\.


--
-- Data for Name: users_token; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.users_token (id, created, expires, key, write_enabled, description, user_id) FROM stdin;
\.


--
-- Data for Name: virtualization_cluster; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.virtualization_cluster (id, created, last_updated, name, comments, group_id, type_id, site_id) FROM stdin;
\.


--
-- Data for Name: virtualization_clustergroup; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.virtualization_clustergroup (id, name, slug, created, last_updated) FROM stdin;
\.


--
-- Data for Name: virtualization_clustertype; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.virtualization_clustertype (id, name, slug, created, last_updated) FROM stdin;
\.


--
-- Data for Name: virtualization_virtualmachine; Type: TABLE DATA; Schema: public; Owner: netbox
--

COPY public.virtualization_virtualmachine (id, created, last_updated, name, vcpus, memory, disk, comments, cluster_id, platform_id, primary_ip4_id, primary_ip6_id, tenant_id, status, role_id, local_context_data) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 320, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: circuits_circuit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.circuits_circuit_id_seq', 1, false);


--
-- Name: circuits_circuittermination_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.circuits_circuittermination_id_seq', 1, false);


--
-- Name: circuits_circuittype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.circuits_circuittype_id_seq', 1, false);


--
-- Name: circuits_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.circuits_provider_id_seq', 1, false);


--
-- Name: dcim_cable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_cable_id_seq', 31, true);


--
-- Name: dcim_consoleport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_consoleport_id_seq', 1, false);


--
-- Name: dcim_consoleporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_consoleporttemplate_id_seq', 1, false);


--
-- Name: dcim_consoleserverport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_consoleserverport_id_seq', 1, false);


--
-- Name: dcim_consoleserverporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_consoleserverporttemplate_id_seq', 1, false);


--
-- Name: dcim_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_device_id_seq', 17, true);


--
-- Name: dcim_devicebay_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_devicebay_id_seq', 1, false);


--
-- Name: dcim_devicebaytemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_devicebaytemplate_id_seq', 1, false);


--
-- Name: dcim_devicerole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_devicerole_id_seq', 5, true);


--
-- Name: dcim_devicetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_devicetype_id_seq', 4, true);


--
-- Name: dcim_frontport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_frontport_id_seq', 1, false);


--
-- Name: dcim_frontporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_frontporttemplate_id_seq', 1, false);


--
-- Name: dcim_interface_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_interface_id_seq', 126, true);


--
-- Name: dcim_interface_tagged_vlans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_interface_tagged_vlans_id_seq', 1, false);


--
-- Name: dcim_interfacetemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_interfacetemplate_id_seq', 38, true);


--
-- Name: dcim_manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_manufacturer_id_seq', 4, true);


--
-- Name: dcim_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_module_id_seq', 1, false);


--
-- Name: dcim_platform_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_platform_id_seq', 1, false);


--
-- Name: dcim_powerfeed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_powerfeed_id_seq', 1, false);


--
-- Name: dcim_poweroutlet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_poweroutlet_id_seq', 1, false);


--
-- Name: dcim_poweroutlettemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_poweroutlettemplate_id_seq', 1, false);


--
-- Name: dcim_powerpanel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_powerpanel_id_seq', 1, false);


--
-- Name: dcim_powerport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_powerport_id_seq', 1, false);


--
-- Name: dcim_powerporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_powerporttemplate_id_seq', 1, false);


--
-- Name: dcim_rack_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rack_id_seq', 8, true);


--
-- Name: dcim_rackgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rackgroup_id_seq', 12, true);


--
-- Name: dcim_rackreservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rackreservation_id_seq', 1, false);


--
-- Name: dcim_rackrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rackrole_id_seq', 2, true);


--
-- Name: dcim_rearport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rearport_id_seq', 1, false);


--
-- Name: dcim_rearporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_rearporttemplate_id_seq', 1, false);


--
-- Name: dcim_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_region_id_seq', 3, true);


--
-- Name: dcim_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_site_id_seq', 6, true);


--
-- Name: dcim_virtualchassis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.dcim_virtualchassis_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 80, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 199, true);


--
-- Name: extras_configcontext_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_id_seq', 1, false);


--
-- Name: extras_configcontext_platforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_platforms_id_seq', 1, false);


--
-- Name: extras_configcontext_regions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_regions_id_seq', 1, false);


--
-- Name: extras_configcontext_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_roles_id_seq', 1, false);


--
-- Name: extras_configcontext_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_sites_id_seq', 1, false);


--
-- Name: extras_configcontext_tenant_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_tenant_groups_id_seq', 1, false);


--
-- Name: extras_configcontext_tenants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_configcontext_tenants_id_seq', 1, false);


--
-- Name: extras_customfield_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_customfield_id_seq', 1, false);


--
-- Name: extras_customfield_obj_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_customfield_obj_type_id_seq', 1, false);


--
-- Name: extras_customfieldchoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_customfieldchoice_id_seq', 1, false);


--
-- Name: extras_customfieldvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_customfieldvalue_id_seq', 1, false);


--
-- Name: extras_customlink_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_customlink_id_seq', 1, false);


--
-- Name: extras_exporttemplate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_exporttemplate_id_seq', 1, false);


--
-- Name: extras_graph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_graph_id_seq', 1, false);


--
-- Name: extras_imageattachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_imageattachment_id_seq', 1, false);


--
-- Name: extras_objectchange_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_objectchange_id_seq', 476, true);


--
-- Name: extras_reportresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_reportresult_id_seq', 1, false);


--
-- Name: extras_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_tag_id_seq', 1, false);


--
-- Name: extras_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_taggeditem_id_seq', 1, false);


--
-- Name: extras_topologymap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_topologymap_id_seq', 1, false);


--
-- Name: extras_webhook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_webhook_id_seq', 1, false);


--
-- Name: extras_webhook_obj_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.extras_webhook_obj_type_id_seq', 1, false);


--
-- Name: ipam_aggregate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_aggregate_id_seq', 1, false);


--
-- Name: ipam_ipaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_ipaddress_id_seq', 62, true);


--
-- Name: ipam_prefix_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_prefix_id_seq', 47, true);


--
-- Name: ipam_rir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_rir_id_seq', 1, false);


--
-- Name: ipam_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_role_id_seq', 7, true);


--
-- Name: ipam_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_service_id_seq', 1, false);


--
-- Name: ipam_service_ipaddresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_service_ipaddresses_id_seq', 1, false);


--
-- Name: ipam_vlan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_vlan_id_seq', 1, true);


--
-- Name: ipam_vlangroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_vlangroup_id_seq', 1, false);


--
-- Name: ipam_vrf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.ipam_vrf_id_seq', 1, false);


--
-- Name: secrets_secret_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_secret_id_seq', 1, false);


--
-- Name: secrets_secretrole_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_secretrole_groups_id_seq', 1, false);


--
-- Name: secrets_secretrole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_secretrole_id_seq', 1, false);


--
-- Name: secrets_secretrole_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_secretrole_users_id_seq', 1, false);


--
-- Name: secrets_sessionkey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_sessionkey_id_seq', 1, false);


--
-- Name: secrets_userkey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.secrets_userkey_id_seq', 1, false);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 1, false);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 1, false);


--
-- Name: tenancy_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.tenancy_tenant_id_seq', 1, false);


--
-- Name: tenancy_tenantgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.tenancy_tenantgroup_id_seq', 1, false);


--
-- Name: users_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.users_token_id_seq', 1, false);


--
-- Name: virtualization_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.virtualization_cluster_id_seq', 1, false);


--
-- Name: virtualization_clustergroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.virtualization_clustergroup_id_seq', 1, false);


--
-- Name: virtualization_clustertype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.virtualization_clustertype_id_seq', 1, false);


--
-- Name: virtualization_virtualmachine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: netbox
--

SELECT pg_catalog.setval('public.virtualization_virtualmachine_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: circuits_circuit circuits_circuit_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_pkey PRIMARY KEY (id);


--
-- Name: circuits_circuit circuits_circuit_provider_id_cid_b6f29862_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_provider_id_cid_b6f29862_uniq UNIQUE (provider_id, cid);


--
-- Name: circuits_circuittermination circuits_circuittermination_circuit_id_term_side_b13efd0e_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_circuit_id_term_side_b13efd0e_uniq UNIQUE (circuit_id, term_side);


--
-- Name: circuits_circuittermination circuits_circuittermination_connected_endpoint_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_connected_endpoint_id_key UNIQUE (connected_endpoint_id);


--
-- Name: circuits_circuittermination circuits_circuittermination_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_pkey PRIMARY KEY (id);


--
-- Name: circuits_circuittype circuits_circuittype_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittype
    ADD CONSTRAINT circuits_circuittype_name_key UNIQUE (name);


--
-- Name: circuits_circuittype circuits_circuittype_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittype
    ADD CONSTRAINT circuits_circuittype_pkey PRIMARY KEY (id);


--
-- Name: circuits_circuittype circuits_circuittype_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittype
    ADD CONSTRAINT circuits_circuittype_slug_key UNIQUE (slug);


--
-- Name: circuits_provider circuits_provider_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_provider
    ADD CONSTRAINT circuits_provider_name_key UNIQUE (name);


--
-- Name: circuits_provider circuits_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_provider
    ADD CONSTRAINT circuits_provider_pkey PRIMARY KEY (id);


--
-- Name: circuits_provider circuits_provider_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_provider
    ADD CONSTRAINT circuits_provider_slug_key UNIQUE (slug);


--
-- Name: dcim_cable dcim_cable_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_pkey PRIMARY KEY (id);


--
-- Name: dcim_cable dcim_cable_termination_a_type_id_termination_a_id_e9d24bad_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_a_type_id_termination_a_id_e9d24bad_uniq UNIQUE (termination_a_type_id, termination_a_id);


--
-- Name: dcim_cable dcim_cable_termination_b_type_id_termination_b_id_057fc21f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_b_type_id_termination_b_id_057fc21f_uniq UNIQUE (termination_b_type_id, termination_b_id);


--
-- Name: dcim_consoleport dcim_consoleport_cs_port_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_cs_port_id_key UNIQUE (connected_endpoint_id);


--
-- Name: dcim_consoleport dcim_consoleport_device_id_name_293786b6_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_device_id_name_293786b6_uniq UNIQUE (device_id, name);


--
-- Name: dcim_consoleport dcim_consoleport_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemplate_device_type_id_name_8208f9ca_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemplate_device_type_id_name_8208f9ca_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleserverport dcim_consoleserverport_device_id_name_fb1c5999_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_device_id_name_fb1c5999_uniq UNIQUE (device_id, name);


--
-- Name: dcim_consoleserverport dcim_consoleserverport_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_pkey PRIMARY KEY (id);


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverportte_device_type_id_name_a05c974d_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverportte_device_type_id_name_a05c974d_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_device dcim_device_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_device dcim_device_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_name_key UNIQUE (name);


--
-- Name: dcim_device dcim_device_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_pkey PRIMARY KEY (id);


--
-- Name: dcim_device dcim_device_primary_ip4_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip4_id_key UNIQUE (primary_ip4_id);


--
-- Name: dcim_device dcim_device_primary_ip6_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip6_id_key UNIQUE (primary_ip6_id);


--
-- Name: dcim_device dcim_device_rack_id_position_face_43208a79_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_rack_id_position_face_43208a79_uniq UNIQUE (rack_id, "position", face);


--
-- Name: dcim_device dcim_device_virtual_chassis_id_vc_position_efea7133_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_virtual_chassis_id_vc_position_efea7133_uniq UNIQUE (virtual_chassis_id, vc_position);


--
-- Name: dcim_devicebay dcim_devicebay_device_id_name_2475a67b_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_device_id_name_2475a67b_uniq UNIQUE (device_id, name);


--
-- Name: dcim_devicebay dcim_devicebay_installed_device_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_installed_device_id_key UNIQUE (installed_device_id);


--
-- Name: dcim_devicebay dcim_devicebay_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_pkey PRIMARY KEY (id);


--
-- Name: dcim_devicebaytemplate dcim_devicebaytemplate_device_type_id_name_8f4899fe_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytemplate_device_type_id_name_8f4899fe_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_devicebaytemplate dcim_devicebaytemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_devicerole dcim_devicerole_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicerole
    ADD CONSTRAINT dcim_devicerole_name_key UNIQUE (name);


--
-- Name: dcim_devicerole dcim_devicerole_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicerole
    ADD CONSTRAINT dcim_devicerole_pkey PRIMARY KEY (id);


--
-- Name: dcim_devicerole dcim_devicerole_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicerole
    ADD CONSTRAINT dcim_devicerole_slug_key UNIQUE (slug);


--
-- Name: dcim_devicetype dcim_devicetype_manufacturer_id_model_17948c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_manufacturer_id_model_17948c0c_uniq UNIQUE (manufacturer_id, model);


--
-- Name: dcim_devicetype dcim_devicetype_manufacturer_id_slug_a0b931cb_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_manufacturer_id_slug_a0b931cb_uniq UNIQUE (manufacturer_id, slug);


--
-- Name: dcim_devicetype dcim_devicetype_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontport dcim_frontport_device_id_name_235b7af2_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_device_id_name_235b7af2_uniq UNIQUE (device_id, name);


--
-- Name: dcim_frontport dcim_frontport_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontport dcim_frontport_rear_port_id_rear_port_position_8b0bf7ca_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_rear_port_id_rear_port_position_8b0bf7ca_uniq UNIQUE (rear_port_id, rear_port_position);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_device_type_id_name_0a0a0e05_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_device_type_id_name_0a0a0e05_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_frontporttemplate dcim_frontporttemplate_rear_port_id_rear_port_p_401fe927_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttemplate_rear_port_id_rear_port_p_401fe927_uniq UNIQUE (rear_port_id, rear_port_position);


--
-- Name: dcim_interface dcim_interface__connected_circuittermination_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__connected_circuittermination_id_key UNIQUE (_connected_circuittermination_id);


--
-- Name: dcim_interface dcim_interface__connected_interface_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__connected_interface_id_key UNIQUE (_connected_interface_id);


--
-- Name: dcim_interface dcim_interface_device_id_name_bffc4ec4_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_device_id_name_bffc4ec4_uniq UNIQUE (device_id, name);


--
-- Name: dcim_interface dcim_interface_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_pkey PRIMARY KEY (id);


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_interface_id_vlan_id_0d55c576_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_interface_id_vlan_id_0d55c576_uniq UNIQUE (interface_id, vlan_id);


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_pkey PRIMARY KEY (id);


--
-- Name: dcim_interfacetemplate dcim_interfacetemplate_device_type_id_name_3a847237_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetemplate_device_type_id_name_3a847237_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_interfacetemplate dcim_interfacetemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_inventoryitem dcim_inventoryitem_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_manufacturer dcim_manufacturer_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_manufacturer
    ADD CONSTRAINT dcim_manufacturer_name_key UNIQUE (name);


--
-- Name: dcim_manufacturer dcim_manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_manufacturer
    ADD CONSTRAINT dcim_manufacturer_pkey PRIMARY KEY (id);


--
-- Name: dcim_manufacturer dcim_manufacturer_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_manufacturer
    ADD CONSTRAINT dcim_manufacturer_slug_key UNIQUE (slug);


--
-- Name: dcim_inventoryitem dcim_module_device_id_parent_id_name_4d8292af_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_module_device_id_parent_id_name_4d8292af_uniq UNIQUE (device_id, parent_id, name);


--
-- Name: dcim_inventoryitem dcim_module_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_module_pkey PRIMARY KEY (id);


--
-- Name: dcim_platform dcim_platform_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_name_key UNIQUE (name);


--
-- Name: dcim_platform dcim_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_pkey PRIMARY KEY (id);


--
-- Name: dcim_platform dcim_platform_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_slug_key UNIQUE (slug);


--
-- Name: dcim_powerfeed dcim_powerfeed_connected_endpoint_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_connected_endpoint_id_key UNIQUE (connected_endpoint_id);


--
-- Name: dcim_powerfeed dcim_powerfeed_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerfeed dcim_powerfeed_power_panel_id_name_0fbaae9f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_power_panel_id_name_0fbaae9f_uniq UNIQUE (power_panel_id, name);


--
-- Name: dcim_poweroutlet dcim_poweroutlet_device_id_name_981b00c1_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_device_id_name_981b00c1_uniq UNIQUE (device_id, name);


--
-- Name: dcim_poweroutlet dcim_poweroutlet_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_pkey PRIMARY KEY (id);


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemplate_device_type_id_name_eafbb07d_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemplate_device_type_id_name_eafbb07d_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerpanel dcim_powerpanel_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerpanel dcim_powerpanel_site_id_name_804df4c0_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_site_id_name_804df4c0_uniq UNIQUE (site_id, name);


--
-- Name: dcim_powerport dcim_powerport__connected_powerfeed_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport__connected_powerfeed_id_key UNIQUE (_connected_powerfeed_id);


--
-- Name: dcim_powerport dcim_powerport_device_id_name_948af82c_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_device_id_name_948af82c_uniq UNIQUE (device_id, name);


--
-- Name: dcim_powerport dcim_powerport_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_pkey PRIMARY KEY (id);


--
-- Name: dcim_powerport dcim_powerport_power_outlet_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_power_outlet_id_key UNIQUE (_connected_poweroutlet_id);


--
-- Name: dcim_powerporttemplate dcim_powerporttemplate_device_type_id_name_b4e9689f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttemplate_device_type_id_name_b4e9689f_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_powerporttemplate dcim_powerporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_rack dcim_rack_asset_tag_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_asset_tag_key UNIQUE (asset_tag);


--
-- Name: dcim_rack dcim_rack_group_id_facility_id_f16a53ae_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_group_id_facility_id_f16a53ae_uniq UNIQUE (group_id, facility_id);


--
-- Name: dcim_rack dcim_rack_group_id_name_846f3826_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_group_id_name_846f3826_uniq UNIQUE (group_id, name);


--
-- Name: dcim_rack dcim_rack_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackgroup dcim_rackgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackgroup dcim_rackgroup_site_id_name_c9bd921f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_site_id_name_c9bd921f_uniq UNIQUE (site_id, name);


--
-- Name: dcim_rackgroup dcim_rackgroup_site_id_slug_7fbfd118_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_site_id_slug_7fbfd118_uniq UNIQUE (site_id, slug);


--
-- Name: dcim_rackreservation dcim_rackreservation_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackrole dcim_rackrole_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackrole
    ADD CONSTRAINT dcim_rackrole_name_key UNIQUE (name);


--
-- Name: dcim_rackrole dcim_rackrole_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackrole
    ADD CONSTRAINT dcim_rackrole_pkey PRIMARY KEY (id);


--
-- Name: dcim_rackrole dcim_rackrole_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackrole
    ADD CONSTRAINT dcim_rackrole_slug_key UNIQUE (slug);


--
-- Name: dcim_rearport dcim_rearport_device_id_name_4b14dde6_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_device_id_name_4b14dde6_uniq UNIQUE (device_id, name);


--
-- Name: dcim_rearport dcim_rearport_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_pkey PRIMARY KEY (id);


--
-- Name: dcim_rearporttemplate dcim_rearporttemplate_device_type_id_name_9bdddb29_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplate_device_type_id_name_9bdddb29_uniq UNIQUE (device_type_id, name);


--
-- Name: dcim_rearporttemplate dcim_rearporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplate_pkey PRIMARY KEY (id);


--
-- Name: dcim_region dcim_region_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_region
    ADD CONSTRAINT dcim_region_name_key UNIQUE (name);


--
-- Name: dcim_region dcim_region_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_region
    ADD CONSTRAINT dcim_region_pkey PRIMARY KEY (id);


--
-- Name: dcim_region dcim_region_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_region
    ADD CONSTRAINT dcim_region_slug_key UNIQUE (slug);


--
-- Name: dcim_site dcim_site_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site
    ADD CONSTRAINT dcim_site_name_key UNIQUE (name);


--
-- Name: dcim_site dcim_site_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site
    ADD CONSTRAINT dcim_site_pkey PRIMARY KEY (id);


--
-- Name: dcim_site dcim_site_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site
    ADD CONSTRAINT dcim_site_slug_key UNIQUE (slug);


--
-- Name: dcim_virtualchassis dcim_virtualchassis_master_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_master_id_key UNIQUE (master_id);


--
-- Name: dcim_virtualchassis dcim_virtualchassis_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: extras_configcontext extras_configcontext_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_name_key UNIQUE (name);


--
-- Name: extras_configcontext extras_configcontext_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext
    ADD CONSTRAINT extras_configcontext_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_platforms extras_configcontext_pla_configcontext_id_platfor_3c67c104_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_pla_configcontext_id_platfor_3c67c104_uniq UNIQUE (configcontext_id, platform_id);


--
-- Name: extras_configcontext_platforms extras_configcontext_platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_platforms_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_regions extras_configcontext_reg_configcontext_id_region__d4a1d77f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_regions
    ADD CONSTRAINT extras_configcontext_reg_configcontext_id_region__d4a1d77f_uniq UNIQUE (configcontext_id, region_id);


--
-- Name: extras_configcontext_regions extras_configcontext_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_regions
    ADD CONSTRAINT extras_configcontext_regions_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_roles extras_configcontext_rol_configcontext_id_devicer_4d8dbb50_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_rol_configcontext_id_devicer_4d8dbb50_uniq UNIQUE (configcontext_id, devicerole_id);


--
-- Name: extras_configcontext_roles extras_configcontext_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_roles_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_sites extras_configcontext_sit_configcontext_id_site_id_a4fe5f4f_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_sites
    ADD CONSTRAINT extras_configcontext_sit_configcontext_id_site_id_a4fe5f4f_uniq UNIQUE (configcontext_id, site_id);


--
-- Name: extras_configcontext_sites extras_configcontext_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_sites
    ADD CONSTRAINT extras_configcontext_sites_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_tenants extras_configcontext_ten_configcontext_id_tenant__aefb257d_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_ten_configcontext_id_tenant__aefb257d_uniq UNIQUE (configcontext_id, tenant_id);


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_ten_configcontext_id_tenantg_d6afc6f5_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_ten_configcontext_id_tenantg_d6afc6f5_uniq UNIQUE (configcontext_id, tenantgroup_id);


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_tenant_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_tenant_groups_pkey PRIMARY KEY (id);


--
-- Name: extras_configcontext_tenants extras_configcontext_tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_tenants_pkey PRIMARY KEY (id);


--
-- Name: extras_customfield extras_customfield_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield
    ADD CONSTRAINT extras_customfield_name_key UNIQUE (name);


--
-- Name: extras_customfield_obj_type extras_customfield_obj_t_customfield_id_contentty_77878958_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield_obj_type
    ADD CONSTRAINT extras_customfield_obj_t_customfield_id_contentty_77878958_uniq UNIQUE (customfield_id, contenttype_id);


--
-- Name: extras_customfield_obj_type extras_customfield_obj_type_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield_obj_type
    ADD CONSTRAINT extras_customfield_obj_type_pkey PRIMARY KEY (id);


--
-- Name: extras_customfield extras_customfield_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield
    ADD CONSTRAINT extras_customfield_pkey PRIMARY KEY (id);


--
-- Name: extras_customfieldchoice extras_customfieldchoice_field_id_value_f959a108_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldchoice_field_id_value_f959a108_uniq UNIQUE (field_id, value);


--
-- Name: extras_customfieldchoice extras_customfieldchoice_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldchoice_pkey PRIMARY KEY (id);


--
-- Name: extras_customfieldvalue extras_customfieldvalue_field_id_obj_type_id_obj_876f6d9c_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldvalue
    ADD CONSTRAINT extras_customfieldvalue_field_id_obj_type_id_obj_876f6d9c_uniq UNIQUE (field_id, obj_type_id, obj_id);


--
-- Name: extras_customfieldvalue extras_customfieldvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldvalue
    ADD CONSTRAINT extras_customfieldvalue_pkey PRIMARY KEY (id);


--
-- Name: extras_customlink extras_customlink_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_name_key UNIQUE (name);


--
-- Name: extras_customlink extras_customlink_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_pkey PRIMARY KEY (id);


--
-- Name: extras_exporttemplate extras_exporttemplate_content_type_id_name_edca9b9b_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplate_content_type_id_name_edca9b9b_uniq UNIQUE (content_type_id, name);


--
-- Name: extras_exporttemplate extras_exporttemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplate_pkey PRIMARY KEY (id);


--
-- Name: extras_graph extras_graph_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_graph
    ADD CONSTRAINT extras_graph_pkey PRIMARY KEY (id);


--
-- Name: extras_imageattachment extras_imageattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_imageattachment
    ADD CONSTRAINT extras_imageattachment_pkey PRIMARY KEY (id);


--
-- Name: extras_objectchange extras_objectchange_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_pkey PRIMARY KEY (id);


--
-- Name: extras_reportresult extras_reportresult_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_reportresult
    ADD CONSTRAINT extras_reportresult_pkey PRIMARY KEY (id);


--
-- Name: extras_reportresult extras_reportresult_report_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_reportresult
    ADD CONSTRAINT extras_reportresult_report_key UNIQUE (report);


--
-- Name: extras_tag extras_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_tag
    ADD CONSTRAINT extras_tag_name_key UNIQUE (name);


--
-- Name: extras_tag extras_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_tag
    ADD CONSTRAINT extras_tag_pkey PRIMARY KEY (id);


--
-- Name: extras_tag extras_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_tag
    ADD CONSTRAINT extras_tag_slug_key UNIQUE (slug);


--
-- Name: extras_taggeditem extras_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: extras_topologymap extras_topologymap_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_topologymap
    ADD CONSTRAINT extras_topologymap_name_key UNIQUE (name);


--
-- Name: extras_topologymap extras_topologymap_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_topologymap
    ADD CONSTRAINT extras_topologymap_pkey PRIMARY KEY (id);


--
-- Name: extras_topologymap extras_topologymap_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_topologymap
    ADD CONSTRAINT extras_topologymap_slug_key UNIQUE (slug);


--
-- Name: extras_webhook extras_webhook_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook
    ADD CONSTRAINT extras_webhook_name_key UNIQUE (name);


--
-- Name: extras_webhook_obj_type extras_webhook_obj_type_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook_obj_type
    ADD CONSTRAINT extras_webhook_obj_type_pkey PRIMARY KEY (id);


--
-- Name: extras_webhook_obj_type extras_webhook_obj_type_webhook_id_contenttype_id_99b8b9c3_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook_obj_type
    ADD CONSTRAINT extras_webhook_obj_type_webhook_id_contenttype_id_99b8b9c3_uniq UNIQUE (webhook_id, contenttype_id);


--
-- Name: extras_webhook extras_webhook_payload_url_type_create__dd332134_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook
    ADD CONSTRAINT extras_webhook_payload_url_type_create__dd332134_uniq UNIQUE (payload_url, type_create, type_update, type_delete);


--
-- Name: extras_webhook extras_webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook
    ADD CONSTRAINT extras_webhook_pkey PRIMARY KEY (id);


--
-- Name: ipam_aggregate ipam_aggregate_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_aggregate
    ADD CONSTRAINT ipam_aggregate_pkey PRIMARY KEY (id);


--
-- Name: ipam_ipaddress ipam_ipaddress_nat_inside_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_nat_inside_id_key UNIQUE (nat_inside_id);


--
-- Name: ipam_ipaddress ipam_ipaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_pkey PRIMARY KEY (id);


--
-- Name: ipam_prefix ipam_prefix_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_pkey PRIMARY KEY (id);


--
-- Name: ipam_rir ipam_rir_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_rir
    ADD CONSTRAINT ipam_rir_name_key UNIQUE (name);


--
-- Name: ipam_rir ipam_rir_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_rir
    ADD CONSTRAINT ipam_rir_pkey PRIMARY KEY (id);


--
-- Name: ipam_rir ipam_rir_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_rir
    ADD CONSTRAINT ipam_rir_slug_key UNIQUE (slug);


--
-- Name: ipam_role ipam_role_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_role
    ADD CONSTRAINT ipam_role_name_key UNIQUE (name);


--
-- Name: ipam_role ipam_role_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_role
    ADD CONSTRAINT ipam_role_pkey PRIMARY KEY (id);


--
-- Name: ipam_role ipam_role_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_role
    ADD CONSTRAINT ipam_role_slug_key UNIQUE (slug);


--
-- Name: ipam_service_ipaddresses ipam_service_ipaddresses_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service_ipaddresses
    ADD CONSTRAINT ipam_service_ipaddresses_pkey PRIMARY KEY (id);


--
-- Name: ipam_service_ipaddresses ipam_service_ipaddresses_service_id_ipaddress_id_d019a805_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service_ipaddresses
    ADD CONSTRAINT ipam_service_ipaddresses_service_id_ipaddress_id_d019a805_uniq UNIQUE (service_id, ipaddress_id);


--
-- Name: ipam_service ipam_service_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_pkey PRIMARY KEY (id);


--
-- Name: ipam_vlan ipam_vlan_group_id_name_e53919df_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_group_id_name_e53919df_uniq UNIQUE (group_id, name);


--
-- Name: ipam_vlan ipam_vlan_group_id_vid_5ca4cc47_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_group_id_vid_5ca4cc47_uniq UNIQUE (group_id, vid);


--
-- Name: ipam_vlan ipam_vlan_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_pkey PRIMARY KEY (id);


--
-- Name: ipam_vlangroup ipam_vlangroup_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_pkey PRIMARY KEY (id);


--
-- Name: ipam_vlangroup ipam_vlangroup_site_id_name_a38e981b_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_site_id_name_a38e981b_uniq UNIQUE (site_id, name);


--
-- Name: ipam_vlangroup ipam_vlangroup_site_id_slug_6372a304_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_site_id_slug_6372a304_uniq UNIQUE (site_id, slug);


--
-- Name: ipam_vrf ipam_vrf_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_pkey PRIMARY KEY (id);


--
-- Name: ipam_vrf ipam_vrf_rd_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_rd_key UNIQUE (rd);


--
-- Name: secrets_secret secrets_secret_device_id_role_id_name_f8acc218_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secret
    ADD CONSTRAINT secrets_secret_device_id_role_id_name_f8acc218_uniq UNIQUE (device_id, role_id, name);


--
-- Name: secrets_secret secrets_secret_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secret
    ADD CONSTRAINT secrets_secret_pkey PRIMARY KEY (id);


--
-- Name: secrets_secretrole_groups secrets_secretrole_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_groups
    ADD CONSTRAINT secrets_secretrole_groups_pkey PRIMARY KEY (id);


--
-- Name: secrets_secretrole_groups secrets_secretrole_groups_secretrole_id_group_id_1c7f7ee5_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_groups
    ADD CONSTRAINT secrets_secretrole_groups_secretrole_id_group_id_1c7f7ee5_uniq UNIQUE (secretrole_id, group_id);


--
-- Name: secrets_secretrole secrets_secretrole_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole
    ADD CONSTRAINT secrets_secretrole_name_key UNIQUE (name);


--
-- Name: secrets_secretrole secrets_secretrole_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole
    ADD CONSTRAINT secrets_secretrole_pkey PRIMARY KEY (id);


--
-- Name: secrets_secretrole secrets_secretrole_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole
    ADD CONSTRAINT secrets_secretrole_slug_key UNIQUE (slug);


--
-- Name: secrets_secretrole_users secrets_secretrole_users_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_users
    ADD CONSTRAINT secrets_secretrole_users_pkey PRIMARY KEY (id);


--
-- Name: secrets_secretrole_users secrets_secretrole_users_secretrole_id_user_id_41832d38_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_users
    ADD CONSTRAINT secrets_secretrole_users_secretrole_id_user_id_41832d38_uniq UNIQUE (secretrole_id, user_id);


--
-- Name: secrets_sessionkey secrets_sessionkey_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_sessionkey
    ADD CONSTRAINT secrets_sessionkey_pkey PRIMARY KEY (id);


--
-- Name: secrets_sessionkey secrets_sessionkey_userkey_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_sessionkey
    ADD CONSTRAINT secrets_sessionkey_userkey_id_key UNIQUE (userkey_id);


--
-- Name: secrets_userkey secrets_userkey_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_userkey
    ADD CONSTRAINT secrets_userkey_pkey PRIMARY KEY (id);


--
-- Name: secrets_userkey secrets_userkey_user_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_userkey
    ADD CONSTRAINT secrets_userkey_user_id_key UNIQUE (user_id);


--
-- Name: taggit_tag taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq UNIQUE (content_type_id, object_id, tag_id);


--
-- Name: taggit_taggeditem taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: tenancy_tenant tenancy_tenant_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_name_key UNIQUE (name);


--
-- Name: tenancy_tenant tenancy_tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_pkey PRIMARY KEY (id);


--
-- Name: tenancy_tenant tenancy_tenant_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_slug_key UNIQUE (slug);


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_name_key UNIQUE (name);


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_pkey PRIMARY KEY (id);


--
-- Name: tenancy_tenantgroup tenancy_tenantgroup_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenantgroup
    ADD CONSTRAINT tenancy_tenantgroup_slug_key UNIQUE (slug);


--
-- Name: users_token users_token_key_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_key_key UNIQUE (key);


--
-- Name: users_token users_token_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_pkey PRIMARY KEY (id);


--
-- Name: virtualization_cluster virtualization_cluster_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_name_key UNIQUE (name);


--
-- Name: virtualization_cluster virtualization_cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_pkey PRIMARY KEY (id);


--
-- Name: virtualization_clustergroup virtualization_clustergroup_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustergroup
    ADD CONSTRAINT virtualization_clustergroup_name_key UNIQUE (name);


--
-- Name: virtualization_clustergroup virtualization_clustergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustergroup
    ADD CONSTRAINT virtualization_clustergroup_pkey PRIMARY KEY (id);


--
-- Name: virtualization_clustergroup virtualization_clustergroup_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustergroup
    ADD CONSTRAINT virtualization_clustergroup_slug_key UNIQUE (slug);


--
-- Name: virtualization_clustertype virtualization_clustertype_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustertype
    ADD CONSTRAINT virtualization_clustertype_name_key UNIQUE (name);


--
-- Name: virtualization_clustertype virtualization_clustertype_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustertype
    ADD CONSTRAINT virtualization_clustertype_pkey PRIMARY KEY (id);


--
-- Name: virtualization_clustertype virtualization_clustertype_slug_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_clustertype
    ADD CONSTRAINT virtualization_clustertype_slug_key UNIQUE (slug);


--
-- Name: virtualization_virtualmachine virtualization_virtualmachine_name_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualmachine_name_key UNIQUE (name);


--
-- Name: virtualization_virtualmachine virtualization_virtualmachine_pkey; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualmachine_pkey PRIMARY KEY (id);


--
-- Name: virtualization_virtualmachine virtualization_virtualmachine_primary_ip4_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualmachine_primary_ip4_id_key UNIQUE (primary_ip4_id);


--
-- Name: virtualization_virtualmachine virtualization_virtualmachine_primary_ip6_id_key; Type: CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtualmachine_primary_ip6_id_key UNIQUE (primary_ip6_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: circuits_circuit_provider_id_d9195418; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuit_provider_id_d9195418 ON public.circuits_circuit USING btree (provider_id);


--
-- Name: circuits_circuit_tenant_id_812508a5; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuit_tenant_id_812508a5 ON public.circuits_circuit USING btree (tenant_id);


--
-- Name: circuits_circuit_type_id_1b9f485a; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuit_type_id_1b9f485a ON public.circuits_circuit USING btree (type_id);


--
-- Name: circuits_circuittermination_cable_id_35e9f703; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuittermination_cable_id_35e9f703 ON public.circuits_circuittermination USING btree (cable_id);


--
-- Name: circuits_circuittermination_circuit_id_257e87e7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuittermination_circuit_id_257e87e7 ON public.circuits_circuittermination USING btree (circuit_id);


--
-- Name: circuits_circuittermination_site_id_e6fe5652; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuittermination_site_id_e6fe5652 ON public.circuits_circuittermination USING btree (site_id);


--
-- Name: circuits_circuittype_name_8256ea9a_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuittype_name_8256ea9a_like ON public.circuits_circuittype USING btree (name varchar_pattern_ops);


--
-- Name: circuits_circuittype_slug_9b4b3cf9_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_circuittype_slug_9b4b3cf9_like ON public.circuits_circuittype USING btree (slug varchar_pattern_ops);


--
-- Name: circuits_provider_name_8f2514f5_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_provider_name_8f2514f5_like ON public.circuits_provider USING btree (name varchar_pattern_ops);


--
-- Name: circuits_provider_slug_c3c0aa10_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX circuits_provider_slug_c3c0aa10_like ON public.circuits_provider USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_cable__termination_a_device_id_e59cde1c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_cable__termination_a_device_id_e59cde1c ON public.dcim_cable USING btree (_termination_a_device_id);


--
-- Name: dcim_cable__termination_b_device_id_a9073762; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_cable__termination_b_device_id_a9073762 ON public.dcim_cable USING btree (_termination_b_device_id);


--
-- Name: dcim_cable_termination_a_type_id_a614bab8; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_cable_termination_a_type_id_a614bab8 ON public.dcim_cable USING btree (termination_a_type_id);


--
-- Name: dcim_cable_termination_b_type_id_a91595d0; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_cable_termination_b_type_id_a91595d0 ON public.dcim_cable USING btree (termination_b_type_id);


--
-- Name: dcim_consoleport_cable_id_a9ae5465; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleport_cable_id_a9ae5465 ON public.dcim_consoleport USING btree (cable_id);


--
-- Name: dcim_consoleport_device_id_f2d90d3c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleport_device_id_f2d90d3c ON public.dcim_consoleport USING btree (device_id);


--
-- Name: dcim_consoleporttemplate_device_type_id_075d4015; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleporttemplate_device_type_id_075d4015 ON public.dcim_consoleporttemplate USING btree (device_type_id);


--
-- Name: dcim_consoleserverport_cable_id_f2940dfd; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleserverport_cable_id_f2940dfd ON public.dcim_consoleserverport USING btree (cable_id);


--
-- Name: dcim_consoleserverport_device_id_d9866581; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleserverport_device_id_d9866581 ON public.dcim_consoleserverport USING btree (device_id);


--
-- Name: dcim_consoleserverporttemplate_device_type_id_579bdc86; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_consoleserverporttemplate_device_type_id_579bdc86 ON public.dcim_consoleserverporttemplate USING btree (device_type_id);


--
-- Name: dcim_device_asset_tag_8dac1079_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_asset_tag_8dac1079_like ON public.dcim_device USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_device_cluster_id_cf852f78; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_cluster_id_cf852f78 ON public.dcim_device USING btree (cluster_id);


--
-- Name: dcim_device_device_role_id_682e8188; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_device_role_id_682e8188 ON public.dcim_device USING btree (device_role_id);


--
-- Name: dcim_device_device_type_id_d61b4086; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_device_type_id_d61b4086 ON public.dcim_device USING btree (device_type_id);


--
-- Name: dcim_device_name_cfa61dd8_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_name_cfa61dd8_like ON public.dcim_device USING btree (name varchar_pattern_ops);


--
-- Name: dcim_device_platform_id_468138f1; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_platform_id_468138f1 ON public.dcim_device USING btree (platform_id);


--
-- Name: dcim_device_rack_id_23bde71f; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_rack_id_23bde71f ON public.dcim_device USING btree (rack_id);


--
-- Name: dcim_device_site_id_ff897cf6; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_site_id_ff897cf6 ON public.dcim_device USING btree (site_id);


--
-- Name: dcim_device_tenant_id_dcea7969; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_tenant_id_dcea7969 ON public.dcim_device USING btree (tenant_id);


--
-- Name: dcim_device_virtual_chassis_id_aed51693; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_device_virtual_chassis_id_aed51693 ON public.dcim_device USING btree (virtual_chassis_id);


--
-- Name: dcim_devicebay_device_id_0c8a1218; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicebay_device_id_0c8a1218 ON public.dcim_devicebay USING btree (device_id);


--
-- Name: dcim_devicebaytemplate_device_type_id_f4b24a29; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicebaytemplate_device_type_id_f4b24a29 ON public.dcim_devicebaytemplate USING btree (device_type_id);


--
-- Name: dcim_devicerole_name_1c813306_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicerole_name_1c813306_like ON public.dcim_devicerole USING btree (name varchar_pattern_ops);


--
-- Name: dcim_devicerole_slug_7952643b_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicerole_slug_7952643b_like ON public.dcim_devicerole USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_devicetype_manufacturer_id_a3e8029e; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicetype_manufacturer_id_a3e8029e ON public.dcim_devicetype USING btree (manufacturer_id);


--
-- Name: dcim_devicetype_slug_448745bd; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicetype_slug_448745bd ON public.dcim_devicetype USING btree (slug);


--
-- Name: dcim_devicetype_slug_448745bd_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_devicetype_slug_448745bd_like ON public.dcim_devicetype USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_frontport_cable_id_04ff8aab; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_frontport_cable_id_04ff8aab ON public.dcim_frontport USING btree (cable_id);


--
-- Name: dcim_frontport_device_id_950557b5; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_frontport_device_id_950557b5 ON public.dcim_frontport USING btree (device_id);


--
-- Name: dcim_frontport_rear_port_id_78df2532; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_frontport_rear_port_id_78df2532 ON public.dcim_frontport USING btree (rear_port_id);


--
-- Name: dcim_frontporttemplate_device_type_id_f088b952; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_frontporttemplate_device_type_id_f088b952 ON public.dcim_frontporttemplate USING btree (device_type_id);


--
-- Name: dcim_frontporttemplate_rear_port_id_9775411b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_frontporttemplate_rear_port_id_9775411b ON public.dcim_frontporttemplate USING btree (rear_port_id);


--
-- Name: dcim_interface_cable_id_1b264edb; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_cable_id_1b264edb ON public.dcim_interface USING btree (cable_id);


--
-- Name: dcim_interface_device_id_359c6115; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_device_id_359c6115 ON public.dcim_interface USING btree (device_id);


--
-- Name: dcim_interface_lag_id_ea1a1d12; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_lag_id_ea1a1d12 ON public.dcim_interface USING btree (lag_id);


--
-- Name: dcim_interface_tagged_vlans_interface_id_5870c9e9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_tagged_vlans_interface_id_5870c9e9 ON public.dcim_interface_tagged_vlans USING btree (interface_id);


--
-- Name: dcim_interface_tagged_vlans_vlan_id_e027005c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_tagged_vlans_vlan_id_e027005c ON public.dcim_interface_tagged_vlans USING btree (vlan_id);


--
-- Name: dcim_interface_untagged_vlan_id_838dc7be; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_untagged_vlan_id_838dc7be ON public.dcim_interface USING btree (untagged_vlan_id);


--
-- Name: dcim_interface_virtual_machine_id_2afd2d50; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interface_virtual_machine_id_2afd2d50 ON public.dcim_interface USING btree (virtual_machine_id);


--
-- Name: dcim_interfacetemplate_device_type_id_4bfcbfab; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_interfacetemplate_device_type_id_4bfcbfab ON public.dcim_interfacetemplate USING btree (device_type_id);


--
-- Name: dcim_inventoryitem_asset_tag_d3289273_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_inventoryitem_asset_tag_d3289273_like ON public.dcim_inventoryitem USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_manufacturer_name_841fcd92_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_manufacturer_name_841fcd92_like ON public.dcim_manufacturer USING btree (name varchar_pattern_ops);


--
-- Name: dcim_manufacturer_slug_00430749_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_manufacturer_slug_00430749_like ON public.dcim_manufacturer USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_module_device_id_53cfd5be; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_module_device_id_53cfd5be ON public.dcim_inventoryitem USING btree (device_id);


--
-- Name: dcim_module_manufacturer_id_95322cbb; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_module_manufacturer_id_95322cbb ON public.dcim_inventoryitem USING btree (manufacturer_id);


--
-- Name: dcim_module_parent_id_bb5d0341; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_module_parent_id_bb5d0341 ON public.dcim_inventoryitem USING btree (parent_id);


--
-- Name: dcim_platform_manufacturer_id_83f72d3d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_platform_manufacturer_id_83f72d3d ON public.dcim_platform USING btree (manufacturer_id);


--
-- Name: dcim_platform_name_c2f04255_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_platform_name_c2f04255_like ON public.dcim_platform USING btree (name varchar_pattern_ops);


--
-- Name: dcim_platform_slug_b0908ae4_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_platform_slug_b0908ae4_like ON public.dcim_platform USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_powerfeed_cable_id_ec44c4f8; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerfeed_cable_id_ec44c4f8 ON public.dcim_powerfeed USING btree (cable_id);


--
-- Name: dcim_powerfeed_power_panel_id_32bde3be; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerfeed_power_panel_id_32bde3be ON public.dcim_powerfeed USING btree (power_panel_id);


--
-- Name: dcim_powerfeed_rack_id_7abba090; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerfeed_rack_id_7abba090 ON public.dcim_powerfeed USING btree (rack_id);


--
-- Name: dcim_poweroutlet_cable_id_8dbea1ec; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_poweroutlet_cable_id_8dbea1ec ON public.dcim_poweroutlet USING btree (cable_id);


--
-- Name: dcim_poweroutlet_device_id_286351d7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_poweroutlet_device_id_286351d7 ON public.dcim_poweroutlet USING btree (device_id);


--
-- Name: dcim_poweroutlet_power_port_id_9bdf4163; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_poweroutlet_power_port_id_9bdf4163 ON public.dcim_poweroutlet USING btree (power_port_id);


--
-- Name: dcim_poweroutlettemplate_device_type_id_26b2316c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_poweroutlettemplate_device_type_id_26b2316c ON public.dcim_poweroutlettemplate USING btree (device_type_id);


--
-- Name: dcim_poweroutlettemplate_power_port_id_c0fb0c42; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_poweroutlettemplate_power_port_id_c0fb0c42 ON public.dcim_poweroutlettemplate USING btree (power_port_id);


--
-- Name: dcim_powerpanel_rack_group_id_76467cc9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerpanel_rack_group_id_76467cc9 ON public.dcim_powerpanel USING btree (rack_group_id);


--
-- Name: dcim_powerpanel_site_id_c430bc89; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerpanel_site_id_c430bc89 ON public.dcim_powerpanel USING btree (site_id);


--
-- Name: dcim_powerport_cable_id_c9682ba2; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerport_cable_id_c9682ba2 ON public.dcim_powerport USING btree (cable_id);


--
-- Name: dcim_powerport_device_id_ef7185ae; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerport_device_id_ef7185ae ON public.dcim_powerport USING btree (device_id);


--
-- Name: dcim_powerporttemplate_device_type_id_1ddfbfcc; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_powerporttemplate_device_type_id_1ddfbfcc ON public.dcim_powerporttemplate USING btree (device_type_id);


--
-- Name: dcim_rack_asset_tag_f88408e5_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rack_asset_tag_f88408e5_like ON public.dcim_rack USING btree (asset_tag varchar_pattern_ops);


--
-- Name: dcim_rack_group_id_44e90ea9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rack_group_id_44e90ea9 ON public.dcim_rack USING btree (group_id);


--
-- Name: dcim_rack_role_id_62d6919e; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rack_role_id_62d6919e ON public.dcim_rack USING btree (role_id);


--
-- Name: dcim_rack_site_id_403c7b3a; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rack_site_id_403c7b3a ON public.dcim_rack USING btree (site_id);


--
-- Name: dcim_rack_tenant_id_7cdf3725; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rack_tenant_id_7cdf3725 ON public.dcim_rack USING btree (tenant_id);


--
-- Name: dcim_rackgroup_site_id_13520e89; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackgroup_site_id_13520e89 ON public.dcim_rackgroup USING btree (site_id);


--
-- Name: dcim_rackgroup_slug_3f4582a7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackgroup_slug_3f4582a7 ON public.dcim_rackgroup USING btree (slug);


--
-- Name: dcim_rackgroup_slug_3f4582a7_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackgroup_slug_3f4582a7_like ON public.dcim_rackgroup USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_rackreservation_rack_id_1ebbaa9b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackreservation_rack_id_1ebbaa9b ON public.dcim_rackreservation USING btree (rack_id);


--
-- Name: dcim_rackreservation_tenant_id_eb5e045f; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackreservation_tenant_id_eb5e045f ON public.dcim_rackreservation USING btree (tenant_id);


--
-- Name: dcim_rackreservation_user_id_0785a527; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackreservation_user_id_0785a527 ON public.dcim_rackreservation USING btree (user_id);


--
-- Name: dcim_rackrole_name_9077cfcc_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackrole_name_9077cfcc_like ON public.dcim_rackrole USING btree (name varchar_pattern_ops);


--
-- Name: dcim_rackrole_slug_40bbcd3a_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rackrole_slug_40bbcd3a_like ON public.dcim_rackrole USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_rearport_cable_id_42c0e4e7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rearport_cable_id_42c0e4e7 ON public.dcim_rearport USING btree (cable_id);


--
-- Name: dcim_rearport_device_id_0bdfe9c0; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rearport_device_id_0bdfe9c0 ON public.dcim_rearport USING btree (device_id);


--
-- Name: dcim_rearporttemplate_device_type_id_6a02fd01; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_rearporttemplate_device_type_id_6a02fd01 ON public.dcim_rearporttemplate USING btree (device_type_id);


--
-- Name: dcim_region_level_2cee781b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_level_2cee781b ON public.dcim_region USING btree (level);


--
-- Name: dcim_region_lft_923d059c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_lft_923d059c ON public.dcim_region USING btree (lft);


--
-- Name: dcim_region_name_ba5a7082_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_name_ba5a7082_like ON public.dcim_region USING btree (name varchar_pattern_ops);


--
-- Name: dcim_region_parent_id_2486f5d4; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_parent_id_2486f5d4 ON public.dcim_region USING btree (parent_id);


--
-- Name: dcim_region_rght_20f888e3; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_rght_20f888e3 ON public.dcim_region USING btree (rght);


--
-- Name: dcim_region_slug_ff078a66_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_slug_ff078a66_like ON public.dcim_region USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_region_tree_id_a09ea9a7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_region_tree_id_a09ea9a7 ON public.dcim_region USING btree (tree_id);


--
-- Name: dcim_site_name_8fe66c76_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_site_name_8fe66c76_like ON public.dcim_site USING btree (name varchar_pattern_ops);


--
-- Name: dcim_site_region_id_45210932; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_site_region_id_45210932 ON public.dcim_site USING btree (region_id);


--
-- Name: dcim_site_slug_4412c762_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_site_slug_4412c762_like ON public.dcim_site USING btree (slug varchar_pattern_ops);


--
-- Name: dcim_site_tenant_id_15e7df63; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX dcim_site_tenant_id_15e7df63 ON public.dcim_site USING btree (tenant_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: extras_configcontext_name_4bbfe25d_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_name_4bbfe25d_like ON public.extras_configcontext USING btree (name varchar_pattern_ops);


--
-- Name: extras_configcontext_platforms_configcontext_id_2a516699; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_platforms_configcontext_id_2a516699 ON public.extras_configcontext_platforms USING btree (configcontext_id);


--
-- Name: extras_configcontext_platforms_platform_id_3fdfedc0; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_platforms_platform_id_3fdfedc0 ON public.extras_configcontext_platforms USING btree (platform_id);


--
-- Name: extras_configcontext_regions_configcontext_id_73003dbc; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_regions_configcontext_id_73003dbc ON public.extras_configcontext_regions USING btree (configcontext_id);


--
-- Name: extras_configcontext_regions_region_id_35c6ba9d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_regions_region_id_35c6ba9d ON public.extras_configcontext_regions USING btree (region_id);


--
-- Name: extras_configcontext_roles_configcontext_id_59b67386; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_roles_configcontext_id_59b67386 ON public.extras_configcontext_roles USING btree (configcontext_id);


--
-- Name: extras_configcontext_roles_devicerole_id_d3a84813; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_roles_devicerole_id_d3a84813 ON public.extras_configcontext_roles USING btree (devicerole_id);


--
-- Name: extras_configcontext_sites_configcontext_id_8c54feb9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_sites_configcontext_id_8c54feb9 ON public.extras_configcontext_sites USING btree (configcontext_id);


--
-- Name: extras_configcontext_sites_site_id_cbb76c96; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_sites_site_id_cbb76c96 ON public.extras_configcontext_sites USING btree (site_id);


--
-- Name: extras_configcontext_tenant_groups_configcontext_id_92f68345; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_tenant_groups_configcontext_id_92f68345 ON public.extras_configcontext_tenant_groups USING btree (configcontext_id);


--
-- Name: extras_configcontext_tenant_groups_tenantgroup_id_0909688d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_tenant_groups_tenantgroup_id_0909688d ON public.extras_configcontext_tenant_groups USING btree (tenantgroup_id);


--
-- Name: extras_configcontext_tenants_configcontext_id_b53552a6; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_tenants_configcontext_id_b53552a6 ON public.extras_configcontext_tenants USING btree (configcontext_id);


--
-- Name: extras_configcontext_tenants_tenant_id_8d0aa28e; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_configcontext_tenants_tenant_id_8d0aa28e ON public.extras_configcontext_tenants USING btree (tenant_id);


--
-- Name: extras_customfield_name_2fe72707_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfield_name_2fe72707_like ON public.extras_customfield USING btree (name varchar_pattern_ops);


--
-- Name: extras_customfield_obj_type_contenttype_id_6890b714; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfield_obj_type_contenttype_id_6890b714 ON public.extras_customfield_obj_type USING btree (contenttype_id);


--
-- Name: extras_customfield_obj_type_customfield_id_82480f86; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfield_obj_type_customfield_id_82480f86 ON public.extras_customfield_obj_type USING btree (customfield_id);


--
-- Name: extras_customfieldchoice_field_id_35006739; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfieldchoice_field_id_35006739 ON public.extras_customfieldchoice USING btree (field_id);


--
-- Name: extras_customfieldvalue_field_id_1a461f0d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfieldvalue_field_id_1a461f0d ON public.extras_customfieldvalue USING btree (field_id);


--
-- Name: extras_customfieldvalue_obj_type_id_b750b07b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customfieldvalue_obj_type_id_b750b07b ON public.extras_customfieldvalue USING btree (obj_type_id);


--
-- Name: extras_customlink_content_type_id_4d35b063; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customlink_content_type_id_4d35b063 ON public.extras_customlink USING btree (content_type_id);


--
-- Name: extras_customlink_name_daed2d18_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_customlink_name_daed2d18_like ON public.extras_customlink USING btree (name varchar_pattern_ops);


--
-- Name: extras_exporttemplate_content_type_id_59737e21; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_exporttemplate_content_type_id_59737e21 ON public.extras_exporttemplate USING btree (content_type_id);


--
-- Name: extras_imageattachment_content_type_id_90e0643d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_imageattachment_content_type_id_90e0643d ON public.extras_imageattachment USING btree (content_type_id);


--
-- Name: extras_objectchange_changed_object_type_id_b755bb60; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_objectchange_changed_object_type_id_b755bb60 ON public.extras_objectchange USING btree (changed_object_type_id);


--
-- Name: extras_objectchange_related_object_type_id_fe6e521f; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_objectchange_related_object_type_id_fe6e521f ON public.extras_objectchange USING btree (related_object_type_id);


--
-- Name: extras_objectchange_time_224380ea; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_objectchange_time_224380ea ON public.extras_objectchange USING btree ("time");


--
-- Name: extras_objectchange_user_id_7fdf8186; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_objectchange_user_id_7fdf8186 ON public.extras_objectchange USING btree (user_id);


--
-- Name: extras_reportresult_report_3575dd21_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_reportresult_report_3575dd21_like ON public.extras_reportresult USING btree (report varchar_pattern_ops);


--
-- Name: extras_reportresult_user_id_0df55b95; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_reportresult_user_id_0df55b95 ON public.extras_reportresult USING btree (user_id);


--
-- Name: extras_tag_name_9550b3d9_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_tag_name_9550b3d9_like ON public.extras_tag USING btree (name varchar_pattern_ops);


--
-- Name: extras_tag_slug_aaa5b7e9_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_tag_slug_aaa5b7e9_like ON public.extras_tag USING btree (slug varchar_pattern_ops);


--
-- Name: extras_taggeditem_content_type_id_ba5562ed; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_taggeditem_content_type_id_ba5562ed ON public.extras_taggeditem USING btree (content_type_id);


--
-- Name: extras_taggeditem_content_type_id_object_id_80e28e23_idx; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_taggeditem_content_type_id_object_id_80e28e23_idx ON public.extras_taggeditem USING btree (content_type_id, object_id);


--
-- Name: extras_taggeditem_object_id_31b2aa77; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_taggeditem_object_id_31b2aa77 ON public.extras_taggeditem USING btree (object_id);


--
-- Name: extras_taggeditem_tag_id_d48af7c7; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_taggeditem_tag_id_d48af7c7 ON public.extras_taggeditem USING btree (tag_id);


--
-- Name: extras_topologymap_name_f377ebf1_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_topologymap_name_f377ebf1_like ON public.extras_topologymap USING btree (name varchar_pattern_ops);


--
-- Name: extras_topologymap_site_id_b56b3ceb; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_topologymap_site_id_b56b3ceb ON public.extras_topologymap USING btree (site_id);


--
-- Name: extras_topologymap_slug_9ba3d31e_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_topologymap_slug_9ba3d31e_like ON public.extras_topologymap USING btree (slug varchar_pattern_ops);


--
-- Name: extras_webhook_name_82cf60b5_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_webhook_name_82cf60b5_like ON public.extras_webhook USING btree (name varchar_pattern_ops);


--
-- Name: extras_webhook_obj_type_contenttype_id_85c7693b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_webhook_obj_type_contenttype_id_85c7693b ON public.extras_webhook_obj_type USING btree (contenttype_id);


--
-- Name: extras_webhook_obj_type_webhook_id_c7bed170; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX extras_webhook_obj_type_webhook_id_c7bed170 ON public.extras_webhook_obj_type USING btree (webhook_id);


--
-- Name: ipam_aggregate_rir_id_ef7a27bd; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_aggregate_rir_id_ef7a27bd ON public.ipam_aggregate USING btree (rir_id);


--
-- Name: ipam_ipaddress_interface_id_91e71d9d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_ipaddress_interface_id_91e71d9d ON public.ipam_ipaddress USING btree (interface_id);


--
-- Name: ipam_ipaddress_tenant_id_ac55acfd; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_ipaddress_tenant_id_ac55acfd ON public.ipam_ipaddress USING btree (tenant_id);


--
-- Name: ipam_ipaddress_vrf_id_51fcc59b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_ipaddress_vrf_id_51fcc59b ON public.ipam_ipaddress USING btree (vrf_id);


--
-- Name: ipam_prefix_role_id_0a98d415; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_prefix_role_id_0a98d415 ON public.ipam_prefix USING btree (role_id);


--
-- Name: ipam_prefix_site_id_0b20df05; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_prefix_site_id_0b20df05 ON public.ipam_prefix USING btree (site_id);


--
-- Name: ipam_prefix_tenant_id_7ba1fcc4; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_prefix_tenant_id_7ba1fcc4 ON public.ipam_prefix USING btree (tenant_id);


--
-- Name: ipam_prefix_vlan_id_1db91bff; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_prefix_vlan_id_1db91bff ON public.ipam_prefix USING btree (vlan_id);


--
-- Name: ipam_prefix_vrf_id_34f78ed0; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_prefix_vrf_id_34f78ed0 ON public.ipam_prefix USING btree (vrf_id);


--
-- Name: ipam_rir_name_64a71982_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_rir_name_64a71982_like ON public.ipam_rir USING btree (name varchar_pattern_ops);


--
-- Name: ipam_rir_slug_ff1a369a_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_rir_slug_ff1a369a_like ON public.ipam_rir USING btree (slug varchar_pattern_ops);


--
-- Name: ipam_role_name_13784849_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_role_name_13784849_like ON public.ipam_role USING btree (name varchar_pattern_ops);


--
-- Name: ipam_role_slug_309ca14c_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_role_slug_309ca14c_like ON public.ipam_role USING btree (slug varchar_pattern_ops);


--
-- Name: ipam_service_device_id_b4d2bb9c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_service_device_id_b4d2bb9c ON public.ipam_service USING btree (device_id);


--
-- Name: ipam_service_ipaddresses_ipaddress_id_b4138c6d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_service_ipaddresses_ipaddress_id_b4138c6d ON public.ipam_service_ipaddresses USING btree (ipaddress_id);


--
-- Name: ipam_service_ipaddresses_service_id_ae26b9ab; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_service_ipaddresses_service_id_ae26b9ab ON public.ipam_service_ipaddresses USING btree (service_id);


--
-- Name: ipam_service_virtual_machine_id_e8b53562; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_service_virtual_machine_id_e8b53562 ON public.ipam_service USING btree (virtual_machine_id);


--
-- Name: ipam_vlan_group_id_88cbfa62; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlan_group_id_88cbfa62 ON public.ipam_vlan USING btree (group_id);


--
-- Name: ipam_vlan_role_id_f5015962; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlan_role_id_f5015962 ON public.ipam_vlan USING btree (role_id);


--
-- Name: ipam_vlan_site_id_a59334e3; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlan_site_id_a59334e3 ON public.ipam_vlan USING btree (site_id);


--
-- Name: ipam_vlan_tenant_id_71a8290d; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlan_tenant_id_71a8290d ON public.ipam_vlan USING btree (tenant_id);


--
-- Name: ipam_vlangroup_site_id_264f36f6; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlangroup_site_id_264f36f6 ON public.ipam_vlangroup USING btree (site_id);


--
-- Name: ipam_vlangroup_slug_40abcf6b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlangroup_slug_40abcf6b ON public.ipam_vlangroup USING btree (slug);


--
-- Name: ipam_vlangroup_slug_40abcf6b_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vlangroup_slug_40abcf6b_like ON public.ipam_vlangroup USING btree (slug varchar_pattern_ops);


--
-- Name: ipam_vrf_rd_0ac1bde1_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vrf_rd_0ac1bde1_like ON public.ipam_vrf USING btree (rd varchar_pattern_ops);


--
-- Name: ipam_vrf_tenant_id_498b0051; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX ipam_vrf_tenant_id_498b0051 ON public.ipam_vrf USING btree (tenant_id);


--
-- Name: secrets_secret_device_id_c7c13124; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secret_device_id_c7c13124 ON public.secrets_secret USING btree (device_id);


--
-- Name: secrets_secret_role_id_39d9347f; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secret_role_id_39d9347f ON public.secrets_secret USING btree (role_id);


--
-- Name: secrets_secretrole_groups_group_id_a687dd10; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_groups_group_id_a687dd10 ON public.secrets_secretrole_groups USING btree (group_id);


--
-- Name: secrets_secretrole_groups_secretrole_id_3cf0338b; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_groups_secretrole_id_3cf0338b ON public.secrets_secretrole_groups USING btree (secretrole_id);


--
-- Name: secrets_secretrole_name_7b6ee7a4_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_name_7b6ee7a4_like ON public.secrets_secretrole USING btree (name varchar_pattern_ops);


--
-- Name: secrets_secretrole_slug_a06c885e_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_slug_a06c885e_like ON public.secrets_secretrole USING btree (slug varchar_pattern_ops);


--
-- Name: secrets_secretrole_users_secretrole_id_d2eac298; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_users_secretrole_id_d2eac298 ON public.secrets_secretrole_users USING btree (secretrole_id);


--
-- Name: secrets_secretrole_users_user_id_25be95ad; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX secrets_secretrole_users_user_id_25be95ad ON public.secrets_secretrole_users USING btree (user_id);


--
-- Name: taggit_tag_name_58eb2ed9_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_tag_name_58eb2ed9_like ON public.taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_6be58b2c_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_tag_slug_6be58b2c_like ON public.taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_content_type_id_object_id_196cc965_idx; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: tenancy_tenant_group_id_7daef6f4; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX tenancy_tenant_group_id_7daef6f4 ON public.tenancy_tenant USING btree (group_id);


--
-- Name: tenancy_tenant_name_f6e5b2f5_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX tenancy_tenant_name_f6e5b2f5_like ON public.tenancy_tenant USING btree (name varchar_pattern_ops);


--
-- Name: tenancy_tenant_slug_0716575e_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX tenancy_tenant_slug_0716575e_like ON public.tenancy_tenant USING btree (slug varchar_pattern_ops);


--
-- Name: tenancy_tenantgroup_name_53363199_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX tenancy_tenantgroup_name_53363199_like ON public.tenancy_tenantgroup USING btree (name varchar_pattern_ops);


--
-- Name: tenancy_tenantgroup_slug_e2af1cb6_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX tenancy_tenantgroup_slug_e2af1cb6_like ON public.tenancy_tenantgroup USING btree (slug varchar_pattern_ops);


--
-- Name: users_token_key_820deccd_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX users_token_key_820deccd_like ON public.users_token USING btree (key varchar_pattern_ops);


--
-- Name: users_token_user_id_af964690; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX users_token_user_id_af964690 ON public.users_token USING btree (user_id);


--
-- Name: virtualization_cluster_group_id_de379828; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_cluster_group_id_de379828 ON public.virtualization_cluster USING btree (group_id);


--
-- Name: virtualization_cluster_name_1b59a61b_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_cluster_name_1b59a61b_like ON public.virtualization_cluster USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_cluster_site_id_4d5af282; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_cluster_site_id_4d5af282 ON public.virtualization_cluster USING btree (site_id);


--
-- Name: virtualization_cluster_type_id_4efafb0a; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_cluster_type_id_4efafb0a ON public.virtualization_cluster USING btree (type_id);


--
-- Name: virtualization_clustergroup_name_4fcd26b4_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_clustergroup_name_4fcd26b4_like ON public.virtualization_clustergroup USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_clustergroup_slug_57ca1d23_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_clustergroup_slug_57ca1d23_like ON public.virtualization_clustergroup USING btree (slug varchar_pattern_ops);


--
-- Name: virtualization_clustertype_name_ea854d3d_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_clustertype_name_ea854d3d_like ON public.virtualization_clustertype USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_clustertype_slug_8ee4d0e0_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_clustertype_slug_8ee4d0e0_like ON public.virtualization_clustertype USING btree (slug varchar_pattern_ops);


--
-- Name: virtualization_virtualmachine_cluster_id_6c9f9047; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_virtualmachine_cluster_id_6c9f9047 ON public.virtualization_virtualmachine USING btree (cluster_id);


--
-- Name: virtualization_virtualmachine_name_266f6cdc_like; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_virtualmachine_name_266f6cdc_like ON public.virtualization_virtualmachine USING btree (name varchar_pattern_ops);


--
-- Name: virtualization_virtualmachine_platform_id_a6c5ccb2; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_virtualmachine_platform_id_a6c5ccb2 ON public.virtualization_virtualmachine USING btree (platform_id);


--
-- Name: virtualization_virtualmachine_role_id_0cc898f9; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_virtualmachine_role_id_0cc898f9 ON public.virtualization_virtualmachine USING btree (role_id);


--
-- Name: virtualization_virtualmachine_tenant_id_d00d1d77; Type: INDEX; Schema: public; Owner: netbox
--

CREATE INDEX virtualization_virtualmachine_tenant_id_d00d1d77 ON public.virtualization_virtualmachine USING btree (tenant_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_provider_id_d9195418_fk_circuits_provider_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_provider_id_d9195418_fk_circuits_provider_id FOREIGN KEY (provider_id) REFERENCES public.circuits_provider(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_tenant_id_812508a5_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_tenant_id_812508a5_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuit circuits_circuit_type_id_1b9f485a_fk_circuits_circuittype_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuit
    ADD CONSTRAINT circuits_circuit_type_id_1b9f485a_fk_circuits_circuittype_id FOREIGN KEY (type_id) REFERENCES public.circuits_circuittype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm_circuit_id_257e87e7_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm_circuit_id_257e87e7_fk_circuits_ FOREIGN KEY (circuit_id) REFERENCES public.circuits_circuit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuitterm_connected_endpoint_i_eb10be43_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuitterm_connected_endpoint_i_eb10be43_fk_dcim_inte FOREIGN KEY (connected_endpoint_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuittermination_cable_id_35e9f703_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_cable_id_35e9f703_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: circuits_circuittermination circuits_circuittermination_site_id_e6fe5652_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.circuits_circuittermination
    ADD CONSTRAINT circuits_circuittermination_site_id_e6fe5652_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable__termination_a_device_id_e59cde1c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable__termination_a_device_id_e59cde1c_fk_dcim_device_id FOREIGN KEY (_termination_a_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable__termination_b_device_id_a9073762_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable__termination_b_device_id_a9073762_fk_dcim_device_id FOREIGN KEY (_termination_b_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable_termination_a_type_i_a614bab8_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_a_type_i_a614bab8_fk_django_co FOREIGN KEY (termination_a_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_cable dcim_cable_termination_b_type_i_a91595d0_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_cable
    ADD CONSTRAINT dcim_cable_termination_b_type_i_a91595d0_fk_django_co FOREIGN KEY (termination_b_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport_cable_id_a9ae5465_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_cable_id_a9ae5465_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport_connected_endpoint_i_efe0a825_fk_dcim_cons; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_connected_endpoint_i_efe0a825_fk_dcim_cons FOREIGN KEY (connected_endpoint_id) REFERENCES public.dcim_consoleserverport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleport dcim_consoleport_device_id_f2d90d3c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleport
    ADD CONSTRAINT dcim_consoleport_device_id_f2d90d3c_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleporttemplate dcim_consoleporttemp_device_type_id_075d4015_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleporttemplate
    ADD CONSTRAINT dcim_consoleporttemp_device_type_id_075d4015_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverporttemplate dcim_consoleserverpo_device_type_id_579bdc86_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverporttemplate
    ADD CONSTRAINT dcim_consoleserverpo_device_type_id_579bdc86_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverport_cable_id_f2940dfd_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_cable_id_f2940dfd_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_consoleserverport dcim_consoleserverport_device_id_d9866581_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_consoleserverport
    ADD CONSTRAINT dcim_consoleserverport_device_id_d9866581_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_cluster_id_cf852f78_fk_virtualization_cluster_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_cluster_id_cf852f78_fk_virtualization_cluster_id FOREIGN KEY (cluster_id) REFERENCES public.virtualization_cluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_device_role_id_682e8188_fk_dcim_devicerole_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_device_role_id_682e8188_fk_dcim_devicerole_id FOREIGN KEY (device_role_id) REFERENCES public.dcim_devicerole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_device_type_id_d61b4086_fk_dcim_devicetype_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_device_type_id_d61b4086_fk_dcim_devicetype_id FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_platform_id_468138f1_fk_dcim_platform_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_platform_id_468138f1_fk_dcim_platform_id FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_primary_ip4_id_2ccd943a_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip4_id_2ccd943a_fk_ipam_ipaddress_id FOREIGN KEY (primary_ip4_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_primary_ip6_id_d180fe91_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_primary_ip6_id_d180fe91_fk_ipam_ipaddress_id FOREIGN KEY (primary_ip6_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_rack_id_23bde71f_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_rack_id_23bde71f_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_site_id_ff897cf6_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_site_id_ff897cf6_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_tenant_id_dcea7969_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_tenant_id_dcea7969_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_device dcim_device_virtual_chassis_id_aed51693_fk_dcim_virt; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_device
    ADD CONSTRAINT dcim_device_virtual_chassis_id_aed51693_fk_dcim_virt FOREIGN KEY (virtual_chassis_id) REFERENCES public.dcim_virtualchassis(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebay dcim_devicebay_device_id_0c8a1218_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_device_id_0c8a1218_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebay dcim_devicebay_installed_device_id_04618112_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebay
    ADD CONSTRAINT dcim_devicebay_installed_device_id_04618112_fk_dcim_device_id FOREIGN KEY (installed_device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicebaytemplate dcim_devicebaytempla_device_type_id_f4b24a29_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicebaytemplate
    ADD CONSTRAINT dcim_devicebaytempla_device_type_id_f4b24a29_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_devicetype dcim_devicetype_manufacturer_id_a3e8029e_fk_dcim_manu; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_devicetype
    ADD CONSTRAINT dcim_devicetype_manufacturer_id_a3e8029e_fk_dcim_manu FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_cable_id_04ff8aab_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_cable_id_04ff8aab_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_device_id_950557b5_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_device_id_950557b5_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontport dcim_frontport_rear_port_id_78df2532_fk_dcim_rearport_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontport
    ADD CONSTRAINT dcim_frontport_rear_port_id_78df2532_fk_dcim_rearport_id FOREIGN KEY (rear_port_id) REFERENCES public.dcim_rearport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontporttemplate dcim_frontporttempla_device_type_id_f088b952_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttempla_device_type_id_f088b952_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_frontporttemplate dcim_frontporttempla_rear_port_id_9775411b_fk_dcim_rear; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_frontporttemplate
    ADD CONSTRAINT dcim_frontporttempla_rear_port_id_9775411b_fk_dcim_rear FOREIGN KEY (rear_port_id) REFERENCES public.dcim_rearporttemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface__connected_circuitte_be36a3a3_fk_circuits_; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__connected_circuitte_be36a3a3_fk_circuits_ FOREIGN KEY (_connected_circuittermination_id) REFERENCES public.circuits_circuittermination(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface__connected_interface_3dfcd87c_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface__connected_interface_3dfcd87c_fk_dcim_inte FOREIGN KEY (_connected_interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_cable_id_1b264edb_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_cable_id_1b264edb_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_device_id_359c6115_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_device_id_359c6115_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_lag_id_ea1a1d12_fk_dcim_interface_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_lag_id_ea1a1d12_fk_dcim_interface_id FOREIGN KEY (lag_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagge_interface_id_5870c9e9_fk_dcim_inte; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagge_interface_id_5870c9e9_fk_dcim_inte FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface_tagged_vlans dcim_interface_tagged_vlans_vlan_id_e027005c_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface_tagged_vlans
    ADD CONSTRAINT dcim_interface_tagged_vlans_vlan_id_e027005c_fk_ipam_vlan_id FOREIGN KEY (vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_untagged_vlan_id_838dc7be_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_untagged_vlan_id_838dc7be_fk_ipam_vlan_id FOREIGN KEY (untagged_vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interface dcim_interface_virtual_machine_id_2afd2d50_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interface
    ADD CONSTRAINT dcim_interface_virtual_machine_id_2afd2d50_fk_virtualiz FOREIGN KEY (virtual_machine_id) REFERENCES public.virtualization_virtualmachine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_interfacetemplate dcim_interfacetempla_device_type_id_4bfcbfab_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_interfacetemplate
    ADD CONSTRAINT dcim_interfacetempla_device_type_id_4bfcbfab_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_device_id_033d83f8_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_device_id_033d83f8_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_manufacturer_id_dcd1b78a_fk_dcim_manu; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_manufacturer_id_dcd1b78a_fk_dcim_manu FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_inventoryitem dcim_inventoryitem_parent_id_7ebcd457_fk_dcim_inventoryitem_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_inventoryitem
    ADD CONSTRAINT dcim_inventoryitem_parent_id_7ebcd457_fk_dcim_inventoryitem_id FOREIGN KEY (parent_id) REFERENCES public.dcim_inventoryitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_platform dcim_platform_manufacturer_id_83f72d3d_fk_dcim_manufacturer_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_platform
    ADD CONSTRAINT dcim_platform_manufacturer_id_83f72d3d_fk_dcim_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES public.dcim_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_cable_id_ec44c4f8_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_cable_id_ec44c4f8_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_connected_endpoint_i_6ad0aad2_fk_dcim_powe; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_connected_endpoint_i_6ad0aad2_fk_dcim_powe FOREIGN KEY (connected_endpoint_id) REFERENCES public.dcim_powerport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_power_panel_id_32bde3be_fk_dcim_powerpanel_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_power_panel_id_32bde3be_fk_dcim_powerpanel_id FOREIGN KEY (power_panel_id) REFERENCES public.dcim_powerpanel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerfeed dcim_powerfeed_rack_id_7abba090_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerfeed
    ADD CONSTRAINT dcim_powerfeed_rack_id_7abba090_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_cable_id_8dbea1ec_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_cable_id_8dbea1ec_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_device_id_286351d7_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_device_id_286351d7_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlet dcim_poweroutlet_power_port_id_9bdf4163_fk_dcim_powerport_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlet
    ADD CONSTRAINT dcim_poweroutlet_power_port_id_9bdf4163_fk_dcim_powerport_id FOREIGN KEY (power_port_id) REFERENCES public.dcim_powerport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemp_device_type_id_26b2316c_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemp_device_type_id_26b2316c_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_poweroutlettemplate dcim_poweroutlettemp_power_port_id_c0fb0c42_fk_dcim_powe; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_poweroutlettemplate
    ADD CONSTRAINT dcim_poweroutlettemp_power_port_id_c0fb0c42_fk_dcim_powe FOREIGN KEY (power_port_id) REFERENCES public.dcim_powerporttemplate(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerpanel dcim_powerpanel_rack_group_id_76467cc9_fk_dcim_rackgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_rack_group_id_76467cc9_fk_dcim_rackgroup_id FOREIGN KEY (rack_group_id) REFERENCES public.dcim_rackgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerpanel dcim_powerpanel_site_id_c430bc89_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerpanel
    ADD CONSTRAINT dcim_powerpanel_site_id_c430bc89_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport__connected_powerfeed_8f5230a3_fk_dcim_powe; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport__connected_powerfeed_8f5230a3_fk_dcim_powe FOREIGN KEY (_connected_powerfeed_id) REFERENCES public.dcim_powerfeed(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport__connected_poweroutl_6c3ea413_fk_dcim_powe; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport__connected_poweroutl_6c3ea413_fk_dcim_powe FOREIGN KEY (_connected_poweroutlet_id) REFERENCES public.dcim_poweroutlet(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport_cable_id_c9682ba2_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_cable_id_c9682ba2_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerport dcim_powerport_device_id_ef7185ae_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerport
    ADD CONSTRAINT dcim_powerport_device_id_ef7185ae_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_powerporttemplate dcim_powerporttempla_device_type_id_1ddfbfcc_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_powerporttemplate
    ADD CONSTRAINT dcim_powerporttempla_device_type_id_1ddfbfcc_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_group_id_44e90ea9_fk_dcim_rackgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_group_id_44e90ea9_fk_dcim_rackgroup_id FOREIGN KEY (group_id) REFERENCES public.dcim_rackgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_role_id_62d6919e_fk_dcim_rackrole_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_role_id_62d6919e_fk_dcim_rackrole_id FOREIGN KEY (role_id) REFERENCES public.dcim_rackrole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_site_id_403c7b3a_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_site_id_403c7b3a_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rack dcim_rack_tenant_id_7cdf3725_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rack
    ADD CONSTRAINT dcim_rack_tenant_id_7cdf3725_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackgroup dcim_rackgroup_site_id_13520e89_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackgroup
    ADD CONSTRAINT dcim_rackgroup_site_id_13520e89_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_rack_id_1ebbaa9b_fk_dcim_rack_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_rack_id_1ebbaa9b_fk_dcim_rack_id FOREIGN KEY (rack_id) REFERENCES public.dcim_rack(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_tenant_id_eb5e045f_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_tenant_id_eb5e045f_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rackreservation dcim_rackreservation_user_id_0785a527_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rackreservation
    ADD CONSTRAINT dcim_rackreservation_user_id_0785a527_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearport dcim_rearport_cable_id_42c0e4e7_fk_dcim_cable_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_cable_id_42c0e4e7_fk_dcim_cable_id FOREIGN KEY (cable_id) REFERENCES public.dcim_cable(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearport dcim_rearport_device_id_0bdfe9c0_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearport
    ADD CONSTRAINT dcim_rearport_device_id_0bdfe9c0_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_rearporttemplate dcim_rearporttemplat_device_type_id_6a02fd01_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_rearporttemplate
    ADD CONSTRAINT dcim_rearporttemplat_device_type_id_6a02fd01_fk_dcim_devi FOREIGN KEY (device_type_id) REFERENCES public.dcim_devicetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_region dcim_region_parent_id_2486f5d4_fk_dcim_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_region
    ADD CONSTRAINT dcim_region_parent_id_2486f5d4_fk_dcim_region_id FOREIGN KEY (parent_id) REFERENCES public.dcim_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_site dcim_site_region_id_45210932_fk_dcim_region_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site
    ADD CONSTRAINT dcim_site_region_id_45210932_fk_dcim_region_id FOREIGN KEY (region_id) REFERENCES public.dcim_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_site dcim_site_tenant_id_15e7df63_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_site
    ADD CONSTRAINT dcim_site_tenant_id_15e7df63_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dcim_virtualchassis dcim_virtualchassis_master_id_ab54cfc6_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.dcim_virtualchassis
    ADD CONSTRAINT dcim_virtualchassis_master_id_ab54cfc6_fk_dcim_device_id FOREIGN KEY (master_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_platforms extras_configcontext_configcontext_id_2a516699_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_configcontext_id_2a516699_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_roles extras_configcontext_configcontext_id_59b67386_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_configcontext_id_59b67386_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_regions extras_configcontext_configcontext_id_73003dbc_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_regions
    ADD CONSTRAINT extras_configcontext_configcontext_id_73003dbc_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_sites extras_configcontext_configcontext_id_8c54feb9_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_sites
    ADD CONSTRAINT extras_configcontext_configcontext_id_8c54feb9_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_configcontext_id_92f68345_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_configcontext_id_92f68345_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenants extras_configcontext_configcontext_id_b53552a6_fk_extras_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_configcontext_id_b53552a6_fk_extras_co FOREIGN KEY (configcontext_id) REFERENCES public.extras_configcontext(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_roles extras_configcontext_devicerole_id_d3a84813_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_roles
    ADD CONSTRAINT extras_configcontext_devicerole_id_d3a84813_fk_dcim_devi FOREIGN KEY (devicerole_id) REFERENCES public.dcim_devicerole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_platforms extras_configcontext_platform_id_3fdfedc0_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_platforms
    ADD CONSTRAINT extras_configcontext_platform_id_3fdfedc0_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_regions extras_configcontext_region_id_35c6ba9d_fk_dcim_regi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_regions
    ADD CONSTRAINT extras_configcontext_region_id_35c6ba9d_fk_dcim_regi FOREIGN KEY (region_id) REFERENCES public.dcim_region(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_sites extras_configcontext_sites_site_id_cbb76c96_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_sites
    ADD CONSTRAINT extras_configcontext_sites_site_id_cbb76c96_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenants extras_configcontext_tenant_id_8d0aa28e_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenants
    ADD CONSTRAINT extras_configcontext_tenant_id_8d0aa28e_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_configcontext_tenant_groups extras_configcontext_tenantgroup_id_0909688d_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_configcontext_tenant_groups
    ADD CONSTRAINT extras_configcontext_tenantgroup_id_0909688d_fk_tenancy_t FOREIGN KEY (tenantgroup_id) REFERENCES public.tenancy_tenantgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfield_obj_type extras_customfield_o_contenttype_id_6890b714_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield_obj_type
    ADD CONSTRAINT extras_customfield_o_contenttype_id_6890b714_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfield_obj_type extras_customfield_o_customfield_id_82480f86_fk_extras_cu; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfield_obj_type
    ADD CONSTRAINT extras_customfield_o_customfield_id_82480f86_fk_extras_cu FOREIGN KEY (customfield_id) REFERENCES public.extras_customfield(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfieldchoice extras_customfieldch_field_id_35006739_fk_extras_cu; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldchoice
    ADD CONSTRAINT extras_customfieldch_field_id_35006739_fk_extras_cu FOREIGN KEY (field_id) REFERENCES public.extras_customfield(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfieldvalue extras_customfieldva_field_id_1a461f0d_fk_extras_cu; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldvalue
    ADD CONSTRAINT extras_customfieldva_field_id_1a461f0d_fk_extras_cu FOREIGN KEY (field_id) REFERENCES public.extras_customfield(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customfieldvalue extras_customfieldva_obj_type_id_b750b07b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customfieldvalue
    ADD CONSTRAINT extras_customfieldva_obj_type_id_b750b07b_fk_django_co FOREIGN KEY (obj_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_customlink extras_customlink_content_type_id_4d35b063_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_customlink
    ADD CONSTRAINT extras_customlink_content_type_id_4d35b063_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_exporttemplate extras_exporttemplat_content_type_id_59737e21_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_exporttemplate
    ADD CONSTRAINT extras_exporttemplat_content_type_id_59737e21_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_imageattachment extras_imageattachme_content_type_id_90e0643d_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_imageattachment
    ADD CONSTRAINT extras_imageattachme_content_type_id_90e0643d_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_changed_object_type__b755bb60_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_changed_object_type__b755bb60_fk_django_co FOREIGN KEY (changed_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_related_object_type__fe6e521f_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_related_object_type__fe6e521f_fk_django_co FOREIGN KEY (related_object_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_objectchange extras_objectchange_user_id_7fdf8186_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_objectchange
    ADD CONSTRAINT extras_objectchange_user_id_7fdf8186_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_reportresult extras_reportresult_user_id_0df55b95_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_reportresult
    ADD CONSTRAINT extras_reportresult_user_id_0df55b95_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_taggeditem extras_taggeditem_content_type_id_ba5562ed_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_content_type_id_ba5562ed_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_taggeditem extras_taggeditem_tag_id_d48af7c7_fk_extras_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_taggeditem
    ADD CONSTRAINT extras_taggeditem_tag_id_d48af7c7_fk_extras_tag_id FOREIGN KEY (tag_id) REFERENCES public.extras_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_topologymap extras_topologymap_site_id_b56b3ceb_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_topologymap
    ADD CONSTRAINT extras_topologymap_site_id_b56b3ceb_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_webhook_obj_type extras_webhook_obj_t_contenttype_id_85c7693b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook_obj_type
    ADD CONSTRAINT extras_webhook_obj_t_contenttype_id_85c7693b_fk_django_co FOREIGN KEY (contenttype_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: extras_webhook_obj_type extras_webhook_obj_t_webhook_id_c7bed170_fk_extras_we; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.extras_webhook_obj_type
    ADD CONSTRAINT extras_webhook_obj_t_webhook_id_c7bed170_fk_extras_we FOREIGN KEY (webhook_id) REFERENCES public.extras_webhook(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_aggregate ipam_aggregate_rir_id_ef7a27bd_fk_ipam_rir_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_aggregate
    ADD CONSTRAINT ipam_aggregate_rir_id_ef7a27bd_fk_ipam_rir_id FOREIGN KEY (rir_id) REFERENCES public.ipam_rir(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_interface_id_91e71d9d_fk_dcim_interface_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_interface_id_91e71d9d_fk_dcim_interface_id FOREIGN KEY (interface_id) REFERENCES public.dcim_interface(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_nat_inside_id_a45fb7c5_fk_ipam_ipaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_nat_inside_id_a45fb7c5_fk_ipam_ipaddress_id FOREIGN KEY (nat_inside_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_tenant_id_ac55acfd_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_tenant_id_ac55acfd_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_ipaddress ipam_ipaddress_vrf_id_51fcc59b_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_ipaddress
    ADD CONSTRAINT ipam_ipaddress_vrf_id_51fcc59b_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_role_id_0a98d415_fk_ipam_role_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_role_id_0a98d415_fk_ipam_role_id FOREIGN KEY (role_id) REFERENCES public.ipam_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_site_id_0b20df05_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_site_id_0b20df05_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_tenant_id_7ba1fcc4_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_tenant_id_7ba1fcc4_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_vlan_id_1db91bff_fk_ipam_vlan_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_vlan_id_1db91bff_fk_ipam_vlan_id FOREIGN KEY (vlan_id) REFERENCES public.ipam_vlan(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_prefix ipam_prefix_vrf_id_34f78ed0_fk_ipam_vrf_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_prefix
    ADD CONSTRAINT ipam_prefix_vrf_id_34f78ed0_fk_ipam_vrf_id FOREIGN KEY (vrf_id) REFERENCES public.ipam_vrf(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service ipam_service_device_id_b4d2bb9c_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_device_id_b4d2bb9c_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service_ipaddresses ipam_service_ipaddre_ipaddress_id_b4138c6d_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service_ipaddresses
    ADD CONSTRAINT ipam_service_ipaddre_ipaddress_id_b4138c6d_fk_ipam_ipad FOREIGN KEY (ipaddress_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service_ipaddresses ipam_service_ipaddresses_service_id_ae26b9ab_fk_ipam_service_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service_ipaddresses
    ADD CONSTRAINT ipam_service_ipaddresses_service_id_ae26b9ab_fk_ipam_service_id FOREIGN KEY (service_id) REFERENCES public.ipam_service(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_service ipam_service_virtual_machine_id_e8b53562_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_service
    ADD CONSTRAINT ipam_service_virtual_machine_id_e8b53562_fk_virtualiz FOREIGN KEY (virtual_machine_id) REFERENCES public.virtualization_virtualmachine(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_group_id_88cbfa62_fk_ipam_vlangroup_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_group_id_88cbfa62_fk_ipam_vlangroup_id FOREIGN KEY (group_id) REFERENCES public.ipam_vlangroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_role_id_f5015962_fk_ipam_role_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_role_id_f5015962_fk_ipam_role_id FOREIGN KEY (role_id) REFERENCES public.ipam_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_site_id_a59334e3_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_site_id_a59334e3_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlan ipam_vlan_tenant_id_71a8290d_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlan
    ADD CONSTRAINT ipam_vlan_tenant_id_71a8290d_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vlangroup ipam_vlangroup_site_id_264f36f6_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vlangroup
    ADD CONSTRAINT ipam_vlangroup_site_id_264f36f6_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ipam_vrf ipam_vrf_tenant_id_498b0051_fk_tenancy_tenant_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.ipam_vrf
    ADD CONSTRAINT ipam_vrf_tenant_id_498b0051_fk_tenancy_tenant_id FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secret secrets_secret_device_id_c7c13124_fk_dcim_device_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secret
    ADD CONSTRAINT secrets_secret_device_id_c7c13124_fk_dcim_device_id FOREIGN KEY (device_id) REFERENCES public.dcim_device(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secret secrets_secret_role_id_39d9347f_fk_secrets_secretrole_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secret
    ADD CONSTRAINT secrets_secret_role_id_39d9347f_fk_secrets_secretrole_id FOREIGN KEY (role_id) REFERENCES public.secrets_secretrole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secretrole_groups secrets_secretrole_g_secretrole_id_3cf0338b_fk_secrets_s; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_groups
    ADD CONSTRAINT secrets_secretrole_g_secretrole_id_3cf0338b_fk_secrets_s FOREIGN KEY (secretrole_id) REFERENCES public.secrets_secretrole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secretrole_groups secrets_secretrole_groups_group_id_a687dd10_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_groups
    ADD CONSTRAINT secrets_secretrole_groups_group_id_a687dd10_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secretrole_users secrets_secretrole_u_secretrole_id_d2eac298_fk_secrets_s; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_users
    ADD CONSTRAINT secrets_secretrole_u_secretrole_id_d2eac298_fk_secrets_s FOREIGN KEY (secretrole_id) REFERENCES public.secrets_secretrole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_secretrole_users secrets_secretrole_users_user_id_25be95ad_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_secretrole_users
    ADD CONSTRAINT secrets_secretrole_users_user_id_25be95ad_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_sessionkey secrets_sessionkey_userkey_id_3ca6176b_fk_secrets_userkey_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_sessionkey
    ADD CONSTRAINT secrets_sessionkey_userkey_id_3ca6176b_fk_secrets_userkey_id FOREIGN KEY (userkey_id) REFERENCES public.secrets_userkey(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: secrets_userkey secrets_userkey_user_id_13ada46b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.secrets_userkey
    ADD CONSTRAINT secrets_userkey_user_id_13ada46b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_9957a03c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tenancy_tenant tenancy_tenant_group_id_7daef6f4_fk_tenancy_tenantgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.tenancy_tenant
    ADD CONSTRAINT tenancy_tenant_group_id_7daef6f4_fk_tenancy_tenantgroup_id FOREIGN KEY (group_id) REFERENCES public.tenancy_tenantgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_token users_token_user_id_af964690_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.users_token
    ADD CONSTRAINT users_token_user_id_af964690_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_clust_group_id_de379828_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_clust_group_id_de379828_fk_virtualiz FOREIGN KEY (group_id) REFERENCES public.virtualization_clustergroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_clust_type_id_4efafb0a_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_clust_type_id_4efafb0a_fk_virtualiz FOREIGN KEY (type_id) REFERENCES public.virtualization_clustertype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_cluster virtualization_cluster_site_id_4d5af282_fk_dcim_site_id; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_cluster
    ADD CONSTRAINT virtualization_cluster_site_id_4d5af282_fk_dcim_site_id FOREIGN KEY (site_id) REFERENCES public.dcim_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_cluster_id_6c9f9047_fk_virtualiz; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_cluster_id_6c9f9047_fk_virtualiz FOREIGN KEY (cluster_id) REFERENCES public.virtualization_cluster(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_platform_id_a6c5ccb2_fk_dcim_plat; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_platform_id_a6c5ccb2_fk_dcim_plat FOREIGN KEY (platform_id) REFERENCES public.dcim_platform(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_primary_ip4_id_942e42ae_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_primary_ip4_id_942e42ae_fk_ipam_ipad FOREIGN KEY (primary_ip4_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_primary_ip6_id_b7904e73_fk_ipam_ipad; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_primary_ip6_id_b7904e73_fk_ipam_ipad FOREIGN KEY (primary_ip6_id) REFERENCES public.ipam_ipaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_role_id_0cc898f9_fk_dcim_devi; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_role_id_0cc898f9_fk_dcim_devi FOREIGN KEY (role_id) REFERENCES public.dcim_devicerole(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: virtualization_virtualmachine virtualization_virtu_tenant_id_d00d1d77_fk_tenancy_t; Type: FK CONSTRAINT; Schema: public; Owner: netbox
--

ALTER TABLE ONLY public.virtualization_virtualmachine
    ADD CONSTRAINT virtualization_virtu_tenant_id_d00d1d77_fk_tenancy_t FOREIGN KEY (tenant_id) REFERENCES public.tenancy_tenant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

