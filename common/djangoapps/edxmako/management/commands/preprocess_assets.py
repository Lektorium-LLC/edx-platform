"""
Preprocess templatized asset files, enabling asset authors to use
Python/Django inside of Sass and CoffeeScript. This preprocessing
will happen before the invocation of the asset compiler (currently
handled by the assets paver file).

For this to work, assets need to be named with the appropriate
template extension (e.g., .mako for Mako templates). Currently Mako
is the only template engine supported.
"""

import os
import textwrap

from django.core.management.base import BaseCommand
from django.conf import settings


class Command(BaseCommand):
    """
    Basic management command to preprocess asset template files.
    """

    help = "Preprocess asset template files to ready them for compilation."

    def add_arguments(self, parser):
        parser.add_argument('files', type=unicode, nargs='+', help='files to pre-process')
        parser.add_argument('dest_dir', type=unicode, help='destination directory')

    def handle(self, *args, **options):
        theme_name = getattr(settings, "THEME_NAME", None)
        studio_theme_name = getattr(settings, "STUDIO_THEME_NAME", None)
        use_custom_theme = settings.FEATURES.get("USE_CUSTOM_THEME", False)
        use_custom_studio_theme = settings.FEATURES.get("USE_CUSTOM_STUDIO_THEME", False)

        if not (use_custom_theme and theme_name
                or use_custom_studio_theme and studio_theme_name):
            # No custom theme, nothing to do!
            return

        dest_dir = options['dest_dir']
        for source_file in options['files']:
            self.process_one_file(
                source_file,
                dest_dir,
                theme_name if use_custom_theme else None,
                studio_theme_name if use_custom_studio_theme else None
            )

    def process_one_file(self, source_file, dest_dir, theme_name, studio_theme_name):
        """Pre-process a .scss file to replace our markers with real code."""
        with open(source_file) as fsource:
            original_content = content = fsource.read()

        if theme_name:
            content = original_content.replace(
                "//<THEME-OVERRIDE>",
                "@import '{}';".format(theme_name),
            )
        if studio_theme_name:
            content = content.replace(
                "//<STUDIO-THEME-OVERRIDE>",
                "@import '{}';".format(studio_theme_name),
            )

        if content != original_content:
            if not os.path.exists(dest_dir):
                os.makedirs(dest_dir)
            dest_file = os.path.join(dest_dir, os.path.basename(source_file))
            with open(dest_file, "w") as fout:
                fout.write(textwrap.dedent("""\
                /*
                 * This file is dynamically generated and ignored by Git.
                 * DO NOT MAKE CHANGES HERE. Instead, go edit its source:
                 * {}
                 */
                \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
                """.format(source_file)))
                fout.write(content)
