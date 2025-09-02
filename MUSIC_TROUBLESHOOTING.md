# Music Island Troubleshooting Guide

This guide helps troubleshoot common issues with the Dynamic Island music display.

## Quick Fixes

### 1. Music Island Not Showing
- **Check if music island is enabled**: In your `userconfig.sh`, ensure `P_DYNAMIC_ISLAND_MUSIC_ENABLED=1`
- **Restart SketchyBar**: After config changes, restart SketchyBar for changes to take effect
- **Check music source**: Ensure `P_DYNAMIC_ISLAND_MUSIC_SOURCE` is set to "Music" or "Spotify" (case sensitive)

### 2. No Song Information Displayed
- **Verify music app is running**: Ensure Apple Music or Spotify is open and playing
- **Check media permissions**: Make sure the music app has proper system permissions
- **Try different song**: Some songs may not have complete metadata

### 3. Music Visualizer Not Working
- **Install cava**: `brew install cava`
- **Install Background Music**: `brew install --cask background-music`
- **Check Background Music is running**: Background Music must be running for audio capture
- **Verify audio output**: Set Background Music as your audio output device

## Debug Mode

Enable debug logging to troubleshoot issues:

1. Edit your `userconfig.sh` file:
   ```bash
   P_DYNAMIC_ISLAND_MUSIC_DEBUG=1
   ```

2. Restart SketchyBar

3. Watch the logs:
   ```bash
   tail -f /var/log/system.log | grep MUSIC_DEBUG
   ```

## Common Error Messages

### "Warning: cava not found"
**Solution**: Install cava with `brew install cava`

### "Warning: cava cannot access audio input"
**Solution**: 
1. Install Background Music: `brew install --cask background-music`
2. Set Background Music as your output device in System Preferences > Sound
3. Make sure Background Music app is running

### "Warning: Music artwork not available"
**Solution**: This is normal for songs without artwork. The island will still show song/artist info.

### "Error: Failed to configure music island elements"
**Solution**: 
1. Check that SketchyBar is running properly
2. Verify your `userconfig.sh` has valid values
3. Try restarting the Dynamic Island

## Configuration Validation

The music island now validates configuration values automatically. If you see warnings like:

```
Warning: P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT is not set or not numeric, using default
```

This means your configuration has invalid values. Check your `userconfig.sh` for:
- Non-numeric values where numbers are expected
- Missing required configuration variables
- Negative values where positive values are required

## Performance Issues

### Music Island Animations Lag
1. **Reduce animation complexity**: Lower the expand width/height values in your config
2. **Check system load**: High CPU usage can affect animations
3. **Disable debug mode**: Debug logging can impact performance

### High CPU Usage
1. **Check cava process**: Multiple cava processes may be running
2. **Restart the music island**: `pkill -f music_island.sh` and let it restart
3. **Disable visualizer temporarily**: Comment out visualizer in your config

## Reset Music Island

If the music island gets stuck or behaves unexpectedly:

1. **Kill music island processes**:
   ```bash
   pkill -f music_island.sh
   pkill -f pause_island.sh
   pkill -f cava
   ```

2. **Clear cache**:
   ```bash
   rm -f ~/.config/dynamic-island-sketchybar/scripts/islands/previous_island
   ```

3. **Restart SketchyBar**:
   ```bash
   brew services restart sketchybar
   ```

## Advanced Troubleshooting

### Check JSON Data
With debug mode enabled, you can see the raw JSON data being processed:
```bash
tail -f /var/log/system.log | grep "Handler called with INFO"
```

### Manual Testing
Test the handler directly:
```bash
export INFO='{"title":"Test Song","artist":"Test Artist","state":"playing"}'
bash ~/.config/dynamic-island-sketchybar/scripts/islands/music/handler.sh
```

### Check SketchyBar Events
Verify that media events are being triggered:
```bash
sketchybar --query mediaListener
```

## Reporting Issues

When reporting music island issues, please include:

1. **System information**: macOS version, hardware model
2. **Configuration**: Your `userconfig.sh` file (remove personal info)
3. **Debug logs**: Output with `P_DYNAMIC_ISLAND_MUSIC_DEBUG=1` enabled
4. **Steps to reproduce**: Exact steps that cause the issue
5. **Music app**: Which music application you're using (Apple Music, Spotify, etc.)

## Related Components

The music island system consists of several files:
- `handler.sh`: Processes music events from SketchyBar
- `music_island.sh`: Main music display logic
- `pause_island.sh`: Handles play/pause states
- `cava.sh`: Audio visualizer (requires Background Music)
- `creator.sh`: Creates SketchyBar items for music island
- `reset.sh` / `reset-resume.sh`: Clean up when music island finishes

All of these files now include improved error handling and validation.