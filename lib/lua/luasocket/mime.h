#ifndef MIME_H 
#define MIME_H 
/*=========================================================================*\
* MIME support functions
* LuaSocket toolkit
*
* This module provides functions to implement transfer content encodings
* and formatting conforming to RFC 2045. It is used by mime.lua, which
* provide a higher level interface to this functionality. 
*
* RCS ID: $Id: mime.h,v 1.1 2005/07/26 21:06:14 cpressey Exp $
\*=========================================================================*/
#include <lua.h>

/*-------------------------------------------------------------------------*\
* This macro prefixes all exported API functions
\*-------------------------------------------------------------------------*/
#ifndef MIME_API
#define MIME_API extern
#endif

MIME_API int luaopen_mime(lua_State *L);

#endif /* MIME_H */
