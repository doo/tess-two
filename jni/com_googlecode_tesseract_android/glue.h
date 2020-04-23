//
// Created by Stefan on 03.04.20.
//

#ifndef ANDROID_SBSDK_GLUE_H
#define ANDROID_SBSDK_GLUE_H

#include "tess_version.h"

#include <glob.h>

#ifndef PACKAGE_VERSION
#define PACKAGE_VERSION TESSERACT_VERSION_STR
#endif

#if __ANDROID_API__ < 28

inline int glob(const char *pattern, int flags,
         int (*errfunc) (const char *epath, int eerrno),
         glob_t *pglob) {
    return GLOB_NOMATCH;
}

inline void globfree(glob_t *pglob) {}

#endif

#endif //ANDROID_SBSDK_GLUE_H
