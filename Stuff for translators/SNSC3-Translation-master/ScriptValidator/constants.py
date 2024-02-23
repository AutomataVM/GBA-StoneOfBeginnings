ROOT_OPEN = str.encode('<root>')
ROOT_CLOSE = str.encode('</root>')
END_LINE_OPEN = str.encode('<end_line>')
END_LINE_CLOSED = str.encode('<end_line/>')
THREE_DOTS_OPEN = str.encode('<three_dots>')
THREE_DOTS_CLOSED = str.encode('<three_dots/>')
PLAYER_NAME_OPEN = str.encode('<player_name>')
PLAYER_NAME_CLOSED = str.encode('<player_name/>')
PLAYER_NICKNAME_OPEN = str.encode('<player_nickname>')
PLAYER_NICKNAME_CLOSED = str.encode('<player_nickname/>')
ASCII_OPEN = str.encode('<ascii>')
ASCII_CLOSE = str.encode('<ascii/>')
HEARTH_OPEN = str.encode('<hearth>')
HEARTH_CLOSED = str.encode('<hearth/>')
PAW_OPEN = str.encode('<paw>')
PAW_CLOSED = str.encode('<paw/>')
PARTNER_OPEN =str.encode('<partner>')
PARTNER_CLOSED = str.encode('<partner/>')
WEAPON_TYPE_OPEN = str.encode('<weapon_type>')
WEAPON_TYPE_CLOSED = str.encode('<weapon_type/>')
BREAK_OPEN = str.encode('<break>')
BREAK_CLOSED = str.encode('<break/>')
QUOTE_OPEN = str.encode('<quote>')
QUOTE_CLOSED = str.encode('<quote/>')
MUSIC_NOTE_OPEN = str.encode('<music_note>')
MUSIC_NOTE_CLOSED = str.encode('<music_note/>')
OPTION_1_OPEN = str.encode('<option_1>')
OPTION_1_CLOSED = str.encode('<option_1/>')
OPTION_2_OPEN = str.encode('<option_2>')
OPTION_2_CLOSED = str.encode('<option_2/>')


NEWLINE = str.encode('\n')
PLAYER_LINE = str.encode('<player ')
PARTNER_LINE = str.encode('<partner ')
INFO_LINE = str.encode('<info')
PORTRAIT_L_LINE = str.encode('<portrait_l')
PORTRAIT_R_LINE = str.encode('<portrait_r')

SJIS_OPEN = str.encode('<sjis>')
SJIS_CLOSED = str.encode('<sjis/>')

LINE_ELS = [PLAYER_LINE, PARTNER_LINE, INFO_LINE, PORTRAIT_L_LINE, PORTRAIT_R_LINE]
SYMBOLS = ['three_dots', 'hearth', 'paw']
NAME_ELS = ['player_name', 'player_nickname', 'partner']

MAX_LINE_LENGTH = 36
SYMBOL_LEN = 2
NAME_EL_LEN = 8
