-- get_os_type(), funtion to return current OS type and architecture
-- get_os_arch(), funtion to return current OS architecture
-- Copyright Nazar Malyy 2022

local M = {} -- public interface

function M.get_os_type()
  -- Return two strings describing the OS name
  -- For Windows, the OS identification is based on environment variables
  -- On unix, a call to uname is use.
  -- 
  -- OS possible values: Windows, Linux, Mac, BSD, Solaris

  local raw_os_name = ''

  -- LuaJIT shortcut
  if jit and jit.os then
    raw_os_name = jit.os
    -- print( ("Debug jit name: %q"):format( raw_os_name ) )
  else
    if package.config:sub(1,1) == '\\' then
      -- Windows
      local env_OS = os.getenv('OS')
      -- print( ("Debug: %q"):format( env_OS ) )
      if env_OS then
          raw_os_name = env_OS
      end
    else
      -- other platform, assume uname support and popen support
      raw_os_name = io.popen('uname -s','r'):read('*l')
    end
  end

  raw_os_name = (raw_os_name):lower()

  -- print( ("Debug: %q"):format( raw_os_name ) )

  local os_patterns = {
    ['windows']     = 'windows',
    ['linux']       = 'linux',
    ['osx']         = 'mac',
    ['mac']         = 'mac',
    ['darwin']      = 'mac',
    ['^mingw']      = 'windows',
    ['^cygwin']     = 'windows',
    ['bsd$']        = 'bsd',
    ['sunos']       = 'solaris',
  }
  
  local os_name = 'unknown'

  for pattern, name in pairs(os_patterns) do
    if raw_os_name == pattern then
      os_name = name
      break
    end
  end

  return os_name

end


function M.get_os_arch()
  -- Return string describing the OS architecture.
  -- 
  -- Arch possible values: x86, x86864, powerpc, arm, mips etc...

  local raw_arch_name = ''

  -- LuaJIT shortcut
  if jit and jit.arch then
    raw_arch_name = jit.arch
    -- print( ("Debug jit name: %q"):format( raw_arch_name ) )
  else
    if package.config:sub(1,1) == '\\' then
      -- Windows
      local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')
      -- print( ("Debug Windows getenv(PROCESSOR_ARCHITECTURE): %q"):format( env_ARCH ) )
      if env_ARCH then
        raw_arch_name = env_ARCH
      end
    else
      -- other platform, assume uname support and popen support
      raw_arch_name = io.popen('uname -m','r'):read('*l')
    end
  end

  raw_arch_name = (raw_arch_name):lower()

  -- print( ("Debug: raw_arch_name %q"):format( raw_arch_name) )
    
  local arch_patterns = {
    ['^x86$']           = 'x86',
    ['i[%d]86']         = 'x86',
    ['amd64']           = 'x86_64',
    ['x86_64']          = 'x86_64',
    ['x64']             = 'x86_64',
    ['power macintosh'] = 'powerpc',
    ['^arm']            = 'arm',
    ['aarch64']         = 'arm64',
    ['arm64']           = 'arm64',
    ['^mips']           = 'mips',
    ['i86pc']           = 'x86',
  }

  local arch_name = 'unknown'

  for pattern, name in pairs(arch_patterns) do
    -- print(("Pattern: %q"):format( pattern ))
    -- print(("Name: %q"):format( name ))
    if raw_arch_name == pattern then
      arch_name = name
      break
    end
  end
  return arch_name
end

-- print(get_os_type())
-- print(get_os_arch())

return M
